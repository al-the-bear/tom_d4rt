/// Shared harness for the D4rt interpreter performance suite.
///
/// The suite measures *interpretation* cost, deliberately separated from
/// parse/setup cost. Each benchmark script (see
/// `example/dart_overview/perf/scripts/`) follows a fixed shape:
///
/// ```dart
/// const int kIterations = 20000;   // tunable inner-loop count
/// int compute() { /* loop kIterations times */ return checksum; }
/// void main() { compute(); }
/// ```
///
/// The harness:
///   1. Loads the script once with [executeFile]. This resolves relative
///      imports, parses the source and runs `main()` a single time — warming
///      the interpreter and defining `compute` and `kIterations` in the global
///      environment. Parse cost is paid here, once, and never measured.
///   2. Reads `kIterations` back via `eval('kIterations')`.
///   3. Repeatedly calls `eval('compute()')` — first for a warmup window, then
///      under a measured time budget — counting calls. `eval` of the tiny
///      `compute()` expression re-parses only those nine characters, so the
///      measured time is dominated by the interpreted loop body.
///   4. Reports nanoseconds-per-operation (one inner-loop iteration) and the
///      returned checksum, which lets the timing test double as a regression
///      guard: a script that starts throwing or returning the wrong value
///      fails the test, not just the benchmark.
///
/// All interpreted `print` output is swallowed by a [runZoned] print hook so
/// the macro-benchmarks (which wrap the chatty dart_overview areas) stay quiet.
library;

import 'dart:async';

import 'package:tom_d4rt/d4rt.dart';

/// Outcome of running one benchmark script.
class BenchResult {
  /// Short benchmark name (script basename without extension).
  final String name;

  /// The `kIterations` constant read from the script — how many inner-loop
  /// operations one `compute()` call performs.
  final int iterationsPerCall;

  /// Number of measured `compute()` calls that fit inside the time budget.
  final int calls;

  /// Wall-clock time spent in the measured calls only.
  final Duration elapsed;

  /// Value returned by the final `compute()` call (the script's checksum).
  final Object? checksum;

  /// Whether setup + measurement completed without error.
  final bool success;

  /// Error text when [success] is false.
  final String? error;

  const BenchResult({
    required this.name,
    required this.iterationsPerCall,
    required this.calls,
    required this.elapsed,
    required this.checksum,
    required this.success,
    this.error,
  });

  factory BenchResult.failure(String name, String error) => BenchResult(
        name: name,
        iterationsPerCall: 0,
        calls: 0,
        elapsed: Duration.zero,
        checksum: null,
        success: false,
        error: error,
      );

  /// Total inner-loop operations executed during measurement.
  int get totalOps => calls * iterationsPerCall;

  /// Nanoseconds per inner-loop operation — the headline throughput figure.
  double get nsPerOp =>
      totalOps == 0 ? 0 : elapsed.inMicroseconds * 1000 / totalOps;

  /// Microseconds per `compute()` call.
  double get usPerCall =>
      calls == 0 ? 0 : elapsed.inMicroseconds / calls;

  /// Operations per second (one inner-loop iteration = one op).
  double get opsPerSecond =>
      elapsed.inMicroseconds == 0 ? 0 : totalOps * 1e6 / elapsed.inMicroseconds;
}

/// Configuration for one benchmark run.
class BenchConfig {
  /// Time spent warming the interpreter before measurement begins.
  final Duration warmup;

  /// Minimum measured window. `compute()` is called until this elapses.
  final Duration budget;

  const BenchConfig({
    this.warmup = const Duration(milliseconds: 250),
    this.budget = const Duration(milliseconds: 1200),
  });

  /// Fast variant for CI / the timing test, where we want a correctness and
  /// regression signal without spending seconds per script.
  static const quick = BenchConfig(
    warmup: Duration(milliseconds: 80),
    budget: Duration(milliseconds: 300),
  );
}

/// Run all interpreted code with `print` suppressed.
T runSilently<T>(T Function() body) {
  return runZoned(
    body,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        // Intentionally swallow interpreted-script output.
      },
    ),
  );
}

/// Build a fully-permissioned interpreter for benchmarking.
///
/// Filesystem permission is required because [executeFile] loads the script
/// (and the macro-benchmarks' relative imports) from disk; isolate permission
/// covers any area that touches async/isolate stdlib bridges.
D4rt newBenchInterpreter() {
  final d4rt = D4rt();
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(IsolatePermission.any);
  return d4rt;
}

/// Measure a single benchmark script at [scriptPath].
///
/// Returns a [BenchResult]; never throws — setup or runtime failures are
/// captured as [BenchResult.failure] so a broken script degrades to a failed
/// assertion in the timing test rather than aborting the whole run.
BenchResult runFileBenchmark(
  String name,
  String scriptPath, {
  BenchConfig config = const BenchConfig(),
}) {
  return runSilently<BenchResult>(() {
    final d4rt = newBenchInterpreter();

    // 1. One-time setup: parse, resolve imports, run main() once.
    final setup = executeFile(d4rt, scriptPath);
    if (!setup.success) {
      return BenchResult.failure(name, 'setup failed: ${setup.error}');
    }

    // 2. Read the inner-loop count for ns/op math.
    final int iterationsPerCall;
    try {
      iterationsPerCall = (d4rt.eval('kIterations') as num).toInt();
    } catch (e) {
      return BenchResult.failure(name, 'missing kIterations: $e');
    }
    if (iterationsPerCall <= 0) {
      return BenchResult.failure(name, 'kIterations must be positive');
    }

    try {
      // 3a. Warmup window — not measured.
      final warm = Stopwatch()..start();
      while (warm.elapsed < config.warmup) {
        d4rt.eval('compute()');
      }
      warm.stop();

      // 3b. Measured window.
      Object? checksum;
      var calls = 0;
      final sw = Stopwatch()..start();
      while (sw.elapsed < config.budget) {
        checksum = d4rt.eval('compute()');
        calls++;
      }
      sw.stop();

      return BenchResult(
        name: name,
        iterationsPerCall: iterationsPerCall,
        calls: calls,
        elapsed: sw.elapsed,
        checksum: checksum,
        success: true,
      );
    } catch (e) {
      return BenchResult.failure(name, 'runtime error: $e');
    }
  });
}

/// Format a result as one aligned table row.
String formatResultRow(BenchResult r) {
  if (!r.success) {
    return '${r.name.padRight(22)}  FAILED: ${r.error}';
  }
  final nsPerOp = r.nsPerOp.toStringAsFixed(0).padLeft(10);
  final usPerCall = r.usPerCall.toStringAsFixed(1).padLeft(10);
  final calls = r.calls.toString().padLeft(7);
  final ops = r.totalOps.toString().padLeft(11);
  return '${r.name.padRight(22)}  $nsPerOp  $usPerCall  $calls  $ops';
}

/// Header row matching [formatResultRow]'s columns.
String resultTableHeader() {
  return '${'benchmark'.padRight(22)}  ${'ns/op'.padLeft(10)}  '
      '${'us/call'.padLeft(10)}  ${'calls'.padLeft(7)}  ${'ops'.padLeft(11)}';
}
