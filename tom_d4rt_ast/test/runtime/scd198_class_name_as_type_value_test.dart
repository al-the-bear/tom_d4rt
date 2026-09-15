import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

// Every comparison here is deliberately cross-type: whether a `BridgedClass`
// equals the `Type` it denotes is the entire subject, and the analyser's
// warning is the very assumption SCD198 changed.
// ignore_for_file: unrelated_type_equality_checks

/// SCD198 coverage for `tom_d4rt_ast` — a class name compares and hashes like
/// the `Type` it denotes.
///
/// WHAT WAS WRONG. `x.runtimeType == Foo` was already reconciled in
/// `visitBinaryExpression`, so `==` answered correctly; `hashCode` did not.
/// Equal objects with different hash codes is an `Object` contract violation,
/// and it explains the symptom set exactly — `==` looked fine and every
/// hash-based collection missed. `{String: v}[x.runtimeType]` was null,
/// `Set<Type>.contains` false, `List<Type>.indexOf` -1.
///
/// THE LEVEL IS REGISTRATION-LEVEL for the DGUC6 reason: `tom_d4rt_exec` is the
/// only runner that could execute a script against *this* tree and it resolves
/// `tom_d4rt_ast` from pub.dev, so it cannot see unpublished edits. The
/// script-level twin is
/// `tom_d4rt/test/scd198_class_name_as_type_value_test.dart`.
///
/// It is also the honest level for the half that changed HERE. The defect was
/// in `BridgedClass`'s own `==` and `hashCode`; asking the object directly is
/// the measurement, and a script would only be a longer way to reach it. The
/// two halves a script WOULD add — the `_unwrapHashKey` normalisation and the
/// `is Type` arm — are the reference twin's to prove.
/// Bound to a variable so `.hashCode` reaches the `Type` OBJECT. Writing
/// `_Carrier.hashCode` is a static member access on the class and does not
/// compile.
final Type _carrierType = _Carrier;

class _Carrier {}

class _Other {}

void main() {
  BridgedClass bridge(Type nativeType, String name) =>
      BridgedClass(nativeType: nativeType, name: name);

  group('SCD198: BridgedClass compares and hashes by its native type', () {
    test('F-SCD198-AST-1: equal to its own Type, both directions where the '
        'language allows [2026-09-15] (PASS)', () {
      final carrier = bridge(_Carrier, 'Carrier');
      expect(carrier == _Carrier, isTrue);
      // The reverse is `Type.==`, which no code here can override — which is
      // exactly why the fix also normalises hash keys at storage rather than
      // relying on equality alone. Asserted so the asymmetry is on the record
      // rather than discovered again.
      expect(_Carrier == carrier, isFalse);
    });

    test('F-SCD198-AST-2: hashes as its native type [2026-09-15] (PASS)', () {
      // The half that was missing. Without it a value that compares equal
      // still lands in a different bucket.
      expect(
        bridge(_Carrier, 'Carrier').hashCode,
        equals(_carrierType.hashCode),
      );
    });

    test('F-SCD198-AST-3: two bridges for one native type are equal '
        '[2026-09-15] (PASS)', () {
      // Deliberate, and it is what a re-export IS:
      // `scd195_registry_collision_test.dart` measures 1 659 names reached
      // through more than one barrel, every one of them the same nativeType.
      final a = bridge(_Carrier, 'Carrier');
      final b = bridge(_Carrier, 'CarrierAlias');
      expect(a == b, isTrue);
      expect(a.hashCode, equals(b.hashCode));
      // Identity is untouched, which is what the shadow machinery relies on.
      expect(identical(a, b), isFalse);
    });

    test('F-SCD198-AST-4: different native types stay unequal [2026-09-15] '
        '(PASS)', () {
      // The widening could have made everything equal to everything; this is
      // what says it did not.
      final carrier = bridge(_Carrier, 'Carrier');
      expect(carrier == bridge(_Other, 'Other'), isFalse);
      expect(carrier == _Other, isFalse);
      expect(carrier == 'Carrier', isFalse);
      expect(carrier == 42, isFalse);
    });

    test('F-SCD198-AST-5: a bridge is usable as a map key against its Type '
        '[2026-09-15] (PASS)', () {
      // The consequence the whole fix exists for, at the level this tree can
      // measure it: store by native, look up by bridge.
      final carrier = bridge(_Carrier, 'Carrier');
      final byType = <Object, String>{_Carrier: 'c'};
      expect(byType[carrier], equals('c'));
    });
  });
}
