// DFUB7 conformance (DGUB10): tightened BridgedClass/TypeParameter subtype
// checks — verified against the HOSTED tom_d4rt_ast that tom_d4rt_exec
// resolves.
//
// Mirror of tom_d4rt_ast/test/dfub7_bridged_typeparameter_subtype_test.dart.
// This is a unit test rather than an interpreted script because dfub7 is an
// API-level change on two directly constructible types that tom_d4rt_ast
// re-exports from `runtime.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  final numType = BridgedClass(nativeType: num, name: 'num');
  final intType = BridgedClass(nativeType: int, name: 'int');
  final doubleType = BridgedClass(nativeType: double, name: 'double');
  final stringType = BridgedClass(nativeType: String, name: 'String');
  final objectType = BridgedClass(nativeType: Object, name: 'Object');

  group('DFUB7 (exec): bridged/type-parameter subtype tightening', () {
    test(
      'F-DFUB7-EXEC-1: int/double <: num (downward) stays true [2026-07-27]',
      () {
        expect(intType.isSubtypeOf(numType), isTrue);
        expect(doubleType.isSubtypeOf(numType), isTrue);
      },
    );

    test('F-DFUB7-EXEC-2: num is NOT a subtype of int/double [2026-07-27]', () {
      expect(numType.isSubtypeOf(intType), isFalse);
      expect(numType.isSubtypeOf(doubleType), isFalse);
    });

    test('F-DFUB7-EXEC-3: num <: num stays true [2026-07-27]', () {
      expect(numType.isSubtypeOf(numType), isTrue);
    });

    test('F-DFUB7-EXEC-4: bounded `T extends num` defers to bound, so T !<: '
        'String [2026-07-27]', () {
      final tBounded = TypeParameter('T', bound: numType);
      expect(tBounded.isSubtypeOf(stringType), isFalse);
      expect(tBounded.isSubtypeOf(numType), isTrue);
    });

    test('F-DFUB7-EXEC-5: unbounded `T` is a subtype only of top types, so T '
        '!<: String [2026-07-27]', () {
      final tUnbounded = TypeParameter('T');
      expect(tUnbounded.isSubtypeOf(stringType), isFalse);
      expect(tUnbounded.isSubtypeOf(objectType), isTrue);
    });
  });
}
