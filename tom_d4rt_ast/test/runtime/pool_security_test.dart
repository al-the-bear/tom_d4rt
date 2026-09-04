/// Step 12 pool/security regression tests for the import-optimization plan
/// (`interpreter_import_optimization_plan.md`) on the analyzer-free
/// `D4rtRunner`.
///
/// Consolidates the four properties the package-pool + warm-parent machinery
/// (steps 7–11) must guarantee — with the **security isolation** property (b)
/// as the headline new requirement:
///
///  (a) `providePackage` returns `false` the first time a package is seen in
///      the process and `true` once it is pooled — across two separate
///      instances.
///  (b) **SECURITY** — a package registered (and pooled) by instance 1 is
///      **not** exposed in the warm parent of instance 2 that did not provide
///      it. The isolation boundary is the per-instance allowed-set, *not* the
///      absence of the class from the process-global pool (the pool still holds
///      it; instance 2 simply was not granted it).
///  (c) Two consecutive executes on one instance reuse a single warm parent
///      (the per-execute child's `enclosing` is `identical` across runs).
///  (d) No script declaration leaks between executes or across instances.
///
/// The pool + warm-parent caches are process-global; reset them before/after
/// each test so the assertions are order-independent.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  /// Builds an [AstBundle] whose `main` returns the literal [returnValue] and
  /// additionally defines a top-level function named [extraName] so the test
  /// can observe whether that script declaration leaks across executes.
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

  group('IMP-OPT-12: pool / security regression (D4rtRunner)', () {
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test('IMP-OPT-12a: providePackage returns false then true across two '
        'instances', () {
      final first = D4rtRunner();
      expect(
        first.providePackage('pkg_a'),
        isFalse,
        reason: 'first sighting of pkg_a in the process — not pooled yet',
      );
      first.registerBridgedClass(
        marker('AClass'),
        'package:a/a.dart',
        sourceUri: 'package:a/a.dart',
      );

      final second = D4rtRunner();
      expect(
        second.providePackage('pkg_a'),
        isTrue,
        reason: 'pkg_a is now pooled — the second instance reuses it',
      );
      expect(second.allowedPackages, contains('pkg_a'));
    });

    test('IMP-OPT-12b: a package provided by instance 1 is NOT exposed in '
        'instance 2 that did not provide it', () {
      // Instance 1 provides pkg_a and pools AClass under it.
      final first = D4rtRunner();
      expect(first.providePackage('pkg_a'), isFalse);
      first.registerBridgedClass(
        marker('AClass'),
        'package:a/a.dart',
        sourceUri: 'package:a/a.dart',
      );
      first.executeBundleAs<int>(bundleWith(1, extraName: 'f1'));

      // Positive control: instance 1's warm parent DOES expose AClass.
      final firstParent = first.visitor!.globalEnvironment.enclosing!;
      expect(
        firstParent.findBridgedClassByName('AClass'),
        isNotNull,
        reason: 'the granting instance sees its own pooled class',
      );

      // The class genuinely lives in the process-global pool — so the
      // isolation below is by allowed-set, not by absence from the pool.
      expect(
        D4rtRunner.debugPooledClassCount('pkg_a'),
        greaterThanOrEqualTo(1),
        reason: 'AClass is pooled process-wide under pkg_a',
      );

      // Instance 2 provides a DIFFERENT package and never provides pkg_a.
      final second = D4rtRunner();
      expect(second.providePackage('pkg_b'), isFalse);
      second.executeBundleAs<int>(bundleWith(2, extraName: 's1'));

      // SECURITY: AClass must NOT be visible in instance 2's warm parent.
      final secondParent = second.visitor!.globalEnvironment.enclosing!;
      expect(
        secondParent.findBridgedClassByName('AClass'),
        isNull,
        reason: 'instance 2 was not granted pkg_a — AClass is out of scope',
      );

      // A legacy instance 3 (no providePackage, no registration) is likewise
      // isolated: its warm parent is built from its own empty maps.
      final third = D4rtRunner();
      third.executeBundleAs<int>(bundleWith(3, extraName: 't1'));
      final thirdParent = third.visitor!.globalEnvironment.enclosing!;
      expect(
        thirdParent.findBridgedClassByName('AClass'),
        isNull,
        reason:
            'a legacy instance never pulls pooled bridges it did not '
            'register itself',
      );
    });

    test('IMP-OPT-12c: two executes reuse one warm parent', () {
      final first = D4rtRunner();
      expect(first.providePackage('pkg_c'), isFalse);
      first.registerBridgedClass(
        marker('CClass'),
        'package:c/c.dart',
        sourceUri: 'package:c/c.dart',
      );

      first.executeBundleAs<int>(bundleWith(1, extraName: 'c1'));
      final parent1 = first.visitor!.globalEnvironment.enclosing;
      first.executeBundleAs<int>(bundleWith(2, extraName: 'c2'));
      final parent2 = first.visitor!.globalEnvironment.enclosing;

      expect(
        identical(parent1, parent2),
        isTrue,
        reason: 'the warm parent is built once and reused across executes',
      );
      expect(
        D4rtRunner.debugWarmParentCacheSize,
        1,
        reason: 'a single cached warm parent for the {pkg_c} signature',
      );
    });

    test('IMP-OPT-12d: no script-decl leak between executes or instances', () {
      final first = D4rtRunner();
      first.executeBundleAs<int>(bundleWith(1, extraName: 'd1'));
      final firstChild = first.visitor!.globalEnvironment;
      expect(
        firstChild.values.containsKey('d1'),
        isTrue,
        reason: 'first bundle\'s top-level fn lands in its own child',
      );

      // Second execute on the SAME instance: fresh child, no leak of `d1`.
      first.executeBundleAs<int>(bundleWith(2, extraName: 'd2'));
      final secondChild = first.visitor!.globalEnvironment;
      expect(identical(firstChild, secondChild), isFalse);
      expect(secondChild.values.containsKey('d2'), isTrue);
      expect(
        secondChild.values.containsKey('d1'),
        isFalse,
        reason: 'first execute\'s `d1` must NOT leak into the second child',
      );
      // The immutable warm parent never receives script declarations.
      final parent = secondChild.enclosing!;
      expect(parent.values.containsKey('d1'), isFalse);
      expect(parent.values.containsKey('d2'), isFalse);

      // A SECOND instance: its child never sees the first instance's decls.
      final other = D4rtRunner();
      other.executeBundleAs<int>(bundleWith(3, extraName: 'd3'));
      final otherChild = other.visitor!.globalEnvironment;
      expect(otherChild.values.containsKey('d3'), isTrue);
      expect(otherChild.values.containsKey('d1'), isFalse);
      expect(
        otherChild.values.containsKey('d2'),
        isFalse,
        reason: 'no script declaration leaks across instances',
      );
    });
  });
}
