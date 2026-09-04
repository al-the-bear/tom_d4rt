/// Step #5 (performance optimization plan) regression test for the
/// analyzer-based `D4rt` (mirror of `tom_d4rt_ast`'s
/// `warm_parent_lazy_class_test.dart`).
///
/// Pins the laziness contract of the one-time pool/registration warmup: when
/// the warm parent [Environment] is built from the package pool
/// (`_buildWarmParentFromPool`), bridged classes are registered as deferred
/// `() => BridgedClass` thunks (Step #17) and the thunk bodies are **not**
/// invoked. The expensive per-class build (member maps + adapter closures) is
/// paid lazily — only when a native value of the bridged type is first wrapped
/// (`toBridgedInstance`).
///
/// This is what keeps the warmup cheap: importing a bridge package registers
/// the type baseline up front but builds only the classes a script touches.
///
/// See `performance_optimization_plan_decisions.md` (Step 5, D24+).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Unique native type for the lazily-registered probe bridge — chosen so the
/// `toBridgedInstance` direct type lookup resolves to this bridge alone and
/// builds exactly its thunk (no shared supertype that would force others).
class _S5Probe {}

void main() {
  group(
    'IMP-OPT-5: warm parent does not force lazy class thunks (analyzer)',
    () {
      // The migrated-instance warm parent and the package pool live in
      // process-global caches; reset both so build-count assertions are
      // order-independent across tests in the run.
      setUp(D4rt.debugResetPool);
      tearDown(D4rt.debugResetPool);

      test('IMP-OPT-5a: building the warm parent registers the class thunk '
          'without invoking it; resolution builds it exactly once', () {
        var builds = 0;
        BridgedClass buildProbe() {
          builds++;
          return BridgedClass(nativeType: _S5Probe, name: 'S5Probe');
        }

        final interpreter = D4rt();
        expect(
          interpreter.providePackage('pkg_s5'),
          isFalse,
          reason: 'first sighting of pkg_s5 — opens the registration context',
        );
        interpreter.registerBridgedClassLazy(
          'S5Probe',
          _S5Probe,
          buildProbe,
          'package:s5/s5.dart',
          sourceUri: 'package:s5/s5.dart',
        );

        // Registration alone must not build the class.
        expect(
          builds,
          0,
          reason: 'registerBridgedClassLazy stores a thunk only',
        );

        // Executing builds the warm parent from the pool (the warmup the plan
        // targets). The class thunk must travel into the warm parent deferred.
        expect(interpreter.execute(source: 'int main() => 1;'), 1);
        expect(
          builds,
          0,
          reason:
              'warm-parent pool registration must not force class thunks — '
              'this is what keeps the one-time registration warmup cheap',
        );

        final parent = interpreter.visitor!.globalEnvironment.enclosing;
        expect(
          parent,
          isNotNull,
          reason: 'the per-execute env is a child chained off the warm parent',
        );

        // First resolution (by native type) builds the bridge exactly once.
        parent!.toBridgedInstance(_S5Probe());
        expect(builds, 1, reason: 'first resolution builds the thunk');

        // Second resolution reuses the memoized build.
        parent.toBridgedInstance(_S5Probe());
        expect(builds, 1, reason: 'the built bridge is memoized, not rebuilt');
      });
    },
  );
}
