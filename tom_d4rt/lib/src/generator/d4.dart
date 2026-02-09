/// D4 Bridge Helpers
///
/// Static helper methods for D4rt-generated bridge code.
///
/// NOTE: This is work in progress - API may change.
library;

import '../bridge/bridged_types.dart';
import '../exceptions.dart';

/// D4 - Static helper class for D4rt bridge code generation.
///
/// All generated bridge code uses these static methods for:
/// - Type coercion (List/Map from D4rt runtime)
/// - Argument extraction (positional and named)
/// - Target validation (instance methods)
/// - Argument count validation
///
/// Example usage in generated bridge code:
/// ```dart
/// // Validate target for instance method
/// final t = D4.validateTarget<MyClass>(target, 'MyClass');
///
/// // Extract required positional argument
/// final name = D4.getRequiredArg<String>(positional, 0, 'name', 'MyClass');
///
/// // Coerce D4rt list to typed list
/// final items = D4.coerceList<Item>(positional[0], 'items');
/// ```
class D4 {
  // Private constructor - all methods are static
  D4._();

  // ==========================================================================
  // List Coercion
  // ==========================================================================

  /// Coerce a List from D4rt to a typed List.
  ///
  /// D4rt creates `List<Object?>` when evaluating list literals, even if all
  /// elements are of the same type. This function coerces the list to the
  /// expected type by casting each element.
  static List<T> coerceList<T>(Object? arg, String paramName) {
    if (arg == null) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected List<$T>, got null',
      );
    }

    // Handle BridgedInstance wrapping
    final value = arg is BridgedInstance ? arg.nativeObject : arg;

    if (value is! List) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected List<$T>, got ${value.runtimeType}',
      );
    }

    // If already the correct type, return as-is
    if (value is List<T>) {
      return value;
    }

    // Coerce each element to the expected type
    try {
      return value.map<T>((e) {
        if (e is BridgedInstance) {
          return e.nativeObject as T;
        }
        return e as T;
      }).toList();
    } catch (e) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": cannot convert List to List<$T> - $e',
      );
    }
  }

  /// Coerce a List from D4rt, returning null if arg is null.
  static List<T>? coerceListOrNull<T>(Object? arg, String paramName) {
    if (arg == null) return null;
    return coerceList<T>(arg, paramName);
  }

  // ==========================================================================
  // Map Coercion
  // ==========================================================================

  /// Coerce a Map from D4rt to a typed Map.
  ///
  /// D4rt creates `Map<Object?, Object?>` when evaluating map literals. This
  /// function coerces the map to the expected key and value types.
  static Map<K, V> coerceMap<K, V>(Object? arg, String paramName) {
    if (arg == null) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected Map<$K, $V>, got null',
      );
    }

    // Handle BridgedInstance wrapping
    final value = arg is BridgedInstance ? arg.nativeObject : arg;

    if (value is! Map) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected Map<$K, $V>, got ${value.runtimeType}',
      );
    }

    // If already the correct type, return as-is
    if (value is Map<K, V>) {
      return value;
    }

    // Coerce each key-value pair to the expected types
    try {
      return value.map<K, V>((k, v) {
        final key = k is BridgedInstance ? k.nativeObject as K : k as K;
        final val = v is BridgedInstance ? v.nativeObject as V : v as V;
        return MapEntry(key, val);
      });
    } catch (e) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": cannot convert Map to Map<$K, $V> - $e',
      );
    }
  }

  /// Coerce a Map from D4rt, returning null if arg is null.
  static Map<K, V>? coerceMapOrNull<K, V>(Object? arg, String paramName) {
    if (arg == null) return null;
    return coerceMap<K, V>(arg, paramName);
  }

  // ==========================================================================
  // Bridged Argument Extraction
  // ==========================================================================

  /// Extract a typed value from a BridgedInstance or native object.
  ///
  /// Handles both wrapped (BridgedInstance) and unwrapped (native) objects.
  /// Throws ArgumentError if the type doesn't match.
  ///
  /// INTER-003: Supports int→double promotion
  /// INTER-004: Supports collection type casting (List, Set, Map)
  static T extractBridgedArg<T>(Object? arg, String paramName) {
    // Unwrap BridgedInstance if needed
    final unwrapped = arg is BridgedInstance ? arg.nativeObject : arg;

    if (unwrapped is T) {
      return unwrapped;
    }

    // INTER-003: int→double promotion
    if (T == double && unwrapped is int) {
      return unwrapped.toDouble() as T;
    }

    // INTER-004: Collection type casting
    // List<Object?> → List<T>
    if (unwrapped is List && T.toString().startsWith('List<')) {
      try {
        // Extract element type from T string (e.g., "List<int>" → "int")
        final elementType = T.toString().substring(5, T.toString().length - 1);
        if (elementType == 'int') {
          return (unwrapped.cast<int>().toList()) as T;
        } else if (elementType == 'double') {
          return (unwrapped.map((e) => e is int ? e.toDouble() : e).cast<double>().toList()) as T;
        } else if (elementType == 'String') {
          return (unwrapped.cast<String>().toList()) as T;
        } else if (elementType == 'num') {
          return (unwrapped.cast<num>().toList()) as T;
        } else if (elementType == 'bool') {
          return (unwrapped.cast<bool>().toList()) as T;
        } else if (elementType == 'Object' || elementType == 'dynamic') {
          return (unwrapped.cast<Object>().toList()) as T;
        }
        // For other types, try direct casting
        return unwrapped as T;
      } catch (_) {
        // Fall through to error
      }
    }

    // Set<Object?> → Set<T>
    if (unwrapped is Set && T.toString().startsWith('Set<')) {
      try {
        final elementType = T.toString().substring(4, T.toString().length - 1);
        if (elementType == 'int') {
          return (unwrapped.cast<int>().toSet()) as T;
        } else if (elementType == 'double') {
          return (unwrapped.map((e) => e is int ? e.toDouble() : e).cast<double>().toSet()) as T;
        } else if (elementType == 'String') {
          return (unwrapped.cast<String>().toSet()) as T;
        } else if (elementType == 'num') {
          return (unwrapped.cast<num>().toSet()) as T;
        } else if (elementType == 'bool') {
          return (unwrapped.cast<bool>().toSet()) as T;
        } else if (elementType == 'Object' || elementType == 'dynamic') {
          return (unwrapped.cast<Object>().toSet()) as T;
        }
        return unwrapped as T;
      } catch (_) {
        // Fall through to error
      }
    }

    // Map casting support
    if (unwrapped is Map && T.toString().startsWith('Map<')) {
      try {
        return unwrapped as T;
      } catch (_) {
        // Fall through to error
      }
    }

    final actualType =
        arg is BridgedInstance ? arg.nativeObject.runtimeType : arg.runtimeType;
    throw ArgumentD4rtException(
      'Invalid parameter "$paramName": expected $T, got $actualType',
    );
  }

  /// Extract a typed value from a BridgedInstance or native object,
  /// returning null if the argument is null.
  ///
  /// Handles both wrapped (BridgedInstance) and unwrapped (native) objects.
  /// Throws ArgumentError if the type doesn't match (and is non-null).
  static T? extractBridgedArgOrNull<T>(Object? arg, String paramName) {
    if (arg == null) return null;
    return extractBridgedArg<T>(arg, paramName);
  }

  // ==========================================================================
  // Positional Argument Helpers
  // ==========================================================================

  /// Get a required positional argument with type checking.
  ///
  /// Throws ArgumentError if the argument is missing or has wrong type.
  static T getRequiredArg<T>(
    List<Object?> positional,
    int index,
    String paramName,
    String methodName,
  ) {
    if (positional.length <= index) {
      throw ArgumentD4rtException(
        '$methodName: Missing required argument "$paramName" at position $index. '
        'Expected at least ${index + 1} arguments, got ${positional.length}',
      );
    }
    return extractBridgedArg<T>(positional[index], paramName);
  }

  /// Get an optional positional argument with type checking.
  ///
  /// Returns null if the argument is missing, throws if wrong type.
  static T? getOptionalArg<T>(
    List<Object?> positional,
    int index,
    String paramName,
  ) {
    if (positional.length <= index || positional[index] == null) {
      return null;
    }
    return extractBridgedArg<T>(positional[index], paramName);
  }

  /// Get an optional positional argument with default value.
  ///
  /// Returns defaultValue if missing, throws if present but wrong type.
  static T getOptionalArgWithDefault<T>(
    List<Object?> positional,
    int index,
    String paramName,
    T defaultValue,
  ) {
    if (positional.length <= index || positional[index] == null) {
      return defaultValue;
    }
    return extractBridgedArg<T>(positional[index], paramName);
  }

  // ==========================================================================
  // Named Argument Helpers
  // ==========================================================================

  /// Get a required named argument with type checking.
  ///
  /// Throws ArgumentError if the argument is missing or has wrong type.
  static T getRequiredNamedArg<T>(
    Map<String, Object?> named,
    String paramName,
    String methodName,
  ) {
    if (!named.containsKey(paramName) || named[paramName] == null) {
      throw ArgumentD4rtException(
        '$methodName: Missing required named argument "$paramName"',
      );
    }
    return extractBridgedArg<T>(named[paramName], paramName);
  }

  /// Get an optional named argument with type checking.
  ///
  /// Returns null if missing, throws if present but wrong type.
  static T? getOptionalNamedArg<T>(
    Map<String, Object?> named,
    String paramName,
  ) {
    if (!named.containsKey(paramName) || named[paramName] == null) {
      return null;
    }
    return extractBridgedArg<T>(named[paramName], paramName);
  }

  /// Get an optional named argument with default value.
  ///
  /// Returns defaultValue if missing, throws if present but wrong type.
  static T getNamedArgWithDefault<T>(
    Map<String, Object?> named,
    String paramName,
    T defaultValue,
  ) {
    if (!named.containsKey(paramName) || named[paramName] == null) {
      return defaultValue;
    }
    return extractBridgedArg<T>(named[paramName], paramName);
  }

  // ==========================================================================
  // Argument Count Validation
  // ==========================================================================

  /// Verify minimum positional arguments count.
  ///
  /// Throws ArgumentError if not enough arguments.
  static void requireMinArgs(
    List<Object?> positional,
    int minCount,
    String methodName,
  ) {
    if (positional.length < minCount) {
      throw ArgumentD4rtException(
        '$methodName expects at least $minCount argument(s), got ${positional.length}',
      );
    }
  }

  /// Verify exact positional arguments count.
  ///
  /// Throws ArgumentError if wrong number of arguments.
  static void requireExactArgs(
    List<Object?> positional,
    int count,
    String methodName,
  ) {
    if (positional.length != count) {
      throw ArgumentD4rtException(
        '$methodName expects exactly $count argument(s), got ${positional.length}',
      );
    }
  }

  // ==========================================================================
  // Target Validation
  // ==========================================================================

  /// Validate target type for instance methods/getters.
  ///
  /// Throws ArgumentError if target is not the expected type.
  static T validateTarget<T>(Object? target, String typeName) {
    if (target is T) {
      return target;
    }
    throw ArgumentD4rtException(
      'Invalid target: expected $typeName, got ${target?.runtimeType}',
    );
  }

  // ==========================================================================
  // Non-Wrappable Default Helpers
  // ==========================================================================

  /// Helper for parameters with non-wrappable defaults.
  ///
  /// The original Dart code has a default value that cannot be expressed in the
  /// bridge (e.g., class static members, private constants, complex expressions).
  /// This forces the caller to provide a value at runtime.
  ///
  /// Throws ArgumentError if the value is null.
  static T getRequiredArgTodoDefault<T>(
    List<Object?> positional,
    int index,
    String paramName,
    String methodName,
    String originalDefault,
  ) {
    if (positional.length <= index || positional[index] == null) {
      throw ArgumentD4rtException(
        '$methodName: Parameter "$paramName" has non-wrappable default ($originalDefault). '
        'Value must be specified but was null.',
      );
    }
    return extractBridgedArg<T>(positional[index], paramName);
  }

  /// Helper for named parameters with non-wrappable defaults.
  ///
  /// The original Dart code has a default value that cannot be expressed in the
  /// bridge (e.g., class static members, private constants, complex expressions).
  /// This forces the caller to provide a value at runtime.
  ///
  /// Throws ArgumentError if the value is null.
  static T getRequiredNamedArgTodoDefault<T>(
    Map<String, Object?> named,
    String paramName,
    String methodName,
    String originalDefault,
  ) {
    if (!named.containsKey(paramName) || named[paramName] == null) {
      throw ArgumentD4rtException(
        '$methodName: Parameter "$paramName" has non-wrappable default ($originalDefault). '
        'Value must be specified but was null.',
      );
    }
    return extractBridgedArg<T>(named[paramName], paramName);
  }
}

