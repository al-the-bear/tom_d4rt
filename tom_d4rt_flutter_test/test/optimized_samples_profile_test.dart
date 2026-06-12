/// Per-update interpreter-cost profile for the original vs "optimized"
/// Conway's Life and particle-field samples.
///
/// Background: the optimized variants (`*_optimized`) were rewritten to push
/// per-tick mutation through host-owned `ValueNotifier`s + a
/// `CustomPainter(repaint: notifier)`, so the widget tree is interpreted once
/// and only the painter re-runs. In principle that should cut per-frame churn
/// to ~0. In practice the user reports the optimized samples run *worse* than
/// the originals (Conway visibly slow, particle field stalls).
///
/// This harness isolates the cost of ONE logical update and attributes it to
/// the interpreter via the global [D4rtDiag] counters. It does this two ways:
///
///  * STEP   — tap `btn-step`: runs the model step (`stepLife`/`stepField`)
///             AND repaints. For the originals this is `setState` -> full
///             interpreted rebuild + paint; for the optimized it is
///             `notifier.value = next` -> repaint of the interpreted painter.
///  * PAINT  — tap the canvas: a trivial model change (toggle one cell /
///             move the attractor) that triggers a repaint with little/no
///             model work, isolating the interpreted `paint()` cost.
///
/// Each measured pump is bracketed by `D4rtDiag.reset()` so the counters
/// capture exactly that pump's interpreter work (build + paint).
@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart' show D4rtDiag;
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

late SourceFlutterD4rt _d4rt;

String _mainPath(String sample) {
  final candidates = <String>[
    p.join(Directory.current.path, 'example', sample, 'main.dart'),
    p.join(Directory.current.path, '..', 'example', sample, 'main.dart'),
  ];
  for (final c in candidates) {
    if (File(c).existsSync()) return p.normalize(c);
  }
  throw StateError('Could not find example/$sample/main.dart. '
      'CWD=${Directory.current.path}');
}

/// One measured sample of a pump's interpreter work.
class _Sample {
  final int micros;
  final int calls;
  final int depth;
  final int env;
  final int closures;
  final int instances;
  final int bridged;
  const _Sample(this.micros, this.calls, this.depth, this.env, this.closures,
      this.instances, this.bridged);
}

double _mean(Iterable<num> xs) =>
    xs.isEmpty ? 0.0 : xs.reduce((a, b) => a + b) / xs.length;

num _max(Iterable<num> xs) =>
    xs.isEmpty ? 0 : xs.reduce((a, b) => a > b ? a : b);

void _report(String label, List<_Sample> s) {
  if (s.isEmpty) {
    // ignore: avoid_print
    print('[profile] $label: NO SAMPLES');
    return;
  }
  // ignore: avoid_print
  print('[profile] $label  (n=${s.length})\n'
      '    pump ms   mean=${(_mean(s.map((e) => e.micros)) / 1000).toStringAsFixed(2)}'
      '  max=${(_max(s.map((e) => e.micros)) / 1000).toStringAsFixed(2)}\n'
      '    calls     mean=${_mean(s.map((e) => e.calls)).toStringAsFixed(0)}'
      '  max=${_max(s.map((e) => e.calls))}\n'
      '    maxDepth  ${_max(s.map((e) => e.depth))}\n'
      '    env       mean=${_mean(s.map((e) => e.env)).toStringAsFixed(0)}'
      '  max=${_max(s.map((e) => e.env))}\n'
      '    closures  mean=${_mean(s.map((e) => e.closures)).toStringAsFixed(0)}'
      '  max=${_max(s.map((e) => e.closures))}\n'
      '    instances mean=${_mean(s.map((e) => e.instances)).toStringAsFixed(0)}\n'
      '    bridged   mean=${_mean(s.map((e) => e.bridged)).toStringAsFixed(0)}'
      '  max=${_max(s.map((e) => e.bridged))}');
}

/// Measure ONE logical update end-to-end: run [action] (the interpreted
/// gesture callback fires synchronously inside it — e.g. the model step) AND
/// the following frame's rebuild + paint, all inside one reset window.
Future<_Sample> _measuredUpdate(
    WidgetTester tester, Future<void> Function() action) async {
  D4rtDiag.reset();
  final sw = Stopwatch()..start();
  await action();
  await tester.pump(const Duration(milliseconds: 16));
  sw.stop();
  return _Sample(
    sw.elapsedMicroseconds,
    D4rtDiag.callCount,
    D4rtDiag.maxDepth,
    D4rtDiag.envAllocs,
    D4rtDiag.closureAllocs,
    D4rtDiag.instanceAllocs,
    D4rtDiag.bridgedAllocs,
  );
}

