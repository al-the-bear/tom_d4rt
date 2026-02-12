/// User bridge overrides for Matrix2x2.
///
/// Demonstrates overriding index operators where the parameter is a
/// `List<int>` for multi-dimensional access — a pattern the generator
/// cannot handle automatically.
///
/// Each override prints a marker line so tests can verify that the
/// user bridge code executes instead of generated code.
library;

import 'package:tom_d4rt/tom_d4rt.dart';

import 'matrix2x2.dart';

/// User bridge overrides for Matrix2x2 index operators.
@D4rtUserBridge('package:d4_example/src/userbridge_user_guide/matrix2x2.dart')
class Matrix2x2UserBridge extends D4UserBridge {
  /// Override operator[] for multi-dimensional index access.
  static Object? overrideOperatorIndex(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    print('[Matrix2x2UserBridge] operator[] called');
    final matrix = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
    final indices = D4.coerceList<int>(positional[0], 'indices');
    return matrix[indices];
  }

  /// Override operator[]= for multi-dimensional index assignment.
  static Object? overrideOperatorIndexAssign(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    print('[Matrix2x2UserBridge] operator[]= called');
    final matrix = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
    final indices = D4.coerceList<int>(positional[0], 'indices');
    final value = D4.extractBridgedArg<double>(positional[1], 'value');
    matrix[indices] = value;
    return null;
  }
}
