// `x is Comparable` answers what Dart answers, for bridged values.
//
// SCE211 SUSPECTED THE OMISSION SCD176 FIXED ON `Enum`: the `Comparable`
// bridge declares no `isAssignable`, and `_valueHasType`'s bridged branch only
// reaches its native-predicate fallback when the bridge has one. Measured
// 2026-09-28, it is NOT a defect, because a different route answers:
//
//     1, 1.5, 'a'                       true    primitive cases        correct
//     Duration, DateTime, BigInt        true    supertype edges        correct
//     true, [1], Uri, RegExp            false                          correct
//
// The edges are declared, not inferred: `core_hierarchy.dart` gives num,
// BigInt, DateTime, Duration and String a `Comparable` supertype, and the
// bridge generator emits the same edge for every generated Comparable
// (Flutter's SemanticsSortKey, TimeOfDay, FocusOrder, ChildVicinity). `Enum`
// had no such edge from anything, which is why it needed the predicate.
//
// NO PREDICATE WAS ADDED, deliberately. `isAssignable` is also the FIRST route
// by which `toBridgedInstance` claims a native value (SCE207), so
// `(v) => v is Comparable` would let this bridge claim every unbridged
// Comparable native before the name fallbacks run — a change to value
// wrapping that nothing measured asks for, riding on a type test that is
// already right. This file pins the type test so that holds.
//
// EVERY EXPECTATION IS COMPUTED, for the reason SCD174 established, and the
// table carries both answers so a constant cannot pass (F-SCE211-1).

import 'package:test/test.dart';

import 'interpreter_test.dart';

/// Script expression -> the same value, natively.
final Map<String, Object> _subjects = {
  '1': 1,
  '1.5': 1.5,
  "'a'": 'a',
  'const Duration(seconds: 1)': const Duration(seconds: 1),
  'DateTime(2020)': DateTime(2020),
  'BigInt.one': BigInt.one,
  'true': true,
  '[1]': [1],
  "Uri.parse('x:y')": Uri.parse('x:y'),
  "RegExp('a')": RegExp('a'),
};

void main() {
  group('SCE211: `is Comparable` matches Dart', () {
    test('F-SCE211-1: the subjects split both ways in Dart '
        '[2026-09-28] (PASS)', () {
      expect(_subjects.values.whereType<Comparable>(), isNotEmpty);
      expect(_subjects.values.where((v) => v is! Comparable), isNotEmpty);
    });

    for (final entry in _subjects.entries) {
      test('F-SCE211-2-${entry.key}: is Comparable matches Dart '
          '[2026-09-28] (PASS)', () {
        expect(
          execute('main() => ${entry.key} is Comparable;'),
          entry.value is Comparable,
          reason: 'Dart says ${entry.value is Comparable} for ${entry.key}',
        );
      });
    }

    test('F-SCE211-3: the predicate does not disturb compareTo or '
        'Comparable.compare [2026-09-28] (PASS)', () {
      expect(
        execute(
          'main() => [\n'
          '  const Duration(seconds: 1).compareTo(const Duration(seconds: 2)),\n'
          '  Comparable.compare(BigInt.two, BigInt.one),\n'
          '  DateTime(2020) is DateTime,\n'
          '];',
        ),
        [-1, 1, true],
      );
    });
  });
}
