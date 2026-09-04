/// PERF step #3 regression tests for the performance-optimization plan
/// (`_ai/quests/d4rt/performance_optimization_plan.md`) on the analyzer-based
/// `D4rt` (mirror of `tom_d4rt_ast`'s `bridge_retention_test.dart`).
///
/// Step #3 eliminates the per-run `BridgedClass` / parsed-AST retention that the
/// baseline heap snapshot exposed (~86k `BridgedClass` across 88 generations,
/// 88 retained `CompilationUnitImpl`). The deterministic, profiler-free proof:
///
///  (a) Across N≥20 sequential executes on one migrated instance, the shared
///      bridge surface is built **once** (`debugBridgedModuleEnvBuildCount`
///      stays flat) and the pooled class count is constant — the ~982-class
///      surface is shared, not re-instantiated ~982/run.
///  (b) Parsed-module retention does not grow per run: `debugLoadedModuleCount`
///      stays bounded (each execute builds a fresh loader; prior runs' ASTs are
///      dropped, never accumulated).
///  (c) `dispose()` releases the finished run's artifacts (loader cache +
///      visitor) — `debugLoadedModuleCount` → 0, `visitor` → null — while
///      keeping the process-global shared caches intact, so a follow-up execute
///      still works.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  /// A marker [BridgedClass] — gives a library URI bridged content so importing
  /// it reaches the per-module env build path.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('PERF-3: per-run BridgedClass / AST retention (analyzer D4rt)', () {
    setUp(D4rt.debugResetPool);
    tearDown(D4rt.debugResetPool);

    test('PERF-3a: N sequential executes share the bridge surface — no per-run '
        'rebuild, constant pooled class count', () {
      final interpreter = D4rt();
      expect(interpreter.providePackage('pkg_w'), isFalse);
      interpreter.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );

      const n = 24;
      int? buildsAfterFirst;
      int? pooledAfterFirst;
      for (var i = 0; i < n; i++) {
        final r = interpreter.execute(
          source: "import 'package:w/w.dart';\nint main() => $i;",
        );
        expect(r, i, reason: 'each run returns its own value');

        if (i == 0) {
          buildsAfterFirst = D4rt.debugBridgedModuleEnvBuildCount;
          pooledAfterFirst = D4rt.debugPooledClassCount('pkg_w');
          expect(
            buildsAfterFirst,
            1,
            reason: 'the bridge surface is built once on the first execute',
          );
        } else {
          expect(
            D4rt.debugBridgedModuleEnvBuildCount,
            buildsAfterFirst,
            reason: 'run $i must reuse the cached bridge surface — no rebuild',
          );
          expect(
            D4rt.debugPooledClassCount('pkg_w'),
            pooledAfterFirst,
            reason:
                'pooled class count is constant — defs are not '
                're-instantiated per run',
          );
        }
      }
    });

    test('PERF-3b: parsed-module retention stays bounded across N executes '
        '(prior runs’ ASTs are not accumulated)', () {
      final interpreter = D4rt();
      expect(interpreter.providePackage('pkg_w'), isFalse);
      interpreter.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );

      const n = 24;
      int? countAfterFirst;
      for (var i = 0; i < n; i++) {
        interpreter.execute(
          source: "import 'package:w/w.dart';\nint main() => $i;",
        );
        final loaded = interpreter.debugLoadedModuleCount;
        if (i == 0) {
          countAfterFirst = loaded;
        } else {
          expect(
            loaded,
            countAfterFirst,
            reason:
                'run $i retains the same bounded module count as run 0 — '
                'ASTs do not accumulate across executes',
          );
        }
      }
    });

    test('PERF-3c: dispose() releases the finished run’s artifacts and stays '
        'reusable', () {
      final interpreter = D4rt();
      expect(interpreter.providePackage('pkg_w'), isFalse);
      interpreter.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );

      final first = interpreter.execute(
        source: "import 'package:w/w.dart';\nint main() => 7;",
      );
      expect(first, 7);
      expect(
        interpreter.debugLoadedModuleCount,
        greaterThan(0),
        reason: 'a finished run retains its parsed module(s)',
      );
      expect(interpreter.visitor, isNotNull);

      final pooledBefore = D4rt.debugPooledClassCount('pkg_w');
      final buildsBefore = D4rt.debugBridgedModuleEnvBuildCount;

      interpreter.dispose();
      expect(
        interpreter.debugLoadedModuleCount,
        0,
        reason: 'dispose drops the parsed-module cache',
      );
      expect(
        interpreter.visitor,
        isNull,
        reason: 'dispose drops the interpreter visitor',
      );
      // Shared process-global caches are preserved — dispose is non-destructive.
      expect(
        D4rt.debugPooledClassCount('pkg_w'),
        pooledBefore,
        reason: 'dispose preserves the shared package pool',
      );
      expect(
        D4rt.debugBridgedModuleEnvBuildCount,
        buildsBefore,
        reason: 'dispose does not evict the shared bridged-module env cache',
      );

      // The instance remains fully usable after dispose.
      final second = interpreter.execute(
        source: "import 'package:w/w.dart';\nint main() => 11;",
      );
      expect(second, 11, reason: 'execute works again after dispose');
      expect(
        D4rt.debugBridgedModuleEnvBuildCount,
        buildsBefore,
        reason: 're-execute reuses the preserved shared bridge surface',
      );
    });
  });
}
