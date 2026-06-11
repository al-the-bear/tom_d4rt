/// Navigation-stress regression for the `particle_field` sample.
///
/// The interactive freeze reported against `particle_field` could not be
/// reproduced by the auto-cycling `profiler_field` harness — because that
/// harness mounts the sample exactly once and never tears it down. The one
/// thing the interactive session does that the harness never did is
/// *navigate in and out of the sample repeatedly*, each time re-running
/// `buildMultiFile` on the SHARED [SourceFlutterD4rt] instance (see
/// `lib/src/widgets/sample_app_page.dart`, which passes one `d4rt` into
/// every `SampleAppPage`).
///
/// If a navigation cycle leaks — i.e. the disposed interpreted widget tree
/// (its `Environment`, captured closures, bridged instances) stays reachable
/// from the shared interpreter — then repeated entry would grow the heap
/// without bound, and eventually every GC becomes a multi-second
/// stop-the-world pause. That matches the user's "runs lively, then freezes
/// 30s–1m, then recovers, then freezes again" sawtooth.
///
/// This test drives many enter → play → switch-modes → move-attractor → exit
/// cycles and asserts process RSS stays bounded. A genuine per-navigation
/// leak dwarfs GC lag over this many iterations, so a monotonic climb is the
/// leak signature; a flat/bounded trace is evidence the navigation path is
/// sound post-fix (commit 63bf61f38).
@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart' show D4rtDiag;
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

/// Shared interpreter — mirrors the real app, where one [SourceFlutterD4rt]
/// is reused across every `SampleAppPage`. Sharing is the whole point: a
/// fresh interpreter per cycle could not leak across navigations.
late SourceFlutterD4rt _d4rt;

String _particleFieldMain() {
  final candidates = <String>[
    p.join(Directory.current.path, 'example', 'particle_field', 'main.dart'),
    p.join(
        Directory.current.path, '..', 'example', 'particle_field', 'main.dart'),
  ];
  for (final c in candidates) {
    if (File(c).existsSync()) return p.normalize(c);
  }
  throw StateError('Could not find example/particle_field/main.dart. '
      'CWD=${Directory.current.path}');
}

