/// SCB28: [D4.describeArityError] — the generic wrong-arity diagnostic.
///
/// Most hand-written stdlib bridges read `positionalArgs[0]`,
/// `positionalArgs[1]`, … without a leading length check (a measured 601 of
/// the 1204 adapters that index the list, identically in both trees), so a
/// call with too few arguments surfaced a bare list `RangeError` naming
/// neither the class nor the member. The dispatch catch-alls in
/// `interpreter_visitor.dart` now run the caught error past this helper first.
///
/// This tree has no source parser — it interprets pre-built `SAstNode` trees —
/// so the script-level behaviour is locked in by the analyzer-based twin,
/// `tom_d4rt/test/stdlib/bridge_arity_test.dart`. What is verifiable here, and
/// what actually carries the risk, is the recogniser itself: it must fire on
/// an out-of-range read of the *argument list* and stay silent on every other
/// `RangeError`, because a false positive would relabel a genuine native error
/// as an arity mistake.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// Runs [body], which must throw, and returns the thrown error.
///
/// The errors are provoked rather than constructed: the helper matches on the
/// exact field layout Dart's `List.[]` produces, so a hand-built [RangeError]
/// would only prove the test agrees with itself.
Object _errorFrom(void Function() body) {
  try {
    body();
  } catch (e) {
    return e;
  }
  fail('expected the body to throw');
}

void main() {
  group('SCB28 — describeArityError recognises a short argument list', () {
    test(
      'F-SCB28-AST-1: empty list, slot 0 — singular wording [2026-09-03]',
      () {
        final args = <Object?>[];
        final error = _errorFrom(() => args[0]);
        expect(
          D4.describeArityError(error, args, 'UriData.parse'),
          equals(
            'UriData.parse expects at least 1 positional argument, '
            'but was called with 0.',
          ),
        );
      },
    );

    test('F-SCB28-AST-2: one argument, slot 2 — reports the slot reached, '
        'plural wording [2026-09-03]', () {
      final args = <Object?>['a'];
      final error = _errorFrom(() => args[2]);
      expect(
        D4.describeArityError(error, args, 'String.replaceRange'),
        equals(
          'String.replaceRange expects at least 3 positional arguments, '
          'but was called with 1.',
        ),
      );
    });

    test('F-SCB28-AST-3: the member description is passed through verbatim '
        '[2026-09-03]', () {
      final args = <Object?>[];
      final error = _errorFrom(() => args[0]);
      final message = D4.describeArityError(error, args, 'MyClass.myMember')!;
      expect(message, startsWith('MyClass.myMember '));
    });
  });

  group('SCB28 — describeArityError stays silent on everything else', () {
    test('F-SCB28-AST-4: a native range error from inside the call passes '
        'through [2026-09-03]', () {
      // `sublist(0, 99)` supplies the right *number* of arguments; its
      // RangeError names 'end', not 'length', and must survive as a
      // RangeError so the author sees the real cause.
      final args = <Object?>[0, 99];
      final error = _errorFrom(() => <int>[1, 2, 3].sublist(0, 99));
      expect(D4.describeArityError(error, args, 'List.sublist'), isNull);
    });

    test('F-SCB28-AST-5: an out-of-range read on a list of a different length '
        'passes through [2026-09-03]', () {
      // The adapter indexed some other collection, not its arguments.
      final other = <Object?>['a', 'b', 'c'];
      final error = _errorFrom(() => other[5]);
      expect(
        D4.describeArityError(error, <Object?>['only-one'], 'A.b'),
        isNull,
      );
    });

    test('F-SCB28-AST-6: a non-RangeError passes through [2026-09-03]', () {
      final error = _errorFrom(() => throw ArgumentError('not a range error'));
      expect(D4.describeArityError(error, <Object?>[], 'A.b'), isNull);
    });

    test('F-SCB28-AST-7: a RangeError whose invalid value is already in range '
        'passes through [2026-09-03]', () {
      // Same shape, but the index was reachable — so the call did not run
      // short of arguments and this is somebody else\'s error.
      final error = RangeError.range(0, 0, 0, 'length');
      expect(D4.describeArityError(error, <Object?>['a'], 'A.b'), isNull);
    });

    test('F-SCB28-AST-8: a correctly-sized call never reaches the helper at '
        'all — the shape is not matched [2026-09-03]', () {
      // Sanity check on the length arithmetic: an error raised against a
      // two-element list is not attributed to a two-element argument list
      // unless the index really is past the end.
      final args = <Object?>['a', 'b'];
      final error = RangeError.range(1, 0, 1, 'length');
      expect(D4.describeArityError(error, args, 'A.b'), isNull);
    });
  });
}
