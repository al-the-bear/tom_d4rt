/// Attribution harness for the ~1.4s "first interpretation" delay.
///
/// The user observes that running a Flutter script through [SourceFlutterD4rt]
/// stalls ~1.4s the first time, while trivial shebang scripts are near-instant.
/// Three suspects: (a) analyzer parse cost, (b) bridge registration/finalize,
/// (c) interpretation of a large widget tree. This harness splits the cost so
/// we can point at the real one rather than guess.
///
/// Method — for each script we measure, in isolation:
///   * CONSTRUCT  — `SourceFlutterD4rt()` (registers + finalizes ~all of the
///                  Flutter Material bridge surface). One-time, per interpreter.
///   * PARSE      — `parseString` with the *exact* FeatureSet flags the
///                  interpreter uses, run standalone. This is the pure analyzer
///                  cost with zero interpreter involvement.
///   * BUILD#1    — first `build`/`buildMultiFile` (parse + module init +
///                  finalize + 2-pass interpret + unwrap).
///   * BUILD#2..N — subsequent builds on the SAME interpreter (steady state).
///
/// Reading the numbers:
///   * BUILD#1 ≈ steady, complex ≈ trivial → fixed per-execute() overhead,
///     not parse and not widget-tree complexity.
///   * D4rtProfile breakdown then localizes that fixed cost to a phase —
///     here it lands on `pass2.imports` (single-file) / `parse`→ModuleLoader
///     (multi-file): resolving `import 'package:flutter/material.dart'`.
@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

/// A single-file widget snippet: trivial top-level `build`.
const _trivialSource = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return const Center(child: Text('hi'));
}
''';

/// A single-file widget snippet with a deeper, wider tree to expose
/// complexity-driven interpretation cost (lots of widget constructors).
String _complexSource() {
  final rows = List.generate(40, (i) => '''
        Card(
          child: ListTile(
            leading: const Icon(Icons.label),
            title: Text('Item $i'),
            subtitle: Text('Subtitle for row $i with some text'),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),''').join('\n');
  return '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Complex')),
    body: ListView(
      padding: const EdgeInsets.all(8),
      children: [
$rows
      ],
    ),
  );
}
''';
}

String _mainPath(String sample) {
  final sep = Platform.pathSeparator;
  final cwd = Directory.current.path;
  final candidates = <String>[
    [cwd, 'example', sample, 'main.dart'].join(sep),
    [cwd, '..', 'example', sample, 'main.dart'].join(sep),
  ];
  for (final c in candidates) {
    if (File(c).existsSync()) return c;
  }
  throw StateError('Could not find example/$sample/main.dart. CWD=$cwd');
}

double _ms(int micros) => micros / 1000.0;

/// Time [body] once, returning (result, micros).
(T, int) _timed<T>(T Function() body) {
  final sw = Stopwatch()..start();
  final r = body();
  sw.stop();
  return (r, sw.elapsedMicroseconds);
}

void _line(String s) {
  // ignore: avoid_print
  print('[timing] $s');
}

void main() {
  testWidgets('interpretation cost attribution', (tester) async {
    tester.view.physicalSize = const Size(1000, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // --- CONSTRUCT: bridge registration + finalize, one-time per interpreter.
    final (_, c1) = _timed(() => SourceFlutterD4rt());
    final (d4rt, c2) = _timed(() => SourceFlutterD4rt());
    _line('CONSTRUCT  first=${_ms(c1).toStringAsFixed(1)}ms  '
        'second=${_ms(c2).toStringAsFixed(1)}ms  '
        '(SourceFlutterD4rt() — registers+finalizes Flutter bridges)');

    // Source used by the complex single-file and breakdown sections below.
    // (Pure-analyzer parse cost is reported by D4rtProfile's `parse` phase in
    // the per-phase breakdown — it lands ~1ms, so no standalone baseline here.)
    final complexSrc = _complexSource();

    // --- Helper: measure N builds of a single-file source on a host context.
    Future<void> measureSingle(String label, String source) async {
      final samples = <(int micros, int calls)>[];
      for (var i = 0; i < 4; i++) {
        await tester.pumpWidget(MaterialApp(home: Builder(builder: (ctx) {
          D4rtDiag.reset();
          final (w, micros) = _timed(() => d4rt.build<Widget>(source, ctx));
          samples.add((micros, D4rtDiag.callCount));
          return w;
        })));
        await tester.pump(const Duration(milliseconds: 16));
      }
      final first = samples.first;
      final steady = samples.skip(1).toList();
      final steadyMean = steady.isEmpty
          ? 0
          : steady.map((e) => e.$1).reduce((a, b) => a + b) ~/ steady.length;
      _line('$label  build#1=${_ms(first.$1).toStringAsFixed(1)}ms '
          '(calls=${first.$2})  '
          'steady=${_ms(steadyMean).toStringAsFixed(1)}ms '
          '(calls=${steady.isEmpty ? 0 : steady.first.$2})');
    }

    await measureSingle('SINGLE trivial', _trivialSource);
    await measureSingle('SINGLE complex', complexSrc);

    // --- Multi-file samples: trivial (counter_app) vs heavy (calculator).
    Future<void> measureMulti(String sample) async {
      final mainPath = _mainPath(sample);
      final samples = <(int micros, int calls)>[];
      for (var i = 0; i < 4; i++) {
        await tester.pumpWidget(MaterialApp(home: Builder(builder: (ctx) {
          D4rtDiag.reset();
          final (w, micros) =
              _timed(() => d4rt.buildMultiFile<Widget>(mainPath, buildContext: ctx));
          samples.add((micros, D4rtDiag.callCount));
          return w;
        })));
        await tester.pump(const Duration(milliseconds: 16));
      }
      final first = samples.first;
      final steady = samples.skip(1).toList();
      final steadyMean = steady.isEmpty
          ? 0
          : steady.map((e) => e.$1).reduce((a, b) => a + b) ~/ steady.length;
      _line('MULTI $sample  build#1=${_ms(first.$1).toStringAsFixed(1)}ms '
          '(calls=${first.$2})  '
          'steady=${_ms(steadyMean).toStringAsFixed(1)}ms '
          '(calls=${steady.isEmpty ? 0 : steady.first.$2})');
    }

    await measureMulti('counter_app');
    await measureMulti('calculator');

    // --- Per-phase breakdown of ONE steady-state execute() via D4rtProfile.
    //     This pinpoints WHICH part of the ~900ms/build dominates: bridge
    //     (re)registration in _initModule vs parse vs interpretation.
    Future<void> phaseBreakdown(
        String label, void Function(BuildContext) runBuild) async {
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (ctx) {
        D4rtProfile.enabled = true;
        D4rtProfile.reset();
        runBuild(ctx);
        D4rtProfile.enabled = false;
        _line('PHASES [$label]\n${D4rtProfile.report()}');
        return const SizedBox.shrink();
      })));
      await tester.pump(const Duration(milliseconds: 16));
    }

    await phaseBreakdown('SINGLE trivial',
        (ctx) => d4rt.build<Widget>(_trivialSource, ctx));
    await phaseBreakdown(
        'SINGLE complex', (ctx) => d4rt.build<Widget>(complexSrc, ctx));
    await phaseBreakdown('MULTI calculator',
        (ctx) => d4rt.buildMultiFile<Widget>(_mainPath('calculator'),
            buildContext: ctx));
  }, timeout: const Timeout(Duration(minutes: 4)));
}
