/// Test fixture for GlobalsUserBridge override functionality.
///
/// This file demonstrates how to provide custom overrides for
/// global variables, getters, and functions.
library;

import 'package:tom_d4rt/d4rt.dart';

/// User overrides for global/top-level members.
///
/// The naming convention is:
/// - `overrideGlobalVariableXxx` for global variables
/// - `overrideGlobalGetterXxx` for global getters
/// - `overrideGlobalFunctionXxx` for top-level functions
class GlobalsUserBridge extends D4UserBridge {
  /// Override for the `appName` global variable.
  /// Returns the value to register instead of the original.
  static Object? overrideGlobalVariableAppName() => 'OverriddenAppName';

  /// Override for the `maxRetries` global variable.
  static Object? overrideGlobalVariableMaxRetries() => 10;

  /// Override for the `currentTime` global getter.
  /// Returns a getter function that will be called at access time.
  static Object? Function() overrideGlobalGetterCurrentTime() =>
      () => DateTime(2026, 1, 1);

  /// Override for the `globalService` global getter.
  static Object? Function() overrideGlobalGetterGlobalService() =>
      () => 'MockGlobalService';

  /// Override for the `greet` top-level function.
  /// Receives the same parameters as NativeFunctionImpl.
  static Object? overrideGlobalFunctionGreet(
    Object? visitor,
    List<Object?> positional,
    Map<String, Object?> named,
    List<Object?>? typeArgs,
  ) {
    final name = positional.isNotEmpty ? positional[0] as String : 'Guest';
    return 'Overridden: Hello, $name!';
  }

  /// Override for the `add` top-level function.
  static Object? overrideGlobalFunctionAdd(
    Object? visitor,
    List<Object?> positional,
    Map<String, Object?> named,
    List<Object?>? typeArgs,
  ) {
    final a = positional[0] as int;
    final b = positional[1] as int;
    return a + b + 100; // Add 100 to show override is used
  }
}
