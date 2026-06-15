/// Globals user-bridge overrides for `app_config.dart`.
///
/// `@D4rtGlobalsUserBridge` targets a library's *top-level* members rather than
/// a class. Scripts that import `app_config.dart` see the overridden values
/// below instead of the native defaults — a way to give sandboxed scripts their
/// own configuration. Override naming:
/// - variables → `overrideGlobalVariable{Name}()`
/// - getters   → `overrideGlobalGetter{Name}()` (returns a getter function)
/// - functions → `overrideGlobalFunction{Name}(visitor, positional, named, typeArgs)`
library;

import 'package:tom_d4rt/d4rt.dart';

/// Hand-written global overrides for the `app_config` library.
@D4rtGlobalsUserBridge('package:d4rt_userbridges_sample/src/config/app_config.dart')
class AppConfigUserBridge extends D4UserBridge {
  /// Replace the `appName` constant.
  static Object? overrideGlobalVariableAppName() => 'ScriptLedger';

  /// Raise the `maxItems` limit for scripts.
  static Object? overrideGlobalVariableMaxItems() => 100;

  /// Replace the `currentTime` getter with a fixed, deterministic clock so
  /// script output is reproducible. Returns the getter function itself.
  static Object? Function() overrideGlobalGetterCurrentTime() =>
      () => DateTime.utc(2026, 1, 1);

  /// Replace the `describe` top-level function.
  static Object? overrideGlobalFunctionDescribe(
    Object? visitor,
    List<Object?> positional,
    Map<String, Object?> named,
    List<Object?>? typeArgs,
  ) {
    final what = D4.getRequiredArg<String>(positional, 0, 'what', 'describe');
    return 'script: $what';
  }

  /// Replace the `taxCents` top-level function with a flat 10% fallback rate.
  static Object? overrideGlobalFunctionTaxCents(
    Object? visitor,
    List<Object?> positional,
    Map<String, Object?> named,
    List<Object?>? typeArgs,
  ) {
    final cents = D4.getRequiredArg<int>(positional, 0, 'cents', 'taxCents');
    final rate = D4.getOptionalNamedArg<num?>(named, 'rate') ?? 0.10;
    return (cents * rate).round();
  }
}
