/// D4rt interpreter CPU-profiling driver.
///
/// Runs the full benchmark corpus under a real time budget, then pulls
/// aggregated CPU samples from the VM service and prints:
///   - the per-benchmark throughput table (full budget), and
///   - the hottest interpreter functions by *exclusive* (self) ticks and by
///     *inclusive* (self + callees) ticks.
///
/// It must run on a VM with the service + profiler enabled. Launch it via
/// `test/perf/run_profile.sh`, which adds the right flags, or manually:
///
/// ```sh
/// dart --enable-vm-service --no-pause-isolates-on-exit \
///   --profiler --sample-buffer-duration=120 \
///   test/perf/d4rt_cpu_profile.dart [--budget-ms=1500] [--only=name,name]
/// ```
///
/// Output is written to stdout and to
/// `example/dart_overview/perf/results/cpu_profile_latest.txt`.
library;

import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';

import 'bench_registry.dart';
import 'd4rt_perf_harness.dart';

Future<void> main(List<String> args) async {
  final budgetMs = _intArg(args, '--budget-ms') ?? 1500;
  final warmupMs = _intArg(args, '--warmup-ms') ?? 300;
  final only = _listArg(args, '--only');
  final topN = _intArg(args, '--top') ?? 30;

  final config = BenchConfig(
    warmup: Duration(milliseconds: warmupMs),
    budget: Duration(milliseconds: budgetMs),
  );

  final scriptsDir = resolveScriptsDir();
  final selected = only == null
      ? benchmarks
      : benchmarks.where((b) => only.contains(b.name)).toList();
  if (selected.isEmpty) {
    stderr.writeln('No benchmarks matched --only=${only?.join(",")}');
    exitCode = 2;
    return;
  }

  // Connect to the VM service so we can pull CPU samples afterwards.
  final serviceInfo = await developer.Service.getInfo();
  final wsUri = _toWebSocket(serviceInfo.serverUri);
  if (wsUri == null) {
    stderr.writeln(
      'VM service is not enabled. Run via test/perf/run_profile.sh '
      '(or add --enable-vm-service --profiler).',
    );
    exitCode = 3;
    return;
  }

  final service = await vmServiceConnectUri(wsUri);
  final vm = await service.getVM();
  final isolateId = vm.isolates!.first.id!;

  // Bound the sample window to the measured run only.
  final originMicros = (await service.getVMTimelineMicros()).timestamp!;

  final out = StringBuffer();
  void emit(String line) {
    stdout.writeln(line);
    out.writeln(line);
  }

  emit('');
  emit('=== D4rt CPU profile run ===');
  emit('budget=${budgetMs}ms warmup=${warmupMs}ms '
      'benchmarks=${selected.length} top=$topN');
  emit('');
  emit(resultTableHeader());

  final results = <BenchResult>[];
  for (final entry in selected) {
    final r = runFileBenchmark(
      entry.name,
      scriptPathFor(entry, scriptsDir),
      config: config,
    );
    results.add(r);
    emit(formatResultRow(r));
  }

  final extentMicros =
      (await service.getVMTimelineMicros()).timestamp! - originMicros;

  // Pull CPU samples for the measured window and aggregate by function.
  final samples = await service.getCpuSamples(
    isolateId,
    originMicros,
    extentMicros,
  );

  final agg = _aggregate(samples);
  emit('');
  emit('total CPU samples in window: ${agg.totalSamples}');

  emit('');
  emit('--- hottest functions by EXCLUSIVE (self) ticks ---');
  _emitFunctionTable(emit, agg.byExclusive(topN), agg.totalSamples);

  emit('');
  emit('--- hottest functions by INCLUSIVE (self+callees) ticks ---');
  _emitFunctionTable(emit, agg.byInclusive(topN), agg.totalSamples);

  await service.dispose();

  // Persist for the analysis doc.
  final resultsDir = Directory(
    p.join(scriptsDir, '..', 'results'),
  );
  resultsDir.createSync(recursive: true);
  final outFile = File(p.join(resultsDir.path, 'cpu_profile_latest.txt'));
  outFile.writeAsStringSync(out.toString());
  stdout.writeln('');
  stdout.writeln('Wrote ${outFile.path}');
}

/// Aggregated tick counts keyed by a human function label.
class _Aggregate {
  final Map<String, int> exclusive = {};
  final Map<String, int> inclusive = {};
  int totalSamples = 0;

  List<MapEntry<String, int>> byExclusive(int n) => _top(exclusive, n);
  List<MapEntry<String, int>> byInclusive(int n) => _top(inclusive, n);

  static List<MapEntry<String, int>> _top(Map<String, int> m, int n) {
    final entries = m.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.take(n).toList();
  }
}

_Aggregate _aggregate(CpuSamples samples) {
  final agg = _Aggregate();
  final functions = samples.functions ?? const [];

  String labelFor(int index) {
    if (index < 0 || index >= functions.length) return '<unknown>';
    final pf = functions[index];
    final f = pf.function;
    String name;
    if (f is FuncRef) {
      name = f.name ?? '<anon>';
      final owner = f.owner;
      if (owner is ClassRef && owner.name != null) {
        name = '${owner.name}.$name';
      }
    } else if (f is NativeFunction) {
      name = '[native] ${f.name}';
    } else {
      name = f?.toString() ?? '<unknown>';
    }
    return name;
  }

  for (final sample in samples.samples ?? const <CpuSample>[]) {
    final stack = sample.stack;
    if (stack == null || stack.isEmpty) continue;
    agg.totalSamples++;

    // Exclusive: the leaf frame (top of stack) is index 0.
    agg.exclusive.update(labelFor(stack.first), (v) => v + 1,
        ifAbsent: () => 1);

    // Inclusive: every distinct function appearing in the stack.
    final seen = <int>{};
    for (final idx in stack) {
      if (seen.add(idx)) {
        agg.inclusive.update(labelFor(idx), (v) => v + 1, ifAbsent: () => 1);
      }
    }
  }
  return agg;
}

void _emitFunctionTable(
  void Function(String) emit,
  List<MapEntry<String, int>> rows,
  int totalSamples,
) {
  emit('${'ticks'.padLeft(8)}  ${'pct'.padLeft(6)}  function');
  for (final row in rows) {
    final pct = totalSamples == 0
        ? '0.0'
        : (row.value * 100 / totalSamples).toStringAsFixed(1);
    emit('${row.value.toString().padLeft(8)}  ${'$pct%'.padLeft(6)}  '
        '${row.key}');
  }
}

String? _toWebSocket(Uri? serverUri) {
  if (serverUri == null) return null;
  final pathSegments = serverUri.pathSegments.where((s) => s.isNotEmpty);
  final wsPath = '/${[...pathSegments, 'ws'].join('/')}';
  return serverUri.replace(scheme: 'ws', path: wsPath).toString();
}

int? _intArg(List<String> args, String flag) {
  for (final a in args) {
    if (a.startsWith('$flag=')) return int.tryParse(a.substring(flag.length + 1));
  }
  return null;
}

List<String>? _listArg(List<String> args, String flag) {
  for (final a in args) {
    if (a.startsWith('$flag=')) {
      return a
          .substring(flag.length + 1)
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }
  }
  return null;
}
