// Import-optimization step #36 — first-run / per-execute timing confirmation.
//
// Like `registration_skip_test.dart`, this is a pure in-process unit test: it
// does NOT spawn the HTTP companion app, so it is safe to run alongside the
// serial Flutter corpus. Where `registration_skip_test` proves the *structural*
// property (a second `FlutterD4rt()` reuses the pooled bundle), this test
// measures the *wall-clock* payoff the import-optimization plan set out to
// realize, and isolates the two costs from each other and from irreducible
// interpretation:
//
//   Cost A (first `FlutterD4rt()` construction): historically ~600 ms to build
//   every `BridgedClass` definition eagerly. With lazy thunks + the
//   process-global package pool, construction now only *pools* thunks; the
//   second construction in the same process is a pure pool hit (near-zero), and
//   the residual eager warm-parent build is deferred to `warmup()` / the first
//   execute so it can be paid off-frame (step #21).
//
//   Cost B (per `execute()`): historically ~840 ms re-running the O(N×M)
//   registry scan on every build. With the URI-keyed registry + warm-parent
//   `Environment` cache, the quadratic re-scan is gone and the runner
//   infrastructure (stdlib + pooled bridge surface) is built once per process
//   and reused — every execute chains a fresh child off the cached warm parent.
//   We isolate the costs by comparing a material-importing bundle against a
//   bare bundle that imports nothing: the bare bundle's sub-millisecond warm
//   reuse proves the per-execute *infrastructure rebuild* is eliminated.
//
//   RESIDUAL (measured, documented, not yet eliminated): the warm material
//   execute is ~200 ms, NOT near-zero. The delta over the bare bundle is the
//   per-execute *import-resolution* cost — each `executeBundle` builds a fresh
//   `AstModuleLoader`, so material's per-import module environment (≈2k bridge
//   thunks + the re-export merge, then `importEnvironment` copying them into
//   the execution child) is reassembled every execute. The O(N×M) re-scan and
//   the per-execute bridge *rebuild* are both gone; this residual O(surface)
//   import-resolution copy is a tracked follow-up (hoist the per-URI bridged-
//   module environments to runner scope). The asserts below guard the realized
//   invariants, not the not-yet-realized near-zero target.
//
// We deliberately assert only the *ordering / ratio* invariants, never absolute
// wall-clock thresholds: CI hosts vary wildly and a millisecond gate would be a
// flaky test. The absolute numbers are printed for the record / trend tracking,
// mirroring the philosophy of `tom_d4rt_generator/test/perf/d4rt_perf_test.dart`.

// ignore_for_file: avoid_print  // perf test: print is the measurement channel
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';
// Host-side analyzer front-end: parses script source into an AstBundle. This is
// the one allowed coupling to the analyzer toolchain — it lives only in the
// test driver. The runtime (FlutterD4rt / tom_d4rt_ast) executes the resulting
// bundle with no analyzer dependency.
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

/// Median of the elapsed-microsecond samples (sorted copy, middle element).
int _medianUs(List<int> samples) {
  final sorted = [...samples]..sort();
  return sorted[sorted.length ~/ 2];
}

/// Run [body] [n] times, returning the per-call median elapsed microseconds.
int _medianRunUs(int n, void Function() body) {
  final samples = <int>[];
  for (var i = 0; i < n; i++) {
    final sw = Stopwatch()..start();
    body();
    sw.stop();
    samples.add(sw.elapsedMicroseconds);
  }
  return _medianUs(samples);
}