void main() {
  setUpAll(() {
    _d4rt = SourceFlutterD4rt();
  });

  testWidgets(
    'repeated navigate-in/out of particle_field does not leak (bounded RSS)',
    (tester) async {
      final mainPath = _particleFieldMain();
      // The world is 600x400; give the canvas room so hover hit-tests land.
      tester.view.physicalSize = const Size(900, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      const cycles = 6;
      final rssMb = <double>[];

      for (var i = 0; i < cycles; i++) {
        // --- navigate IN: fresh host -> re-interprets on shared _d4rt ------
        await tester.pumpWidget(_NavHost(d4rt: _d4rt, mainPath: mainPath));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        expect(find.byType(CustomPaint), findsWidgets,
            reason: 'particle_field should mount on cycle $i');

        // --- play: start the raw Ticker driving stepField per frame --------
        final playPause = find.byKey(const Key('btn-play-pause'));
        if (playPause.evaluate().isNotEmpty) {
          await tester.tap(playPause);
          await tester.pump();
        }

        // --- exercise the interpreter hot path: mode switches + frames -----
        for (final mode in const ['Repel', 'Orbit', 'Attract']) {
          final seg = find.text(mode);
          if (seg.evaluate().isNotEmpty) {
            await tester.tap(seg.first, warnIfMissed: false);
          }
          // Advance simulated time so the fake Ticker fires _onFrame and the
          // interpreted tree rebuilds repeatedly (the per-frame churn path).
          for (var f = 0; f < 8; f++) {
            await tester.pump(const Duration(milliseconds: 16));
          }
          // Move the attractor (mimics the macOS hover storm: every move is a
          // setState -> full interpreted-tree rebuild).
          final canvas = find.byKey(const Key('field-canvas'));
          if (canvas.evaluate().isNotEmpty) {
            final center = tester.getCenter(canvas.first);
            await tester.tapAt(center + Offset(10.0 * (f1(i)), 0));
            await tester.pump(const Duration(milliseconds: 16));
          }
        }

        // --- navigate OUT: replace the tree so the interpreted State, its
        //     Ticker, and the captured Environment are disposed. ------------
        await tester.pumpWidget(const _Empty());
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Give the VM a beat to reclaim; RSS won't shrink without GC, but a
        // real leak grows far faster than GC lag over 16 cycles.
        final rss = ProcessInfo.currentRss / (1024 * 1024);
        rssMb.add(rss);
        // ignore: avoid_print
        print('[nav-leak] cycle ${i.toString().padLeft(2)}  '
            'RSS=${rss.toStringAsFixed(1)} MB');
      }

      // Baseline = mean of the first 3 cycles (warmup: bridge tables, JIT,
      // first interpret). Compare the last 3 against it.
      final warmup = (rssMb[0] + rssMb[1] + rssMb[2]) / 3.0;
      final tail =
          (rssMb[cycles - 3] + rssMb[cycles - 2] + rssMb[cycles - 1]) / 3.0;
      final growth = tail - warmup;
      // ignore: avoid_print
      print('[nav-leak] warmup=${warmup.toStringAsFixed(1)}MB '
          'tail=${tail.toStringAsFixed(1)}MB '
          'growth=${growth.toStringAsFixed(1)}MB over ${cycles - 3} cycles');

      // A per-navigation leak of a ~600MB interpreter graph would add
      // hundreds of MB per cycle. Allow generous headroom for GC lag /
      // allocator fragmentation but flag a clear monotonic climb.
      expect(growth, lessThan(400.0),
          reason: 'RSS grew ${growth.toStringAsFixed(1)}MB across navigations '
              '— a per-navigation retained-graph leak. Trace: $rssMb');
    },
    timeout: const Timeout(Duration(minutes: 4)),
  );

  _registerSingleMountProbe();
}

/// Small deterministic jitter so successive attractor taps land at slightly
/// different points (exercises distinct setState paths without RNG).
int f1(int i) => (i % 5) - 2;

/// Single-mount build-time growth probe.
///
/// The DevTools performance trace from the interactive freeze shows a single
/// `BUILD` slice of 61 SECONDS (normally ~18ms) with negligible GC inside —
/// i.e. the freeze is the interpreter executing one `build()` for tens of
/// seconds, not a GC pause. 61s / 16ms ≈ 3400× ≈ ~3400 frames at 60fps ≈
/// "freezes after ~1m". That signature is per-frame work that GROWS while the
/// sample stays mounted (each interpreted `build()` recreates gesture / hover
/// / onChanged / onPressed closures; if the interpreter retains them, build
/// cost climbs frame over frame).
///
/// This probe mounts particle_field ONCE, plays it, and pumps a few thousand
/// frames with periodic mode switches + attractor taps, timing every pump. If
/// the mean pump time at the END is dramatically larger than at the START,
/// build cost is growing within a single session — the freeze cause.
void _registerSingleMountProbe() {
  testWidgets(
    'single-mount particle_field: per-frame build time stays bounded',
    (tester) async {
      final mainPath = _particleFieldMain();
      tester.view.physicalSize = const Size(900, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_NavHost(d4rt: _d4rt, mainPath: mainPath));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      final playPause = find.byKey(const Key('btn-play-pause'));
      if (playPause.evaluate().isNotEmpty) {
        await tester.tap(playPause);
        await tester.pump();
      }

      const totalFrames = 2400; // ~40s of 60fps frames
      final sw = Stopwatch();
      final buckets = <int, List<int>>{}; // 100-frame bucket -> pump micros
      final callBuckets = <int, List<num>>{}; // 100-frame bucket -> calls/pump
      final depthBuckets = <int, List<num>>{}; // 100-frame bucket -> maxDepth
      final rssBuckets = <int, List<num>>{}; // 100-frame bucket -> RSS (MB)
      final canvas = find.byKey(const Key('field-canvas'));
      Offset? canvasCenter;
      if (canvas.evaluate().isNotEmpty) {
        canvasCenter = tester.getCenter(canvas.first);
      }

      final slowFrames = <String>[];
      for (var frame = 0; frame < totalFrames; frame++) {
        // Periodic interaction, mirroring the interactive session.
        var didSwitch = false;
        var switchedTo = '';
        if (frame % 120 == 0) {
          switchedTo = const ['Repel', 'Orbit', 'Attract'][(frame ~/ 120) % 3];
          final seg = find.text(switchedTo);
          if (seg.evaluate().isNotEmpty) {
            await tester.tap(seg.first, warnIfMissed: false);
            didSwitch = true;
          }
        }
        var didTap = false;
        if (frame % 7 == 0 && canvasCenter != null) {
          await tester.tapAt(
              canvasCenter + Offset(20.0 * f1(frame ~/ 7), 10.0 * f1(frame)));
          didTap = true;
        }
        // Snapshot interpreter counters across the pump so a slow frame can be
        // attributed to call volume vs. recursion depth (the latter is what
        // makes exception-based `return` unwinding expensive).
        D4rtDiag.reset();
        sw.reset();
        sw.start();
        await tester.pump(const Duration(milliseconds: 16));
        sw.stop();
        final calls = D4rtDiag.callCount;
        final maxDepth = D4rtDiag.maxDepth;
        final us = sw.elapsedMicroseconds;
        final rssMb = ProcessInfo.currentRss / (1024 * 1024);
        final b = frame ~/ 100;
        buckets.putIfAbsent(b, () => <int>[]).add(us);
        callBuckets.putIfAbsent(b, () => <num>[]).add(calls);
        depthBuckets.putIfAbsent(b, () => <num>[]).add(maxDepth);
        rssBuckets.putIfAbsent(b, () => <num>[]).add(rssMb);
        if (us > 1000 * 1000) {
          slowFrames.add('frame=$frame  ${(us / 1e6).toStringAsFixed(2)}s  '
              'calls=$calls  maxDepth=$maxDepth  '
              'RSS=${rssMb.toStringAsFixed(0)}MB  '
              'modeSwitch=$didSwitch(${didSwitch ? switchedTo : "-"})  '
              'attractorTap=$didTap');
        }
      }
      // ignore: avoid_print
      print('[build-growth] SLOW pumps (>1s): ${slowFrames.length}');
      for (final s in slowFrames) {
        // ignore: avoid_print
        print('  >> $s');
      }

      double meanMs(int bucket) {
        final xs = buckets[bucket]!;
        return xs.reduce((a, b) => a + b) / xs.length / 1000.0;
      }

      double meanOf(Map<int, List<num>> m, int bucket) {
        final xs = m[bucket]!;
        return xs.reduce((a, b) => a + b) / xs.length;
      }

      num maxOf(Map<int, List<num>> m, int bucket) =>
          m[bucket]!.reduce((a, b) => a > b ? a : b);

      final firstBuckets = [0, 1, 2];
      final lastBuckets = [
        (totalFrames ~/ 100) - 3,
        (totalFrames ~/ 100) - 2,
        (totalFrames ~/ 100) - 1,
      ];
      final startMean =
          firstBuckets.map(meanMs).reduce((a, b) => a + b) / firstBuckets.length;
      final endMean =
          lastBuckets.map(meanMs).reduce((a, b) => a + b) / lastBuckets.length;
      final ratio = endMean / startMean;

      // ignore: avoid_print
      print('[build-growth] per-100-frame mean pump (ms) | mean calls | '
          'max depth:');
      for (final bk in buckets.keys.toList()..sort()) {
        // ignore: avoid_print
        print('  frames ${bk * 100}-${bk * 100 + 99}: '
            '${meanMs(bk).toStringAsFixed(2)} ms | '
            'calls~${meanOf(callBuckets, bk).toStringAsFixed(0)} | '
            'depth<=${maxOf(depthBuckets, bk)} | '
            'RSS~${meanOf(rssBuckets, bk).toStringAsFixed(0)}MB');
      }
      // ignore: avoid_print
      print('[build-growth] startMean=${startMean.toStringAsFixed(2)}ms '
          'endMean=${endMean.toStringAsFixed(2)}ms ratio=${ratio.toStringAsFixed(2)}x');

      expect(ratio, lessThan(3.0),
          reason: 'Per-frame build cost grew ${ratio.toStringAsFixed(1)}x over '
              '$totalFrames frames within a single mount — the interpreter is '
              'accumulating per-frame work (the 61s-BUILD freeze cause).');
    },
    timeout: const Timeout(Duration(minutes: 6)),
  );
}

/// Host that interprets the sample exactly once per State instance. A fresh
/// [_NavHost] (new State) re-interprets — exactly what pushing a new
/// `SampleAppPage` does in the real app.
class _NavHost extends StatefulWidget {
  final SourceFlutterD4rt d4rt;
  final String mainPath;
  const _NavHost({required this.d4rt, required this.mainPath});

  @override
  State<_NavHost> createState() => _NavHostState();
}

class _NavHostState extends State<_NavHost> {
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
        print('[nav-leak] interpret failed: $e');
      }
    }
    if (_err != null) {
      return MaterialApp(home: Scaffold(body: Text('err: $_err')));
    }
    return _built ?? const SizedBox.shrink();
  }
}

class _Empty extends StatelessWidget {
  const _Empty();
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: Scaffold(body: SizedBox.shrink()));
}
