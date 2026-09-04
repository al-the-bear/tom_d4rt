/// Phase-2 step #8 regression tests for the import-optimization plan.
///
/// Lock in the warm-parent [Environment] contract:
///
///  (a) Two consecutive `executeBundle` calls on one runner build the warm
///      parent exactly **once** — the per-execute child's `enclosing` is the
///      same parent object across both runs (`identical`).
///  (b) Script state does **not** leak between executes: a top-level
///      declaration created by the first bundle is absent from the second
///      execute's fresh child (the child is rebuilt per call; the parent stays
///      immutable and never receives script declarations).
///  (c) Migrated instances (those that called `providePackage`) share the warm
///      parent process-wide via the static cache keyed on the allowed-set
///      signature — two executes populate `debugWarmParentCacheSize` to 1, and
///      a second runner with the same allowed-set reuses that parent.
///  (d) Legacy instances (no `providePackage`) do **not** share their warm
///      parent across runners — each gets its own private parent — so one
///      runner's bridges never leak into another via the `<default>` package.
///
/// The done-condition from the plan (step #8): "two consecutive executeBundle
/// calls build the warm parent once; script state does not leak between
/// executes."
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  /// Builds an [AstBundle] whose `main` returns the literal [returnValue]
  /// and additionally defines a top-level function named [extraName] so the
  /// test can observe whether that script declaration leaks across executes.
  AstBundle bundleWith(int returnValue, {required String extraName}) {
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
    final extraFn = SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: SSimpleIdentifier(
        offset: 0,
        length: extraName.length,
        name: extraName,
      ),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(offset: 0, length: 0, statements: []),
        ),
      ),
    );
    final unit = SCompilationUnit(
      offset: 0,
      length: 0,
      declarations: [mainFn, extraFn],
    );
    return AstBundle(
      entryPointUri: 'package:t/main.dart',
      modules: {'package:t/main.dart': unit},
    );
  }

  /// A marker [BridgedClass] — never instantiated; only used to make an
  /// instance "migrated" by registering it under a provided package.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('IMP-OPT-8: warm parent environment reuse', () {
    // The migrated-instance warm parent lives in a process-global cache that
    // is keyed on pool contents; reset both before/after each test so the
    // cache-size assertions are order-independent.
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test(
      'IMP-OPT-8a: two consecutive executes reuse one warm parent (legacy)',
      () {
        final runner = D4rtRunner();

        expect(runner.executeBundleAs<int>(bundleWith(1, extraName: 'a1')), 1);
        final parentAfterFirst = runner.visitor!.globalEnvironment.enclosing;
        expect(
          parentAfterFirst,
          isNotNull,
          reason: 'the per-execute env must be a child chained off the parent',
        );

        expect(runner.executeBundleAs<int>(bundleWith(2, extraName: 'a2')), 2);
        final parentAfterSecond = runner.visitor!.globalEnvironment.enclosing;

        expect(
          identical(parentAfterFirst, parentAfterSecond),
          isTrue,
          reason: 'the warm parent must be built once and reused, not rebuilt',
        );
      },
    );

    test('IMP-OPT-8b: script state does not leak between executes (legacy)', () {
      final runner = D4rtRunner();

      // First bundle declares top-level `a1`; it lands in that execute's child.
      runner.executeBundleAs<int>(bundleWith(1, extraName: 'a1'));
      final firstChild = runner.visitor!.globalEnvironment;
      expect(
        firstChild.values.containsKey('a1'),
        isTrue,
        reason: 'first bundle\'s top-level fn lands in its own child',
      );

      // Second bundle declares `a2` instead; its child is fresh.
      runner.executeBundleAs<int>(bundleWith(2, extraName: 'a2'));
      final secondChild = runner.visitor!.globalEnvironment;

      expect(
        identical(firstChild, secondChild),
        isFalse,
        reason: 'each execute builds a fresh child environment',
      );
      expect(
        secondChild.values.containsKey('a2'),
        isTrue,
        reason: 'second bundle\'s top-level fn lands in the new child',
      );
      expect(
        secondChild.values.containsKey('a1'),
        isFalse,
        reason: 'first bundle\'s `a1` must NOT leak into the second child',
      );
      // The immutable warm parent never receives script declarations.
      final parent = secondChild.enclosing!;
      expect(parent.values.containsKey('a1'), isFalse);
      expect(parent.values.containsKey('a2'), isFalse);
    });

    test(
      'IMP-OPT-8c: migrated instances share one warm parent by signature',
      () {
        final first = D4rtRunner();
        expect(first.providePackage('pkg_w'), isFalse);
        first.registerBridgedClass(
          marker('WClass'),
          'package:w/w.dart',
          sourceUri: 'package:w/w.dart',
        );

        // Two executes on the migrated instance build the parent once.
        first.executeBundleAs<int>(bundleWith(1, extraName: 'w1'));
        final parent1 = first.visitor!.globalEnvironment.enclosing;
        first.executeBundleAs<int>(bundleWith(2, extraName: 'w2'));
        final parent2 = first.visitor!.globalEnvironment.enclosing;
        expect(identical(parent1, parent2), isTrue);
        expect(
          D4rtRunner.debugWarmParentCacheSize,
          1,
          reason: 'one cached warm parent for the {pkg_w} signature',
        );

        // A second runner granted the same package reuses the cached parent.
        final second = D4rtRunner();
        expect(
          second.providePackage('pkg_w'),
          isTrue,
          reason: 'pkg_w is already pooled — second runner reuses it',
        );
        second.executeBundleAs<int>(bundleWith(3, extraName: 'w3'));
        final parent3 = second.visitor!.globalEnvironment.enclosing;
        expect(
          identical(parent1, parent3),
          isTrue,
          reason: 'same allowed-set signature → same cached warm parent',
        );
        expect(
          D4rtRunner.debugWarmParentCacheSize,
          1,
          reason: 'no new parent built for the same signature',
        );
      },
    );

    test('IMP-OPT-8d: legacy instances do NOT share a warm parent across '
        'runners', () {
      final first = D4rtRunner();
      final second = D4rtRunner();

      first.executeBundleAs<int>(bundleWith(1, extraName: 'l1'));
      second.executeBundleAs<int>(bundleWith(2, extraName: 'l2'));

      final firstParent = first.visitor!.globalEnvironment.enclosing;
      final secondParent = second.visitor!.globalEnvironment.enclosing;

      expect(
        identical(firstParent, secondParent),
        isFalse,
        reason: 'legacy parents are per-instance — no cross-runner sharing',
      );
      // Legacy runners never populate the migrated static cache.
      expect(D4rtRunner.debugWarmParentCacheSize, 0);
    });
  });
}
