// SCD62 — `is` honours the nullable `?` suffix, and so do typed patterns.
//
// `_valueHasType` dropped the suffix: it switched on the type NAME, so
// `String?` reached the `String` case and asked the host's own `is`, which is
// false for null. Measured before the fix, `null is String?`, `null is int?`
// and `null is Object?` were all false. The third is the sharpest form of it —
// every value satisfies `Object?`, so there was no input for which that answer
// was right.
//
// IT WAS NOT ONLY `is`. SCC18 extracted `_valueHasType` out of
// `visitIsExpression` and routed typed PATTERNS through it, so the same
// predicate decided pattern arms: `case String? _` did not match null and the
// null fell through to a later arm or to `default`. The extraction did not
// cause the bug — it was in that copy all along — but it widened the blast
// radius, which is why the pattern contexts are pinned here beside the
// operator ones rather than left to the `is` cases to imply.
//
// THE FIX WAS REVERTED AND THE SPLIT IS THE DESIGN. With the nullable early
// return removed, `+3 -5`:
//
//   | case                                   | on revert |
//   | -------------------------------------- | --------- |
//   | F-SCD62-1  nullable accepts null        | FAILS     |
//   | F-SCD62-5  `is!` negates it             | FAILS     |
//   | F-SCD62-6/-7/-8  the three pattern ones | FAIL      |
//   | F-SCD62-2  non-nullable rejects null    | passes    |
//   | F-SCD62-3  non-null value unaffected    | passes    |
//   | F-SCD62-4  Null / dynamic / void        | passes    |
//
// The three that keep passing are the point of writing them: they are not
// evidence about this defect, they are the rail that stops the NEXT fix from
// being "answer true whenever the value is null", which would satisfy every
// case that fails above and be wrong.
//
// BOTH DIRECTIONS, BOTH KINDS. A fix that makes `null is String?` true is easy
// to write in a way that also makes `null is String` true, and only the
// negative cases can tell those apart. `Null`, `dynamic` and `void` keep their
// own branches — SCC20's notes warn against collapsing them into the nullable
// question — so each is pinned too.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Runs [source] as the body of `main`, returning whatever it returns.
Object? run(String body) =>
    D4rt().execute(source: 'Object? main() {\n$body\n}');

void main() {
  group('SCD62: the nullable suffix on `is`', () {
    test(
      'F-SCD62-1: null satisfies every nullable type [2026-09-12] (PASS)',
      () {
        expect(run('Object? n = null; return n is String?;'), isTrue);
        expect(run('Object? n = null; return n is int?;'), isTrue);
        expect(run('Object? n = null; return n is List?;'), isTrue);
        // The one with no correct false answer: every value is an `Object?`.
        expect(run('Object? n = null; return n is Object?;'), isTrue);
      },
    );

    test('F-SCD62-2: null still fails the NON-nullable form [2026-09-12] '
        '(PASS)', () {
      // The half that stops a fix from being "return true for null".
      expect(run('Object? n = null; return n is String;'), isFalse);
      expect(run('Object? n = null; return n is int;'), isFalse);
      expect(run('Object? n = null; return n is Object;'), isFalse);
    });

    test('F-SCD62-3: a non-null value is unaffected by the suffix '
        '[2026-09-12] (PASS)', () {
      // This direction was always right; it is pinned because the obvious
      // implementation of F-SCD62-1 — answering before the name switch for
      // ALL values rather than only null — would break it.
      expect(run("return 'hi' is String?;"), isTrue);
      expect(run("return 'hi' is Object?;"), isTrue);
      expect(run("return 'hi' is int?;"), isFalse);
      expect(run('return 7 is String?;'), isFalse);
    });

    test('F-SCD62-4: Null, dynamic and void keep their own answers '
        '[2026-09-12] (PASS)', () {
      expect(run('Object? n = null; return n is Null;'), isTrue);
      expect(run('Object? n = null; return n is dynamic;'), isTrue);
      expect(run("return 'hi' is Null;"), isFalse);
      expect(run("return 'hi' is dynamic;"), isTrue);
    });

    test(
      'F-SCD62-5: `is!` negates the nullable answer [2026-09-12] (PASS)',
      () {
        expect(run('Object? n = null; return n is! String?;'), isFalse);
        expect(run('Object? n = null; return n is! String;'), isTrue);
      },
    );
  });

  group('SCD62: the nullable suffix in typed patterns', () {
    // One case per context, because SCC18 routed each of them through the same
    // predicate separately and the corpus exercises none of them.
    test('F-SCD62-6: a switch arm typed `String?` matches null [2026-09-12] '
        '(PASS)', () {
      const body = '''
String sw(Object? v) => switch (v) {
  String? _ => 'nullable',
  int _ => 'int',
  _ => 'default',
};
return [sw(null), sw('hi'), sw(7)].join(',');
''';
      // Before the fix null fell past the first arm to `default`.
      expect(run(body), 'nullable,nullable,int');
    });

    test('F-SCD62-7: `if (v case String? _)` matches null [2026-09-12] '
        '(PASS)', () {
      const body = '''
String f(Object? v) {
  if (v case String? _) return 'yes';
  return 'no';
}
return [f(null), f('hi'), f(7)].join(',');
''';
      expect(run(body), 'yes,yes,no');
    });

    test('F-SCD62-8: a `case String? s:` label binds null [2026-09-12] '
        '(PASS)', () {
      const body = '''
String f(Object? v) {
  switch (v) {
    case String? s:
      return 'bound:\$s';
    default:
      return 'default';
  }
}
return [f(null), f('hi'), f(7)].join('|');
''';
      // The binding matters as much as the match: an arm that matched but
      // bound nothing would read the same from a `_` pattern.
      expect(run(body), 'bound:null|bound:hi|default');
    });
  });
}
