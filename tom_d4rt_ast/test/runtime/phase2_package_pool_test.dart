/// Phase-2 step #7 regression tests for the import-optimization plan.
///
/// Lock in the `providePackage` + process-global pool contract:
///
///  (a) `providePackage` returns `false` the first time a package is seen in
///      the process and `true` thereafter (across instances) — the pool is
///      process-global, so a second runner reuses the first's registration.
///  (b) `providePackage` is idempotent: a second call on the *same* instance
///      for an already-pooled package returns `true` and keeps the grant.
///  (c) A freshly-provided package's `register*` definitions land in
///      `_packagePool[name]` (asserted via the read-only pool introspection).
///  (d) Unmigrated callers (no `providePackage`) still register — their defs
///      land under the synthetic `'<default>'` package.
///
/// The step-7 read path still resolves from the per-instance maps; the pool is
/// populated but not yet consumed (that switch is step #8). These tests
/// therefore assert pool *population* + `providePackage` *reporting*, not
/// cross-instance resolution (covered by the step #12 security tests).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  /// A marker [BridgedClass] — we never instantiate the native type.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('IMP-OPT-7: providePackage + process-global pool', () {
    // The pool is process-global; reset it before each test so assertions
    // about pool membership are deterministic regardless of test order.
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test(
        'IMP-OPT-7a: providePackage returns false then true across instances',
        () {
      final first = D4rtRunner();
      // First instance in the process: package not pooled yet.
      expect(first.providePackage('pkg_a'), isFalse,
          reason: 'first sighting of pkg_a is a pool miss');
      // The caller (this test) now registers, populating the pool.
      first.registerBridgedClass(marker('AClass'), 'package:a/a.dart',
          sourceUri: 'package:a/a.dart');

      // A second instance for the same package gets a pool hit.
      final second = D4rtRunner();
      expect(second.providePackage('pkg_a'), isTrue,
          reason: 'pkg_a is now pooled — the second instance reuses it');

      // Grant is recorded on both instances either way.
      expect(first.allowedPackages, contains('pkg_a'));
      expect(second.allowedPackages, contains('pkg_a'));
    });

    test('IMP-OPT-7b: providePackage is idempotent on one instance', () {
      final runner = D4rtRunner();
      expect(runner.providePackage('pkg_b'), isFalse);
      runner.registerBridgedClass(marker('BClass'), 'package:b/b.dart',
          sourceUri: 'package:b/b.dart');
      // Second call for the same package on the same instance: now pooled.
      expect(runner.providePackage('pkg_b'), isTrue,
          reason: 're-providing an already-pooled package returns true');
      // Grant remains in place (set semantics — no duplicate, still present).
      expect(runner.allowedPackages, contains('pkg_b'));
    });

    test('IMP-OPT-7c: freshly-provided defs land in the pool under the name',
        () {
      final runner = D4rtRunner();
      expect(runner.providePackage('pkg_c'), isFalse);
      runner.registerBridgedClass(marker('CClass'), 'package:c/c.dart',
          sourceUri: 'package:c/c.dart');
      runner.registerBridgedClass(marker('CClass2'), 'package:c/c2.dart',
          sourceUri: 'package:c/c2.dart');

      expect(D4rtRunner.debugPooledPackages, contains('pkg_c'));
      expect(D4rtRunner.debugPooledClassCount('pkg_c'), 2,
          reason: 'both classes registered while pkg_c was the active context');
      // Nothing leaked into the default package.
      expect(D4rtRunner.debugPooledClassCount('<default>'), 0);
    });

    test('IMP-OPT-7d: unmigrated callers route to the <default> package', () {
      final runner = D4rtRunner();
      // No providePackage call — legacy registration path.
      runner.registerBridgedClass(marker('DClass'), 'package:d/d.dart',
          sourceUri: 'package:d/d.dart');

      expect(D4rtRunner.debugPooledPackages, contains('<default>'));
      expect(D4rtRunner.debugPooledClassCount('<default>'), 1);
      // Per-instance read path still works (step-7 resolution source).
      expect(runner.bridgedClasses['package:d/d.dart']!.containsKey('DClass'),
          isTrue);
    });

    test(
        'IMP-OPT-7e: providePackage(true) closes the registration context so '
        'later legacy register* fall back to <default>', () {
      final first = D4rtRunner();
      expect(first.providePackage('pkg_e'), isFalse);
      first.registerBridgedClass(marker('EClass'), 'package:e/e.dart',
          sourceUri: 'package:e/e.dart');

      // Second instance: pool hit closes the context (no _currentProvidingPackage).
      final second = D4rtRunner();
      expect(second.providePackage('pkg_e'), isTrue);
      // A subsequent legacy registration on the second instance must not be
      // misattributed to pkg_e — it goes to <default>.
      second.registerBridgedClass(marker('Stray'), 'package:stray/stray.dart',
          sourceUri: 'package:stray/stray.dart');
      expect(D4rtRunner.debugPooledClassCount('pkg_e'), 1,
          reason: 'pkg_e keeps only its own class');
      expect(D4rtRunner.debugPooledClassCount('<default>'), 1,
          reason: 'the stray legacy class lands in <default>');
    });
  });
}
