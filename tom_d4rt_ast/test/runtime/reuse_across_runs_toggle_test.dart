/// Regression tests for the `reuseAcrossRuns` isolation toggle on the
/// analyzer-free `D4rtRunner` (mirror of `tom_d4rt`'s
/// `reuse_across_runs_toggle_test.dart`).
///
/// The performance caches (warm parent + per-bridged-module environments) are
/// **on by default** for *every* runner, including legacy ones that never
/// called `providePackage`. Legacy runners reuse a *per-instance* bridged-
/// module env cache (never shared across runners, so `<default>`-package
/// bridges cannot substitute into another runner), while still binding the
/// transitive bridge surface once and reusing it across `executeBundle` calls.
///
/// `D4rtRunner(reuseAcrossRuns: false)` opts out: the warm parent and bridged
/// module environments are rebuilt fresh on every run for full inter-run
/// isolation.
///
/// Both contracts are pinned via the process-global
/// [D4rtRunner.debugBridgedModuleEnvBuildCount] counter, which increments only
/// when a module env is actually *built* (a cache miss):
///
///  (a) default-on: a legacy runner re-importing the same bridged URI reuses
///      its per-instance cached env across executes — count does not advance.
///  (b) opt-out: a legacy runner constructed with `reuseAcrossRuns: false`
///      rebuilds the module env on every run — the count advances each time.
///  (c) invalidation: registering a new bridge after a run (on the same
///      default-on legacy runner) drops the per-instance cache, so re-importing
///      the same URI rebuilds.
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

  group('reuseAcrossRuns toggle (analyzer-free D4rtRunner)', () {
    // The module-env cache, warm-parent cache and package pool are all
    // process-global; reset before/after each test so build-count assertions
    // are order-independent.
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test(
      'default-on: a legacy runner reuses its per-instance module env across '
      'executes',
      () {
        // No providePackage → legacy runner (empty allowed-set).
        final runner = D4rtRunner();
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
          reason:
              'with reuseAcrossRuns on (default) the second execute reuses '
              'the per-instance cached env — no rebuild',
        );
      },
    );

    test(
      'opt-out: reuseAcrossRuns:false rebuilds the module env on every run',
      () {
        final runner = D4rtRunner(reuseAcrossRuns: false);
        runner.registerBridgedClass(
          marker('WClass'),
          'package:w/w.dart',
          sourceUri: 'package:w/w.dart',
        );

        runner.executeBundleAs<int>(
          bundleImporting('package:w/w.dart', returnValue: 1),
        );
        expect(
          D4rtRunner.debugBridgedModuleEnvBuildCount,
          1,
          reason: 'first run builds the module env',
        );

        runner.executeBundleAs<int>(
          bundleImporting('package:w/w.dart', returnValue: 2),
        );
        expect(
          D4rtRunner.debugBridgedModuleEnvBuildCount,
          2,
          reason: 'with reuseAcrossRuns off every run rebuilds for isolation',
        );
      },
    );

    test(
      'invalidation: registering after a run drops the per-instance cache',
      () {
        final runner = D4rtRunner();
        runner.registerBridgedClass(
          marker('WClass'),
          'package:w/w.dart',
          sourceUri: 'package:w/w.dart',
        );

        runner.executeBundleAs<int>(
          bundleImporting('package:w/w.dart', returnValue: 1),
        );
        expect(D4rtRunner.debugBridgedModuleEnvBuildCount, 1);

        // A new (unrelated) registration must invalidate the per-instance caches
        // so the next run rebinds even for the *same* URI — fixes the latent
        // register-after-execute staleness. Without invalidation the cached `w`
        // env would be reused and the count would stay 1.
        runner.registerBridgedClass(
          marker('XClass'),
          'package:x/x.dart',
          sourceUri: 'package:x/x.dart',
        );

        runner.executeBundleAs<int>(
          bundleImporting('package:w/w.dart', returnValue: 3),
        );
        expect(
          D4rtRunner.debugBridgedModuleEnvBuildCount,
          2,
          reason:
              'the post-run registration dropped the cache, so re-importing '
              'the same URI rebuilds',
        );
      },
    );
  });
}
