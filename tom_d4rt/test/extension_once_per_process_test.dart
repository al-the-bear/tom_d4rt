/// Step 11 regression tests for the import-optimization plan
/// (`interpreter_import_optimization_plan.md`) on the analyzer-based `D4rt`
/// (mirror of `tom_d4rt_ast`'s `extension_once_per_process_test.dart`).
///
/// Pins the once-per-package-per-process firing contract for
/// `D4rt.registerExtensions` / `finalizeBridges`:
///
///  * a package's extension callback fires **exactly once per process**, even
///    when two separate interpreters each register it and each finalize;
///  * the canonical `providePackage`-guarded idiom fires it once (the first
///    instance pays the cost; the second skips both registration and the
///    extension);
///  * distinct packages each still fire once (no cross-package interference).
///
/// The pool + warm-parent caches are process-global; reset them before/after
/// each test so the firing assertions are order-independent.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  /// A marker [BridgedClass] — never instantiated; only used to make an
  /// instance "migrated" by registering it under a provided package.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('IMP-OPT-11: extension callbacks fire once per package per process', () {
    setUp(D4rt.debugResetPool);
    tearDown(D4rt.debugResetPool);

    test(
        'IMP-OPT-11a: two interpreters registering the same package fire the '
        'callback exactly once', () {
      var fireCount = 0;

      final first = D4rt();
      first.registerExtensions('shared_pkg', () => fireCount++);
      first.finalizeBridges();
      expect(fireCount, 1, reason: 'first finalize fires the callback');

      final second = D4rt();
      second.registerExtensions('shared_pkg', () => fireCount += 100);
      second.finalizeBridges();

      expect(fireCount, 1,
          reason: 'second interpreter must NOT re-fire the already-fired '
              'package');
    });

    test(
        'IMP-OPT-11b: canonical providePackage idiom fires extensions once', () {
      var fireCount = 0;

      final first = D4rt();
      if (first.providePackage('flutter') == false) {
        first.registerBridgedClass(marker('FWidget'), 'package:f/f.dart',
            sourceUri: 'package:f/f.dart');
        first.registerExtensions('flutter', () => fireCount++);
      }
      first.finalizeBridges();
      expect(fireCount, 1);

      final second = D4rt();
      if (second.providePackage('flutter') == false) {
        second.registerExtensions('flutter', () => fireCount += 100);
      }
      second.finalizeBridges();

      expect(fireCount, 1,
          reason: 'second instance skips registration and the extension, and '
              'the pooled callback is already fired');
    });

    test('IMP-OPT-11c: distinct packages each fire once in registration order',
        () {
      final order = <String>[];

      final first = D4rt();
      first.registerExtensions('alpha', () => order.add('alpha'));
      first.registerExtensions('beta', () => order.add('beta'));
      first.finalizeBridges();
      expect(order, equals(<String>['alpha', 'beta']));

      final second = D4rt();
      second.registerExtensions('alpha', () => order.add('alpha2'));
      second.registerExtensions('beta', () => order.add('beta2'));
      second.finalizeBridges();

      expect(order, equals(<String>['alpha', 'beta']),
          reason: 'both packages already fired once in this process');
    });
  });
}
