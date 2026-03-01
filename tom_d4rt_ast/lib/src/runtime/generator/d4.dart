/// D4 Bridge Helpers
///
/// Static helper methods for D4rt-generated bridge code.
///
/// NOTE: This is work in progress - API may change.
library;

import '../bridge/bridged_types.dart';
import '../bridge/bridged_enum.dart';
import '../callable.dart';
import '../exceptions.dart';
import '../interpreter_visitor.dart';

/// GEN-079: Factory callback for creating typed wrappers.
///
/// Takes the raw unwrapped value and the inner type argument string
/// (e.g., 'Color?' for `WidgetStateProperty<Color?>`).
/// Returns a properly typed wrapper, or null if the type arg is not supported.
typedef GenericTypeWrapperFactory =
    Object? Function(Object value, String innerTypeArg);

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
  // GEN-079: Generic Type Wrapper Registration
  // ==========================================================================

  /// Registered wrapper factories keyed by base type name.
  ///
  /// Example: 'WidgetStateProperty' → factory that creates
  /// typed WidgetStateProperty wrappers.
  static final Map<String, GenericTypeWrapperFactory> _genericTypeWrappers = {};

  /// Register a wrapper factory for a generic base type.
  ///
  /// When [extractBridgedArg] encounters a value whose `is T` check fails
  /// due to generic type argument mismatch (e.g., `WidgetStatePropertyAll<dynamic>`
  /// vs `WidgetStateProperty<Color?>`), it looks up a registered factory for
  /// the base type name and uses it to create a properly typed wrapper.
  ///
  /// The [baseTypeName] is the unparameterized type name (e.g., 'WidgetStateProperty').
  /// The [factory] receives the raw value and the desired inner type argument string.
  static void registerGenericTypeWrapper(
    String baseTypeName,
    GenericTypeWrapperFactory factory,
  ) {
    _genericTypeWrappers[baseTypeName] = factory;
  }

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
        if (e is BridgedEnumValue) {
          return e.nativeValue as T;
        }
        // INTER-003c: int→double element promotion in lists
        if (_isDoubleType<T>() && e is int) {
          return e.toDouble() as T;
        }
        return e as T;
      }).toList();
    } catch (e) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": cannot convert List to List<$T> - $e',
      );
    }
  }

  /// Check if T is double or double? (nullable double)
  static bool _isDoubleType<T>() {
    // Check non-nullable double
    if (T == double) return true;
    // Check nullable double by examining type string
    final typeName = T.toString();
    return typeName == 'double?' || typeName == 'double?';
  }

  /// Check if T is num or num? (nullable num)
  static bool _isNumType<T>() {
    if (T == num) return true;
    final typeName = T.toString();
    return typeName == 'num?' || typeName == 'num?';
  }

  /// GEN-075: Unwrap a single element from BridgedInstance/BridgedEnumValue.
  static Object? _unwrapElement(Object? e) {
    if (e is BridgedInstance) return e.nativeObject;
    if (e is BridgedEnumValue) return e.nativeValue;
    return e;
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
  ///
  /// If [visitor] is provided and the value type V is a function type,
  /// InterpretedFunction values will be wrapped in proper callbacks.
  static Map<K, V> coerceMap<K, V>(
    Object? arg,
    String paramName, [
    InterpreterVisitor? visitor,
  ]) {
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
        final val = _coerceMapValue<V>(v, paramName, visitor);
        return MapEntry(key, val);
      });
    } catch (e) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": cannot convert Map to Map<$K, $V> - $e',
      );
    }
  }

  /// Coerce a Map from D4rt, returning null if arg is null.
  ///
  /// If [visitor] is provided and the value type V is a function type,
  /// InterpretedFunction values will be wrapped in proper callbacks.
  static Map<K, V>? coerceMapOrNull<K, V>(
    Object? arg,
    String paramName, [
    InterpreterVisitor? visitor,
  ]) {
    if (arg == null) return null;
    return coerceMap<K, V>(arg, paramName, visitor);
  }

  /// Coerce a single map value, handling function type wrapping.
  static V _coerceMapValue<V>(
    Object? v,
    String paramName,
    InterpreterVisitor? visitor,
  ) {
    final unwrapped = v is BridgedInstance ? v.nativeObject : v;

    // If V is a function type and v is an InterpretedFunction, wrap it
    // We detect function types by checking the type name string
    final vTypeName = V.toString();
    if (_looksLikeFunctionType(vTypeName) &&
        (v is InterpretedFunction || v is NativeFunction || v is Callable)) {
      if (visitor == null) {
        throw ArgumentD4rtException(
          'Invalid parameter "$paramName": Map contains function values but '
          'visitor was not provided for callback wrapping',
        );
      }
      return _wrapCallableForMap<V>(v!, visitor) as V;
    }

    // Direct cast as fallback
    return unwrapped as V;
  }

  /// Check if a type string looks like a function type.
  static bool _looksLikeFunctionType(String typeName) {
    // Function types look like:
    // - "() => void"
    // - "(int) => String"
    // - "void Function()"
    // - "Widget Function(BuildContext)"
    return typeName.contains('=>') ||
        typeName.contains('Function(') ||
        typeName.contains('Function<');
  }

  /// Wrap an InterpretedFunction/Callable for use as a Map value function.
  ///
  /// Detects the expected return type from V and creates an appropriate wrapper.
  /// For common widget builder patterns like `Widget Function(BuildContext)`,
  /// returns the correctly typed wrapper.
  static dynamic _wrapCallableForMap<V>(
    Object callable,
    InterpreterVisitor visitor,
  ) {
    // Extract function signature info from V
    final vType = V.toString();

    // Check for common single-argument patterns like "Widget Function(BuildContext)"
    // Pattern: "ReturnType Function(ArgType)" or "(ArgType) => ReturnType"
    // Note: Using untyped parameters to get dynamic, which is assignable to any type
    if (_isSingleArgFunction(vType)) {
      // Return a wrapper with 1 required positional argument (untyped = dynamic)
      return (arg) {
        if (callable is Callable) {
          return callable.call(visitor, [arg], {});
        }
        throw ArgumentD4rtException(
          'Cannot call non-callable in Map value: ${callable.runtimeType}',
        );
      };
    }

    // Check for no-argument functions like "void Function()"
    if (_isNoArgFunction(vType)) {
      return () {
        if (callable is Callable) {
          return callable.call(visitor, [], {});
        }
        throw ArgumentD4rtException(
          'Cannot call non-callable in Map value: ${callable.runtimeType}',
        );
      };
    }

    // Check for two-argument functions (untyped = dynamic)
    if (_isTwoArgFunction(vType)) {
      return (arg1, arg2) {
        if (callable is Callable) {
          return callable.call(visitor, [arg1, arg2], {});
        }
        throw ArgumentD4rtException(
          'Cannot call non-callable in Map value: ${callable.runtimeType}',
        );
      };
    }

    // Fallback: variable-arity wrapper with dynamic params
    // Note: Using untyped optional params for flexibility
    return ([p0, p1, p2, p3, p4, p5, p6, p7, p8, p9]) {
      final args = <Object?>[];
      if (p0 != null) args.add(p0);
      if (p1 != null) args.add(p1);
      if (p2 != null) args.add(p2);
      if (p3 != null) args.add(p3);
      if (p4 != null) args.add(p4);
      if (p5 != null) args.add(p5);
      if (p6 != null) args.add(p6);
      if (p7 != null) args.add(p7);
      if (p8 != null) args.add(p8);
      if (p9 != null) args.add(p9);

      if (callable is Callable) {
        return callable.call(visitor, args, {});
      }
      throw ArgumentD4rtException(
        'Cannot call non-callable object in Map value: ${callable.runtimeType}',
      );
    };
  }

  /// Check if type is a single-argument function.
  /// Examples: "Widget Function(BuildContext)", "(BuildContext) => Widget"
  static bool _isSingleArgFunction(String typeName) {
    // Match "ReturnType Function(SingleType)" - no comma means single arg
    final functionMatch = RegExp(r'Function\(([^,)]+)\)$').firstMatch(typeName);
    if (functionMatch != null) {
      return true;
    }
    // Match "(SingleType) => ReturnType"
    final arrowMatch = RegExp(r'\(([^,)]+)\)\s*=>\s*\S+$').firstMatch(typeName);
    if (arrowMatch != null) {
      return true;
    }
    return false;
  }

  /// Check if type is a no-argument function.
  /// Examples: "void Function()", "() => void"
  static bool _isNoArgFunction(String typeName) {
    return typeName.contains('Function()') ||
        RegExp(r'\(\)\s*=>').hasMatch(typeName);
  }

  /// Check if type is a two-argument function.
  /// Examples: "Widget Function(BuildContext, Widget)", "(A, B) => R"
  static bool _isTwoArgFunction(String typeName) {
    // Match "Function(Type1, Type2)" - exactly one comma
    final functionMatch = RegExp(
      r'Function\(([^,]+),\s*([^,)]+)\)$',
    ).firstMatch(typeName);
    if (functionMatch != null) {
      return true;
    }
    // Match "(Type1, Type2) => ReturnType"
    final arrowMatch = RegExp(
      r'\(([^,]+),\s*([^,)]+)\)\s*=>',
    ).firstMatch(typeName);
    if (arrowMatch != null) {
      return true;
    }
    return false;
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
    // Unwrap BridgedInstance or BridgedEnumValue if needed
    final unwrapped = arg is BridgedInstance
        ? arg.nativeObject
        : arg is BridgedEnumValue
        ? arg.nativeValue
        : arg;

    if (unwrapped is T) {
      return unwrapped;
    }

    // GEN-079: Generic type wrapper resolution.
    // When T is a complex generic (e.g., WidgetStateProperty<Color?>?),
    // the `is T` check fails if the value was created with `<dynamic>`
    // (e.g., WidgetStatePropertyAll<dynamic>) because Dart's reified generics
    // require exact type argument matching for subtype checks.
    // Use registered wrapper factories to create properly typed proxy objects.
    if (unwrapped != null && _genericTypeWrappers.isNotEmpty) {
      final tStr = T.toString();
      // Strip trailing '?' for nullable generic types
      String baseT = tStr;
      while (baseT.endsWith('?')) {
        baseT = baseT.substring(0, baseT.length - 1);
      }
      if (baseT.contains('<')) {
        final baseTypeName = baseT.substring(0, baseT.indexOf('<'));
        final factory = _genericTypeWrappers[baseTypeName];
        if (factory != null) {
          final innerTypeArg = baseT.substring(
            baseT.indexOf('<') + 1,
            baseT.lastIndexOf('>'),
          );
          final wrapped = factory(unwrapped, innerTypeArg);
          if (wrapped is T) return wrapped;
        }
      }
    }

    // INTER-003: int→double promotion (handles both double and double?)
    if (_isDoubleType<T>() && unwrapped is int) {
      return unwrapped.toDouble() as T;
    }

    // INTER-003b: int→num promotion (handles both num and num?)
    if (_isNumType<T>() && unwrapped is int) {
      return unwrapped as T;
    }

    // INTER-004: Collection type casting
    // GEN-075: Unwrap BridgedInstance/BridgedEnumValue elements first
    final tStr = T.toString();

    // List<Object?> → List<T> (also handles Iterable<T>)
    if (unwrapped is List &&
        (tStr.startsWith('List<') || tStr.startsWith('Iterable<'))) {
      try {
        // Unwrap any BridgedInstance/BridgedEnumValue elements
        final unwrappedList = unwrapped.map(_unwrapElement).toList();
        // Extract element type from T string
        final prefixLen = tStr.startsWith('List<') ? 5 : 9;
        final elementType = tStr.substring(prefixLen, tStr.length - 1);
        return switch (elementType) {
              'int' => unwrappedList.cast<int>().toList(),
              'double' =>
                unwrappedList
                    .map((e) => e is int ? e.toDouble() : e)
                    .cast<double>()
                    .toList(),
              'String' => unwrappedList.cast<String>().toList(),
              'num' => unwrappedList.cast<num>().toList(),
              'bool' => unwrappedList.cast<bool>().toList(),
              'Object' || 'dynamic' => unwrappedList.cast<Object>().toList(),
              _ => unwrappedList,
            }
            as T;
      } catch (_) {
        // Fall through to error
      }
    }

    // Set<Object?> → Set<T>
    if (unwrapped is Set && tStr.startsWith('Set<')) {
      try {
        final unwrappedSet = unwrapped.map(_unwrapElement).toSet();
        final elementType = tStr.substring(4, tStr.length - 1);
        return switch (elementType) {
              'int' => unwrappedSet.cast<int>().toSet(),
              'double' =>
                unwrappedSet
                    .map((e) => e is int ? e.toDouble() : e)
                    .cast<double>()
                    .toSet(),
              'String' => unwrappedSet.cast<String>().toSet(),
              'num' => unwrappedSet.cast<num>().toSet(),
              'bool' => unwrappedSet.cast<bool>().toSet(),
              'Object' || 'dynamic' => unwrappedSet.cast<Object>().toSet(),
              _ => unwrappedSet,
            }
            as T;
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

    final actualType = arg is BridgedInstance
        ? arg.nativeObject.runtimeType
        : arg.runtimeType;
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

  // ==========================================================================
  // Callback Invocation
  // ==========================================================================

  /// Call an interpreter callback that may be either an InterpretedFunction
  /// or a NativeFunction.
  ///
  /// G-DCLI-07 FIX: When bridge code needs to invoke a callback parameter
  /// (e.g., `forEach(print)`), the callback may be a NativeFunction (like `print`)
  /// or an InterpretedFunction (user-defined lambda). This method handles both.
  ///
  /// Returns the result of calling the callback.
  static Object? callInterpreterCallback(
    InterpreterVisitor visitor,
    Object? callback,
    List<Object?> args, [
    Map<String, Object?> namedArgs = const {},
  ]) {
    if (callback is InterpretedFunction) {
      return callback.call(visitor, args, namedArgs);
    } else if (callback is NativeFunction) {
      return callback.call(visitor, args, namedArgs);
    } else if (callback is Callable) {
      return callback.call(visitor, args, namedArgs);
    } else {
      throw ArgumentD4rtException(
        'Expected a callable function, got ${callback?.runtimeType}',
      );
    }
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
