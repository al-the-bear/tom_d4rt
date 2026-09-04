/// PERF step #2 regression tests for the performance-optimization plan
/// (`_ai/quests/d4rt/performance_optimization_plan.md`) on the analyzer-free
/// `D4rtRunner` (mirror of `tom_d4rt`'s `bridged_module_env_cache_test.dart`).
///
/// Step #2 caches the fully-registered bridged-module environments per
/// allowed-package signature so the ~982-class flutter bridge surface is built
/// once per process (per signature) instead of being re-registered on every
/// `executeBundle`. These tests pin the cache contract via the
/// [D4rtRunner.debugBridgedModuleEnvBuildCount] introspection counter, which
/// increments only when a module env is actually *built* (a cache miss):
///
///  (a) A second execute on the same migrated runner importing the same bridged
///      URI reuses the cached module env — the build count does not advance.
///  (b) A second migrated runner granted the same allowed-set reuses the cached
///      env across instances — still no rebuild.
///  (c) A different allowed-set signature rebuilds the module env (its cache is
///      keyed separately), so the build count advances exactly once.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  /// Builds an [AstBundle] whose entry module imports [importUri] and whose
  /// `main` returns the literal [returnValue]. The imported URI is intentionally
  /// absent from `modules`, so import resolution falls through to bridged-module
  /// loading (the path under test).
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
                expression: SIntegerLiteral(
                  offset: 0,
                  length: 1,
                  value: returnValue,
                ),
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

  /// A marker [BridgedClass] — only used to give a library URI bridged content
  /// so importing it reaches the per-module env build path.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('PERF-2: bridged-module env cache (analyzer-free D4rtRunner)', () {
    // The module-env cache, warm-parent cache and package pool are all
    // process-global; reset before/after each test so build-count assertions
    // are order-independent.
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test('PERF-2a: re-importing the same bridged URI reuses the cached module '
        'env across executes', () {
      final runner = D4rtRunner();
      expect(runner.providePackage('pkg_w'), isFalse);
      runner.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );

      runner.executeBundleAs<int>(
        bundleImporting('package:w/w.dart', returnValue: 1),
      );
      final afterFirst = D4rtRunner.debugBridgedModuleEnvBuildCount;
      expect(
        afterFirst,
        1,
        reason: 'the first import builds the per-module env exactly once',
      );

      runner.executeBundleAs<int>(
        bundleImporting('package:w/w.dart', returnValue: 2),
      );
      expect(
        D4rtRunner.debugBridgedModuleEnvBuildCount,
        afterFirst,
        reason: 'the second execute reuses the cached env — no rebuild',
      );
    });

    test('PERF-2b: a second runner with the same allowed-set reuses it', () {
      final first = D4rtRunner();
      expect(first.providePackage('pkg_w'), isFalse);
      first.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );
      first.executeBundleAs<int>(
        bundleImporting('package:w/w.dart', returnValue: 1),
      );
      expect(D4rtRunner.debugBridgedModuleEnvBuildCount, 1);

      // Second runner granted the same package → same signature → shares the
      // cached module env. (Twin divergence: the analyzer-free loader resolves
      // bridged content from this runner's own registration maps, not the pool,
      // so the second runner re-registers the same class to make the URI
      // importable — the allowed-set signature is still {pkg_w}, so the cached
      // module env from the first runner is reused, not rebuilt.)
      final second = D4rtRunner();
      expect(
        second.providePackage('pkg_w'),
        isTrue,
        reason: 'pkg_w already pooled — second runner reuses it',
      );
      second.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );
      second.executeBundleAs<int>(
        bundleImporting('package:w/w.dart', returnValue: 2),
      );
      expect(
        D4rtRunner.debugBridgedModuleEnvBuildCount,
        1,
        reason: 'same allowed-set signature → cached env reused, no rebuild',
      );
    });

    test('PERF-2c: a different allowed-set rebuilds the module env', () {
      final first = D4rtRunner();
      expect(first.providePackage('pkg_w'), isFalse);
      first.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );
      first.executeBundleAs<int>(
        bundleImporting('package:w/w.dart', returnValue: 1),
      );
      expect(D4rtRunner.debugBridgedModuleEnvBuildCount, 1);

      // A second runner with a DIFFERENT allowed-set imports a different bridged
      // URI: its cache bucket is keyed separately, so its module env is built
      // fresh.
      final second = D4rtRunner();
      expect(second.providePackage('pkg_v'), isFalse);
      second.registerBridgedClass(
        marker('VClass'),
        'package:v/v.dart',
        sourceUri: 'package:v/v.dart',
      );
      second.executeBundleAs<int>(
        bundleImporting('package:v/v.dart', returnValue: 2),
      );
      expect(
        D4rtRunner.debugBridgedModuleEnvBuildCount,
        2,
        reason: 'a different signature rebuilds the env — count advances',
      );
    });
  });
}
