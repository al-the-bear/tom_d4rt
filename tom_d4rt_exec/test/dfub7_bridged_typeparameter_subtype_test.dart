// DFUB7: tighten BridgedClass/TypeParameter subtype checks.
//
// Ports the num-subtyping + TypeParameter-bound half of upstream
// kodjodevf/d4rt 28ca517. Two bugs in bridge/bridged_types.dart:
//   1. `BridgedClass.isSubtypeOf` had a blanket `num` block that returned true
//      for `num <: int` and `num <: double` — making num a subtype of its own
//      subtypes. The correct downward direction (int/double <: num) is handled
//      separately and must stay.
//   2. `TypeParameter.isSubtypeOf` was a hard `return true;`. A bounded
//      `T extends num` must defer to its bound; an unbounded `T` is a subtype
//      only of the top types (Object / dynamic / void).
//
// The upstream value-based `toBridgedClass` / `isSubtypeOfFunc` signature churn
// (the OTHER half of 28ca517) is deliberately NOT adopted — see the dfub7 todo.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final numType = BridgedClass(nativeType: num, name: 'num');
  final intType = BridgedClass(nativeType: int, name: 'int');
  final doubleType = BridgedClass(nativeType: double, name: 'double');
  final stringType = BridgedClass(nativeType: String, name: 'String');
  final objectType = BridgedClass(nativeType: Object, name: 'Object');

  group('DFUB7: bridged/type-parameter subtype tightening', () {
    // GREEN guard-rail: the downward direction must keep working.
    test('F-DFUB7-1: int/double <: num (downward) stays true [2026-07-23]', () {
      expect(intType.isSubtypeOf(numType), isTrue);
      expect(doubleType.isSubtypeOf(numType), isTrue);
    });

    test(
      'F-DFUB7-2: num is NOT a subtype of int/double [2026-07-23] (RED)',
      () {
        expect(numType.isSubtypeOf(intType), isFalse);
        expect(numType.isSubtypeOf(doubleType), isFalse);
      },
    );

    // GREEN guard-rail: reflexivity.
    test('F-DFUB7-3: num <: num stays true [2026-07-23]', () {
      expect(numType.isSubtypeOf(numType), isTrue);
    });

    test('F-DFUB7-4: bounded `T extends num` defers to bound, so T !<: String '
        '[2026-07-23] (RED)', () {
      final tBounded = TypeParameter('T', bound: numType);
      expect(tBounded.isSubtypeOf(stringType), isFalse);
      // ...but T <: num (its own bound) holds.
      expect(tBounded.isSubtypeOf(numType), isTrue);
    });

    test('F-DFUB7-5: unbounded `T` is a subtype only of top types, so T !<: '
        'String [2026-07-23] (RED)', () {
      final tUnbounded = TypeParameter('T');
      expect(tUnbounded.isSubtypeOf(stringType), isFalse);
      // ...but T <: Object (top type) holds.
      expect(tUnbounded.isSubtypeOf(objectType), isTrue);
    });
  });
}
