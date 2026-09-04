/// Step 6 of `d4rt_consolidation_plan.md` — runner-level extension hook
/// (`D4rt.registerExtensions` / `finalizeBridges`).
///
/// Mirrors `tom_d4rt_ast/test/runtime/extension_hook_test.dart` against
/// the analyzer-based `D4rt` class. The contract is identical to the
/// analyzer-free runner — the only difference is the entry point that
/// triggers the implicit finalize: `execute(source: ...)` here vs
/// `executeBundle(...)` on `D4rtRunner`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('D4rt.registerExtensions / finalizeBridges', () {
    test(
      'callbacks fire in registration order when finalizeBridges is called',
      () {
        final d4rt = D4rt();
        final order = <String>[];
        d4rt.registerExtensions('alpha', () => order.add('alpha'));
        d4rt.registerExtensions('beta', () => order.add('beta'));
        d4rt.registerExtensions('gamma', () => order.add('gamma'));

        // Pre-condition: nothing has run yet.
        expect(order, isEmpty);
        expect(d4rt.bridgesFinalized, isFalse);

        d4rt.finalizeBridges();

        // Post-condition: every callback ran exactly once, in registration
        // order.
        expect(order, equals(<String>['alpha', 'beta', 'gamma']));
        expect(d4rt.bridgesFinalized, isTrue);
      },
    );

    test('finalizeBridges is idempotent — second call is a no-op', () {
      final d4rt = D4rt();
      var fireCount = 0;
      d4rt.registerExtensions('once', () => fireCount++);

      d4rt.finalizeBridges();
      d4rt.finalizeBridges();
      d4rt.finalizeBridges();

      expect(
        fireCount,
        1,
        reason:
            'finalizeBridges() must run each callback exactly once across '
            'any number of finalize calls.',
      );
      expect(d4rt.bridgesFinalized, isTrue);
    });

    test('re-registering with the same package name overwrites the body '
        '(idempotent on package name)', () {
      final d4rt = D4rt();
      var fired = '';
      d4rt.registerExtensions('flutter', () => fired = 'first');
      d4rt.registerExtensions('flutter', () => fired = 'second');
      d4rt.registerExtensions('flutter', () => fired = 'third');

      d4rt.finalizeBridges();

      expect(
        fired,
        'third',
        reason:
            'Last registration for a given package name wins; '
            'previous bodies are dropped (one extension per package).',
      );
    });

    test(
      'registerExtensions throws StateError after finalizeBridges has run',
      () {
        final d4rt = D4rt();
        d4rt.registerExtensions('early', () {});
        d4rt.finalizeBridges();

        expect(
          () => d4rt.registerExtensions('late', () {}),
          throwsA(isA<StateError>()),
          reason:
              'Adding extensions after the runner is frozen is a misuse — '
              'the runner must surface it as an error rather than silently '
              'dropping the registration.',
        );
      },
    );

    test('callbacks fire implicitly on the first execute call', () {
      final d4rt = D4rt();
      var ranBeforeScript = false;
      d4rt.registerExtensions('implicit', () {
        ranBeforeScript = true;
      });

      // Pre-condition: nothing wired yet.
      expect(d4rt.bridgesFinalized, isFalse);
      expect(ranBeforeScript, isFalse);

      // Execute a tiny script. _executeInEnvironment calls finalizeBridges
      // before pass 1.
      final result = d4rt.execute(source: 'int main() => 7;');

      expect(result, 7);
      expect(
        ranBeforeScript,
        isTrue,
        reason:
            'Implicit finalize must run extension callbacks before '
            'the script body executes.',
      );
      expect(d4rt.bridgesFinalized, isTrue);
    });

    test('a second execute call does NOT re-run callbacks', () {
      final d4rt = D4rt();
      var fireCount = 0;
      d4rt.registerExtensions('countMe', () => fireCount++);

      d4rt.execute(source: 'int main() => 1;');
      d4rt.execute(source: 'int main() => 2;');
      d4rt.execute(source: 'int main() => 3;');

      expect(
        fireCount,
        1,
        reason:
            'Implicit finalize is once-per-runner; subsequent '
            'execute calls must not re-run extension callbacks.',
      );
    });

    test('explicit finalizeBridges before execute is supported and '
        'still runs callbacks before the script', () {
      final d4rt = D4rt();
      final events = <String>[];
      d4rt.registerExtensions('explicit', () => events.add('callback'));

      // Embedder-driven explicit finalize.
      d4rt.finalizeBridges();
      events.add('finalize-returned');

      // The implicit hook in _executeInEnvironment is a no-op now.
      final result = d4rt.execute(source: 'int main() => 42;');

      expect(result, 42);
      // Order: callback ran during finalize, then 'finalize-returned'
      // recorded, then the script ran. The callback did NOT run again.
      expect(events, equals(<String>['callback', 'finalize-returned']));
    });
  });
}
