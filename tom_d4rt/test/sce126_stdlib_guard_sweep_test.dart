// SCE126 — the SCC30/SCD93 shape, swept one layer out in the stdlib bridges.
//
// SCD93 found twenty-one pre-empting guards in `interpreter_visitor.dart`, one
// of which turned out to live in `stdlib/core/string.dart` instead — evidence
// that the anti-pattern exists in the bridge layer, where that sweep did not
// look. 165 lines there carry an `is! int` / `is! String` / `is! List` shaped
// test, and the todo is explicit that 165 is an upper bound on the SHAPE, not
// a count of defects.
//
// SO THE METHOD IS MEASUREMENT, exactly as SCD93 did it: write the one-line
// script that reaches the site, run the same expression in real Dart, compare
// what comes back. 63 expressions were compared across the five families the
// todo names as highest-yield.
//
// THE YIELD IS ONE. `String.fromCharCodes` cast its argument to `List` where
// the SDK declares `Iterable<int>`, so a `Set`, a `.map(…)` or a `.where(…)`
// raised `_TypeError` for input real Dart accepts. That is the "wrong DOMAIN —
// a predicate wider than the SDK's" case, and it is the only one: the other 62
// already agreed, error type for error type.
//
// TYPE AGREEMENT WAS NOT THE ONLY QUESTION ASKED, and asking only that is what
// would have missed this. A sweep that compares thrown types over BAD input
// sees 37 of 37 agree and reports nothing. The divergence is visible only over
// GOOD input — a value the SDK accepts and the bridge rejects — so the second
// pass fed twenty-six Iterable- and Pattern-taking members something legal.
// F-SCE126-2 is that pass, and it is the half worth keeping.
//
// THE AGREEMENTS ARE PINNED TOO, which the todo's DONE-WHEN requires: they are
// what stops the guards being reinstated. A future "let us validate the
// arguments properly" pass that re-adds an `is! int` in front of a native
// operand fails F-SCE126-1 on the type it changes.
//
// WHAT WAS NOT TOUCHED, and why that is not a gap. Most of the 165 lines are an
// ARITY test joined to a type test by `||`, and arity has no SDK counterpart —
// the bridge, not Dart, decides how many arguments an adapter received. Of the
// `is! List` sites, nearly all guard members whose SDK signature really is
// `List<int>` (`utf8.decode`, `base64.encode`, `stdout.add`, `BytesBuilder.add`),
// so the guard states the SDK's own domain rather than narrowing it.
//
// ABLATED 2026-09-22 by restoring `as List`: F-SCE126-2 fails, F-SCE126-1 and
// -3 pass — which is what makes them the controls.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String body, {String imports = ''}) =>
    D4rt().execute(source: '$imports\nmain() { $body }', name: 'main');

/// The runtime type of what [body] throws, or `'no throw'`.
String thrownType(String body, {String imports = ''}) {
  try {
    run(body, imports: imports);
  } catch (e) {
    return e.runtimeType.toString();
  }
  return 'no throw';
}

