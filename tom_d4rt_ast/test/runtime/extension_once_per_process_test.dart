/// Step 11 regression tests for the import-optimization plan
/// (`interpreter_import_optimization_plan.md`).
///
/// Pins the once-per-package-per-process firing contract for
/// `D4rtRunner.registerExtensions` / `finalizeBridges`:
///
///  * a package's extension callback fires **exactly once per process**, even
///    when two separate runners each register it and each finalize;
///  * the canonical `providePackage`-guarded idiom fires it once (the first
///    instance pays the cost; the second skips both registration and the
///    extension);
///  * distinct packages each still fire once (no cross-package interference).
///
/// The pool + warm-parent caches are process-global; reset them before/after
/// each test so the firing assertions are order-independent.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  /// A marker [BridgedClass] — never instantiated; only used to make an
  /// instance "migrated" by registering it under a provided package.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  group('IMP-OPT-11: extension callbacks fire once per package per process', () {
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test('IMP-OPT-11a: two runners registering the same package fire the '
        'callback exactly once', () {
      var fireCount = 0;

      final first = D4rtRunner();
      first.registerExtensions('shared_pkg', () => fireCount++);
      first.finalizeBridges();
      expect(fireCount, 1, reason: 'first finalize fires the callback');

      final second = D4rtRunner();
      // A different body for the same package name. Step-11 guard means it is
      // never fired — the package already fired in this process.
      second.registerExtensions('shared_pkg', () => fireCount += 100);
      second.finalizeBridges();

      expect(
        fireCount,
        1,
        reason: 'second runner must NOT re-fire the already-fired package',
      );
    });

    test(
      'IMP-OPT-11b: canonical providePackage idiom fires extensions once',
      () {
        var fireCount = 0;

        // First instance: providePackage returns false → register + extensions.
        final first = D4rtRunner();
        if (first.providePackage('flutter') == false) {
          first.registerBridgedClass(
            marker('FWidget'),
            'package:f/f.dart',
            sourceUri: 'package:f/f.dart',
          );
          first.registerExtensions('flutter', () => fireCount++);
        }
        first.finalizeBridges();
        expect(fireCount, 1);

        // Second instance: providePackage returns true → skips both branches.
        final second = D4rtRunner();
        if (second.providePackage('flutter') == false) {
          // Should NOT enter — already pooled.
          second.registerExtensions('flutter', () => fireCount += 100);
        }
        second.finalizeBridges();

        expect(
          fireCount,
          1,
          reason:
              'second instance skips registration and the extension, and '
              'the pooled callback is already fired',
        );
      },
    );

    test(
      'IMP-OPT-11c: distinct packages each fire once in registration order',
      () {
        final order = <String>[];

        final first = D4rtRunner();
        first.registerExtensions('alpha', () => order.add('alpha'));
        first.registerExtensions('beta', () => order.add('beta'));
        first.finalizeBridges();
        expect(order, equals(<String>['alpha', 'beta']));

        // A second runner re-registering both fires neither again.
        final second = D4rtRunner();
        second.registerExtensions('alpha', () => order.add('alpha2'));
        second.registerExtensions('beta', () => order.add('beta2'));
        second.finalizeBridges();

        expect(
          order,
          equals(<String>['alpha', 'beta']),
          reason: 'both packages already fired once in this process',
        );
      },
    );
  });
}
