/// Step 10 regression tests for the import-optimization plan on the
/// `tom_d4rt_exec` wrapper `D4rt` (mirror of `tom_d4rt_ast`'s
/// `phase2_warm_parent_test.dart` and `tom_d4rt`'s
/// `warm_parent_package_pool_test.dart`).
///
/// The wrapper forwards `providePackage`, `allowedPackages`, and the static
/// pool/warm-parent introspection to its inner [D4rtRunner]; the
/// `executeBundle*` path runs entirely against that runner. These tests pin
/// that the forwards expose the runner's contract faithfully through the
/// wrapper:
///
///  (a) Two consecutive `executeBundleAs` calls on one wrapper build the warm
///      parent exactly **once** — the per-execute child's `enclosing` is the
///      same parent object across both runs (`identical`).
///  (b) Script state does **not** leak between executes.
///  (c) Migrated instances (those that called `providePackage`) share the warm
///      parent process-wide via the static cache keyed on the allowed-set
///      signature — and a second wrapper with the same allowed-set reuses it.
///  (d) Legacy instances (no `providePackage`) do **not** share their warm
///      parent across wrappers.
///  (e) `providePackage` returns `false` the first time a package is seen in
///      the process and `true` once it is pooled; the pool carries the
///      registered definitions, visible via the wrapper's static introspection.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

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
                expression:
                    SIntegerLiteral(offset: 0, length: 1, value: returnValue),
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

  group('IMP-OPT-10: warm parent + package pool (tom_d4rt_exec wrapper)', () {
    // The migrated-instance warm parent and the package pool live in
    // process-global caches on the inner runner; reset both before/after each
    // test through the wrapper's forward so the cache-size / pooled-package
    // assertions are order-independent.
    setUp(D4rt.debugResetPool);
    tearDown(D4rt.debugResetPool);

    test(
        'IMP-OPT-10a: two consecutive executes reuse one warm parent (legacy)',
        () {
      final interpreter = D4rt();

      expect(
          interpreter.executeBundleAs<int>(bundleWith(1, extraName: 'a1')), 1);
      final parentAfterFirst = interpreter.visitor!.globalEnvironment.enclosing;
      expect(parentAfterFirst, isNotNull,
          reason: 'the per-execute env must be a child chained off the parent');

      expect(
          interpreter.executeBundleAs<int>(bundleWith(2, extraName: 'a2')), 2);
      final parentAfterSecond = interpreter.visitor!.globalEnvironment.enclosing;

      expect(identical(parentAfterFirst, parentAfterSecond), isTrue,
          reason: 'the warm parent must be built once and reused, not rebuilt');
    });

    test('IMP-OPT-10b: script state does not leak between executes (legacy)',
        () {
      final interpreter = D4rt();

      interpreter.executeBundleAs<int>(bundleWith(1, extraName: 'a1'));
      final firstChild = interpreter.visitor!.globalEnvironment;
      expect(firstChild.values.containsKey('a1'), isTrue,
          reason: "first bundle's top-level fn lands in its own child");

      interpreter.executeBundleAs<int>(bundleWith(2, extraName: 'a2'));
      final secondChild = interpreter.visitor!.globalEnvironment;

      expect(identical(firstChild, secondChild), isFalse,
          reason: 'each execute builds a fresh child environment');
      expect(secondChild.values.containsKey('a2'), isTrue,
          reason: "second bundle's top-level fn lands in the new child");
      expect(secondChild.values.containsKey('a1'), isFalse,
          reason: "first bundle's `a1` must NOT leak into the second child");
      final parent = secondChild.enclosing!;
      expect(parent.values.containsKey('a1'), isFalse);
      expect(parent.values.containsKey('a2'), isFalse);
    });

    test('IMP-OPT-10c: migrated instances share one warm parent by signature',
        () {
      final first = D4rt();
      expect(first.providePackage('pkg_w'), isFalse,
          reason: 'first sighting of pkg_w in the process — not pooled yet');
      first.registerBridgedClass(marker('WClass'), 'package:w/w.dart',
          sourceUri: 'package:w/w.dart');

      first.executeBundleAs<int>(bundleWith(1, extraName: 'w1'));
      final parent1 = first.visitor!.globalEnvironment.enclosing;
      first.executeBundleAs<int>(bundleWith(2, extraName: 'w2'));
      final parent2 = first.visitor!.globalEnvironment.enclosing;
      expect(identical(parent1, parent2), isTrue);
      expect(D4rt.debugWarmParentCacheSize, 1,
          reason: 'one cached warm parent for the {pkg_w} signature');

      final second = D4rt();
      expect(second.providePackage('pkg_w'), isTrue,
          reason: 'pkg_w is already pooled — second wrapper reuses it');
      second.executeBundleAs<int>(bundleWith(3, extraName: 'w3'));
      final parent3 = second.visitor!.globalEnvironment.enclosing;
      expect(identical(parent1, parent3), isTrue,
          reason: 'same allowed-set signature → same cached warm parent');
      expect(D4rt.debugWarmParentCacheSize, 1,
          reason: 'no new parent built for the same signature');
    });

    test(
        'IMP-OPT-10d: legacy instances do NOT share a warm parent across '
        'wrappers', () {
      final first = D4rt();
      final second = D4rt();

      first.executeBundleAs<int>(bundleWith(1, extraName: 'l1'));
      second.executeBundleAs<int>(bundleWith(2, extraName: 'l2'));

      final firstParent = first.visitor!.globalEnvironment.enclosing;
      final secondParent = second.visitor!.globalEnvironment.enclosing;

      expect(identical(firstParent, secondParent), isFalse,
          reason: 'legacy parents are per-instance — no cross-wrapper sharing');
      expect(D4rt.debugWarmParentCacheSize, 0);
    });

    test('IMP-OPT-10e: providePackage pools definitions for reuse', () {
      final first = D4rt();
      expect(first.providePackage('pkg_p'), isFalse);
      first.registerBridgedClass(marker('PClass'), 'package:p/p.dart',
          sourceUri: 'package:p/p.dart');
      first.registerBridgedClass(marker('QClass'), 'package:p/p.dart',
          sourceUri: 'package:p/p.dart');

      expect(D4rt.debugPooledPackages, contains('pkg_p'));
      expect(D4rt.debugPooledClassCount('pkg_p'), 2,
          reason: 'both classes registered under pkg_p are pooled');

      final second = D4rt();
      expect(second.providePackage('pkg_p'), isTrue);
      expect(second.allowedPackages, contains('pkg_p'));
    });
  });
}
