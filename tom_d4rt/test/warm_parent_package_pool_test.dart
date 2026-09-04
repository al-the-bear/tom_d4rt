/// Step 7–9 regression tests for the import-optimization plan on the
/// analyzer-based `D4rt` (mirror of `tom_d4rt_ast`'s
/// `phase2_warm_parent_test.dart`).
///
/// These pin the `providePackage` package-pool contract (step 7) and the
/// warm-parent [Environment] reuse contract (step 8) ported into `tom_d4rt`
/// (step 9):
///
///  (a) Two consecutive `execute` calls on one interpreter build the warm
///      parent exactly **once** — the per-execute child's `enclosing` is the
///      same parent object across both runs (`identical`).
///  (b) Script state does **not** leak between executes: a top-level
///      declaration created by the first script is absent from the second
///      execute's fresh child.
///  (c) Migrated instances (those that called `providePackage`) share the warm
///      parent process-wide via the static cache keyed on the allowed-set
///      signature — and a second interpreter with the same allowed-set reuses
///      it.
///  (d) Legacy instances (no `providePackage`) do **not** share their warm
///      parent across interpreters.
///  (e) `providePackage` returns `false` the first time a package is seen in
///      the process and `true` once it is pooled; the pool carries the
///      registered definitions.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  /// A marker [BridgedClass] — never instantiated; only used to make an
  /// instance "migrated" by registering it under a provided package.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('IMP-OPT-9: warm parent + package pool (analyzer D4rt)', () {
    // The migrated-instance warm parent and the package pool live in
    // process-global caches; reset both before/after each test so the
    // cache-size / pooled-package assertions are order-independent.
    setUp(D4rt.debugResetPool);
    tearDown(D4rt.debugResetPool);

    test(
      'IMP-OPT-9a: two consecutive executes reuse one warm parent (legacy)',
      () {
        final interpreter = D4rt();

        expect(interpreter.execute(source: 'int main() => 1;'), 1);
        final parentAfterFirst =
            interpreter.visitor!.globalEnvironment.enclosing;
        expect(
          parentAfterFirst,
          isNotNull,
          reason: 'the per-execute env must be a child chained off the parent',
        );

        expect(interpreter.execute(source: 'int main() => 2;'), 2);
        final parentAfterSecond =
            interpreter.visitor!.globalEnvironment.enclosing;

        expect(
          identical(parentAfterFirst, parentAfterSecond),
          isTrue,
          reason: 'the warm parent must be built once and reused, not rebuilt',
        );
      },
    );

    test('IMP-OPT-9b: script state does not leak between executes (legacy)', () {
      final interpreter = D4rt();

      // First script declares top-level `a1`; it lands in that execute's child.
      interpreter.execute(source: 'void a1() {}\nint main() => 1;');
      final firstChild = interpreter.visitor!.globalEnvironment;
      expect(
        firstChild.values.containsKey('a1'),
        isTrue,
        reason: "first script's top-level fn lands in its own child",
      );

      // Second script declares `a2` instead; its child is fresh.
      interpreter.execute(source: 'void a2() {}\nint main() => 2;');
      final secondChild = interpreter.visitor!.globalEnvironment;

      expect(
        identical(firstChild, secondChild),
        isFalse,
        reason: 'each execute builds a fresh child environment',
      );
      expect(
        secondChild.values.containsKey('a2'),
        isTrue,
        reason: "second script's top-level fn lands in the new child",
      );
      expect(
        secondChild.values.containsKey('a1'),
        isFalse,
        reason: "first script's `a1` must NOT leak into the second child",
      );
      // The immutable warm parent never receives script declarations.
      final parent = secondChild.enclosing!;
      expect(parent.values.containsKey('a1'), isFalse);
      expect(parent.values.containsKey('a2'), isFalse);
    });

    test('IMP-OPT-9c: migrated instances share one warm parent by signature', () {
      final first = D4rt();
      expect(
        first.providePackage('pkg_w'),
        isFalse,
        reason: 'first sighting of pkg_w in the process — not pooled yet',
      );
      first.registerBridgedClass(
        marker('WClass'),
        'package:w/w.dart',
        sourceUri: 'package:w/w.dart',
      );

      // Two executes on the migrated instance build the parent once.
      first.execute(source: 'int main() => 1;');
      final parent1 = first.visitor!.globalEnvironment.enclosing;
      first.execute(source: 'int main() => 2;');
      final parent2 = first.visitor!.globalEnvironment.enclosing;
      expect(identical(parent1, parent2), isTrue);
      expect(
        D4rt.debugWarmParentCacheSize,
        1,
        reason: 'one cached warm parent for the {pkg_w} signature',
      );

      // A second interpreter granted the same package reuses the cached parent.
      final second = D4rt();
      expect(
        second.providePackage('pkg_w'),
        isTrue,
        reason: 'pkg_w is already pooled — second interpreter reuses it',
      );
      second.execute(source: 'int main() => 3;');
      final parent3 = second.visitor!.globalEnvironment.enclosing;
      expect(
        identical(parent1, parent3),
        isTrue,
        reason: 'same allowed-set signature → same cached warm parent',
      );
      expect(
        D4rt.debugWarmParentCacheSize,
        1,
        reason: 'no new parent built for the same signature',
      );
    });

    test('IMP-OPT-9d: legacy instances do NOT share a warm parent across '
        'interpreters', () {
      final first = D4rt();
      final second = D4rt();

      first.execute(source: 'int main() => 1;');
      second.execute(source: 'int main() => 2;');

      final firstParent = first.visitor!.globalEnvironment.enclosing;
      final secondParent = second.visitor!.globalEnvironment.enclosing;

      expect(
        identical(firstParent, secondParent),
        isFalse,
        reason: 'legacy parents are per-instance — no cross-instance sharing',
      );
      // Legacy interpreters never populate the migrated static cache.
      expect(D4rt.debugWarmParentCacheSize, 0);
    });

    test('IMP-OPT-9e: providePackage pools definitions for reuse', () {
      final first = D4rt();
      expect(first.providePackage('pkg_p'), isFalse);
      first.registerBridgedClass(
        marker('PClass'),
        'package:p/p.dart',
        sourceUri: 'package:p/p.dart',
      );
      first.registerBridgedClass(
        marker('QClass'),
        'package:p/p.dart',
        sourceUri: 'package:p/p.dart',
      );

      expect(D4rt.debugPooledPackages, contains('pkg_p'));
      expect(
        D4rt.debugPooledClassCount('pkg_p'),
        2,
        reason: 'both classes registered under pkg_p are pooled',
      );

      // A second interpreter sees the package already pooled and skips
      // registration.
      final second = D4rt();
      expect(second.providePackage('pkg_p'), isTrue);
      expect(second.allowedPackages, contains('pkg_p'));
    });
  });
}
