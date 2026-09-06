// SCC56: `dart:core` had no supertype edges at all. Every other library that
// needed them got a hierarchy block — `dart:collection`, `dart:convert`,
// `dart:typed_data`, and the error chain inside `dart:core` itself — but the
// non-error half of `dart:core` was never given one, so the type tests a
// generic-bounded script writes all answered false:
//
//     'abc' is Comparable      // false — String implements Comparable<String>
//     'abc' is Pattern         // false — String implements Pattern
//     1 is Comparable          // false — via num
//     Duration(...) is Comparable
//     RegExp('a') is Pattern
//     StringBuffer() is StringSink
//
// WHY THE EDGE IS THE ONLY MECHANISM HERE. `ComparableCore` and `PatternCore`
// declare no `isAssignable` predicate, so the fallback that quietly answered
// `Uint8List is List` for the typed-data views (see SCB20) has nothing to fire
// on: a bridge without `isAssignable` can never be reached except through a
// direct `Type` match or a registered edge, and `Comparable`'s native type is
// never the runtime type of anything. That is also why declaring these edges
// carries no ownership risk — a bridge that cannot win the `isAssignable` pass
// cannot start winning dispatch because the registry learned about it.
//
// `int -> num` AND `double -> num` ARE THE EXCEPTION and the reason this file
// carries a dispatch half. Those two were already `true` before SCC56, answered
// by `num`'s `isAssignable` with no edge behind them — the audit reports them
// as "satisfied anyway", the same bucket the eleven typed-data `-> List` edges
// sat in. Declaring them changes what `Environment._filterToMostSpecific` can
// see on `int` and `double`, which are on every hot path in the interpreter.
// The direction is right — the filter can now DROP the `num` match in favour of
// the more specific `int` — but "right in principle" is not a test, so the
// F-SCC56-3x cases below read concrete members off both primitives.
//
// The member half of this finding was already closed: `String.matchAsPrefix`
// is declared directly on the `String` bridge, so the `Pattern` edge buys type
// tests only and costs no member. F-SCC56-21 pins that, because the obvious
// reading of "String is not a Pattern" is that the Pattern surface is missing,
// and the next person to check should find the answer here rather than
// re-derive it.

import '../../interpreter_test.dart';
import 'package:test/test.dart';

/// `(expression, supertype)` pairs that must answer `true`.
///
/// Grouped by the edge that makes them true rather than by class, because a
/// single missing edge is what breaks a whole row — `num -> Comparable` is one
/// declaration and three of these cases.
const _comparables = <String, String>{
  "'abc'": 'String',
  '1': 'int',
  '1.5': 'double',
  'BigInt.from(6)': 'BigInt',
  'DateTime.utc(2026, 1, 2)': 'DateTime',
  'Duration(seconds: 1)': 'Duration',
};

