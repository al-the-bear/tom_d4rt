import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCD93 — a guard standing in front of a native operator is the bug.
///
/// SCC30 removed six divergences with one deletion, and only two were the ones
/// it went looking for. This file is the sweep that ratio asked for. The
/// anti-pattern is not "d4rt throws the wrong exception"; it is **d4rt
/// hand-writing a check in front of an operand that is ALREADY NATIVE**, so the
/// SDK operator never gets to decide. Every way such a check differs from the
/// SDK is a divergence nobody wrote down.
///
/// WHAT THE SWEEP FOUND
///
/// Twenty-one sites, in five families. Each was measured by running the same
/// one-line program in real Dart and in d4rt and comparing the thrown value.
///
///   1. The six BITWISE AND SHIFT arms (`& | ^ << >> >>>`) threw
///      `RuntimeD4rtException('Unsupported binary operator "AMPERSAND"')` — a
///      d4rt-only type no `on` clause can name, whose message printed the
///      TokenType rather than the operator. The comparison arms twenty lines up
///      (`< <= > >=`) had delegated to the SDK since they were written; these
///      six were simply the ones nobody converted.
///
///   2. The six LIST BOUNDS guards recomputed `index < 0 || index >= length`
///      in front of a native list. Right type (`RangeError`), wrong detail in
///      three ways — see F-SCD93-6, -7 and -8.
///
///   3. The four LIST INDEX `is int` guards threw
///      `RuntimeD4rtException('List index must be an integer')` where the SDK
///      raises `TypeError`.
///
///   4. The STRING `[]` bridge carried the same `is! int` guard, one layer out
///      in the stdlib rather than the visitor.
///
///   5. Five guards where delegation is not available — `&&`/`||` (short-
///      circuiting is control flow, not a method), unary `-`/`~` and
///      `++`/`--` (the throw is the last resort after extension-operator
///      lookup, and the increment sites must assign back). Those KEEP their
///      guard and raise the SDK's TYPE with d4rt's own message, which is the
///      pattern `sdk_errors.dart` exists for and what SCB10 did throughout.
///
/// NOT ONE EXISTING TEST FAILED WHEN ALL OF THIS CHANGED, and that is the
/// finding behind this file. None of these types or messages was pinned
/// anywhere, so every one of them could have drifted in either direction
/// unobserved. The cases below where d4rt and the SDK now AGREE are therefore
/// as load-bearing as the ones that moved: they are what stops a future reader
/// reinstating a guard "for a better message".
///
/// WHAT IS DELIBERATELY NOT FIXED — pinned honestly rather than omitted:
///
///   - `'ab'[k]` with a non-int `k` raises `TypeError` with the SDK's CAST
///     wording (`... in type cast`) rather than its parameter wording
///     (`... of 'index'`), because the delegation runs through the bridge's
///     `as int`. The type is right and `on TypeError` matches; the sentence
///     differs. F-SCD93-12.
///   - `x++` on a non-num raises `TypeError` where the SDK splits: `TypeError`
///     when the operand's type declares `+` (`'x'++`, `[1]++`),
///     `NoSuchMethodError` when it declares none (`true++`). Reproducing the
///     split needs either a table of which native types declare `+` — a second
///     implementation of exactly what this sweep removes — or performing
///     `operand + 1` to learn the answer, which can run a bridged receiver's
///     operator for its side effects. F-SCD93-17.
void main() {
  group('SCD93: native operands reach the SDK operator', () {
    // ------------------------------------------------------------------
    // Family 1 — bitwise and shift arms now delegate.

    test('F-SCD93-1: `1 & 2.0` raises the SDK TypeError, not a '
        'RuntimeD4rtException [2026-09-14]', () {
      expect(
        () => execute('main() { var a = 1; var b = 2.0; return a & b; }'),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            "type 'double' is not a subtype of type 'int' of 'other'",
          ),
        ),
      );
    });

    test('F-SCD93-2: the expected type follows the RECEIVER, so `true & 1` '
        'names bool [2026-09-14]', () {
      // This is why the fix is delegation rather than a table. `&` is declared
      // by `int`, `bool` and `BigInt`, each with its own parameter type, and a
      // hand-written message would have had to know all three.
      expect(
        () => execute('main() { var a = true; var b = 1; return a & b; }'),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            "type 'int' is not a subtype of type 'bool' of 'other'",
          ),
        ),
      );
    });

    test('F-SCD93-3: a receiver that declares no such operator raises '
        'NoSuchMethodError [2026-09-14]', () {
      // `bool` has `&` but not `<<`. The SDK distinguishes "wrong argument
      // type" from "no such method"; the single `Unsupported binary operator`
      // exception could not.
      expect(
        () => execute('main() { var a = true; var b = 1; return a << b; }'),
        throwsA(isA<NoSuchMethodError>()),
      );
      expect(
        () => execute("main() { var a = 'x'; var b = 1; return a & b; }"),
        throwsA(isA<NoSuchMethodError>()),
      );
    });

    test('F-SCD93-4: the working paths still work [2026-09-14]', () {
      // The fast arms are untouched: delegation is the FALLBACK, so the common
      // case never pays for it.
      expect(execute('main() { var a = 6; var b = 3; return a & b; }'), 2);
      expect(execute('main() { var a = 6; var b = 3; return a | b; }'), 7);
      expect(execute('main() { var a = 6; var b = 3; return a ^ b; }'), 5);
      expect(execute('main() { var a = 1; var b = 3; return a << b; }'), 8);
      expect(execute('main() { var a = 8; var b = 3; return a >> b; }'), 1);
      expect(
        execute('main() { var a = true; var b = false; return a & b; }'),
        isFalse,
      );
    });

    test("F-SCD93-5: the interpreter's own objects keep the d4rt exception "
        '[2026-09-14]', () {
      // The legitimate kind of guard. An InterpretedInstance has no SDK
      // operator to delegate to — its class operators were already given their
      // chance — so handing the question over would only name
      // `InterpretedInstance` in a NoSuchMethodError, leaking an internal class
      // into a script's diagnostics.
      expect(
        () => execute('''
          class Box {}
          main() { var b = Box(); var i = 1; return b & i; }
        '''),
        throwsA(
          allOf(
            isNot(isA<TypeError>()),
            isNot(isA<NoSuchMethodError>()),
            isA<Object>().having(
              (e) => e.toString(),
              'toString()',
              contains('Unsupported binary operator "&"'),
            ),
          ),
        ),
      );
    });

    // ------------------------------------------------------------------
    // Family 2 — list bounds guards deleted; the SDK's own RangeError.

    test('F-SCD93-6: an out-of-range READ reports `(length)`, as the SDK does '
        '[2026-09-14]', () {
      // The guard said `(index)`. Same type, same catchability, different
      // sentence — which is exactly the kind of divergence that survives
      // because nobody pinned it.
      expect(
        () => execute('main() { var l = <int>[1]; return l[5]; }'),
        throwsA(
          isA<RangeError>().having(
            (e) => e.toString(),
            'toString()',
            'RangeError (length): Invalid value: Only valid value is 0: 5',
          ),
        ),
      );
    });

    test('F-SCD93-7: an out-of-range WRITE reports `(index)`, as the SDK does '
        '[2026-09-14]', () {
      // The SDK words read and write differently. The single hand-written
      // helper could not, and said `(index)` for both.
      expect(
        () => execute('main() { var l = <int>[1]; l[5] = 9; }'),
        throwsA(
          isA<RangeError>().having(
            (e) => e.toString(),
            'toString()',
            'RangeError (index): Invalid value: Only valid value is 0: 5',
          ),
        ),
      );
    });

    test('F-SCD93-8: a COMPOUND assignment reports the read error, because the '
        'read happens first [2026-09-14]', () {
      // `l[5] += 9` is a read then a write, so real Dart fails on the read and
      // says `(length)`. The compound arm carried its own copy of the guard and
      // said `(index)` — the same self-disagreement SCC30 found between `/` and
      // `/=`, in a different operator.
      expect(
        () => execute('main() { var l = <int>[1]; l[5] += 9; }'),
        throwsA(
          isA<RangeError>().having(
            (e) => e.toString(),
            'toString()',
            'RangeError (length): Invalid value: Only valid value is 0: 5',
          ),
        ),
      );
    });

    test('F-SCD93-9: an empty list says the range is empty [2026-09-14]', () {
      expect(
        () => execute('main() { var l = <int>[]; return l[0]; }'),
        throwsA(
          isA<RangeError>().having(
            (e) => e.toString(),
            'toString()',
            contains('Valid value range is empty'),
          ),
        ),
      );
    });

    test('F-SCD93-10: indexing still works, at every path [2026-09-14]', () {
      // Six guards were deleted across four paths — plain read, assignment,
      // compound assignment and cascade. Deleting a bounds test is only safe if
      // the reads it fronted still reach the same element.
      expect(execute('main() { var l = <int>[7, 8]; return l[1]; }'), 8);
      expect(execute('main() { var l = <int>[7]; l[0] = 9; return l[0]; }'), 9);
      expect(
        execute('main() { var l = <int>[7]; l[0] += 9; return l[0]; }'),
        16,
      );
      expect(
        execute('main() { var l = <int>[1, 2]; l..[0] = 9; return l[0]; }'),
        9,
      );
      expect(
        execute('main() { var m = <String, int>{"a": 1}; return m["a"]; }'),
        1,
      );
    });

    // ------------------------------------------------------------------
    // Family 3 and 4 — a non-int index is a TypeError, on both halves of `[]`.

    test('F-SCD93-11: a non-int LIST index raises TypeError with the SDK '
        "wording [2026-09-14]", () {
      expect(
        () => execute("main() { var l = <int>[1]; var k = 'a'; return l[k]; }"),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            "type 'String' is not a subtype of type 'int' of 'index'",
          ),
        ),
      );
      expect(
        () => execute("main() { var l = <int>[1]; var k = 'a'; l[k] = 9; }"),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCD93-12: a non-int STRING index raises TypeError, with the cast '
        'wording [2026-09-14]', () {
      // Honest about the remaining difference: the type is right and `on TypeError`
      // matches, but the sentence is the SDK's CAST wording rather than its
      // parameter wording, because the String bridge reaches the operator
      // through `as int`. Pinned so it reads as a known limit, not an
      // oversight.
      expect(
        () => execute("main() { var s = 'ab'; var k = 'a'; return s[k]; }"),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            contains("type 'String' is not a subtype of type 'int'"),
          ),
        ),
      );
    });

    test('F-SCD93-13: String indexing AGREED before the sweep and still does '
        '[2026-09-14]', () {
      // The audit's starting point was that the String arm indexes natively
      // while the List arm four lines below did not. Measured, they agreed by
      // accident — the String arm was already right. It is pinned because the
      // obvious "tidy-up" is to make the two arms look alike again by giving
      // this one a bounds check.
      expect(
        () => execute("main() { var s = 'ab'; return s[5]; }"),
        throwsA(
          isA<RangeError>().having(
            (e) => e.toString(),
            'toString()',
            'RangeError (index): Invalid value: Not in inclusive range 0..1: 5',
          ),
        ),
      );
      expect(execute("main() { var s = 'ab'; return s[0]; }"), 'a');
    });

    // ------------------------------------------------------------------
    // Family 5 — the guards that stay, raising the SDK's type.

    test('F-SCD93-14: a non-bool operand of `||` raises TypeError '
        '[2026-09-14]', () {
      expect(
        () => execute('main() { var a = 1; var b = true; return a || b; }'),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => execute('main() { var a = true; var b = 1; return a && b; }'),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCD93-15: the short-circuit DOMAIN already matched the SDK '
        '[2026-09-14]', () {
      // SCC30's second consequence was a guard whose domain was wider than the
      // SDK's (`right == 0` also caught `0.0`). Measured here: these guards
      // never look at an operand Dart would not evaluate, so `true || 1` is
      // `true` rather than an error. That is the agreement that says the fix
      // was the type alone.
      expect(
        execute('main() { var a = true; var b = 1; return a || b; }'),
        isTrue,
      );
      expect(
        execute('main() { var a = false; var b = 1; return a && b; }'),
        isFalse,
      );
    });

    test(
      'F-SCD93-16: unary `-` and `~` raise NoSuchMethodError [2026-09-14]',
      () {
        // What real Dart raises: no native non-num type declares `unary-`, and
        // only `int`/`BigInt` declare `~` — both already handled above the guard.
        expect(
          () => execute("main() { var s = 'x'; return -s; }"),
          throwsA(isA<NoSuchMethodError>()),
        );
        expect(
          () => execute('main() { var d = 1.5; return ~d; }'),
          throwsA(isA<NoSuchMethodError>()),
        );
      },
    );

    test('F-SCD93-17: `++` on a non-num raises TypeError, the SDK split '
        'approximated [2026-09-14]', () {
      // Real Dart: TypeError for an operand whose type declares `+`
      // (`'x' + 1`), NoSuchMethodError for one that does not (`true + 1`).
      // d4rt raises TypeError for both — see this file's header for why the
      // split is not reproduced. Both spellings are pinned so the
      // approximation is visible rather than inferred from one example.
      expect(
        () => execute("main() { var v = 'x'; return v++; }"),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => execute('main() { var v = true; return v++; }'),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCD93-18: every one of these is catchable inside the script '
        '[2026-09-14]', () {
      // The point of the whole sweep. Before it, each of these reached an `on`
      // clause as a RuntimeD4rtException and matched nothing.
      String caught(String body) =>
          execute('''
            main() {
              try { $body }
              on TypeError { return 'TypeError'; }
              on NoSuchMethodError { return 'NoSuchMethodError'; }
              on RangeError { return 'RangeError'; }
              return 'no throw';
            }
          ''')
              as String;

      expect(caught('var a = 1; var b = 2.0; return a & b;'), 'TypeError');
      expect(
        caught('var a = true; var b = 1; return a << b;'),
        'NoSuchMethodError',
      );
      expect(caught('var l = <int>[1]; return l[5];'), 'RangeError');
      expect(
        caught("var l = <int>[1]; var k = 'a'; return l[k];"),
        'TypeError',
      );
      expect(caught("var s = 'ab'; return s[5];"), 'RangeError');
      expect(caught('var a = 1; var b = true; return a || b;'), 'TypeError');
      expect(caught("var s = 'x'; return -s;"), 'NoSuchMethodError');
      expect(caught("var v = 'x'; return v++;"), 'TypeError');
    });
  });
}
