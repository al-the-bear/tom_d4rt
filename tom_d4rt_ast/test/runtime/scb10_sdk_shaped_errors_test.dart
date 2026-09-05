import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// `CoreStdlib` — like every other stdlib registrar — is deliberately not
// re-exported from `runtime.dart`; `dart:core` is registered by
// `ast_module_loader.dart`. Reaching for the same-package registrar directly
// avoids widening the published API just to drive a unit test.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

/// SCB10 mirror coverage for `tom_d4rt_ast`.
///
/// Registration-level rather than script-level, for the same reason as the SC5
/// mirror suite: `tom_d4rt_exec` — the only runner that could execute a script
/// against *this* tree — resolves `tom_d4rt_ast` from pub.dev rather than by
/// path, so it cannot see unpublished local edits. The script-level equivalents
/// live in `tom_d4rt/test/scb10_sdk_shaped_errors_test.dart`.
///
/// What *is* observable here is the joint that actually decides whether SCB10
/// works: the interpreter raises `D4rtTypeError` / `D4rtNoSuchMethodError` /
/// a plain `RangeError`, and the catch-clause matcher asks the SC5 bridge's
/// `isAssignable` predicate whether the catch type accepts the thrown value. If
/// the raised types and the bridges' predicates ever drift apart, `on TypeError`
/// silently stops matching — so these two halves are tested against each other
/// rather than in isolation.
void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
  });

  BridgedClass bridgeOf(String name) {
    final bridge = env.findBridgedClassByName(name);
    expect(bridge, isNotNull, reason: '$name should be registered');
    return bridge!;
  }

  group('SCB10/AST: the interpreter raises SDK-shaped errors', () {
    test('F-SCB10-AST-1: d4rt error types satisfy the SDK `is` checks an `on` '
        'clause compiles to [2026-07-28]', () {
      // `implements` rather than `extends` is what makes these true while
      // `toString()` still returns d4rt's own diagnostic — see sdk_errors.dart.
      final typeError = D4rtTypeError('cast failed');
      expect(typeError, isA<TypeError>());
      expect(typeError, isA<Error>());
      expect(typeError.toString(), 'cast failed');

      final nsm = D4rtNoSuchMethodError('no such member');
      expect(nsm, isA<NoSuchMethodError>());
      expect(nsm, isA<Error>());
      expect(nsm.toString(), 'no such member');
    });

    test('F-SCB10-AST-2: the SC5 bridges claim the d4rt subtypes, so `on` '
        'clauses match them [2026-07-28]', () {
      // The predicate consulted by the catch-clause matcher. A bridge that
      // recognised only the SDK's own private subtype would leave every
      // interpreter-raised error uncatchable by name.
      expect(bridgeOf('TypeError').isAssignable!(D4rtTypeError('x')), isTrue);
      expect(
        bridgeOf('NoSuchMethodError').isAssignable!(D4rtNoSuchMethodError('x')),
        isTrue,
      );
    });

    test('F-SCB10-AST-3: indexRangeError produces a plain RangeError, NOT an '
        'IndexError [2026-07-28]', () {
      // Measured against the platform: the VM's `List.[]` raises a plain
      // `RangeError`, and `on IndexError` does not catch it. Raising
      // `IndexError` here would make d4rt strictly *more* catchable than Dart,
      // so a script written against d4rt would break once compiled.
      final e = indexRangeError(9, 3);
      expect(e, isA<RangeError>());
      expect(e, isNot(isA<IndexError>()));
      expect(e.invalidValue, 9);
      expect(e.start, 0);
      expect(e.end, 2);
      // The empty-container edge: `end` is -1, below `start`. `RangeError.range`
      // accepts that and reports what the platform reports.
      expect(indexRangeError(0, 0).toString(), contains('range is empty'));
    });

    test('F-SCB10-AST-4: the deliberately raised types cross the host boundary '
        'as themselves [2026-07-28]', () {
      // SCC27 CONTRACT CHANGE: this case used to assert `isSdkShapedError`, the
      // four-type carve-out that let these escape `execute()`'s catch-all. The
      // predicate is gone — the boundary now asks whether a value is an `Error`
      // or an `Exception`, which subsumes the list. What the carve-out
      // guaranteed still has to hold, so the case now asserts it through the
      // rule that replaced it rather than through the predicate that is no
      // longer there.
      for (final e in [
        AssertionError('m'),
        D4rtTypeError('m'),
        D4rtNoSuchMethodError('m'),
        indexRangeError(9, 3),
        // A native callee's errors were deliberately outside the carve-out.
        // Under the general rule they are inside it, which is the whole point
        // of SCC27: nothing about a `FormatException` made it less catchable.
        FormatException('m'),
        StateError('m'),
        RuntimeD4rtException('m'),
      ]) {
        expect(
          () => throwAsHostFacingError(e, StackTrace.current),
          throwsA(same(e)),
          reason: '${e.runtimeType} should reach the host as itself',
        );
      }

      // The one class of value that is still relabelled — neither hierarchy
      // names it, so a bare `toString()` would be the host's whole diagnostic.
      expect(
        () => throwAsHostFacingError('not-an-exception', StackTrace.current),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('Unexpected error: not-an-exception'),
          ),
        ),
      );
    });
  });
}
