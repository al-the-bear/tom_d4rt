/// Step #5 (performance optimization plan) regression test for the AST
/// runner `D4rtRunner`.
///
/// Pins the laziness contract of the one-time pool/registration warmup: when
/// the warm parent [Environment] is built from the package pool
/// (`_buildWarmParentFromPool` → `_registerBridgedDefinitionsFromBundle` →
/// `_registerDefsInto`), bridged classes are registered as deferred
/// `() => BridgedClass` thunks (Step #17) and the thunk bodies are **not**
/// invoked. The expensive per-class build (member maps + adapter closures) is
/// paid lazily — only when a class is first resolved by name or native type.
///
/// This is what keeps the `registerBridgedDefinitionsFromPool` warmup cheap:
/// importing a bridge package registers the class baseline up front but builds
/// only the handful of classes a script actually touches.
///
/// See `performance_optimization_plan_decisions.md` (Step 5, D24+) for why the
/// lazy-registration program of plan step #5 is already satisfied by the
/// import-optimization steps #17/#20/#21, and why lazy enums are infeasible.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// Unique native type for the lazily-registered probe bridge — chosen so the
/// `toBridgedInstance` direct type lookup resolves to this bridge alone and
/// builds exactly its thunk (no shared supertype that would force others).
class _S5Probe {}

void main() {
  /// Builds a minimal [AstBundle] whose `main` returns [returnValue]. Executing
  /// it triggers the warm-parent build without declaring anything observable.
  AstBundle bundleReturning(int returnValue) {
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
    final unit = SCompilationUnit(offset: 0, length: 0, declarations: [mainFn]);
    return AstBundle(
      entryPointUri: 'package:t/main.dart',
      modules: {'package:t/main.dart': unit},
    );
  }

  group('IMP-OPT-5: warm parent does not force lazy class thunks (AST)', () {
    // The migrated-instance warm parent and the package pool live in
    // process-global caches; reset both so build-count assertions are
    // order-independent across tests in the run.
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test(
        'IMP-OPT-5a: building the warm parent registers the class thunk '
        'without invoking it; resolution builds it exactly once', () {
      var builds = 0;
      BridgedClass buildProbe() {
        builds++;
        return BridgedClass(nativeType: _S5Probe, name: 'S5Probe');
      }

      final runner = D4rtRunner();
      expect(runner.providePackage('pkg_s5'), isFalse,
          reason: 'first sighting of pkg_s5 — opens the registration context');
      runner.registerBridgedClassLazy(
        'S5Probe',
        _S5Probe,
        buildProbe,
        'package:s5/s5.dart',
        sourceUri: 'package:s5/s5.dart',
      );

      // Registration alone must not build the class.
      expect(builds, 0, reason: 'registerBridgedClassLazy stores a thunk only');

      // Executing builds the warm parent from the pool (the warmup the plan
      // targets). The class thunk must travel into the warm parent deferred.
      expect(runner.executeBundleAs<int>(bundleReturning(1)), 1);
      expect(builds, 0,
          reason: 'warm-parent pool registration must not force class thunks — '
              'this is what keeps registerBridgedDefinitionsFromPool cheap');

      final parent = runner.visitor!.globalEnvironment.enclosing;
      expect(parent, isNotNull,
          reason: 'the per-execute env is a child chained off the warm parent');

      // First resolution (by native type) builds the bridge exactly once.
      parent!.toBridgedInstance(_S5Probe());
      expect(builds, 1, reason: 'first resolution builds the thunk');

      // Second resolution reuses the memoized build.
      parent.toBridgedInstance(_S5Probe());
      expect(builds, 1, reason: 'the built bridge is memoized, not rebuilt');
    });
  });
}
