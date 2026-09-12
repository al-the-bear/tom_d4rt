// SCD29: `Float32List.fromList([1, 2])` worked while `setAll(0, [7, 8])` did
// not, so the same script could build a float list from int literals and then
// fail to write int literals into it.
//
// THE TODO RECOMMENDED MAKING `fromList` STRICT. Measured against the analyzer,
// that would have been wrong, and the measurement is the whole finding:
//
//     Float32List.fromList([1, 2]);   // compiles
//     l.setAll(0, [7, 8]);            // compiles
//     l.setRange(0, 2, [7, 8]);       // compiles
//     l.followedBy([9]);              // compiles
//     Float32List(1) + [9];           // compiles
//
// In a context expecting `double`, an integer LITERAL is a double. Dart accepts
// every one of these, so `fromList` was right and the other four were rejecting
// valid Dart — the SCD26 defect shape (an over-narrow guard refusing an argument
// a script is entitled to pass), not the must-not-widen one.
//
// THE LIMIT IS REAL AND IS NOT FIXABLE HERE. Dart accepts the literal and
// refuses a genuine `List<int>` variable:
//
//     void f(List<int> ints) => Float32List.fromList(ints);   // does NOT compile
//
// d4rt erases element types, so `[7, 8]` and `ints` arrive at the coercion
// indistinguishable. One side has to be chosen. Accepting admits the common and
// valid form; refusing breaks it. The residue — a `List<int>` variable that Dart
// would refuse — is a consequence of erasure, recorded rather than hidden.
//
// The conversion is deliberately narrow, which these cases also pin: int to
// double only, never double to int, and no other element type.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  dynamic run(String body) =>
      D4rt().execute(source: "import 'dart:typed_data'; main() { $body }");

  group('SCD29: the float variants accept int literals, as Dart does', () {
    for (final type in const ['Float32List', 'Float64List']) {
      test('F-SCD29-1-$type: fromList([1, 2]) [2026-09-12] (PASS)', () {
        expect(run('return $type.fromList([1, 2]).first;'), equals(1.0));
      });

      test('F-SCD29-2-$type: setAll(0, [7, 8]) [2026-09-12] (PASS)', () {
        expect(
          run('var l = $type(2); l.setAll(0, [7, 8]); return l.first;'),
          equals(7.0),
        );
      });

      test('F-SCD29-3-$type: setRange(0, 2, [7, 8]) [2026-09-12] (PASS)', () {
        expect(
          run('var l = $type(2); l.setRange(0, 2, [7, 8]); return l.last;'),
          equals(8.0),
        );
      });

      test('F-SCD29-4-$type: followedBy([9]) [2026-09-12] (PASS)', () {
        expect(
          run('var l = $type(1); return l.followedBy([9]).toList().last;'),
          equals(9.0),
        );
      });

      test('F-SCD29-5-$type: `l + [9]` [2026-09-12] (PASS)', () {
        expect(run('var l = $type(1); return (l + [9]).last;'), equals(9.0));
      });
    }
  });

  group('SCD29: the conversion stays narrow', () {
    test('F-SCD29-6: a double is still refused where an int is wanted '
        '[2026-09-12] (PASS)', () {
      // The other direction is LOSSY and Dart refuses it — `Int32List(2)
      // .setAll(0, [7.5])` does not compile. Nothing in this change admits it,
      // and this case is what says so.
      expect(
        () => run('var l = Int32List(2); l.setAll(0, [7.5]); return l.first;'),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCD29-7: a non-numeric element is still refused [2026-09-12] '
        '(PASS)', () {
      expect(
        () =>
            run("var l = Float32List(2); l.setAll(0, ['x']); return l.first;"),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCD29-8: an int list is unaffected [2026-09-12] (PASS)', () {
      // Anti-regression: the int variants must not start accepting doubles
      // because a float-shaped rule leaked into the shared helper.
      expect(
        run('var l = Int32List(2); l.setAll(0, [7, 8]); return l.first;'),
        equals(7),
      );
    });
  });
}
