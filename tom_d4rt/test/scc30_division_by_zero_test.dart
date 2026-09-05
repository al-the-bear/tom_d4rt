import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCC30 — division by zero produces the SDK's own outcome, whatever that is.
///
/// `1 ~/ 0` raised `RuntimeD4rtException('Integer division by zero.')`. Real
/// Dart raises `IntegerDivisionByZeroException`, which is an `UnsupportedError`
/// — so neither `on IntegerDivisionByZeroException` nor the broader
/// `on UnsupportedError` could catch it. Same defect SCB10 fixed for four other
/// operations; this site was outside the four it named.
///
/// **The guards were the bug, and deleting them is the fix.** Each arm tested
/// `right == 0` and threw a hand-written message. But `left` and `right` are
/// already native `num`s at that point, so `left ~/ right` dispatches straight
/// to the SDK operator — which raises exactly the right thing on its own. The
/// guards were not translating the SDK's behaviour, they were pre-empting it,
/// and every way they differed from it was a divergence. Removing them fixes
/// six rows at once and cannot drift again, because there is no longer a second
/// implementation to drift from.
///
/// **What the audit turned up beyond the two operators.** `right == 0` is true
/// for `0.0` as well, so the guards also fired on doubles, where Dart does not
/// throw at all: `1.0 % 0.0` is `NaN`. And the `/=` arm threw outright, while
/// plain `/` twenty lines away correctly returned `Infinity` — the same
/// operator disagreeing with itself depending on whether you wrote the compound
/// form. Those cases are pinned here alongside the ones the fix was aimed at,
/// because they came from the same root cause and would return with it.
///
/// **Why `on UnsupportedError` gets its own cases.** Catching by name is the
/// obvious assertion, but it is the fragile one: `IntegerDivisionByZeroException`
/// is deprecated, and a future SDK may narrow it to a plain `UnsupportedError`.
/// The supertype clause keeps working across that change, so a script written
/// against it survives. It is also the clause that would silently stop matching
/// if someone later "simplified" this back to a hand-thrown exception with a
/// nice message — which is the regression this file exists to catch.
///
/// **The message is a real loss, and that is correct.** The SDK exception
/// carries no message, so `toString()` degrades from `Integer division by zero.`
/// to the bare `IntegerDivisionByZeroException`. Matching the SDK is the point;
/// preserving the nicer text would mean inventing a subclass the SDK does not
/// have, and scripts would then be catching a type that exists nowhere else.
void main() {
  group('SCC30: integer division by zero raises the SDK exception', () {
    // ------------------------------------------------------------------
    // The two operators the fix was aimed at.

    test('F-SCC30-1: `1 ~/ 0` reaches the host as the SDK exception, not a '
        'RuntimeD4rtException [2026-09-05]', () {
      expect(
        () => execute('main() { var z = 0; return 1 ~/ z; }'),
        throwsA(isIntegerDivisionByZero),
      );
    });

    test(
      'F-SCC30-2: `1 % 0` raises the same exception as `~/` [2026-09-05]',
      () {
        // Modulo and truncating division share one SDK exception — there is no
        // separate "modulo by zero" type, which is what the old hand-written
        // `Modulo by zero.` message implied there was.
        expect(
          () => execute('main() { var z = 0; return 1 % z; }'),
          throwsA(isIntegerDivisionByZero),
        );
      },
    );

    test('F-SCC30-3: the exception is an UnsupportedError, so the supertype '
        'clause catches it [2026-09-05]', () {
      final e = _thrownBy('main() { var z = 0; return 1 ~/ z; }');
      expect(e, isA<UnsupportedError>());
    });

    test('F-SCC30-4: toString() is the SDK\'s bare type name, message and all '
        '[2026-09-05]', () {
      // Deliberately asserting the LOSS. d4rt used to say
      // `Integer division by zero.`; the SDK exception carries no message at
      // all. Anyone reinstating the friendlier text would break real-Dart
      // parity, so the degradation is pinned rather than left implicit.
      expect(
        _thrownBy('main() { var z = 0; return 1 ~/ z; }').toString(),
        'IntegerDivisionByZeroException',
      );
    });

    test('F-SCC30-5: negative operands take the same path [2026-09-05]', () {
      expect(
        () => execute('main() { var z = 0; return -7 ~/ z; }'),
        throwsA(isIntegerDivisionByZero),
      );
      expect(
        () => execute('main() { var z = 0; return -7 % z; }'),
        throwsA(isIntegerDivisionByZero),
      );
    });

    // ------------------------------------------------------------------
    // A script has to be able to catch it. This is the whole point of the
    // change — the host-side type is only how we observe it.

    test('F-SCC30-6: a script catches it with `on UnsupportedError` '
        '[2026-09-05]', () {
      // The durable clause. It keeps working if the SDK ever retires
      // `IntegerDivisionByZeroException` in favour of a plain
      // `UnsupportedError`, and it is the one that silently stops matching if
      // this regresses to a hand-thrown D4rt exception.
      expect(
        execute('''
          main() {
            var z = 0;
            try {
              return 1 ~/ z;
            } on UnsupportedError {
              return "caught";
            }
          }
        '''),
        'caught',
      );
    });

    test('F-SCC30-7: a script catches it by its own name [2026-09-05]', () {
      // Requires the type to be registered as a bridge: an `on` clause naming
      // an unregistered type does not error, it just never matches — so
      // without the registration this case would silently fall through to the
      // bare `catch` below and report the wrong answer rather than failing
      // loudly.
      expect(
        execute('''
          main() {
            var z = 0;
            try {
              return 1 ~/ z;
            } on IntegerDivisionByZeroException {
              return "by-name";
            } catch (e) {
              return "fell-through";
            }
          }
        '''),
        'by-name',
      );
    });

    test('F-SCC30-8: `%` is catchable by both clauses too [2026-09-05]', () {
      expect(
        execute('''
          main() {
            var z = 0;
            try {
              return 1 % z;
            } on IntegerDivisionByZeroException {
              return "by-name";
            }
          }
        '''),
        'by-name',
      );
      expect(
        execute('''
          main() {
            var z = 0;
            try {
              return 1 % z;
            } on UnsupportedError {
              return "supertype";
            }
          }
        '''),
        'supertype',
      );
    });

    // ------------------------------------------------------------------
    // Compound assignment. A separate dispatch site with its own copy of the
    // guards, which is how `/` and `/=` came to disagree.

    test('F-SCC30-9: `x ~/= 0` raises the SDK exception [2026-09-05]', () {
      expect(
        () => execute('main() { num x = 1; var z = 0; x ~/= z; return x; }'),
        throwsA(isIntegerDivisionByZero),
      );
    });

    test('F-SCC30-10: `x %= 0` raises the SDK exception [2026-09-05]', () {
      expect(
        () => execute('main() { num x = 1; var z = 0; x %= z; return x; }'),
        throwsA(isIntegerDivisionByZero),
      );
    });

    test('F-SCC30-11: `x /= 0` yields Infinity — it must not throw at all '
        '[2026-09-05]', () {
      // The audit find. `/` always produces a double, so dividing by zero is
      // Infinity, not an error; the compound arm threw where the plain arm in
      // the same file returned Infinity. A script could not have written this
      // and been believed.
      expect(
        execute('main() { num x = 1; var z = 0; x /= z; return x; }'),
        double.infinity,
      );
    });

    test('F-SCC30-12: `x /= 0.0` yields Infinity [2026-09-05]', () {
      expect(
        execute('main() { num x = 1.0; var z = 0.0; x /= z; return x; }'),
        double.infinity,
      );
    });

    // ------------------------------------------------------------------
    // Doubles. The guards tested `right == 0`, which is true of `0.0`, so they
    // fired on operands where Dart does not throw at all.

    test('F-SCC30-13: `1 / 0` is Infinity, not an error [2026-09-05]', () {
      expect(execute('main() { var z = 0; return 1 / z; }'), double.infinity);
    });

    test('F-SCC30-14: `1.0 / 0.0` is Infinity [2026-09-05]', () {
      expect(
        execute('main() { var z = 0.0; return 1.0 / z; }'),
        double.infinity,
      );
    });

    test('F-SCC30-15: `0.0 / 0.0` is NaN [2026-09-05]', () {
      expect(execute('main() { var z = 0.0; return 0.0 / z; }'), isNaN);
    });

    test('F-SCC30-16: `1.0 % 0.0` is NaN — the guard used to throw here '
        '[2026-09-05]', () {
      expect(execute('main() { var z = 0.0; return 1.0 % z; }'), isNaN);
    });

    test('F-SCC30-17: `1.0 ~/ 0.0` raises the SDK\'s toInt error, not the '
        'integer-division one [2026-09-05]', () {
      // Truncating division on doubles fails while converting Infinity to an
      // int, so the SDK raises a plain `UnsupportedError` with a message about
      // `toInt` — a different exception from the int/int case. The old guard
      // collapsed both into one hand-written message.
      expect(
        () => execute('main() { var z = 0.0; return 1.0 ~/ z; }'),
        throwsA(
          isA<UnsupportedError>().having(
            (e) => e.toString(),
            'toString',
            contains('Infinity or NaN'),
          ),
        ),
      );
    });

    test('F-SCC30-18: `1.0.remainder(0.0)` is NaN [2026-09-05]', () {
      expect(
        execute('main() { var z = 0.0; return 1.0.remainder(z); }'),
        isNaN,
      );
    });

    // ------------------------------------------------------------------
    // Sites that already delegated natively. They were correct before this
    // change; the cases exist so that a later "consistency" pass cannot
    // reintroduce a guard in front of them.

    test(
      'F-SCC30-19: `1.remainder(0)` raises the SDK exception [2026-09-05]',
      () {
        expect(
          () => execute('main() { var z = 0; return 1.remainder(z); }'),
          throwsA(isIntegerDivisionByZero),
        );
      },
    );

    test('F-SCC30-20: BigInt truncating division by zero raises it too '
        '[2026-09-05]', () {
      expect(
        () => execute('''
          main() {
            var z = BigInt.zero;
            return BigInt.one ~/ z;
          }
        '''),
        throwsA(isIntegerDivisionByZero),
      );
    });

    // ------------------------------------------------------------------
    // A canary on the SDK itself.

    test('F-SCC30-21: the SDK still throws this type, so d4rt matching it is '
        'still right [2026-09-05]', () {
      // `IntegerDivisionByZeroException` is deprecated. d4rt no longer names it
      // in production code — the native operator raises whatever the SDK
      // raises — so if a future SDK switches to a plain `UnsupportedError`,
      // d4rt follows silently and correctly, but the by-name cases above start
      // failing with no hint as to why. This case fails first and says why.
      Object? thrown;
      try {
        final int zero = 0;
        1 ~/ zero;
      } catch (e) {
        thrown = e;
      }
      expect(
        thrown,
        isIntegerDivisionByZero,
        reason:
            'The SDK changed what `1 ~/ 0` throws. d4rt now follows it '
            'automatically, but the by-name expectations in this file and the '
            'bridge registration in stdlib/core/error.dart need realigning.',
      );
      expect(thrown, isA<UnsupportedError>());
    });
  });
}

/// Matches the SDK's integer-division-by-zero exception.
///
/// The type is deprecated but is still what the VM throws, so the ignore is
/// load-bearing rather than a suppression: naming the type is the only way to
/// assert that d4rt reproduces the SDK exactly. F-SCC30-21 is the canary for
/// the day that stops being true.
// ignore: deprecated_member_use
final isIntegerDivisionByZero = isA<IntegerDivisionByZeroException>();

/// Runs [source] and returns whatever escaped, for cases that need to inspect
/// the thrown object rather than merely match its type.
Object _thrownBy(String source) {
  try {
    execute(source);
  } catch (e) {
    return e;
  }
  throw StateError('Expected `$source` to throw, but it returned normally.');
}
