/// User bridge overrides for Vector2D.
///
/// Demonstrates overriding operators that the generator cannot handle
/// automatically: +, -, * (binary), and unary negation.
///
/// Each override prints a marker line so tests can verify that the
/// user bridge code executes instead of generated code.
library;

import 'package:tom_d4rt/tom_d4rt.dart';

import 'vector2d.dart';

/// User bridge overrides for Vector2D operators.
///
/// Each static method follows the D4UserBridge naming convention:
/// - `overrideOperator{OpName}` for operators
/// - `overrideMethod{Name}` for regular methods
@D4rtUserBridge('package:userbridge_user_guide_example/src/vector2d.dart')
class Vector2DUserBridge extends D4UserBridge {
  /// Override operator+ with print marker.
  static Object? overrideOperatorPlus(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    print('[Vector2DUserBridge] operator+ called');
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
    return vec + other;
  }

  /// Override operator- (handles both binary subtraction and unary negation).
  ///
  /// The interpreter uses the same '-' key for both binary (v1 - v2) and
  /// unary (-v1) operations. For unary negation, positional will be empty.
  static Object? overrideOperatorMinus(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    if (positional.isEmpty) {
      print('[Vector2DUserBridge] unary operator- called');
      return -vec;
    } else {
      print('[Vector2DUserBridge] binary operator- called');
      final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
      return vec - other;
    }
  }

  /// Override operator* (scalar multiplication) with print marker.
  static Object? overrideOperatorMultiply(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    print('[Vector2DUserBridge] operator* called');
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    final scalar = D4.extractBridgedArg<double>(positional[0], 'scalar');
    return vec * scalar;
  }

  /// Override dot method with print marker.
  static Object? overrideMethodDot(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    print('[Vector2DUserBridge] dot() called');
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
    return vec.dot(other);
  }
}
