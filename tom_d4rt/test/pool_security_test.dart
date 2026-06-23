/// Step 12 pool/security regression tests for the import-optimization plan
/// (`interpreter_import_optimization_plan.md`) on the analyzer-based `D4rt`
/// (mirror of `tom_d4rt_ast`'s `pool_security_test.dart`).
///
/// Consolidates the four properties the package-pool + warm-parent machinery
/// (steps 7–11) must guarantee — with the **security isolation** property (b)
/// as the headline new requirement:
///
///  (a) `providePackage` returns `false` the first time a package is seen in
///      the process and `true` once it is pooled — across two separate
///      interpreters.
///  (b) **SECURITY** — a package registered (and pooled) by interpreter 1 is
///      **not** exposed in the warm parent of interpreter 2 that did not
///      provide it. The isolation boundary is the per-instance allowed-set,
///      *not* the absence of the class from the process-global pool (the pool
///      still holds it; interpreter 2 simply was not granted it).
///  (c) Two consecutive executes on one interpreter reuse a single warm parent
///      (the per-execute child's `enclosing` is `identical` across runs).
///  (d) No script declaration leaks between executes or across interpreters.
///
/// **Twin divergence (deliberate).** Unlike `tom_d4rt_ast`, whose warm parent
/// holds full *name* bindings (so its mirror test asserts via
/// `findBridgedClassByName`), the analyzer-based `D4rt` registers only the
/// *type* lookup on the warm parent (`registerBridgeType`, not `defineBridge`)
/// — the analyzer `ModuleLoader` owns per-module name registration at import
/// time for module isolation (GEN-100/107, see `_warmParent` in
/// `d4rt_base.dart`). The security test (b) therefore probes the warm parent's
/// real exposure surface here: type resolution via `toBridgedInstance`, using
/// distinct native marker types per package. Both twins assert the same
/// *property* — an ungranted instance's warm parent does not contain the
/// granting instance's class — through each twin's actual exposure surface.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Distinct native marker types so the analyzer twin's *type* lookup can tell
/// `AClass` apart from `BClass` (a shared `Object` nativeType would collide).
class _AClassNative {}

void main() {
  /// A marker [BridgedClass] — never instantiated; only used to make an
  /// instance "migrated" by registering it under a provided package.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('IMP-OPT-12: pool / security regression (analyzer D4rt)', () {
    setUp(D4rt.debugResetPool);
    tearDown(D4rt.debugResetPool);

    test(
        'IMP-OPT-12a: providePackage returns false then true across two '
        'interpreters', () {
      final first = D4rt();
      expect(first.providePackage('pkg_a'), isFalse,
          reason: 'first sighting of pkg_a in the process — not pooled yet');
      first.registerBridgedClass(marker('AClass'), 'package:a/a.dart',
          sourceUri: 'package:a/a.dart');

      final second = D4rt();
      expect(second.providePackage('pkg_a'), isTrue,
          reason: 'pkg_a is now pooled — the second interpreter reuses it');
      expect(second.allowedPackages, contains('pkg_a'));
    });

    test(
        'IMP-OPT-12b: a package provided by interpreter 1 is NOT exposed in '
        'interpreter 2 that did not provide it', () {
      // Interpreter 1 provides pkg_a and pools AClass (native `_AClassNative`)
      // under it.
      final first = D4rt();
      expect(first.providePackage('pkg_a'), isFalse);
      first.registerBridgedClass(
          BridgedClass(nativeType: _AClassNative, name: 'AClass'),
          'package:a/a.dart',
          sourceUri: 'package:a/a.dart');
      first.execute(source: 'int main() => 1;');

      // Positive control: interpreter 1's warm parent DOES resolve the native
      // `_AClassNative` type (its pooled bridge is registered there).
      final firstParent = first.visitor!.globalEnvironment.enclosing!;
      expect(firstParent.toBridgedInstance(_AClassNative()), isNotNull,
          reason: 'the granting interpreter sees its own pooled class');

      // The class genuinely lives in the process-global pool — so the
      // isolation below is by allowed-set, not by absence from the pool.
      expect(D4rt.debugPooledClassCount('pkg_a'), greaterThanOrEqualTo(1),
          reason: 'AClass is pooled process-wide under pkg_a');

      // Interpreter 2 provides a DIFFERENT package and never provides pkg_a.
      final second = D4rt();
      expect(second.providePackage('pkg_b'), isFalse);
      second.execute(source: 'int main() => 2;');

      // SECURITY: `_AClassNative` must NOT resolve in interpreter 2's warm
      // parent — it was not granted pkg_a, so the type is unbridged there.
      final secondParent = second.visitor!.globalEnvironment.enclosing!;
      expect(() => secondParent.toBridgedInstance(_AClassNative()),
          throwsA(anything),
          reason: 'interpreter 2 was not granted pkg_a — AClass is out of '
              'scope');

      // A legacy interpreter 3 (no providePackage, no registration) is
      // likewise isolated: its warm parent is built from its own empty maps.
      final third = D4rt();
      third.execute(source: 'int main() => 3;');
      final thirdParent = third.visitor!.globalEnvironment.enclosing!;
      expect(() => thirdParent.toBridgedInstance(_AClassNative()),
          throwsA(anything),
          reason: 'a legacy interpreter never pulls pooled bridges it did not '
              'register itself');
    });

    test('IMP-OPT-12c: two executes reuse one warm parent', () {
      final first = D4rt();
      expect(first.providePackage('pkg_c'), isFalse);
      first.registerBridgedClass(marker('CClass'), 'package:c/c.dart',
          sourceUri: 'package:c/c.dart');

      first.execute(source: 'int main() => 1;');
      final parent1 = first.visitor!.globalEnvironment.enclosing;
      first.execute(source: 'int main() => 2;');
      final parent2 = first.visitor!.globalEnvironment.enclosing;

      expect(identical(parent1, parent2), isTrue,
          reason: 'the warm parent is built once and reused across executes');
      expect(D4rt.debugWarmParentCacheSize, 1,
          reason: 'a single cached warm parent for the {pkg_c} signature');
    });

    test('IMP-OPT-12d: no script-decl leak between executes or interpreters',
        () {
      final first = D4rt();
      first.execute(source: 'void d1() {}\nint main() => 1;');
      final firstChild = first.visitor!.globalEnvironment;
      expect(firstChild.values.containsKey('d1'), isTrue,
          reason: "first script's top-level fn lands in its own child");

      // Second execute on the SAME interpreter: fresh child, no leak of `d1`.
      first.execute(source: 'void d2() {}\nint main() => 2;');
      final secondChild = first.visitor!.globalEnvironment;
      expect(identical(firstChild, secondChild), isFalse);
      expect(secondChild.values.containsKey('d2'), isTrue);
      expect(secondChild.values.containsKey('d1'), isFalse,
          reason: "first execute's `d1` must NOT leak into the second child");
      // The immutable warm parent never receives script declarations.
      final parent = secondChild.enclosing!;
      expect(parent.values.containsKey('d1'), isFalse);
      expect(parent.values.containsKey('d2'), isFalse);

      // A SECOND interpreter: its child never sees the first's decls.
      final other = D4rt();
      other.execute(source: 'void d3() {}\nint main() => 3;');
      final otherChild = other.visitor!.globalEnvironment;
      expect(otherChild.values.containsKey('d3'), isTrue);
      expect(otherChild.values.containsKey('d1'), isFalse);
      expect(otherChild.values.containsKey('d2'), isFalse,
          reason: 'no script declaration leaks across interpreters');
    });
  });
}
