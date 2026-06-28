/// PERF step #3 regression tests for the performance-optimization plan
/// (`_ai/quests/d4rt/performance_optimization_plan.md`) on the analyzer-free
/// `D4rtRunner` (mirror of `tom_d4rt`'s `bridge_retention_test.dart`).
///
/// Step #3 eliminates the per-run `BridgedClass` / parsed-AST retention that the
/// baseline heap snapshot exposed (~86k `BridgedClass` across 88 generations,
/// 88 retained AST generations). The deterministic, profiler-free proof:
///
///  (a) Across N≥20 sequential executes on one migrated runner, the shared
///      bridge surface is built **once** (`debugBridgedModuleEnvBuildCount`
///      stays flat) and the pooled class count is constant — the bridge surface
///      is shared, not re-instantiated per run.
///  (b) Parsed-module retention does not grow per run: `debugLoadedModuleCount`
///      stays bounded (each executeBundle builds a fresh loader; prior runs'
///      ASTs are dropped, never accumulated).
///  (c) `dispose()` releases the finished run's artifacts (loader cache +
///      visitor) — `debugLoadedModuleCount` → 0, `visitor` → null — while
///      keeping the process-global shared caches intact, so a follow-up execute
///      still works.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  /// Builds an [AstBundle] whose entry module imports [importUri] and whose
  /// `main` returns [returnValue]. The imported URI is absent from `modules`, so
  /// import resolution falls through to bridged-module loading.
  AstBundle bundleImporting(String importUri, {required int returnValue}) {
    final importDirective = SImportDirective(
      offset: 0,
      length: 0,
      uri: SSimpleStringLiteral(offset: 0, length: 0, value: importUri),
    );
    final mainFn = SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: SSimpleIdentifier(offset: 0, length: 4, name: 'main'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(
            offset: 0,
            length: 0,
            statements: [
              SReturnStatement(
                offset: 0,
                length: 0,
                expression:
                    SIntegerLiteral(offset: 0, length: 1, value: returnValue),
              ),
            ],
          ),
        ),
      ),
    );
    final unit = SCompilationUnit(
      offset: 0,
      length: 0,
      directives: [importDirective],
      declarations: [mainFn],
    );
    return AstBundle(
      entryPointUri: 'package:t/main.dart',
      modules: {'package:t/main.dart': unit},
    );
  }

  /// A marker [BridgedClass] — gives a library URI bridged content so importing
  /// it reaches the per-module env build path.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('PERF-3: per-run BridgedClass / AST retention (analyzer-free D4rtRunner)',
      () {
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test(
        'PERF-3a: N sequential executes share the bridge surface — no per-run '
        'rebuild, constant pooled class count', () {
      final runner = D4rtRunner();
      expect(runner.providePackage('pkg_w'), isFalse);
      runner.registerBridgedClass(marker('WClass'), 'package:w/w.dart',
          sourceUri: 'package:w/w.dart');

      const n = 24;
      int? buildsAfterFirst;
      int? pooledAfterFirst;
      for (var i = 0; i < n; i++) {
        final r = runner.executeBundleAs<int>(
            bundleImporting('package:w/w.dart', returnValue: i));
        expect(r, i, reason: 'each run returns its own value');

        if (i == 0) {
          buildsAfterFirst = D4rtRunner.debugBridgedModuleEnvBuildCount;
          pooledAfterFirst = D4rtRunner.debugPooledClassCount('pkg_w');
          expect(buildsAfterFirst, 1,
              reason: 'the bridge surface is built once on the first execute');
        } else {
          expect(D4rtRunner.debugBridgedModuleEnvBuildCount, buildsAfterFirst,
              reason:
                  'run $i must reuse the cached bridge surface — no rebuild');
          expect(D4rtRunner.debugPooledClassCount('pkg_w'), pooledAfterFirst,
              reason: 'pooled class count is constant — defs are not '
                  're-instantiated per run');
        }
      }
    });

    test(
        'PERF-3b: parsed-module retention stays bounded across N executes '
        '(prior runs’ ASTs are not accumulated)', () {
      final runner = D4rtRunner();
      expect(runner.providePackage('pkg_w'), isFalse);
      runner.registerBridgedClass(marker('WClass'), 'package:w/w.dart',
          sourceUri: 'package:w/w.dart');

      const n = 24;
      int? countAfterFirst;
      for (var i = 0; i < n; i++) {
        runner.executeBundleAs<int>(
            bundleImporting('package:w/w.dart', returnValue: i));
        final loaded = runner.debugLoadedModuleCount;
        if (i == 0) {
          countAfterFirst = loaded;
        } else {
          expect(loaded, countAfterFirst,
              reason: 'run $i retains the same bounded module count as run 0 — '
                  'ASTs do not accumulate across executes');
        }
      }
    });

    test(
        'PERF-3c: dispose() releases the finished run’s artifacts and stays '
        'reusable', () {
      final runner = D4rtRunner();
      expect(runner.providePackage('pkg_w'), isFalse);
      runner.registerBridgedClass(marker('WClass'), 'package:w/w.dart',
          sourceUri: 'package:w/w.dart');

      final first = runner.executeBundleAs<int>(
          bundleImporting('package:w/w.dart', returnValue: 7));
      expect(first, 7);
      expect(runner.debugLoadedModuleCount, greaterThan(0),
          reason: 'a finished run retains its parsed module(s)');
      expect(runner.visitor, isNotNull);

      final pooledBefore = D4rtRunner.debugPooledClassCount('pkg_w');
      final buildsBefore = D4rtRunner.debugBridgedModuleEnvBuildCount;

      runner.dispose();
      expect(runner.debugLoadedModuleCount, 0,
          reason: 'dispose drops the parsed-module cache');
      expect(runner.visitor, isNull,
          reason: 'dispose drops the interpreter visitor');
      // Shared process-global caches are preserved — dispose is non-destructive.
      expect(D4rtRunner.debugPooledClassCount('pkg_w'), pooledBefore,
          reason: 'dispose preserves the shared package pool');
      expect(D4rtRunner.debugBridgedModuleEnvBuildCount, buildsBefore,
          reason: 'dispose does not evict the shared bridged-module env cache');

      // The runner remains fully usable after dispose.
      final second = runner.executeBundleAs<int>(
          bundleImporting('package:w/w.dart', returnValue: 11));
      expect(second, 11, reason: 'executeBundle works again after dispose');
      expect(D4rtRunner.debugBridgedModuleEnvBuildCount, buildsBefore,
          reason: 're-execute reuses the preserved shared bridge surface');
    });
  });
}
