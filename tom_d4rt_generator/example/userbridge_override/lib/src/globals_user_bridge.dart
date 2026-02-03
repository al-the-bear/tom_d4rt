/// Globals user bridge overrides.
///
/// This file demonstrates how to override global variables,
/// getters, and top-level functions with custom implementations.
library;

import 'package:tom_d4rt/tom_d4rt.dart';

/// User overrides for global members.
///
/// Override naming conventions:
/// - Variables: `overrideGlobalVariable{Name}`
/// - Getters: `overrideGlobalGetter{Name}`
/// - Functions: `overrideGlobalFunction{Name}`
class GlobalsUserBridge extends D4UserBridge {
  /// Override the `appName` global variable.
  /// Returns the value to register instead of the original.
  static Object? overrideGlobalVariableAppName() => 'OverriddenApp';

  /// Override the `maxRetries` global variable.
  static Object? overrideGlobalVariableMaxRetries() => 10;

  /// Override the `currentTime` global getter.
  /// Returns a getter function that will be called at access time.
  static Object? Function() overrideGlobalGetterCurrentTime() =>
      () => DateTime.now();

  /// Override the `greet` top-level function.
  static Object? overrideGlobalFunctionGreet(
    Object? visitor,
    List<Object?> positional,
    Map<String, Object?> named,
    List<Object?>? typeArgs,
  ) {
    final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
    return 'Custom greeting for $name!';
  }

  /// Override the `calculate` top-level function.
  static Object? overrideGlobalFunctionCalculate(
    Object? visitor,
    List<Object?> positional,
    Map<String, Object?> named,
    List<Object?>? typeArgs,
  ) {
    final a = D4.getRequiredArg<int>(positional, 0, 'a', 'calculate');
    final b = D4.getRequiredArg<int>(positional, 1, 'b', 'calculate');
    final operation =
        D4.getOptionalNamedArg<String?>(named, 'operation') ?? 'add';

    switch (operation) {
      case 'add':
        return a + b;
      case 'subtract':
        return a - b;
      case 'multiply':
        return a * b;
      default:
        throw ArgumentError('Unknown operation: $operation');
    }
  }
}