void main() {
  group('SCC56: the dart:core Comparable edges', () {
    _comparables.forEach((expr, className) {
      test('F-SCC56-1-$className: `$expr is Comparable` answers true '
          '[2026-09-06]', () {
        expect(
          execute('main() => $expr is Comparable;'),
          isTrue,
          reason:
              '$className implements Comparable in the SDK; before SCC56 '
              'dart:core declared no supertype edges, so this was false',
        );
      });
    });

    test('F-SCC56-2: `1 is Comparable` is answered through `num`, not by a '
        'direct edge [2026-09-06]', () {
      // The declaration is single-hop — `int -> num` and `num -> Comparable`,
      // exactly as the SDK writes them — so this answer can only come from the
      // transitive walk SCC19 put behind `isSubtypeOf`. A block that spelled
      // the closure out by hand would pass this case without exercising the
      // walk at all, which is the mistake SCC19 was filed to undo.
      expect(execute('main() => 1 is num;'), isTrue);
      expect(execute('main() => 2 is Comparable;'), isTrue);
      expect(execute('main() => 1.5 is num;'), isTrue);
      expect(execute('main() => 1.5 is Comparable;'), isTrue);
    });

    test('F-SCC56-3: `compareTo` was never the missing part [2026-09-06]', () {
      // Every class in `_comparables` declares `compareTo` on its own bridge,
      // so the edges buy type tests only. Pinned so the next reader does not
      // assume a false `is Comparable` meant the member was gone too.
      expect(execute("main() => 'abc'.compareTo('abd');"), lessThan(0));
      expect(execute('main() => 2.compareTo(1);'), greaterThan(0));
      expect(
        execute(
          'main() => Duration(seconds: 1).compareTo(Duration(seconds: 2));',
        ),
        lessThan(0),
      );
    });
  });

  group('SCC56: the dart:core Pattern and Match edges', () {
    test('F-SCC56-11: `\'abc\' is Pattern` answers true [2026-09-06]', () {
      expect(execute("main() => 'abc' is Pattern;"), isTrue);
    });

    test('F-SCC56-12: `RegExp(...) is Pattern` answers true [2026-09-06]', () {
      expect(execute("main() => RegExp('a+') is Pattern;"), isTrue);
    });

    test('F-SCC56-13: a `RegExpMatch` is a `Match` [2026-09-06]', () {
      expect(
        execute("main() => RegExp('a+').firstMatch('aaa') is Match;"),
        isTrue,
      );
    });

    test('F-SCC56-14: `Runes` is an `Iterable` [2026-09-06]', () {
      expect(execute("main() => 'abc'.runes is Iterable;"), isTrue);
    });

    test('F-SCC56-15: `StringBuffer` is a `StringSink` [2026-09-06]', () {
      expect(execute("main() => StringBuffer('x') is StringSink;"), isTrue);
    });

    test('F-SCC56-21: `String.matchAsPrefix` is reachable, and was before the '
        'edge [2026-09-06]', () {
      // `matchAsPrefix` is the one member `Pattern` carries that a String could
      // plausibly have lost to the missing edge. It did not — the `String`
      // bridge declares it directly — so this case guards a member that is
      // already present rather than restoring one.
      expect(execute("main() => 'abc'.matchAsPrefix('a') == null;"), isTrue);
      expect(execute("main() => 'abc'.matchAsPrefix('abc')!.group(0);"), 'abc');
      expect(execute("main() => 'abc'.allMatches('xabcx').length;"), 1);
    });
  });

  group('SCC56: dispatch is unchanged on the primitives', () {
    // Declaring `int -> num` and `double -> num` is the only part of this
    // change that touches a bridge with an `isAssignable` predicate, so it is
    // the only part that can move `_filterToMostSpecific`. These cases read
    // members that exist on the SUBTYPE only: if `num` started winning
    // dispatch, each one would fail with "has no instance method named".
    test('F-SCC56-31: int-only members still resolve [2026-09-06]', () {
      expect(execute('main() => 255.toRadixString(16);'), 'ff');
      expect(execute('main() => 4.isEven;'), isTrue);
      expect(execute('main() => 7.gcd(21);'), 7);
      expect(execute('main() => 5.modPow(3, 7);'), 6);
    });

    test('F-SCC56-32: double-only members still resolve [2026-09-06]', () {
      expect(execute('main() => 1.5.roundToDouble();'), 2.0);
      expect(execute('main() => (0.0 / 0.0).isNaN;'), isTrue);
      expect(execute('main() => 1.5.truncateToDouble();'), 1.0);
    });

    test('F-SCC56-33: members shared with `num` still resolve, and on the '
        'right receiver [2026-09-06]', () {
      expect(execute('main() => (-3).abs();'), 3);
      expect(execute('main() => (-3).abs() is int;'), isTrue);
      expect(execute('main() => (-3.5).abs() is double;'), isTrue);
      expect(execute('main() => 7.clamp(1, 5);'), 5);
      expect(execute('main() => 3.toInt() is int;'), isTrue);
    });

    test('F-SCC56-34: String-only members still resolve [2026-09-06]', () {
      // `String` gains two supertypes at once and is on as hot a path as the
      // primitives, so it gets the same guard even though neither `Comparable`
      // nor `Pattern` can win the `isAssignable` pass.
      expect(execute("main() => 'abc'.toUpperCase();"), 'ABC');
      expect(execute("main() => 'a,b'.split(',').length;"), 2);
      expect(execute("main() => 'abc'.substring(1);"), 'bc');
      expect(execute("main() => 'abc'.padLeft(5, '.');"), '..abc');
      expect(execute("main() => 'abc'.codeUnitAt(0);"), 97);
    });

    test('F-SCC56-35: `is` against the primitives is still exact '
        '[2026-09-06]', () {
      // The edges are one-directional. `num is int` must stay false — a
      // symmetric registration, or an edge declared the wrong way round, shows
      // up here rather than in a member probe.
      expect(execute('main() => 1 is double;'), isFalse);
      expect(execute('main() => 1.5 is int;'), isFalse);
      expect(execute("main() => 1 is String;"), isFalse);
      expect(execute("main() => 'abc' is num;"), isFalse);
      expect(execute('main() => Duration(seconds: 1) is Pattern;'), isFalse);
    });
  });
}
