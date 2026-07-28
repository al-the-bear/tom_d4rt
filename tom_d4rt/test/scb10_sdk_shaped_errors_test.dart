import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCB10 — the interpreter raises the SDK's own error types for the operations
/// that produce them in real Dart.
///
/// SC5 made seven `dart:core` error classes nameable and catchable, but its
/// premise — "errors are already thrown with SDK-correct shapes; the gap is
/// purely the missing `BridgedClass`" — held for only two of them. Everything
/// the interpreter raised *itself* was a `RuntimeD4rtException` carrying a
/// formatted message, so no `on IndexError` / `on TypeError` /
/// `on NoSuchMethodError` / `on AssertionError` clause could ever match the
/// operation that should have produced it. This suite pins the corrected
/// behaviour at each raise site.
///
/// **`list[9]` throws `RangeError`, NOT `IndexError`** — measured against the
/// platform, and it contradicts SCB10's own FIX instruction. `IndexError` does
/// exist and *is* a `RangeError`, but the SDK's `List.[]` does not use it: the
/// VM raises a plain `RangeError` whose `name` is `"length"`, and
/// `on IndexError` does **not** catch it. Throwing `IndexError` here would make
/// d4rt *more* catchable than the platform — a script written against d4rt with
/// `on IndexError` would then break when compiled. So `RangeError.range` is the
/// faithful choice, and F-SCB10-3 pins the negative half of that.
/// Consequence for the assertions: `length` is an `IndexError` member, so the
/// tests assert `invalidValue` / `start` / `end`, which `RangeError` carries.
///
/// **Native SDK errors were already fine inside scripts.** Probing found
/// `s[9]`, `[].first`, `int.parse('zz')` and `list.sublist(0, 9)` all catchable
/// by their true types (`RangeError`, `StateError`, `FormatException`) before
/// this change — the interpreter lets an error thrown by a *native* callee
/// through untouched, and the interpreted `try`/`catch` matches it correctly.
/// The gap was confined to the sites where the interpreter throws its own
/// exception, which for list indexing means the six hand-written bounds checks
/// that pre-empt the native list's throw. F-SCB10-17 guards the native path so
/// a future refactor cannot quietly start wrapping it.
///
/// **Two cases SCB10 did not name are the same bug.** The `!` null-check
/// operator raises `TypeError` in real Dart exactly as a failing cast does
/// (F-SCB10-9), and `assert` inside a constructor initializer list is a second
/// assert raise site in `callable.dart` (F-SCB10-15). Both are fixed here
/// because they share their case's fix rather than because the todo listed
/// them.
///
/// **What deliberately did NOT change** — F-SCB10-16. Genuine interpreter
/// failures (an undefined name, a malformed AST) have no SDK counterpart and
/// keep raising `RuntimeD4rtException`. Note this is *not* because such
/// failures are uncatchable from script: a bare `catch (e)` in interpreted code
/// already catches `RuntimeD4rtException` today, contradicting SCB10's note.
/// The reason is narrower and still holds — inventing an SDK type for
/// "undefined variable" would claim a fidelity that does not exist, since real
/// Dart rejects that program at compile time and never throws at all.
void main() {
  group('SCB10: interpreter raises SDK-shaped errors', () {
    // ---------------------------------------------------------------- (a)
    // Index out of range -> RangeError.

    test(
        'F-SCB10-1: list index out of range is catchable as RangeError and '
        'carries invalidValue/start/end [2026-07-28]', () {
      final result = execute('''
        main() {
          try {
            var l = [1, 2, 3];
            return l[9];
          } on RangeError catch (e) {
            return [e.invalidValue, e.start, e.end];
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, [9, 0, 2]);
    });

    test('F-SCB10-2: a negative list index is the same RangeError [2026-07-28]',
        () {
      final result = execute('''
        main() {
          try {
            var l = [1, 2, 3];
            return l[-1];
          } on RangeError catch (e) {
            return e.invalidValue;
          } catch (e) {
            return 'wrong-type';
          }
        }
      ''');
      expect(result, -1);
    });

    test(
        'F-SCB10-3: `on IndexError` does NOT catch it — the platform raises a '
        'plain RangeError for List.[] [2026-07-28]', () {
      // Fidelity in the negative direction. Throwing IndexError would satisfy
      // `on RangeError` too, so F-SCB10-1 alone cannot tell the two apart; this
      // is the case that pins which one we raise.
      final result = execute('''
        main() {
          try {
            var l = [1, 2, 3];
            return l[9];
          } on IndexError catch (e) {
            return 'too-specific';
          } on RangeError catch (e) {
            return 'plain-RangeError';
          }
        }
      ''');
      expect(result, 'plain-RangeError');
    });

    test(
        'F-SCB10-4: index assignment out of range raises RangeError '
        '[2026-07-28]', () {
      final result = execute('''
        main() {
          try {
            var l = [1, 2, 3];
            l[9] = 0;
            return 'no-throw';
          } on RangeError catch (e) {
            return e.invalidValue;
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, 9);
    });

    test(
        'F-SCB10-5: compound index assignment out of range raises RangeError '
        '[2026-07-28]', () {
      // Separate raise site from F-SCB10-4 — the compound path reads before it
      // writes and had its own bounds check with its own message.
      final result = execute('''
        main() {
          try {
            var l = [1, 2, 3];
            l[9] += 1;
            return 'no-throw';
          } on RangeError catch (e) {
            return e.invalidValue;
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, 9);
    });

    test(
        'F-SCB10-6: index access out of range inside a cascade raises '
        'RangeError [2026-07-28]', () {
      final result = execute('''
        main() {
          try {
            var l = [1, 2, 3];
            l..[9];
            return 'no-throw';
          } on RangeError catch (e) {
            return e.invalidValue;
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, 9);
    });

    test(
        'F-SCB10-7: indexing an EMPTY list yields the empty-range RangeError, '
        'not a malformed one [2026-07-28]', () {
      // The edge the `0..length - 1` formulation could get wrong: for an empty
      // list `end` is -1, i.e. below `start`. RangeError.range accepts that and
      // reports "Valid value range is empty", which is what the platform says.
      final result = execute('''
        main() {
          try {
            var l = [];
            return l[0];
          } on RangeError catch (e) {
            return [e.invalidValue, e.start, e.end, e.toString()];
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, isA<List<Object?>>());
      final parts = result as List<Object?>;
      expect(parts[0], 0);
      expect(parts[1], 0);
      expect(parts[2], -1);
      expect(parts[3], contains('Valid value range is empty'));
    });

    // ---------------------------------------------------------------- (b)
    // Failing cast / null check -> TypeError.

    test(
        'F-SCB10-8: a failing `as` cast is catchable as TypeError and keeps its '
        'diagnostic [2026-07-28]', () {
      final result = execute('''
        main() {
          try {
            dynamic x = 1;
            return x as String;
          } on TypeError catch (e) {
            return 'caught: \${e.toString()}';
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      // The 'caught:' marker is load-bearing. An earlier draft returned the
      // message alone and asserted `contains('int')` / `contains('String')` —
      // which the generic branch's `'wrong-type: Cast failed ... int ...
      // String'` also satisfies, so the test PASSED before the fix existed.
      expect(result, isA<String>());
      expect(result as String, startsWith('caught:'));
      // The message must still name both types — that diagnostic quality is
      // why the interpreter used its own exception type in the first place.
      expect(result, contains('int'));
      expect(result, contains('String'));
    });

    test(
        'F-SCB10-9: the `!` null-check operator raises TypeError, as it does '
        'natively [2026-07-28]', () {
      // Not named by SCB10, but real Dart raises TypeError here too ("Null
      // check operator used on a null value"), and it shares case (b)'s fix.
      final result = execute('''
        main() {
          String? s = null;
          try {
            return s!.length;
          } on TypeError catch (e) {
            return 'caught: \${e.toString()}';
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, isA<String>());
      expect(result as String, startsWith('caught:'));
      expect(result, contains('Null check operator'));
    });

    // ---------------------------------------------------------------- (c)
    // Missing member -> NoSuchMethodError.

    test(
        'F-SCB10-10: a missing method on an interpreted instance raises '
        'NoSuchMethodError [2026-07-28]', () {
      final result = execute('''
        class A {}
        main() {
          try {
            dynamic a = A();
            return a.wibble();
          } on NoSuchMethodError catch (e) {
            return 'caught';
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, 'caught');
    });

    test(
        'F-SCB10-11: a missing method on a bridged receiver raises '
        'NoSuchMethodError [2026-07-28]', () {
      final result = execute('''
        main() {
          try {
            dynamic x = 1;
            return x.wibble();
          } on NoSuchMethodError catch (e) {
            return 'caught';
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, 'caught');
    });

    test(
        'F-SCB10-12: a missing getter raises NoSuchMethodError too '
        '[2026-07-28]', () {
      final result = execute('''
        main() {
          try {
            dynamic x = 1;
            return x.wibble;
          } on NoSuchMethodError catch (e) {
            return 'caught';
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, 'caught');
    });

    // ---------------------------------------------------------------- (d)
    // Failing assert -> AssertionError.

    test(
        'F-SCB10-13: a failing assert raises AssertionError [2026-07-28]', () {
      final result = execute('''
        main() {
          try {
            assert(1 == 2);
            return 'no-throw';
          } on AssertionError catch (e) {
            return 'caught';
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, 'caught');
    });

    test(
        'F-SCB10-14: the assert message lands in AssertionError.message '
        '[2026-07-28]', () {
      // `message` rather than the formatted `toString()`: the SDK exposes the
      // raw message object, so a script can inspect it.
      final result = execute('''
        main() {
          try {
            assert(1 == 2, 'boom');
            return 'no-throw';
          } on AssertionError catch (e) {
            return e.message;
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, 'boom');
    });

    test(
        'F-SCB10-15: a failing assert in a constructor initializer list also '
        'raises AssertionError [2026-07-28]', () {
      // Second assert raise site, in callable.dart rather than the visitor —
      // not named by SCB10, found by grepping for the message it produced.
      final result = execute('''
        class A {
          final int v;
          A(this.v) : assert(v > 0);
        }
        main() {
          try {
            var a = A(-1);
            return 'no-throw';
          } on AssertionError catch (e) {
            return 'caught';
          } catch (e) {
            return 'wrong-type: \$e';
          }
        }
      ''');
      expect(result, 'caught');
    });

    // ---------------------------------------------------------- scope guards

    test(
        'F-SCB10-16: a genuine interpreter failure is NOT given an SDK type '
        '[2026-07-28]', () {
      // The boundary SCB10's notes drew. An undefined name has no SDK
      // counterpart — real Dart rejects the program at compile time rather
      // than throwing — so claiming NoSuchMethodError for it would be a
      // fidelity regression dressed as an improvement.
      final result = execute('''
        main() {
          try {
            return totallyUndefinedThing;
          } on NoSuchMethodError catch (e) {
            return 'wrongly-typed';
          } on Error catch (e) {
            return 'wrongly-typed-as-Error';
          } catch (e) {
            return 'still-generic';
          }
        }
      ''');
      expect(result, 'still-generic');
    });

    test(
        'F-SCB10-17: an error thrown by a NATIVE callee still arrives as '
        'itself [2026-07-28]', () {
      // Guards the property that made case (a) small: the interpreter does not
      // wrap what a native callee throws. String indexing has no interpreter
      // bounds check at all, so this path was already correct and must stay so.
      final result = execute('''
        main() {
          var out = [];
          try { var s = "abc"; s[9]; } on RangeError catch (e) { out.add('range'); }
          try { var l = []; l.first; } on StateError catch (e) { out.add('state'); }
          try { int.parse("zz"); } on FormatException catch (e) { out.add('format'); }
          return out;
        }
      ''');
      expect(result, ['range', 'state', 'format']);
    });

    test(
        'F-SCB10-18: an uncaught SDK-shaped error reaches the HOST unwrapped '
        '[2026-07-28]', () {
      // `execute()` ends in a catch-all that re-labels anything it does not
      // recognise as `RuntimeD4rtException('Unexpected error: ...')` — a message
      // that tells the caller they hit an interpreter bug. Correct for a stray
      // internal failure; wrong for a script whose own assert failed. Without
      // the `isSdkShapedError` carve-out, the shape made catchable *inside* a
      // script would be destroyed on the way *out* of one, and the host would
      // read "Unexpected error: Assertion failed".
      expect(() => execute('main() { assert(1 == 2, "boom"); }'),
          throwsA(isA<AssertionError>()));
      expect(() => execute('main() { var l = [1]; return l[9]; }'),
          throwsA(isA<RangeError>()));
      expect(() => execute('main() { dynamic x = 1; return x as String; }'),
          throwsA(isA<TypeError>()));
      expect(() => execute('main() { dynamic x = 1; return x.wibble(); }'),
          throwsA(isA<NoSuchMethodError>()));
    });
  });
}