void main() {
  // The pool + warm-parent caches are process-global; reset around the test so
  // the "first construction" timing reflects a genuinely cold pool.
  setUp(D4rtRunner.debugResetPool);
  tearDown(D4rtRunner.debugResetPool);

  test('Cost A + Cost B realized: cold vs warm, registration isolated',
      () async {
    // A material-importing script whose entry returns a plain int. Importing
    // `package:flutter/material.dart` is what triggers the full Material bridge
    // import-registration (Cost B); the body returns a stable int so the
    // measurement needs no BuildContext and no widget rendering.
    const materialSource = '''
import 'package:flutter/material.dart';
int main() => Icons.add.codePoint;
''';
    // A bare script that imports nothing — the interpreter's per-bundle baseline
    // with zero bridge import-registration. The delta between this and the
    // material bundle's warm reuse is the residual per-execute registration cost.
    const bareSource = '''
int main() {
  var acc = 0;
  for (var i = 0; i < 100; i++) {
    acc += i;
  }
  return acc;
}
''';

    // --- Cost A: first construction WITHOUT warmup (lazy thunks pooled) -------
    final swFirstCtor = Stopwatch()..start();
    final d4rt = FlutterD4rt();
    swFirstCtor.stop();

    // --- Cost A: second instance construction (pool hit → registration skip) --
    final swSecondCtor = Stopwatch()..start();
    FlutterD4rt();
    swSecondCtor.stop();

    // --- Residual eager warm-parent build, deferred off construction ---------
    final swWarmup = Stopwatch()..start();
    d4rt.warmup();
    swWarmup.stop();

    // Build the bundles once (not part of either cost — this is the host-side
    // analyzer compile, which has no on-device equivalent).
    final bundler =
        AstBundler(bridgedLibraries: d4rt.interpreter.bridgedLibraryUris);
    final materialBundle = await bundler.createFromSource(materialSource,
        sourcePath: 'perf_material.dart');
    final bareBundle =
        await bundler.createFromSource(bareSource, sourcePath: 'perf_bare.dart');

    // --- Cost B: first (cold) material execute -------------------------------
    final swColdExec = Stopwatch()..start();
    final firstResult = d4rt.execute<int>(materialBundle, name: 'main');
    swColdExec.stop();

    // --- Cost B: warm reuse of the material bundle ---------------------------
    final materialWarmUs =
        _medianRunUs(10, () => d4rt.execute<int>(materialBundle, name: 'main'));

    // --- Baseline: warm reuse of the bare (no-import) bundle ------------------
    final bareWarmUs =
        _medianRunUs(10, () => d4rt.execute<int>(bareBundle, name: 'main'));

    String ms(int us) => (us / 1000).toStringAsFixed(3);
    print('=== Import-optimization perf (Step #36, AST twin) ===');
    print('Cost A  first construction (no warmup):  '
        '${swFirstCtor.elapsedMicroseconds / 1000} ms');
    print('Cost A  second construction (pool hit):  '
        '${swSecondCtor.elapsedMicroseconds / 1000} ms');
    print('        deferred warm-parent build (warmup): '
        '${swWarmup.elapsedMilliseconds} ms');
    print('Cost B  cold first material execute:     '
        '${swColdExec.elapsedMilliseconds} ms');
    print('Cost B  warm material execute (median):  ${ms(materialWarmUs)} ms');
    print('        warm bare execute (median):      ${ms(bareWarmUs)} ms');
    print('        per-execute registration delta:  '
        '${ms(materialWarmUs - bareWarmUs)} ms '
        '(material warm − bare warm)');

    // The script executed end to end (proves the material import path ran).
    expect(firstResult, isA<int>());
    expect(firstResult, greaterThan(0));

    // Cost A realized: the pool-hit second construction is far cheaper than the
    // first construction that pooled the bridge surface.
    expect(swSecondCtor.elapsedMicroseconds,
        lessThan(swFirstCtor.elapsedMicroseconds),
        reason: 'second construction must hit the pool and skip registration');

    // Cost B (warm-parent infrastructure overhead eliminated): a bare bundle
    // that imports nothing chains off the cached warm parent and runs in well
    // under a millisecond. If warm-parent reuse had regressed (every execute
    // rebuilding stdlib + the pooled bridge surface into a fresh Environment),
    // even the bare bundle would pay that cost. Sub-millisecond bare reuse
    // proves the per-execute *infrastructure* rebuild is gone.
    expect(bareWarmUs, lessThan(swColdExec.elapsedMicroseconds),
        reason: 'bare warm execute must reuse the warm parent, not rebuild '
            'the runner infrastructure');

    // Cost B (core fix realized — no per-execute bridge *rebuild*): warm reuse
    // of the material bundle must be cheaper than building the whole bridge
    // surface from scratch (the one-time warmup). The pre-optimization code
    // re-ran the O(N×M) registry scan and rebuilt every BridgedClass on EVERY
    // execute, so a warm material execute would have cost AT LEAST a full
    // warmup. Coming in well under warmup proves the bridge *definitions* are
    // built once per process and reused, not rebuilt per execute — this is the
    // regression guard against the O(N×M) re-scan returning.
    expect(materialWarmUs, lessThan(swWarmup.elapsedMicroseconds),
        reason: 'warm material execute must not rebuild the bridge surface — '
            'it must be cheaper than a full warmup build');

    // Cost B (warm-parent reuse): warm reuse must also beat the cold first
    // execute, which pays the one-time lazy materialization on top of import
    // resolution.
    expect(materialWarmUs, lessThan(swColdExec.elapsedMicroseconds),
        reason: 'warm executes must chain off the cached warm parent, not '
            're-run the cold-start build');

    // DOCUMENTED RESIDUAL (not asserted as near-zero): the warm material
    // execute is ~200 ms, NOT near-zero like the bare bundle (sub-ms). The
    // delta is the per-execute import-resolution cost: each `executeBundle`
    // builds a fresh `AstModuleLoader`, so material's per-import module
    // environment (≈2k bridge thunks + the re-export merge, then
    // `importEnvironment` copying them into the execution child) is reassembled
    // every execute. The quadratic O(N×M) re-scan IS gone (asserted above) and
    // the runner infrastructure is reused, but this residual O(surface)
    // import-resolution cost remains. Follow-up: hoist the per-URI bridged-
    // module environments to runner scope so they are built once per process.
    // See completion_steps.d4rt.md — "Hoist per-URI bridged-module environments
    // to runner scope (residual Cost B)".
  });
}
