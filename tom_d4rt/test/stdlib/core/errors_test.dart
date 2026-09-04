import 'package:test/test.dart';
import '../../interpreter_test.dart' show execute;

/// SC5 — the catchable `dart:core` error types.
///
/// Seven SDK error classes had no `BridgedClass`, so their names did not
/// resolve at all: `on NoSuchMethodError catch (e)` fell through to the
/// generic clause, and `AssertionError('boom')` failed with
/// `Undefined variable: AssertionError`.
///
/// Two design points are worth stating up front, because both are easy to get
/// wrong and neither is visible from the bridge definitions alone:
///
/// **1. The `IndexError` -> `RangeError` edge goes through the supertype
/// registry, not `isAssignable`.** `isAssignable` is what
/// `Environment.toBridgedInstance` consults when deciding which bridge *owns*
/// a native object. Every hand-written stdlib bridge carries
/// `hierarchyDepth == 0`, so ties break on registration order — a bridge that
/// claims assignability for its subtypes can quietly steal dispatch from the
/// more specific bridge. `BridgedClass.registerSupertypes` feeds `isSubtypeOf`
/// only, so `is` and `on` learn the hierarchy while dispatch stays exact.
///
/// **2. Catch-clause matching now consults `isAssignable`.** The bridged branch
/// of `visitTryStatement` used to compare the thrown value's *own* bridge
/// against the catch type, which is an exact-identity test: it cannot see that
/// `_TypeError` is a `TypeError`, nor that an `IndexError` is a `RangeError`.
/// Asking the catch type's own `isAssignable` closure first makes the match
/// subtype-correct for every bridge, not just these seven.
///
/// What is deliberately *not* asserted here: that the interpreter throws
/// SDK-shaped errors for the operations that produce them in real Dart
/// (`list[9]`, a failing cast, a missing method on `dynamic`, a failing
/// `assert`). SC5 is about making the types nameable, catchable and
/// constructible; the shapes the interpreter *raises* are SCB10's subject and
/// live in `test/scb10_sdk_shaped_errors_test.dart`.
///
/// One SC5 assumption did not survive that work: `list[9]` raises a plain
/// `RangeError`, **not** an `IndexError`. The VM's `List.[]` does not use
/// `IndexError` and `on IndexError` does not catch an out-of-range access, so
/// the `IndexError` bridge below is still needed for naming and construction but
/// is not what an interpreted `list[9]` produces. The `IndexError -> RangeError`
/// supertype registration is what earns its keep there — it is why `on
/// RangeError` catches what the index sites raise.
void main() {
  group('SC5: catchable dart:core error types', () {
    test(
      'F-SC5-1: NoSuchMethodError is catchable by concrete type [2026-07-27]',
      () {
        final result = execute('''
        main() {
          try {
            throw NoSuchMethodError.withInvocation(
                1, Invocation.method(Symbol('foo'), []));
          } on NoSuchMethodError catch (e) {
            return 'caught';
          } catch (e) {
            return 'missed';
          }
        }
      ''');
        expect(result, 'caught');
      },
    );

    test('F-SC5-2: ConcurrentModificationError catches a real concurrent '
        'modification and exposes modifiedObject [2026-07-27]', () {
      // This one the interpreter already threw SDK-shaped (the native list
      // does the throwing), so before SC5 the value was right and only the
      // `on` clause failed to match it.
      final result = execute('''
        main() {
          final list = [1, 2, 3];
          try {
            for (final item in list) { list.add(item); }
          } on ConcurrentModificationError catch (e) {
            return 'caught:\${e.modifiedObject.length}';
          } catch (e) {
            return 'missed';
          }
          return 'no-throw';
        }
      ''');
      expect(result, 'caught:4');
    });

    test('F-SC5-3: IndexError is constructible and catchable [2026-07-27]', () {
      final result = execute('''
        main() {
          try {
            throw IndexError.withLength(5, 2, name: 'idx');
          } on IndexError catch (e) {
            return '\${e.invalidValue}|\${e.start}|\${e.end}|\${e.length}';
          } catch (e) {
            return 'missed';
          }
        }
      ''');
      expect(result, '5|0|1|2');
    });

    test('F-SC5-4: an IndexError is also caught by `on RangeError` and '
        '`on ArgumentError` [2026-07-27]', () {
      // The SDK hierarchy is IndexError -> RangeError -> ArgumentError -> Error.
      // A script that catches the broader type must keep catching the narrower
      // one, otherwise adding the IndexError bridge would silently *narrow*
      // existing error handling.
      final result = execute('''
        String tryCatch(String kind) {
          try {
            throw IndexError.withLength(5, 2);
          } on RangeError catch (e) {
            if (kind == 'range') return 'range';
            return 'range-unexpected';
          } catch (e) {
            return 'missed';
          }
        }
        main() {
          final viaRange = tryCatch('range');
          String viaArgument;
          try {
            throw IndexError.withLength(5, 2);
          } on ArgumentError catch (e) {
            viaArgument = 'argument';
          } catch (e) {
            viaArgument = 'missed';
          }
          return '\$viaRange|\$viaArgument';
        }
      ''');
      expect(result, 'range|argument');
    });

    test(
      'F-SC5-5: `is` follows the registered error hierarchy [2026-07-27]',
      () {
        final result = execute('''
        main() {
          final e = IndexError.withLength(5, 2);
          return '\${e is IndexError}|\${e is RangeError}|'
                 '\${e is ArgumentError}|\${e is Error}';
        }
      ''');
        expect(result, 'true|true|true|true');
      },
    );

    test('F-SC5-6: TypeError is constructible and catchable [2026-07-27]', () {
      final result = execute('''
        main() {
          try {
            throw TypeError();
          } on TypeError catch (e) {
            return 'caught';
          } catch (e) {
            return 'missed';
          }
        }
      ''');
      expect(result, 'caught');
    });

    test('F-SC5-7: AssertionError is constructible, catchable, and carries its '
        'message [2026-07-27]', () {
      final result = execute('''
        main() {
          try {
            throw AssertionError('boom');
          } on AssertionError catch (e) {
            return 'caught:\${e.message}';
          } catch (e) {
            return 'missed';
          }
        }
      ''');
      expect(result, 'caught:boom');
    });

    test('F-SC5-8: StackOverflowError catches real runaway recursion '
        '[2026-07-27]', () {
      // Unlike the other six, this error genuinely arrives SDK-shaped today —
      // the recursion blows the *host* stack, so the native error escapes.
      // Only the `on` clause was missing.
      final result = execute('''
        int recurse(int n) => recurse(n + 1);
        main() {
          try {
            return recurse(0);
          } on StackOverflowError catch (e) {
            return 'caught';
          } catch (e) {
            return 'missed';
          }
        }
      ''');
      expect(result, 'caught');
    });

    test(
      'F-SC5-9: OutOfMemoryError is constructible and catchable [2026-07-27]',
      () {
        final result = execute('''
        main() {
          try {
            throw OutOfMemoryError();
          } on OutOfMemoryError catch (e) {
            return 'caught';
          } catch (e) {
            return 'missed';
          }
        }
      ''');
        expect(result, 'caught');
      },
    );

    test('F-SC5-10: every new error type is still caught by the broad '
        '`on Error` clause [2026-07-27]', () {
      // Regression guard: `on Error` is the hardcoded fast path in
      // `visitTryStatement`. Registering concrete bridges must not divert a
      // throw away from it.
      final result = execute('''
        String catchAsError(Object Function() make) {
          try {
            throw make();
          } on Error catch (e) {
            return 'y';
          } catch (e) {
            return 'n';
          }
        }
        main() {
          final results = [
            catchAsError(() => AssertionError('a')),
            catchAsError(() => TypeError()),
            catchAsError(() => OutOfMemoryError()),
            catchAsError(() => StackOverflowError()),
            catchAsError(() => IndexError.withLength(5, 2)),
            catchAsError(() => ConcurrentModificationError([1])),
          ];
          return results.join();
        }
      ''');
      expect(result, 'yyyyyy');
    });

    test(
      'F-SC5-11: NoSuchMethodError.withInvocation reports the missing member '
      '[2026-07-27]',
      () {
        // The SDK keeps the captured Invocation private — `toString()` is the
        // only way a script can see which member was missing, so that is what
        // the bridge has to keep working.
        final result = execute('''
        main() {
          final e = NoSuchMethodError.withInvocation(
              'receiver', Invocation.method(Symbol('foo'), [1, 2]));
          return e.toString().contains('foo');
        }
      ''');
        expect(result, true);
      },
    );

    test('F-SC5-12: ConcurrentModificationError is constructible with an '
        'explicit modified object [2026-07-27]', () {
      final result = execute('''
        main() {
          final e = ConcurrentModificationError([1, 2, 3]);
          return '\${e.modifiedObject.length}|\${e.toString().isNotEmpty}';
        }
      ''');
      expect(result, '3|true');
    });
  });
}
