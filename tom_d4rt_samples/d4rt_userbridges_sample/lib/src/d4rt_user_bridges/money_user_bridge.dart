/// User-bridge overrides for [Money].
///
/// Operators are the canonical reason to write a user bridge: the generator's
/// auto-produced operator adapters are unreliable, so we implement `+`, `-`,
/// `*` and unary `-` here. We also override the ordinary `format()` method to
/// show that a user bridge can selectively replace *any* member — the generator
/// still bridges everything we leave untouched (`majorUnits`, `isNegative`, …).
///
/// Each static method matches the `D4UserBridge` naming convention
/// (`overrideOperator{Name}`, `overrideMethod{Name}`) and the fixed instance
/// signature `(visitor, target, positional, named, typeArgs)`.
library;

import 'package:tom_d4rt/d4rt.dart';

import '../money/money.dart';

/// Hand-written operator and method bridges for [Money].
@D4rtUserBridge('package:d4rt_userbridges_sample/src/money/money.dart')
class MoneyUserBridge extends D4UserBridge {
  /// `a + b` — both operands are bridged [Money] values.
  static Object? overrideOperatorPlus(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final money = D4.validateTarget<Money>(target, 'Money');
    final other = D4.extractBridgedArg<Money>(positional[0], 'other');
    return money + other;
  }

  /// `a - b` (binary) and `-a` (unary) share the same `-` key. When the
  /// interpreter dispatches unary negation, [positional] is empty.
  static Object? overrideOperatorMinus(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final money = D4.validateTarget<Money>(target, 'Money');
    if (positional.isEmpty) {
      return -money;
    }
    final other = D4.extractBridgedArg<Money>(positional[0], 'other');
    return money - other;
  }

  /// `a * factor` — scales by a numeric factor.
  static Object? overrideOperatorMultiply(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final money = D4.validateTarget<Money>(target, 'Money');
    final factor = D4.extractBridgedArg<num>(positional[0], 'factor');
    return money * factor;
  }

  /// Replace `format()` with sign-aware accounting formatting. This member
  /// *could* be auto-generated; overriding it shows that user bridges and
  /// generated bridges coexist on the same class.
  static Object? overrideMethodFormat(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final money = D4.validateTarget<Money>(target, 'Money');
    final magnitude = money.majorUnits.abs().toStringAsFixed(2);
    return money.isNegative
        ? '(${money.currency} $magnitude)'
        : '${money.currency} $magnitude';
  }
}
