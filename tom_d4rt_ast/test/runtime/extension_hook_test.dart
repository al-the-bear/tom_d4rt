/// Step 6 of `d4rt_consolidation_plan.md` — runner-level extension hook
/// (`D4rtRunner.registerExtensions` / `finalizeBridges`).
///
/// Replaces the comment-driven "must run AFTER bridges" rule with an
/// enforced mechanism. Bridge packages register an extension callback
/// at construction; the runner runs all callbacks in registration
/// order when [D4rtRunner.finalizeBridges] is called (or implicitly on
/// the first execute call).
///
/// This suite asserts the contract directly:
///   * extension callbacks fire in registration order on
///     `finalizeBridges()`;
///   * `finalizeBridges()` is idempotent — repeat calls do not re-run
///     callbacks;
///   * implicit finalize fires on the first `execute*` call;
///   * registering after finalize throws [StateError];
///   * re-registering with the same package name overwrites the body
///     (one-callback-per-package contract).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// Builds the smallest possible [AstBundle] whose `main()` returns an
/// `int`. Used to drive `executeBundle` in the implicit-finalize test.
AstBundle _intBundle(
  int returnValue, {
  String entryUri = 'package:t/main.dart',
}) {
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
  final unit = SCompilationUnit(offset: 0, length: 0, declarations: [mainFn]);
  return AstBundle(entryPointUri: entryUri, modules: {entryUri: unit});
}

void main() {
  group('D4rtRunner.registerExtensions / finalizeBridges', () {
    test(
      'callbacks fire in registration order when finalizeBridges is called',
      () {
        final runner = D4rtRunner();
        final order = <String>[];
        runner.registerExtensions('alpha', () => order.add('alpha'));
        runner.registerExtensions('beta', () => order.add('beta'));
        runner.registerExtensions('gamma', () => order.add('gamma'));

        // Pre-condition: nothing has run yet.
        expect(order, isEmpty);
        expect(runner.bridgesFinalized, isFalse);

        runner.finalizeBridges();

        // Post-condition: every callback ran exactly once, in registration
        // order.
        expect(order, equals(<String>['alpha', 'beta', 'gamma']));
        expect(runner.bridgesFinalized, isTrue);
      },
    );

    test('finalizeBridges is idempotent — second call is a no-op', () {
      final runner = D4rtRunner();
      var fireCount = 0;
      runner.registerExtensions('once', () => fireCount++);

      runner.finalizeBridges();
      runner.finalizeBridges();
      runner.finalizeBridges();

      expect(
        fireCount,
        1,
        reason:
            'finalizeBridges() must run each callback exactly once across '
            'any number of finalize calls.',
      );
      expect(runner.bridgesFinalized, isTrue);
    });

    test('re-registering with the same package name overwrites the body '
        '(idempotent on package name)', () {
      final runner = D4rtRunner();
      var fired = '';
      runner.registerExtensions('flutter', () => fired = 'first');
      runner.registerExtensions('flutter', () => fired = 'second');
      runner.registerExtensions('flutter', () => fired = 'third');

      runner.finalizeBridges();

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
        final runner = D4rtRunner();
        runner.registerExtensions('early', () {});
        runner.finalizeBridges();

        expect(
          () => runner.registerExtensions('late', () {}),
          throwsA(isA<StateError>()),
          reason:
              'Adding extensions after the runner is frozen is a misuse — '
              'the runner must surface it as an error rather than silently '
              'dropping the registration.',
        );
      },
    );

    test('callbacks fire implicitly on the first executeBundle call', () {
      final runner = D4rtRunner();
      var ranBeforeScript = false;
      runner.registerExtensions('implicit', () {
        // Capture the moment the callback runs. After this returns, the
        // script body executes; if the callback has already set the flag
        // by then, the implicit finalize fired before pass 1.
        ranBeforeScript = true;
      });

      // Pre-condition: nothing wired yet.
      expect(runner.bridgesFinalized, isFalse);
      expect(ranBeforeScript, isFalse);

      // Execute a tiny bundle. _executeInEnvironment calls finalizeBridges
      // before pass 1.
      final result = runner.executeBundle(_intBundle(7));

      expect(result, 7);
      expect(
        ranBeforeScript,
        isTrue,
        reason:
            'Implicit finalize must run extension callbacks before '
            'the script body executes.',
      );
      expect(runner.bridgesFinalized, isTrue);
    });

    test('a second executeBundle call does NOT re-run callbacks', () {
      final runner = D4rtRunner();
      var fireCount = 0;
      runner.registerExtensions('countMe', () => fireCount++);

      runner.executeBundle(_intBundle(1));
      runner.executeBundle(_intBundle(2));
      runner.executeBundle(_intBundle(3));

      expect(
        fireCount,
        1,
        reason:
            'Implicit finalize is once-per-runner; subsequent '
            'executeBundle calls must not re-run extension callbacks.',
      );
    });

    test('explicit finalizeBridges before execute is supported and '
        'still runs callbacks before the script', () {
      final runner = D4rtRunner();
      final events = <String>[];
      runner.registerExtensions('explicit', () => events.add('callback'));

      // Embedder-driven explicit finalize.
      runner.finalizeBridges();
      events.add('finalize-returned');

      // The implicit hook in _executeInEnvironment is a no-op now.
      final result = runner.executeBundle(_intBundle(42));

      expect(result, 42);
      // Order: callback ran during finalize, then 'finalize-returned'
      // recorded, then the script ran. The callback did NOT run again.
      expect(events, equals(<String>['callback', 'finalize-returned']));
    });
  });
}