void main() {
  group('SCE126: the stdlib bridges do not pre-empt the SDK', () {
    test('F-SCE126-1 (control): bad input raises what the SDK raises '
        '[2026-09-22] (PASS)', () {
      // Measured against real Dart, expression by expression. These already
      // agreed; they are here so a later "validate the arguments" pass that
      // re-adds a hand-written check in front of a native operand fails on the
      // type it changes rather than in a corpus run weeks later.
      const cases = <String, String>{
        // numeric conversion
        'return int.parse(1);': '_TypeError',
        'return int.parse("x");': 'FormatException',
        'return double.parse(1);': '_TypeError',
        'return num.parse("x");': 'FormatException',
        'return int.parse("1", radix: 99);': 'RangeError',
        'return double.infinity.toInt();': 'UnsupportedError',
        // String range
        'return "abc".substring(5);': 'RangeError',
        'return "abc".substring(-1);': 'RangeError',
        'return "abc".substring("a");': '_TypeError',
        'return "abc".codeUnitAt(9);': 'RangeError',
        'return "abc".padLeft("x");': '_TypeError',
        'return "abc".replaceRange(5, 6, "z");': 'RangeError',
        'return "abc"[9];': 'RangeError',
        'return "abc"["a"];': '_TypeError',
        // List mutation
        'var l = [1]; l.insert(9, 2); return l;': 'RangeError',
        'var l = [1]; l.insert("a", 2); return l;': '_TypeError',
        'var l = [1]; return l.removeAt(9);': 'RangeError',
        'var l = [1]; return l.removeAt("a");': '_TypeError',
        'var l = [1, 2]; l.setRange(0, 9, [3]); return l;': 'RangeError',
        'var l = [1, 2]; l.fillRange(0, 9, 0); return l;': 'RangeError',
        'return [1].sublist(9);': 'RangeError',
        'return [1][9];': 'RangeError',
        'return [1]["a"];': '_TypeError',
        // element access
        'return [1].elementAt(9);': 'RangeError',
        'return [1].elementAt("a");': '_TypeError',
        'return [].first;': 'StateError',
        'return [].last;': 'StateError',
        'return [1, 2].single;': 'StateError',
        'return [1].firstWhere((e) => e == 9);': 'StateError',
        // DateTime / Duration
        'return DateTime(2020, "a");': '_TypeError',
        'return DateTime.parse("x");': 'FormatException',
        'return Duration(days: "a");': '_TypeError',
      };
      final actual = <String, String>{
        for (final body in cases.keys) body: thrownType(body),
      };
      expect(actual, cases);
    });

    test('F-SCE126-2: a member declaring Iterable accepts one [2026-09-22] '
        '(PASS)', () {
      // The defect this sweep found, and the shape that a bad-input comparison
      // cannot see: the input is LEGAL and the bridge refused it.
      expect(run('return String.fromCharCodes({97, 98});'), 'ab');
      expect(run('return String.fromCharCodes([97].map((e) => e));'), 'a');
      expect(
        run('return String.fromCharCodes([97, 98].where((e) => e > 96));'),
        'ab',
      );
      // The forms that always worked, so a fix that traded one domain for
      // another fails here.
      expect(run('return String.fromCharCodes([104, 105]);'), 'hi');
      expect(run('return String.fromCharCodes([104, 105], 1);'), 'i');
      expect(run('return String.fromCharCodes([104, 105, 33], 0, 2);'), 'hi');
      // A non-Iterable still raises what the SDK raises — the cast is still a
      // cast, it is only wider.
      expect(thrownType('return String.fromCharCodes(5);'), '_TypeError');
    });

    test('F-SCE126-3 (control): the other Iterable and Pattern members already '
        'agreed [2026-09-22] (PASS)', () {
      // Twenty-six members were fed something the SDK accepts; twenty-three
      // are here. They are the reason the fix is one line rather than a sweep
      // — and the reason a later change that narrows one of them to `List` or
      // to `String` fails immediately.
      expect(
        run(
          'var l = [1]; l.addAll([2, 3].where((e) => e > 2)); '
          'return l.length;',
        ),
        2,
      );
      expect(
        run('var s = {1}; s.addAll([2].map((e) => e)); return s.length;'),
        2,
      );
      expect(
        run(
          'var l = [1]; l.insertAll(0, [9].map((e) => e)); '
          'return l.length;',
        ),
        2,
      );
      expect(
        run(
          'var l = [1, 2]; l.setAll(0, [8, 9].map((e) => e)); '
          'return l.length;',
        ),
        2,
      );
      expect(
        run(
          'var l = [1, 2]; l.replaceRange(0, 1, [9].map((e) => e)); '
          'return l.length;',
        ),
        2,
      );
      expect(
        run(
          'var b = StringBuffer(); b.writeAll([1, 2].map((e) => e), "-"); '
          'return b.toString();',
        ),
        '1-2',
      );
      expect(run('return List.from([1].map((e) => e)).length;'), 1);
      expect(run('return Set.of([1].map((e) => e)).length;'), 1);
      expect(run('return List.of({1, 2}).length;'), 2);
      expect(run('return [1, 2].map((e) => e).join("-");'), '1-2');
      expect(run('return [1].followedBy([2].map((e) => e)).length;'), 2);
      expect(
        run('return Map.fromEntries([MapEntry(1, 2)].map((e) => e)).length;'),
        1,
      );
      expect(run('return {1, 2}.containsAll([1].map((e) => e));'), isTrue);
      expect(
        run(
          'var s = {1, 2}; s.removeAll([1].map((e) => e)); '
          'return s.length;',
        ),
        1,
      );
      // Pattern, not String: a guard demanding a String would reject a RegExp.
      expect(run('return "a1b".split(RegExp("[0-9]")).length;'), 2);
      expect(run('return "a1b".replaceAll(RegExp("[0-9]"), "-");'), 'a-b');
      expect(run('return "a1b".replaceFirst(RegExp("[0-9]"), "-");'), 'a-b');
      expect(
        run('return "a1b".replaceAllMapped(RegExp("[0-9]"), (m) => "-");'),
        'a-b',
      );
      expect(run('return "a1b".contains(RegExp("[0-9]"));'), isTrue);
      expect(run('return "a1b".indexOf(RegExp("[0-9]"));'), 1);
      expect(run('return "a1b1".lastIndexOf(RegExp("[0-9]"));'), 3);
      expect(run('return "a1b".startsWith(RegExp("[a-z]"));'), isTrue);
      expect(
        run('return "a1b".splitMapJoin(RegExp("[0-9]"), onMatch: (m) => "#");'),
        'a#b',
      );
      // A multi-character pad, which the SDK allows and a `length == 1` guard
      // would not. The SDK repeats the pad `width - length` times rather than
      // padding to the width, so five becomes nine characters — measured
      // against real Dart, not predicted.
      expect(run('return "a".padLeft(5, "xy");'), 'xyxyxyxya');
    });
  });
}
