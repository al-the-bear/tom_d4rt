/// Regression tests for the `reuseAcrossRuns` isolation toggle on the
/// analyzer-based `D4rt` (mirror of `tom_d4rt_ast`'s
/// `reuse_across_runs_toggle_test.dart`).
///
/// The performance caches (warm parent + per-bridged-module environments) are
/// **on by default** for *every* instance, including legacy ones that never
/// called `providePackage`. Legacy instances reuse a *per-instance* bridged-
/// module env cache (never shared across instances, so `<default>`-package
/// bridges cannot substitute into another interpreter), while still binding the
/// transitive bridge surface once and reusing it across `execute` calls.
///
/// `D4rt(reuseAcrossRuns: false)` opts out: the warm parent and bridged module
/// environments are rebuilt fresh on every run for full inter-run isolation.
///
/// Both contracts are pinned via the process-global
/// [D4rt.debugBridgedModuleEnvBuildCount] counter, which increments only when a
/// module env is actually *built* (a cache miss):
///
///  (a) default-on: a legacy instance re-importing the same bridged URI reuses
///      its per-instance cached env across executes — the count does not
///      advance on the second run.
///  (b) opt-out: a legacy instance constructed with `reuseAcrossRuns: false`
///      rebuilds the module env on every run — the count advances each time.
///  (c) invalidation: registering a new bridge after a run (on the same
///      default-on legacy instance) drops the per-instance cache, so the next
///      run rebuilds.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  /// A marker [BridgedClass] — only used to give a library URI bridged content
  /// so importing it reaches the per-module env build path.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('reuseAcrossRuns toggle (analyzer D4rt)', () {
    // The module-env cache, warm-parent cache and package pool are all
    // process-global; reset before/after each test so build-count assertions
    // are order-independent.
    setUp(D4rt.debugResetPool);
    tearDown(D4rt.debugResetPool);

    test(
        'default-on: a legacy instance reuses its per-instance module env '
        'across executes', () {
      // No providePackage → legacy instance (empty allowed-set).
      final interpreter = D4rt();
      interpreter.registerBridgedClass(marker('WClass'), 'package:w/w.dart',
          sourceUri: 'package:w/w.dart');

      const src = "import 'package:w/w.dart';\nint main() => 1;";

      interpreter.execute(source: src);
      final afterFirst = D4rt.debugBridgedModuleEnvBuildCount;
      expect(afterFirst, 1,
          reason: 'the first import builds the per-module env exactly once');

      interpreter.execute(source: src);
      expect(D4rt.debugBridgedModuleEnvBuildCount, afterFirst,
          reason: 'with reuseAcrossRuns on (default) the second execute reuses '
              'the per-instance cached env — no rebuild');
    });

    test(
        'opt-out: reuseAcrossRuns:false rebuilds the module env on every run',
        () {
      final interpreter = D4rt(reuseAcrossRuns: false);
      interpreter.registerBridgedClass(marker('WClass'), 'package:w/w.dart',
          sourceUri: 'package:w/w.dart');

      const src = "import 'package:w/w.dart';\nint main() => 1;";

      interpreter.execute(source: src);
      expect(D4rt.debugBridgedModuleEnvBuildCount, 1,
          reason: 'first run builds the module env');

      interpreter.execute(source: src);
      expect(D4rt.debugBridgedModuleEnvBuildCount, 2,
          reason: 'with reuseAcrossRuns off every run rebuilds for isolation');
    });

    test(
        'invalidation: registering after a run drops the per-instance cache',
        () {
      final interpreter = D4rt();
      interpreter.registerBridgedClass(marker('WClass'), 'package:w/w.dart',
          sourceUri: 'package:w/w.dart');

      const src = "import 'package:w/w.dart';\nint main() => 1;";
      interpreter.execute(source: src);
      expect(D4rt.debugBridgedModuleEnvBuildCount, 1);

      // A new (unrelated) registration must invalidate the per-instance caches
      // so the next run rebinds even for the *same* URI — fixes the latent
      // register-after-execute staleness. Without invalidation the cached `w`
      // env would be reused and the count would stay 1.
      interpreter.registerBridgedClass(marker('XClass'), 'package:x/x.dart',
          sourceUri: 'package:x/x.dart');

      interpreter.execute(source: src);
      expect(D4rt.debugBridgedModuleEnvBuildCount, 2,
          reason: 'the post-run registration dropped the cache, so re-importing '
              'the same URI rebuilds');
    });
  });
}
