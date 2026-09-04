import 'package:test/test.dart';
import '../../interpreter_test.dart' show execute;

/// SCC11 part 1 — the static argument-validation helpers on the error classes.
///
/// `RangeError.checkValidIndex`, `ArgumentError.checkNotNull` and their
/// siblings are how idiomatic Dart validates arguments, so a script porting
/// real code reaches them on its first function. They are all **statics**, and
/// a static gets no fallback from the interpreter: instance lookups walk the
/// supertype chain and may still resolve, but an unregistered static is always
/// a hard failure. Nothing inherits `checkNotNull`.
///
/// Every one of these helpers **throws as its normal behaviour**, which makes
/// the interesting assertion the *catch*, not the throw. A host-side
/// `throwsA(anything)` would pass whether the bridge raised a bridged
/// `RangeError` or a bare `RuntimeD4rtException` — and only the first lets an
/// interpreted `on RangeError` clause match. So each throwing case is asserted
/// from **inside** the script, by naming the type in an `on` clause and
/// returning a marker the host compares. A wrong thrown type shows up as
/// `'wrong-type'`, never as a green test.
void main() {
  group('SCC11: static argument-validation helpers', () {
    group('RangeError.checkNotNegative', () {
      test(
          'F-SCC11-1: returns the value unchanged when it is not negative '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            return RangeError.checkNotNegative(3, 'n', 'must not be negative');
          }
        ''');
        expect(result, 3);
      });

      test('F-SCC11-2: throws a catchable RangeError for a negative value '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            try {
              RangeError.checkNotNegative(-1, 'n');
              return 'no-throw';
            } on RangeError catch (e) {
              return 'RangeError';
            } catch (e) {
              return 'wrong-type';
            }
          }
        ''');
        expect(result, 'RangeError');
      });
    });

    group('RangeError.checkValidIndex', () {
      test('F-SCC11-3: returns the index when it is in range [2026-09-04]', () {
        final result = execute('''
          main() {
            return RangeError.checkValidIndex(1, [1, 2, 3], 'i', 3, 'oops');
          }
        ''');
        expect(result, 1);
      });

      test('F-SCC11-4: reads the length from the indexable when none is given '
          '[2026-09-04]', () {
        // The `length` parameter is optional precisely so the helper can be
        // called with just the collection; if the bridge required it, the
        // common call shape would be the one that fails.
        final result = execute('''
          main() {
            return RangeError.checkValidIndex(2, [1, 2, 3]);
          }
        ''');
        expect(result, 2);
      });

      test('F-SCC11-5: throws a catchable RangeError for an out-of-range index '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            try {
              RangeError.checkValidIndex(9, [1, 2, 3], 'i');
              return 'no-throw';
            } on RangeError catch (e) {
              return 'RangeError';
            } catch (e) {
              return 'wrong-type';
            }
          }
        ''');
        expect(result, 'RangeError');
      });
    });

    group('RangeError.checkValidRange', () {
      test('F-SCC11-6: returns the resolved end for a valid range '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            return RangeError.checkValidRange(0, 2, 3, 's', 'e', 'oops');
          }
        ''');
        expect(result, 2);
      });

      test('F-SCC11-7: a null end resolves to the length [2026-09-04]', () {
        // `checkValidRange` returning the *resolved* end is the whole reason
        // it returns a value at all, and the null case is what callers rely on
        // to normalise an omitted `end` argument.
        final result = execute('''
          main() {
            return RangeError.checkValidRange(1, null, 4);
          }
        ''');
        expect(result, 4);
      });

      test('F-SCC11-8: throws a catchable RangeError when start exceeds end '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            try {
              RangeError.checkValidRange(3, 1, 5);
              return 'no-throw';
            } on RangeError catch (e) {
              return 'RangeError';
            } catch (e) {
              return 'wrong-type';
            }
          }
        ''');
        expect(result, 'RangeError');
      });
    });

    group('RangeError.checkValueInInterval', () {
      test('F-SCC11-9: accepts a value inside the interval and returns void '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            RangeError.checkValueInInterval(2, 1, 3, 'n', 'oops');
            return 'ok';
          }
        ''');
        expect(result, 'ok');
      });

      test('F-SCC11-10: throws a catchable RangeError outside the interval '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            try {
              RangeError.checkValueInInterval(7, 1, 3, 'n');
              return 'no-throw';
            } on RangeError catch (e) {
              return 'RangeError';
            } catch (e) {
              return 'wrong-type';
            }
          }
        ''');
        expect(result, 'RangeError');
      });
    });

    group('ArgumentError.checkNotNull', () {
      test('F-SCC11-11: returns the argument when it is non-null '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            return ArgumentError.checkNotNull(5, 'n');
          }
        ''');
        expect(result, 5);
      });

      test('F-SCC11-12: throws a catchable ArgumentError for null '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            try {
              ArgumentError.checkNotNull(null, 'n');
              return 'no-throw';
            } on ArgumentError catch (e) {
              return 'ArgumentError';
            } catch (e) {
              return 'wrong-type';
            }
          }
        ''');
        expect(result, 'ArgumentError');
      });
    });

    group('IndexError.check', () {
      test('F-SCC11-13: returns the index when it is in range [2026-09-04]',
          () {
        // Note the *named* parameters — `IndexError.check` differs in shape
        // from every `RangeError.check*` helper, which take positional
        // optionals. A bridge that read them positionally would compile and
        // then silently ignore them.
        final result = execute('''
          main() {
            return IndexError.check(1, 3, indexable: [1, 2, 3], name: 'i');
          }
        ''');
        expect(result, 1);
      });

      test('F-SCC11-14: throws a catchable IndexError out of range '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            try {
              IndexError.check(9, 3);
              return 'no-throw';
            } on IndexError catch (e) {
              return 'IndexError';
            } catch (e) {
              return 'wrong-type';
            }
          }
        ''');
        expect(result, 'IndexError');
      });

      test('F-SCC11-15: the thrown IndexError is also catchable as a RangeError '
          '[2026-09-04]', () {
        // `IndexError implements RangeError` in the SDK, and SC5 registered
        // that supertype edge. This asserts the helper's thrown value goes
        // through the real bridge rather than being fabricated.
        final result = execute('''
          main() {
            try {
              IndexError.check(9, 3, message: 'oops');
              return 'no-throw';
            } on RangeError catch (e) {
              return 'RangeError';
            } catch (e) {
              return 'wrong-type';
            }
          }
        ''');
        expect(result, 'RangeError');
      });
    });

    group('Error.throwWithStackTrace', () {
      test('F-SCC11-16: rethrows the given error under its own type '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            try {
              Error.throwWithStackTrace(StateError('boom'), StackTrace.current);
              return 'no-throw';
            } on StateError catch (e) {
              return 'StateError';
            } catch (e) {
              return 'wrong-type';
            }
          }
        ''');
        expect(result, 'StateError');
      });

      test('F-SCC11-17: the thrown value is the same error object '
          '[2026-09-04]', () {
        final result = execute('''
          main() {
            final original = StateError('boom');
            try {
              Error.throwWithStackTrace(original, StackTrace.current);
              return 'no-throw';
            } catch (e) {
              return identical(e, original);
            }
          }
        ''');
        expect(result, true);
      });

      test('F-SCC11-18: the caught stack trace is the one that was passed in '
          '[2026-09-04]', () {
        // This is the entire point of the helper — rethrowing while keeping an
        // *earlier* trace. If the interpreter substitutes the throw site's own
        // trace, the helper is present but useless.
        //
        // The `on StateError` clause is load-bearing, not decoration: with a
        // bare `catch` this test passed while `throwWithStackTrace` was still
        // missing, because the "no such static method" error arrived with a
        // trace that happened to stringify equal to `captured`. Narrowing the
        // clause makes the absence path an uncaught error instead of a green
        // tick.
        final result = execute('''
          main() {
            final captured = StackTrace.current;
            try {
              Error.throwWithStackTrace(StateError('boom'), captured);
              return 'no-throw';
            } on StateError catch (e, st) {
              return st.toString() == captured.toString();
            }
          }
        ''');
        expect(result, true);
      });
    });
  });
}
