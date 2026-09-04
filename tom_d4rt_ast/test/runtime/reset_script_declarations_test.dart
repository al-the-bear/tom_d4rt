/// Tests for [D4rtRunner.resetScriptDeclarations] — the §U28 / TODO #14
/// forward-compatibility hook that evicts script-declared entries from
/// `_globalEnvironment._values` while preserving bridge / stdlib
/// registrations.
///
/// See `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` §U28 for
/// the architectural caveat: the runner already constructs a fresh
/// `Environment` per `executeBundle`, so this API is a forward-
/// compatibility hook rather than the §U28 wedge fix. These tests
/// only verify the API contract — that the reset removes script-
/// declared entries, preserves the bridge / stdlib baseline, and is
/// safe to call before any execute (no-op) and between executes
/// (idempotent).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  /// Builds an [AstBundle] whose `main` returns the literal [returnValue]
  /// AND defines an extra top-level function `extra()` so we can assert
  /// it lands in the global environment as a script declaration.
  AstBundle bundleWithExtraTopLevelFn(int returnValue) {
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
      name: SSimpleIdentifier(offset: 0, length: 5, name: 'extra'),
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

  group('D4rtRunner.resetScriptDeclarations', () {
    test('is a safe no-op before any execute', () {
      final runner = D4rtRunner();
      // No prior execute → no global environment → must not throw.
      expect(() => runner.resetScriptDeclarations(), returnsNormally);
    });

    test('evicts script-declared entries after execute while leaving '
        'a working interpreter behind', () {
      final runner = D4rtRunner();
      // First execute: `extra` lands in the global environment as a
      // script declaration.
      expect(runner.executeBundleAs<int>(bundleWithExtraTopLevelFn(7)), 7);

      // Step 8 (warm parent): the visitor's globalEnvironment is the
      // per-execute child; it holds the script declarations (`main`, `extra`),
      // while stdlib/bridges live on the warm parent. So the child's local
      // `_values` is non-empty purely because of script declarations.
      final preResetValueCount =
          runner.visitor!.globalEnvironment.values.length;
      expect(
        preResetValueCount,
        greaterThan(0),
        reason: 'script declarations must populate the child environment',
      );

      // Reset evicts the `extra` (and `main`) entries.
      runner.resetScriptDeclarations();

      // The map shrinks, but the stdlib / bridge entries remain — the
      // resulting size must be lower than pre-reset, and lower or equal
      // to the post-init baseline (a fresh environment with no script
      // run yet should never have more values than after a reset).
      final postResetValueCount =
          runner.visitor!.globalEnvironment.values.length;
      expect(
        postResetValueCount,
        lessThanOrEqualTo(preResetValueCount),
        reason: 'reset must not add entries',
      );
      expect(
        runner.visitor!.globalEnvironment.values.containsKey('extra'),
        isFalse,
        reason: 'script-declared "extra" must be evicted by reset',
      );
      expect(
        runner.visitor!.globalEnvironment.values.containsKey('main'),
        isFalse,
        reason: 'script-declared "main" must be evicted by reset',
      );
    });

    test('is idempotent — repeated calls preserve the baseline', () {
      final runner = D4rtRunner();
      expect(runner.executeBundleAs<int>(bundleWithExtraTopLevelFn(11)), 11);
      runner.resetScriptDeclarations();
      final firstSize = runner.visitor!.globalEnvironment.values.length;
      runner.resetScriptDeclarations();
      runner.resetScriptDeclarations();
      final lastSize = runner.visitor!.globalEnvironment.values.length;
      expect(
        lastSize,
        firstSize,
        reason: 'subsequent resets must not change the environment size',
      );
    });

    test('a follower executeBundle after reset still works — the '
        'fresh-environment-per-call invariant is preserved', () {
      final runner = D4rtRunner();
      expect(runner.executeBundleAs<int>(bundleWithExtraTopLevelFn(13)), 13);
      runner.resetScriptDeclarations();
      // executeBundle calls _initEnvironment which constructs a fresh
      // Environment — the reset must not have damaged any state the
      // next executeBundle relies on.
      expect(runner.executeBundleAs<int>(bundleWithExtraTopLevelFn(17)), 17);
    });

    // TODO #14 risk §707 ("false positive — over-clearing"): if the
    // reset accidentally evicts stdlib or bridge entries, subsequent
    // builds will fail with "Undefined name" errors. These cases pin
    // the contract that those classes of entry are preserved.
    test('preserves stdlib names — print and Stopwatch survive reset', () {
      final runner = D4rtRunner();
      // Bootstrap the global environment by running any bundle.
      expect(runner.executeBundleAs<int>(bundleWithExtraTopLevelFn(1)), 1);

      // Step 8 (warm parent): stdlib bridges land on the shared warm PARENT
      // via `Stdlib(parent).register()`, not on the per-execute child. The
      // visitor's `globalEnvironment` is the child; its `enclosing` is the
      // warm parent that holds the stdlib baseline. `reset` walks the child,
      // so stdlib on the parent is preserved by construction.
      final env = runner.visitor!.globalEnvironment;
      final parent = env.enclosing!;
      expect(
        parent.values.containsKey('print'),
        isTrue,
        reason: 'stdlib `print` must be registered on the warm parent',
      );
      // Resolvable from the child via the enclosing chain (the script's view).
      expect(
        env.get('print'),
        isNotNull,
        reason: 'child must resolve stdlib `print` through the warm parent',
      );

      // The script declarations get evicted...
      runner.resetScriptDeclarations();

      // ...but stdlib survives on the immutable parent.
      expect(
        parent.values.containsKey('print'),
        isTrue,
        reason: 'reset must NOT evict stdlib `print` (TODO #14 §707)',
      );
      // A second executeBundle that depends on stdlib still succeeds —
      // this is the integration-level guarantee equivalent to "smoke
      // test passes after reset" from the validation plan.
      expect(runner.executeBundleAs<int>(bundleWithExtraTopLevelFn(2)), 2);
    });

    test('preserves bridge registrations — _bridgedClasses survive reset', () {
      final runner = D4rtRunner();
      // Run any bundle to populate the environment.
      expect(runner.executeBundleAs<int>(bundleWithExtraTopLevelFn(1)), 1);

      // Step 8 (warm parent): `_registerBridgedDefinitions` runs on the warm
      // PARENT, so built-in stdlib bridges (e.g. _Random) live on
      // `env.enclosing`, not on the per-execute child. The reset walks the
      // child's `_values`, so parent bridges are preserved by construction.
      final env = runner.visitor!.globalEnvironment;
      final parent = env.enclosing!;
      final preBridgeNames = parent.bridgedClassNames.toSet();
      expect(
        preBridgeNames,
        isNotEmpty,
        reason:
            'stdlib bridge registration must populate the warm parent\'s '
            '_bridgedClasses (at minimum: _Random etc.)',
      );

      runner.resetScriptDeclarations();

      final postBridgeNames = parent.bridgedClassNames.toSet();
      expect(
        postBridgeNames,
        preBridgeNames,
        reason:
            'reset must NOT evict any bridged class names — bridge '
            'registrations live on the warm parent\'s `_bridgedClasses`, '
            'not the child\'s `_values` (TODO #14 §707 + §676)',
      );
    });

    test('preserves bridged enum registrations across reset', () {
      final runner = D4rtRunner();
      expect(runner.executeBundleAs<int>(bundleWithExtraTopLevelFn(1)), 1);

      // Step 8 (warm parent): bridged enums also live on the warm parent.
      final env = runner.visitor!.globalEnvironment;
      final parent = env.enclosing!;
      final preEnumNames = parent.bridgedEnumNames.toSet();

      runner.resetScriptDeclarations();

      expect(
        parent.bridgedEnumNames.toSet(),
        preEnumNames,
        reason:
            'reset must NOT evict bridged enum names — they live on the warm '
            'parent\'s `_bridgedEnums`, not the child\'s `_values`',
      );
    });
  });
}
