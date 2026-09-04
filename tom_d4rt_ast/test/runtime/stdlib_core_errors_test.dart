import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// `CoreStdlib` — like every other stdlib registrar — is deliberately not
// re-exported from `runtime.dart`; `dart:core` is registered by
// `ast_module_loader.dart`. Driving that path from a unit test would mean
// building a parsed AST module, so we reach for the same-package registrar
// directly instead of widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

/// SC5 mirror coverage for `tom_d4rt_ast`.
///
/// Registration-level rather than script-level: the script-level equivalents
/// live in `tom_d4rt/test/stdlib/core/errors_test.dart`, and `tom_d4rt_exec`
/// (the runner that could execute a script against *this* tree) resolves
/// `tom_d4rt_ast` from pub.dev rather than by path, so it cannot see
/// unpublished local edits.
///
/// What is observable without an interpreter is exactly what SC5 changed on
/// this side: the seven bridges exist with usable constructors and getters,
/// each claims its own native type through `isAssignable` (the predicate the
/// catch-clause matcher now consults), and the `dart:core` error inheritance
/// chain is in the supertype registry so `isSubtypeOf` can answer
/// `IndexError is RangeError`.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    // Method adapters take a non-nullable visitor (only getters accept `null`).
    // None of the members exercised here resolves a name or loads a module, so
    // an empty loader is enough.
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  BridgedClass bridgeOf(String name) {
    final bridge = env.findBridgedClassByName(name);
    expect(bridge, isNotNull, reason: '$name should be registered');
    return bridge!;
  }

  group('SC5/AST: catchable dart:core error types', () {
    test('F-SC5-AST-1: all seven error types are registered against their SDK '
        'native type [2026-07-27]', () {
      const expected = <String, Type>{
        'NoSuchMethodError': NoSuchMethodError,
        'ConcurrentModificationError': ConcurrentModificationError,
        'IndexError': IndexError,
        'TypeError': TypeError,
        'AssertionError': AssertionError,
        'StackOverflowError': StackOverflowError,
        'OutOfMemoryError': OutOfMemoryError,
      };
      for (final entry in expected.entries) {
        expect(bridgeOf(entry.key).nativeType, entry.value, reason: entry.key);
      }
    });

    test('F-SC5-AST-2: every new bridge carries an isAssignable predicate that '
        'accepts its own type [2026-07-27]', () {
      // This predicate is load-bearing twice over: `Environment` uses it to
      // pick the owning bridge for a native object, and (as of SC5) the
      // catch-clause matcher asks it whether the catch type accepts the
      // thrown value.
      final samples = <String, Object>{
        'ConcurrentModificationError': ConcurrentModificationError([1]),
        'IndexError': IndexError.withLength(5, 2),
        'TypeError': TypeError(),
        'AssertionError': AssertionError('m'),
        'StackOverflowError': StackOverflowError(),
        'OutOfMemoryError': OutOfMemoryError(),
      };
      for (final entry in samples.entries) {
        final bridge = bridgeOf(entry.key);
        expect(bridge.isAssignable, isNotNull, reason: entry.key);
        expect(bridge.isAssignable!(entry.value), isTrue, reason: entry.key);
      }
    });

    test('F-SC5-AST-3: the private VM subclasses route to their public bridge '
        '[2026-07-27]', () {
      // A failing cast raises `_TypeError`, a failing `assert` raises
      // `_AssertionError`. Without `nativeNames` those values reach no bridge
      // at all, so `on TypeError` could never see them.
      expect(bridgeOf('TypeError').nativeNames, contains('_TypeError'));
      expect(
        bridgeOf('AssertionError').nativeNames,
        contains('_AssertionError'),
      );
    });

    test('F-SC5-AST-4: the dart:core error hierarchy is in the supertype '
        'registry [2026-07-27]', () {
      // Bridges are registered flat, so this registry is the only thing that
      // can answer `indexError is RangeError`.
      expect(
        BridgedClass.transitiveSupertypeNames('IndexError'),
        containsAll(<String>['RangeError', 'ArgumentError', 'Error']),
      );
      expect(
        BridgedClass.transitiveSupertypeNames('RangeError'),
        containsAll(<String>['ArgumentError', 'Error']),
      );
      expect(
        BridgedClass.transitiveSupertypeNames('UnimplementedError'),
        containsAll(<String>['UnsupportedError', 'Error']),
      );
      for (final name in const [
        'NoSuchMethodError',
        'ConcurrentModificationError',
        'TypeError',
        'AssertionError',
        'StackOverflowError',
        'OutOfMemoryError',
      ]) {
        expect(
          BridgedClass.transitiveSupertypeNames(name),
          contains('Error'),
          reason: name,
        );
      }
    });

    test(
      'F-SC5-AST-5: isSubtypeOf follows the registered chain [2026-07-27]',
      () {
        final indexError = bridgeOf('IndexError');
        expect(indexError.isSubtypeOf(bridgeOf('RangeError')), isTrue);
        expect(indexError.isSubtypeOf(bridgeOf('ArgumentError')), isTrue);
        expect(indexError.isSubtypeOf(bridgeOf('Error')), isTrue);
        // Guard the other direction: a RangeError is not an IndexError.
        expect(bridgeOf('RangeError').isSubtypeOf(indexError), isFalse);
      },
    );

    test(
      'F-SC5-AST-6: the constructors build real SDK errors [2026-07-27]',
      () {
        expect(
          bridgeOf('IndexError').constructors['withLength']!(
            visitor,
            [5, 2],
            {'name': 'idx'},
          ),
          isA<IndexError>(),
        );
        expect(
          bridgeOf('ConcurrentModificationError').constructors['']!(visitor, [
            [1, 2],
          ], {}),
          isA<ConcurrentModificationError>(),
        );
        expect(
          bridgeOf('TypeError').constructors['']!(visitor, [], {}),
          isA<TypeError>(),
        );
        expect(
          bridgeOf('AssertionError').constructors['']!(visitor, ['boom'], {}),
          isA<AssertionError>(),
        );
        expect(
          bridgeOf('StackOverflowError').constructors['']!(visitor, [], {}),
          isA<StackOverflowError>(),
        );
        expect(
          bridgeOf('OutOfMemoryError').constructors['']!(visitor, [], {}),
          isA<OutOfMemoryError>(),
        );
        expect(
          bridgeOf('NoSuchMethodError').constructors['withInvocation']!(
            visitor,
            [1, Invocation.method(#foo, const [])],
            {},
          ),
          isA<NoSuchMethodError>(),
        );
      },
    );

    test(
      'F-SC5-AST-7: the getters read through to the SDK value [2026-07-27]',
      () {
        final indexError = IndexError.withLength(5, 2, name: 'idx');
        final bridge = bridgeOf('IndexError');
        expect(bridge.getters['invalidValue']!(visitor, indexError), 5);
        expect(bridge.getters['length']!(visitor, indexError), 2);
        expect(bridge.getters['start']!(visitor, indexError), 0);
        expect(bridge.getters['end']!(visitor, indexError), 1);
        expect(bridge.getters['name']!(visitor, indexError), 'idx');

        expect(
          bridgeOf('AssertionError').getters['message']!(
            visitor,
            AssertionError('boom'),
          ),
          'boom',
        );
        final modified = [1, 2, 3];
        expect(
          bridgeOf('ConcurrentModificationError').getters['modifiedObject']!(
            visitor,
            ConcurrentModificationError(modified),
          ),
          same(modified),
        );
      },
    );

    test('F-SC5-AST-8: adding the new bridges leaves the pre-existing error '
        'bridges registered [2026-07-27]', () {
      // Regression guard: the seven `defineBridge` calls were inserted into
      // `CoreStdlib.register`, which is keyed by name — a typo would silently
      // replace an existing bridge rather than add one.
      for (final name in const [
        'Error',
        'StateError',
        'ArgumentError',
        'RangeError',
        'UnsupportedError',
        'UnimplementedError',
        'Exception',
        'FormatException',
      ]) {
        expect(env.findBridgedClassByName(name), isNotNull, reason: name);
      }
    });
  });
}
