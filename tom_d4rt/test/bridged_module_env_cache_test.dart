/// PERF step #2 regression tests for the performance-optimization plan
/// (`_ai/quests/d4rt/performance_optimization_plan.md`) on the analyzer-based
/// `D4rt` (mirror of `tom_d4rt_ast`'s `bridged_module_env_cache_test.dart`).
///
/// Step #2 caches the fully-registered bridged-module environments per
/// allowed-package signature so the ~982-class flutter bridge surface is built
/// once per process (per signature) instead of being re-registered on every
/// `execute`. These tests pin the cache contract via the
/// [D4rt.debugBridgedModuleEnvBuildCount] introspection counter, which
/// increments only when a module env is actually *built* (a cache miss):
///
///  (a) A second execute on the same migrated instance importing the same
///      bridged URI reuses the cached module env — the build count does not
///      advance.
///  (b) A second migrated interpreter granted the same allowed-set reuses the
///      cached env across instances — still no rebuild.
///  (c) A different allowed-set signature rebuilds the module env (its cache is
///      keyed separately), so the build count advances exactly once.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  /// A marker [BridgedClass] — only used to give a library URI bridged content
  /// so importing it reaches the per-module env build path.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('PERF-2: bridged-module env cache (analyzer D4rt)', () {
    // The module-env cache, warm-parent cache and package pool are all
    // process-global; reset before/after each test so build-count assertions
    // are order-independent.
    setUp(D4rt.debugResetPool);
    tearDown(D4rt.debugResetPool);

    test('PERF-2a: re-importing the same bridged URI reuses the cached module '
        'env across executes', () {
      final interpreter = D4rt();
      expect(interpreter.providePackage('pkg_w'), isFalse);
      interpreter.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );

      const src = "import 'package:w/w.dart';\nint main() => 1;";

      interpreter.execute(source: src);
      final afterFirst = D4rt.debugBridgedModuleEnvBuildCount;
      expect(
        afterFirst,
        1,
        reason: 'the first import builds the per-module env exactly once',
      );

      interpreter.execute(source: src);
      expect(
        D4rt.debugBridgedModuleEnvBuildCount,
        afterFirst,
        reason: 'the second execute reuses the cached env — no rebuild',
      );
    });

    test(
      'PERF-2b: a second interpreter with the same allowed-set reuses it',
      () {
        final first = D4rt();
        expect(first.providePackage('pkg_w'), isFalse);
        first.registerBridgedClass(
          marker('WClass'),
          'package:w/w.dart',
          sourceUri: 'package:w/w.dart',
        );

        const src = "import 'package:w/w.dart';\nint main() => 1;";
        first.execute(source: src);
        expect(D4rt.debugBridgedModuleEnvBuildCount, 1);

        // Second interpreter granted the same package → same signature → shares
        // the cached module env.
        final second = D4rt();
        expect(
          second.providePackage('pkg_w'),
          isTrue,
          reason: 'pkg_w already pooled — second interpreter reuses it',
        );
        second.execute(source: src);
        expect(
          D4rt.debugBridgedModuleEnvBuildCount,
          1,
          reason: 'same allowed-set signature → cached env reused, no rebuild',
        );
      },
    );

    test('PERF-2c: a different allowed-set rebuilds the module env', () {
      final first = D4rt();
      expect(first.providePackage('pkg_w'), isFalse);
      first.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );
      first.execute(source: "import 'package:w/w.dart';\nint main() => 1;");
      expect(D4rt.debugBridgedModuleEnvBuildCount, 1);

      // A second interpreter with a DIFFERENT allowed-set imports a different
      // bridged URI: its cache bucket is keyed separately, so its module env is
      // built fresh.
      final second = D4rt();
      expect(second.providePackage('pkg_v'), isFalse);
      second.registerBridgedClass(
        marker('VClass'),
        'package:v/v.dart',
        sourceUri: 'package:v/v.dart',
      );
      second.execute(source: "import 'package:v/v.dart';\nint main() => 2;");
      expect(
        D4rt.debugBridgedModuleEnvBuildCount,
        2,
        reason: 'a different signature rebuilds the env — count advances',
      );
    });
  });
}