// =============================================================================
// D4UserBridge Base Class
// =============================================================================

/// Base class for user-defined bridge overrides.
///
/// Extend this class to provide custom implementations for specific bridge
/// members that the generator cannot handle correctly (e.g., operators,
/// complex generics, or classes needing `nativeNames`).
///
/// This is a marker class - extending it tells the generator:
/// 1. This class should be excluded from bridge generation
/// 2. Static methods matching the override naming convention should be used
///
/// ## Naming Convention
///
/// Create a class named `{ClassName}UserBridge` that extends `D4UserBridge`:
///
/// ```dart
/// class MyListUserBridge extends D4UserBridge {
///   // Static override methods...
/// }
/// ```
///
/// ## Override Methods (all must be static)
///
/// | Member Type | Static Override Method |
/// |-------------|------------------------|
/// | Constructor `Foo()` | `static overrideConstructor(...)` |
/// | Constructor `Foo.named()` | `static overrideConstructorNamed(...)` |
/// | Getter `value` | `static overrideGetterValue(...)` |
/// | Setter `value=` | `static overrideSetterValue(...)` |
/// | Method `doWork()` | `static overrideMethodDoWork(...)` |
/// | Static getter | `static overrideStaticGetterName(...)` |
/// | Static setter | `static overrideStaticSetterName(...)` |
/// | Static method | `static overrideStaticMethodName(...)` |
/// | Operator `[]` | `static overrideOperatorIndex(...)` |
/// | Operator `[]=` | `static overrideOperatorIndexAssign(...)` |
/// | Operator `+` | `static overrideOperatorPlus(...)` |
///
/// ## Special Properties
///
/// - `nativeNames`: Define as a static getter to provide internal type names
///
/// ## Example
///
/// ```dart
/// class MyListUserBridge extends D4UserBridge {
///   /// Map internal List implementations to this bridge.
///   static List<String> get nativeNames => ['_GrowableList', '_FixedLengthList'];
///
///   /// Override operator[] - not auto-generated.
///   static Object? overrideOperatorIndex(
///     Object? visitor,
///     Object? target,
///     List<Object?> positional,
///     Map<String, Object?> named,
///   ) {
///     final list = D4.validateTarget<MyList>(target, 'MyList');
///     final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]');
///     return list[index];
///   }
/// }
/// ```
///
/// The generator will:
/// 1. Detect `MyListUserBridge` extending `D4UserBridge`
/// 2. Skip `MyListUserBridge` from bridge generation
/// 3. For class `MyList`, check if `MyListUserBridge` exists
/// 4. Use `MyListUserBridge.overrideOperatorIndex` instead of generating `[]`
/// 5. Use `MyListUserBridge.nativeNames` in the generated `BridgedClass`
abstract class D4UserBridge {
  // Empty marker class - all override methods in subclasses must be static
}
