/// SCD90 — every implementation of `RuntimeType` answers the top-type question
/// the same way.
///
/// ## What was measured
///
/// `X <: <top>` asked of each implementation, before any change:
///
/// | subject                 | BC(Object) | BC(dynamic) | BC(void) | NRT(Object) | NRT(dynamic) | NRT(void) |
/// | ----------------------- | ---------- | ----------- | -------- | ----------- | ------------ | --------- |
/// | `BridgedClass('int')`   | true       | **false**   | **false**| **false**   | **false**    | **false** |
/// | `NamedRuntimeType('int')`| true      | true        | true     | true        | true         | true      |
/// | `TypeParameter('T')`    | true       | true        | true     | true        | true         | true      |
///
/// `BridgedClass` was wrong in five of six cells and the other two were right in
/// all of them, so the defect was never "a missing case" — it was one
/// implementation disagreeing with its peers. The todo that filed this named
/// only the `BC(dynamic)` cell; the `NRT(*)` column is worse and was not
/// mentioned, because `BridgedClass.isSubtypeOf` reached a name test only inside
/// its `other is BridgedClass` block and fell through to `return false` for
/// every other kind of target — including the `NamedRuntimeType` sentinel that
/// `runtime_interfaces.dart` documents as how `dynamic` is spelled when a richer
/// type object is unavailable.
///
/// ## Why one predicate rather than a third private copy
///
/// Two spellings of the same idea already existed — `_isWildcardTypeName` in
/// `runtime_interfaces.dart` and `TypeParameter._isTopType` in
/// `bridged_types.dart` — and they did not agree with the third implementation
/// that had neither. `isTopTypeName` is now the single answer all three ask.
///
/// ## What this is NOT
///
/// It is not a claim that every pair of types answers correctly. A
/// `BridgedClass('int')` against a `NamedRuntimeType('num')` is still `false`,
/// which is wrong about Dart — but that needs real knowledge of the name, not a
/// top-type test, and nothing here pretends otherwise.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/src/bridge/bridged_types.dart';
import 'package:tom_d4rt/src/runtime_interfaces.dart';

/// A native type distinct from the subject's, so `nativeType == other.nativeType`
/// cannot short-circuit the comparison and hide the answer under test. The first
/// probe written for SCD90 used the same native type on both sides and reported
/// every cell `true`, which looked like "already fixed".
class _Unrelated {}

void main() {
  final subject = BridgedClass(nativeType: int, name: 'int');
  BridgedClass bridged(String name) =>
      BridgedClass(nativeType: _Unrelated, name: name);

  group('SCD90: the top-type answer is one answer', () {
    test('F-SCD90-1: a bridged class inhabits every top type, however the '
        'target is spelled [2026-09-14]', () {
      for (final name in const ['Object', 'Object?', 'dynamic', 'void']) {
        expect(
          subject.isSubtypeOf(bridged(name)),
          isTrue,
          reason: 'int should inhabit a BridgedClass named $name',
        );
        expect(
          subject.isSubtypeOf(NamedRuntimeType(name)),
          isTrue,
          reason:
              'int should inhabit a NamedRuntimeType named $name — this is '
              'the column the filing todo did not mention',
        );
      }
    });

    test('F-SCD90-2: the three implementations agree, cell for cell '
        '[2026-09-14]', () {
      // The disagreement WAS the defect, so agreement is what to assert. A
      // per-implementation expectation would pass with all three wrong in the
      // same way.
      final subjects = <String, RuntimeType>{
        'BridgedClass': subject,
        'NamedRuntimeType': NamedRuntimeType('int'),
        'TypeParameter': TypeParameter('T'),
      };
      final targets = <String, RuntimeType>{
        for (final n in const ['Object', 'Object?', 'dynamic', 'void']) ...{
          'BridgedClass($n)': bridged(n),
          'NamedRuntimeType($n)': NamedRuntimeType(n),
        },
      };
      final disagreements = <String>[];
      targets.forEach((tn, t) {
        final answers = {
          for (final e in subjects.entries) e.key: e.value.isSubtypeOf(t),
        };
        if (answers.values.toSet().length != 1 ||
            answers.values.first != true) {
          disagreements.add('$tn -> $answers');
        }
      });
      expect(
        disagreements,
        isEmpty,
        reason:
            'every implementation must answer `true` for a top type, and answer '
            'it alike:\n${disagreements.join('\n')}',
      );
    });

    test('F-SCD90-3: `num` is not excepted from the top types [2026-09-14]', () {
      // `BridgedClass.isSubtypeOf` special-cases `num` to stop it being a
      // subtype of its own subtypes (DFUB7). That switch returned false for
      // anything but `num`, so it also said `num` does not inhabit `dynamic`.
      // The top-type test is above it now, which is what fixes this — placing it
      // below would have left this cell wrong.
      final num_ = BridgedClass(nativeType: num, name: 'num');
      for (final name in const ['Object', 'dynamic', 'void']) {
        expect(num_.isSubtypeOf(bridged(name)), isTrue, reason: name);
      }
      expect(
        num_.isSubtypeOf(BridgedClass(nativeType: int, name: 'int')),
        isFalse,
        reason: 'DFUB7 still holds: num is not a subtype of its own subtype',
      );
    });

    test('F-SCD90-4: a non-top target is still answered on the merits '
        '[2026-09-14]', () {
      // Anti-vacuity. A predicate that returned `true` for every target would
      // pass all three cases above and destroy the check entirely.
      expect(
        subject.isSubtypeOf(bridged('Widget')),
        isFalse,
        reason: 'int does not inhabit an unrelated bridged class',
      );
      expect(isTopTypeName('Widget'), isFalse);
      expect(
        isTopTypeName('Null'),
        isFalse,
        reason: 'Null is the bottom-ish type, not a top type',
      );
    });
  });
}