void main() {
  setUp(() {
    _d4rt = SourceFlutterD4rt();
  });

  for (final sample in const [
    'conway_life',
    'conway_life_optimized',
    'particle_field',
    'particle_field_optimized',
  ]) {
    testWidgets('profile $sample', (tester) async {
      final mainPath = _mainPath(sample);
      tester.view.physicalSize = const Size(900, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_Host(d4rt: _d4rt, mainPath: mainPath));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(find.byType(CustomPaint), findsWidgets,
          reason: '$sample should mount');

      final isLife = sample.startsWith('conway');
      final canvasKey = isLife ? const Key('life-board') : const Key('field-canvas');

      // --- Seed Conway with a small live cluster so stepLife has work and the
      //     comparison with the (population-sensitive) original is fair. The
      //     particle field is auto-seeded with 20 particles. ---
      if (isLife) {
        final board = find.byKey(canvasKey);
        if (board.evaluate().isNotEmpty) {
          final c = tester.getCenter(board.first);
          for (var dx = -2; dx <= 2; dx++) {
            for (var dy = -2; dy <= 2; dy++) {
              await tester.tapAt(c + Offset(dx * 14.0, dy * 14.0));
              await tester.pump(const Duration(milliseconds: 1));
            }
          }
        }
      }

      final step = find.byKey(const Key('btn-step'));
      final hasStep = step.evaluate().isNotEmpty;

      // --- Warm up the JIT / bridge tables (not measured). ---
      for (var i = 0; i < 5; i++) {
        if (hasStep) await tester.tap(step);
        await tester.pump(const Duration(milliseconds: 16));
      }

      // --- STEP measurement: model step (runs in tap) + rebuild/repaint. ---
      const stepCount = 40;
      final stepSamples = <_Sample>[];
      for (var i = 0; i < stepCount; i++) {
        stepSamples.add(await _measuredUpdate(tester, () async {
          if (hasStep) await tester.tap(step);
        }));
      }
      _report('$sample :: STEP (model + rebuild/repaint)', stepSamples);

      // --- PAINT-ish measurement: trivial model change that triggers a repaint
      //     of the interpreted painter, isolating paint() cost. ---
      final canvas = find.byKey(canvasKey);
      final paintSamples = <_Sample>[];
      if (canvas.evaluate().isNotEmpty) {
        final center = tester.getCenter(canvas.first);
        for (var i = 0; i < 20; i++) {
          final off = Offset((i % 7) * 6.0, (i % 5) * 6.0);
          paintSamples.add(await _measuredUpdate(tester, () async {
            await tester.tapAt(center + off);
          }));
        }
      }
      _report('$sample :: PAINT (canvas tap -> rebuild/repaint)', paintSamples);

      // --- AUTO-PLAY: drive the real running path (ticker/timer -> step ->
      //     rebuild/repaint) with NO interaction, exactly as the app does when
      //     you press play. Captures the ticker/timer callback cost too. ---
      final play = find.byKey(const Key('btn-play-pause'));
      if (play.evaluate().isNotEmpty) {
        await tester.tap(play);
        await tester.pump(const Duration(milliseconds: 16));
        const frames = 90;
        final all = <_Sample>[];
        final active = <_Sample>[]; // only pumps that did interpreter work
        for (var i = 0; i < frames; i++) {
          final s = await _measuredUpdate(tester, () async {});
          all.add(s);
          if (s.calls > 5) active.add(s);
        }
        // ignore: avoid_print
        print('[profile] $sample :: AUTO-PLAY  frames=$frames  '
            'activeFrames(calls>5)=${active.length}  '
            'wallTotal=${(_mean(all.map((e) => e.micros)) * all.length / 1000).toStringAsFixed(0)}ms');
        _report('$sample :: AUTO-PLAY active frames', active);
        // Stop the ticker so teardown is clean.
        await tester.tap(play);
        await tester.pump(const Duration(milliseconds: 16));
      }
    }, timeout: const Timeout(Duration(minutes: 6)));
  }
}

/// Host that interprets the sample exactly once (like a real `SampleAppPage`).
class _Host extends StatefulWidget {
  final SourceFlutterD4rt d4rt;
  final String mainPath;
  const _Host({required this.d4rt, required this.mainPath});

  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host> {
  Widget? _built;
  Object? _err;

  @override
  Widget build(BuildContext context) {
    if (_built == null && _err == null) {
      try {
        _built = widget.d4rt
            .buildMultiFile<Widget>(widget.mainPath, buildContext: context);
      } catch (e) {
        _err = e;
        // ignore: avoid_print
        print('[profile] interpret failed: $e');
      }
    }
    if (_err != null) {
      return MaterialApp(home: Scaffold(body: Text('err: $_err')));
    }
    return _built ?? const SizedBox.shrink();
  }
}
