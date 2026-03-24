/// D4 Bridge Helpers
///
/// Static helper methods for D4rt-generated bridge code.
///
/// NOTE: This is work in progress - API may change.
library;

import '../bridge/bridged_types.dart';
import '../bridge/bridged_enum.dart';
import '../bridge/registration.dart' show BridgedMethodAdapter;
import '../callable.dart';
import '../exceptions.dart';
import '../interpreter_visitor.dart';
import '../runtime_interfaces.dart';
import '../runtime_types.dart';

/// GEN-079: Factory callback for creating typed wrappers.
///
/// Takes the raw unwrapped value and the inner type argument string
/// (e.g., 'Color?' for `WidgetStateProperty<Color?>`).
/// Returns a properly typed wrapper, or null if the type arg is not supported.
typedef GenericTypeWrapperFactory = Object? Function(
    Object value, String innerTypeArg);

/// RC-1: Factory for creating native proxy objects that delegate method calls
/// back to an [InterpretedInstance].
///
/// When a D4rt script class implements or extends a bridged abstract class
/// or interface (e.g., `class MyClipper extends CustomClipper<Path>`),
/// the resulting [InterpretedInstance] cannot be used directly as the native
/// type. An interface proxy wraps it in a native object that delegates
/// method calls back to the interpreter.
///
/// The [visitor] is the current interpreter for dispatching callbacks.
/// The [instance] is the D4rt interpreted instance that provides the implementation.
typedef InterfaceProxyFactory = Object? Function(
    InterpreterVisitor visitor, InterpretedInstance instance);

/// RC-3: Factory for converting one type to another when they represent
/// the same concept but live in different packages.
///
/// Example: `painting.TextStyle` → `dart:ui.TextStyle` via `getTextStyle()`.
typedef TypeCoercionFactory = Object? Function(Object value);

/// RC-2: Factory for constructing generic bridged classes with type arguments.
///
/// When a D4rt script calls `GlobalKey<NavigatorState>()`, the type argument
/// is evaluated at runtime but Dart requires compile-time generic types.
/// This factory receives the evaluated [RuntimeType] list and dispatches to
/// the correct statically-typed constructor.
///
/// The [visitor] is the current interpreter context.
/// [positionalArgs] and [namedArgs] are the converted arguments.
/// [typeArguments] are the evaluated type arguments from the script,
/// or null when called without type arguments (constructor override).
typedef GenericConstructorFactory = Object? Function(
    InterpreterVisitor visitor,
    List<Object?> positionalArgs,
    Map<String, Object?> namedArgs,
    List<RuntimeType>? typeArguments);

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
  // Active Visitor (for interface proxy creation in bridge constructor helpers)
  // ==========================================================================

  /// The currently active [InterpreterVisitor] during bridge constructor/method
  /// execution. Set via [withActiveVisitor] before calling bridge adapters.
  ///
  /// This allows [extractBridgedArg] to access the visitor for interface proxy
  /// creation even when called indirectly via helper methods (getRequiredNamedArg
  /// etc.) that don't pass the visitor parameter.
  static InterpreterVisitor? _activeVisitor;

  /// Execute [fn] with the given [visitor] as the active visitor.
  /// Restores the previous visitor when done (supports nesting).
  static T withActiveVisitor<T>(InterpreterVisitor visitor, T Function() fn) {
    final previous = _activeVisitor;
    _activeVisitor = visitor;
    try {
      return fn();
    } finally {
      _activeVisitor = previous;
    }
  }

  // ==========================================================================
  // GEN-079: Generic Type Wrapper Registration
  // ==========================================================================

  /// Registered wrapper factory lists keyed by base type name.
  ///
  /// Each base type name maps to a list of factories registered additively
  /// across modules. Factories are checked in registration order — the first
  /// factory that returns non-null wins.
  ///
  /// Example: 'ValueNotifier' → [foundationFactory, widgetsFactory, userFactory]
  static final Map<String, List<GenericTypeWrapperFactory>>
      _genericTypeWrappers = {};

  // ==========================================================================
  // RC-1: Interface Proxy Registration
  // ==========================================================================

  /// Registered interface proxy factories keyed by bridged class name.
  ///
  /// When [extractBridgedArg] encounters an [InterpretedInstance] whose class
  /// hierarchy includes a bridged interface/superclass, it looks up a proxy
  /// factory here to create a native object that delegates back to the interpreter.
  static final Map<String, InterfaceProxyFactory> _interfaceProxies = {};

  /// Register a proxy factory for a bridged interface or abstract class.
  ///
  /// The [bridgedTypeName] is the name of the bridged class/interface.
  /// The [factory] creates a native proxy that delegates to the InterpreterVisitor.
  static void registerInterfaceProxy(
    String bridgedTypeName,
    InterfaceProxyFactory factory,
  ) {
    _interfaceProxies[bridgedTypeName] = factory;
  }

  // ==========================================================================
  // RC-3: Type Coercion Registration
  // ==========================================================================

  /// Registered type coercion factories keyed by "SourceType->TargetType".
  ///
  /// When [extractBridgedArg<T>] receives a value that isn't T but has a
  /// registered coercion from its runtime type to T, it applies the coercion.
  static final Map<String, TypeCoercionFactory> _typeCoercions = {};

  /// Register a type coercion from one type to another.
  ///
  /// [sourceTypeName] is the runtime type name of the source (e.g., 'TextStyle').
  /// [targetTypeName] is the expected type name (e.g., 'TextStyle') — but in a
  /// different package. The key used is "sourceType->targetType" but since both
  /// may have the same name, we use the native [Type] objects.
  /// [sourceType] and [targetType] are the actual Dart [Type] objects.
  /// The [factory] converts the source to the target type.
  static void registerTypeCoercion({
    required Type sourceType,
    required Type targetType,
    required TypeCoercionFactory factory,
  }) {
    final key = '${sourceType.hashCode}->${targetType.hashCode}';
    _typeCoercions[key] = factory;
    // Also store by type objects for lookup
    _typeCoercionsByType[_TypePair(sourceType, targetType)] = factory;
  }

  static final Map<_TypePair, TypeCoercionFactory> _typeCoercionsByType = {};

  /// Register a wrapper factory for a generic base type (additive).
  ///
  /// Multiple factories can be registered for the same base type — each module
  /// contributes factory cases for its own types. Factories are checked in
  /// registration order during [extractBridgedArg] resolution; the first to
  /// return non-null wins.
  ///
  /// The [baseTypeName] is the unparameterized type name (e.g., 'WidgetStateProperty').
  /// The [factory] receives the raw value and the desired inner type argument string.
  static void registerGenericTypeWrapper(
    String baseTypeName,
    GenericTypeWrapperFactory factory,
  ) {
    (_genericTypeWrappers[baseTypeName] ??= []).add(factory);
  }

  // ==========================================================================
  // RC-2: Generic Constructor Registration
  // ==========================================================================

  /// Registered generic constructor factories keyed by "ClassName.ctorName".
  ///
  /// When a bridged class constructor is called with type arguments
  /// (e.g., `GlobalKey<NavigatorState>()`), the interpreter checks this map
  /// first. If found, the factory handles the construction with proper
  /// generic type arguments. Otherwise, the regular constructor adapter runs.
  static final Map<String, GenericConstructorFactory> _genericConstructors = {};

  /// Register a generic constructor factory for a bridged class.
  ///
  /// [className] - The bridged class name (e.g., 'GlobalKey').
  /// [constructorName] - The constructor name ('' for default, 'named' for named).
  /// [factory] - Creates the native object using the provided type arguments.
  ///
  /// **Chaining:** If a factory is already registered for the same key, the
  /// new factory runs first. If it returns `null` (unhandled type), the
  /// previously-registered factory runs as fallback. This enables downstream
  /// packages to extend type dispatches without knowledge of upstream types.
  static void registerGenericConstructor(
    String className,
    String constructorName,
    GenericConstructorFactory factory,
  ) {
    final key = '$className.$constructorName';
    final existing = _genericConstructors[key];
    if (existing != null) {
      // Chain: try new factory first, fall back to existing
      _genericConstructors[key] =
          (visitor, positionalArgs, namedArgs, typeArgs) {
        final result = factory(visitor, positionalArgs, namedArgs, typeArgs);
        if (result != null) return result;
        return existing(visitor, positionalArgs, namedArgs, typeArgs);
      };
    } else {
      _genericConstructors[key] = factory;
    }
  }

  /// Look up a registered generic constructor factory.
  ///
  /// Returns null if no generic constructor is registered for this class/ctor.
  static GenericConstructorFactory? findGenericConstructor(
    String className,
    String constructorName,
  ) {
    return _genericConstructors['$className.$constructorName'];
  }

  // ==========================================================================
  // RC-5: Supplementary Method Adapters
  // ==========================================================================

  /// Supplementary method adapters for bridged classes.
  ///
  /// These fill gaps where the bridge generator skips methods (e.g. @protected
  /// methods like ChangeNotifier.notifyListeners). Checked as a fallback
  /// after the main bridge method lookup in InterpretedInstance.get().
  static final Map<String, Map<String, BridgedMethodAdapter>>
      _supplementaryMethods = {};

  /// Register a supplementary method adapter for a bridged class.
  ///
  /// [bridgedClassName] - The name of the bridged class.
  /// [methodName] - The method name to add.
  /// [adapter] - The method adapter (same signature as generated adapters).
  static void registerSupplementaryMethod(
    String bridgedClassName,
    String methodName,
    BridgedMethodAdapter adapter,
  ) {
    _supplementaryMethods.putIfAbsent(bridgedClassName, () => {})[methodName] =
        adapter;
  }

  /// Look up a supplementary method adapter.
  static BridgedMethodAdapter? findSupplementaryMethod(
    String bridgedClassName,
    String methodName,
  ) {
    return _supplementaryMethods[bridgedClassName]?[methodName];
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
          final native = e.nativeObject;
          if (native is T) return native as T;
          // GEN-079: Try wrapper resolution before failing the cast.
          // e.g., TweenSequenceItem<dynamic> → $RelaxedTweenSequenceItem<double>
          final wrapped = _tryGenericWrapperResolution<T>(native);
          if (wrapped != null) return wrapped;
          return native as T;
        }
        if (e is BridgedEnumValue) {
          return e.nativeValue as T;
        }
        // RC-1: InterpretedInstance element unwrapping.
        // When a D4rt list contains interpreted widgets/objects that extend
        // a bridged type, unwrap via bridgedSuperObject.
        if (e is InterpretedInstance) {
          if (e.bridgedSuperObject is T) {
            return e.bridgedSuperObject as T;
          }
          // RC-1: Try interface proxy for elements that implement a bridged interface
          final effectiveVisitor = _activeVisitor;
          if (_interfaceProxies.isNotEmpty && effectiveVisitor != null) {
            final proxy =
                tryCreateInterfaceProxyWithVisitor<T>(e, effectiveVisitor);
            if (proxy != null) return proxy;
          }
        }
        // INTER-003c: int→double element promotion in lists
        if (_isDoubleType<T>() && e is int) {
          return e.toDouble() as T;
        }
        // GEN-079: Generic wrapper resolution for list elements.
        // When T is a parameterized generic (e.g., TweenSequenceItem<double>)
        // and the element has the right base type but wrong type args
        // (e.g., TweenSequenceItem<dynamic>), use registered wrapper factories.
        final unwrappedElem = e is BridgedInstance ? e.nativeObject : e;
        final wrapped = _tryGenericWrapperResolution<T>(unwrappedElem);
        if (wrapped != null) return wrapped;
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

  /// GEN-079: Try to resolve a value through registered generic type wrapper
  /// factories.
  ///
  /// When T is a parameterized generic (e.g., `TweenSequenceItem<double>`) and
  /// [value] has the right base type but wrong type arguments (e.g.,
  /// `TweenSequenceItem<dynamic>`), registered wrapper factories can create a
  /// properly typed proxy (e.g., `$RelaxedTweenSequenceItem<double>`).
  ///
  /// Returns the wrapped value if a factory succeeds, or `null` if no factory
  /// matched.
  static T? _tryGenericWrapperResolution<T>(Object? value) {
    if (value == null || _genericTypeWrappers.isEmpty) return null;
    final tStr = T.toString();
    // Strip trailing '?' for nullable generic types
    String baseT = tStr;
    while (baseT.endsWith('?')) {
      baseT = baseT.substring(0, baseT.length - 1);
    }
    if (!baseT.contains('<')) return null;
    final baseTypeName = baseT.substring(0, baseT.indexOf('<'));
    final innerTypeArg = baseT.substring(
      baseT.indexOf('<') + 1,
      baseT.lastIndexOf('>'),
    );

    // Try with the target base type name first, then with the value's
    // runtime base type name (e.g., WidgetStatePropertyAll when target is
    // WidgetStateProperty).
    final valueName = value.runtimeType.toString();
    final valueBaseName = valueName.contains('<')
        ? valueName.substring(0, valueName.indexOf('<'))
        : valueName;
    final typeNamesToTry = <String>{baseTypeName, valueBaseName};

    for (final typeName in typeNamesToTry) {
      final factories = _genericTypeWrappers[typeName];
      if (factories == null) continue;
      for (final factory in factories) {
        // Try exact innerTypeArg first (e.g., 'Color?')
        final wrapped = factory(value, innerTypeArg);
        if (wrapped is T) return wrapped;
        // GEN-079b: If innerTypeArg is nullable (e.g., 'Color?'), also try
        // the non-nullable form (e.g., 'Color'). The wrapper created with
        // non-nullable T will still be assignable to the nullable target.
        if (innerTypeArg.endsWith('?')) {
          final nonNullableArg =
              innerTypeArg.substring(0, innerTypeArg.length - 1);
          final wrapped2 = factory(value, nonNullableArg);
          if (wrapped2 is T) return wrapped2;
        }
      }
    }
    return null;
  }

  /// Coerce a List from D4rt, returning null if arg is null.
  static List<T>? coerceListOrNull<T>(Object? arg, String paramName) {
    if (arg == null) return null;
    return coerceList<T>(arg, paramName);
  }

  // ==========================================================================
  // Set Coercion
  // ==========================================================================

  /// Coerce a Set from D4rt to a typed Set.
  ///
  /// D4rt creates `Set<Object?>` when evaluating set literals. This
  /// function coerces the set to the expected element type by unwrapping
  /// BridgedInstance, BridgedEnumValue, and InterpretedInstance elements.
  static Set<T> coerceSet<T>(Object? arg, String paramName) {
    if (arg == null) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected Set<$T>, got null',
      );
    }

    // Handle BridgedInstance wrapping
    final value = arg is BridgedInstance ? arg.nativeObject : arg;

    // D4rt may produce Maps for set literals (e.g. `{}` defaults to Map,
    // or `{a, b}` can be misidentified). Coerce Map keys → Set elements.
    final Iterable<Object?> elements;
    if (value is Set) {
      if (value is Set<T>) return value;
      elements = value;
    } else if (value is Map) {
      elements = value.keys;
    } else if (value is List) {
      elements = value;
    } else {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": expected Set<$T>, got ${value.runtimeType}',
      );
    }

    // Coerce each element to the expected type
    try {
      return elements.map<T>((e) {
        if (e is BridgedInstance) {
          final native = e.nativeObject;
          if (native is T) return native as T;
          // GEN-079: Try wrapper resolution before failing the cast.
          final wrapped = _tryGenericWrapperResolution<T>(native);
          if (wrapped != null) return wrapped;
          return native as T;
        }
        if (e is BridgedEnumValue) {
          return e.nativeValue as T;
        }
        if (e is InterpretedInstance) {
          if (e.bridgedSuperObject is T) {
            return e.bridgedSuperObject as T;
          }
          final effectiveVisitor = _activeVisitor;
          if (_interfaceProxies.isNotEmpty && effectiveVisitor != null) {
            final proxy =
                tryCreateInterfaceProxyWithVisitor<T>(e, effectiveVisitor);
            if (proxy != null) return proxy;
          }
        }
        // GEN-079: Generic wrapper resolution for set elements.
        final unwrappedElem = e is BridgedInstance ? e.nativeObject : e;
        final wrapped = _tryGenericWrapperResolution<T>(unwrappedElem);
        if (wrapped != null) return wrapped;
        return e as T;
      }).toSet();
    } catch (e) {
      throw ArgumentD4rtException(
        'Invalid parameter "$paramName": cannot convert to Set<$T> - $e',
      );
    }
  }

  /// Coerce a Set from D4rt, returning null if arg is null.
  static Set<T>? coerceSetOrNull<T>(Object? arg, String paramName) {
    if (arg == null) return null;
    return coerceSet<T>(arg, paramName);
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
        final key = k is BridgedInstance
            ? k.nativeObject as K
            : k is BridgedEnumValue
                ? k.nativeValue as K
                : k is BridgedClass
                    ? k.nativeType as K // ENG-002: class name → Type
                    : k as K;
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
          return unwrapInterpreterValue(callable.call(visitor, [arg], {}));
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
          return unwrapInterpreterValue(callable.call(visitor, [], {}));
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
          return unwrapInterpreterValue(
              callable.call(visitor, [arg1, arg2], {}));
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
        return unwrapInterpreterValue(callable.call(visitor, args, {}));
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
  /// If [visitor] is provided, interface proxy creation is enabled for
  /// InterpretedInstance values that implement bridged abstract types.
  ///
  /// INTER-003: Supports int→double promotion
  /// INTER-004: Supports collection type casting (List, Set, Map)
  static T extractBridgedArg<T>(Object? arg, String paramName,
      [InterpreterVisitor? visitor]) {
    // Unwrap BridgedInstance or BridgedEnumValue if needed
    final unwrapped = arg is BridgedInstance
        ? arg.nativeObject
        : arg is BridgedEnumValue
            ? arg.nativeValue
            : arg;

    if (unwrapped is T) {
      return unwrapped;
    }

    // ENG-007: Nullable type fallback.
    // When T is nullable (e.g., TextStyle?) and unwrapped is the non-nullable
    // base type (TextStyle), the `is T` check should succeed in Dart.
    // However, cross-package or reified generics edge cases may cause `is T`
    // to fail. This fallback uses a dynamic cast as a safety net.
    if (null is T && unwrapped != null) {
      try {
        return unwrapped as T;
      } catch (_) {
        // Fall through to subsequent checks
      }
    }

    // GEN-100: String-based nullable type check fallback.
    // In some Flutter test environments, `v is T?` can incorrectly return
    // false even when v's runtimeType matches the non-nullable base of T.
    // This check compares type names as strings as a last resort.
    if (null is T && unwrapped != null) {
      final tStr = T.toString();
      final unwrappedTypeStr = unwrapped.runtimeType.toString();
      // Check if T is "SomeType?" and unwrapped is "SomeType"
      if (tStr.endsWith('?') && tStr.substring(0, tStr.length - 1) == unwrappedTypeStr) {
        // The types match semantically, force the return through dynamic
        final dynamic temp = unwrapped;
        return temp as T;
      }
    }

    // ENG-002: BridgedClass → Type conversion.
    // When a class name appears in expression position (e.g., as a map key
    // like `{ActivateIntent: ...}`), the interpreter resolves it to a
    // BridgedClass object. Convert to the native Type for bridges expecting Type.
    if (arg is BridgedClass && arg.nativeType is T) {
      return arg.nativeType as T;
    }

    // GEN-079: Generic type wrapper resolution.
    // When T is a complex generic (e.g., WidgetStateProperty<Color?>?),
    // the `is T` check fails if the value was created with `<dynamic>`
    // (e.g., WidgetStatePropertyAll<dynamic>) because Dart's reified generics
    // require exact type argument matching for subtype checks.
    // Use registered wrapper factories to create properly typed proxy objects.
    if (unwrapped != null) {
      final wrapperResult = _tryGenericWrapperResolution<T>(unwrapped);
      if (wrapperResult != null) return wrapperResult;
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
        final result = switch (elementType) {
          'int' => unwrappedList.cast<int>().toList(),
          'double' => unwrappedList
              .map((e) => e is int ? e.toDouble() : e)
              .cast<double>()
              .toList(),
          'String' => unwrappedList.cast<String>().toList(),
          'num' => unwrappedList.cast<num>().toList(),
          'bool' => unwrappedList.cast<bool>().toList(),
          'Object' || 'dynamic' => unwrappedList.cast<Object>().toList(),
          // ENG-001: For non-primitive types, use coerceList which handles
          // BridgedInstance/InterpretedInstance/BridgedEnumValue unwrapping
          // and produces a properly typed List<T> via element casting.
          _ => unwrappedList,
        };
        // ENG-001: Try typed cast; if it fails, try coerceList which creates
        // a properly-typed list using per-element casting.
        try {
          return result as T;
        } catch (_) {
          // Fall through — collection is right shape but wrong generic type
        }
      } catch (_) {
        // Fall through to error
      }
    }

    // Set<Object?> → Set<T>
    if ((unwrapped is Set || (unwrapped is Map && tStr.startsWith('Set<'))) &&
        tStr.startsWith('Set<')) {
      try {
        // D4rt may produce Maps for set literals (e.g., `{}` defaults to Map).
        // Coerce Map keys → Set elements.
        final source = unwrapped is Map ? unwrapped.keys : (unwrapped as Set);
        final unwrappedSet = source.map(_unwrapElement).toSet();
        final elementType = tStr.substring(4, tStr.length - 1);
        final result = switch (elementType) {
          'int' => unwrappedSet.cast<int>().toSet(),
          'double' => unwrappedSet
              .map((e) => e is int ? e.toDouble() : e)
              .cast<double>()
              .toSet(),
          'String' => unwrappedSet.cast<String>().toSet(),
          'num' => unwrappedSet.cast<num>().toSet(),
          'bool' => unwrappedSet.cast<bool>().toSet(),
          'Object' || 'dynamic' => unwrappedSet.cast<Object>().toSet(),
          // ENG-001: For non-primitive types, return unwrapped and try cast
          _ => unwrappedSet,
        };
        try {
          return result as T;
        } catch (_) {
          // Fall through — collection is right shape but wrong generic type
        }
      } catch (_) {
        // Fall through to error
      }
    }

    // Map casting support
    // When T is Map<K,V> and the value is Map<Object?, Object?>, unwrap
    // BridgedInstance/BridgedEnumValue keys and values, then try to cast
    // the resulting map. Uses coerceMap for proper typed map creation
    // when the basic unwrap+cast approach fails.
    if (unwrapped is Map && tStr.startsWith('Map<')) {
      try {
        // ENG-001: Try unwrapping map keys and values first
        final unwrappedMap = <Object?, Object?>{};
        for (final entry in unwrapped.entries) {
          unwrappedMap[_unwrapElement(entry.key)] =
              _unwrapElement(entry.value);
        }
        try {
          return unwrappedMap as T;
        } catch (_) {}
        // Fall back to original map
        try {
          return unwrapped as T;
        } catch (_) {}
        // GEN-079: Generic wrapper resolution for map values.
        // Try wrapping individual values through registered factories.
        final rewrappedMap = <Object?, Object?>{};
        for (final entry in unwrappedMap.entries) {
          rewrappedMap[entry.key] = entry.value;
        }
        return rewrappedMap as T;
      } catch (_) {
        // Fall through to error
      }
    }

    // RC-1: InterpretedInstance → bridgedSuperObject unwrapping.
    // When a D4rt script class extends a bridged class (e.g.,
    // `class _StatefulDemo extends StatefulWidget`), the InterpretedInstance
    // holds the native object in bridgedSuperObject.
    if (arg is InterpretedInstance) {
      final superObj = arg.bridgedSuperObject;
      if (superObj is T) {
        return superObj;
      }
      // RC-1: Try registered interface proxy factories.
      // For abstract classes/interfaces (CustomClipper, TickerProvider),
      // bridgedSuperObject may be null. Use a proxy factory to create a
      // native delegate that calls back into the interpreter.
      final effectiveVisitor = visitor ?? _activeVisitor;
      if (_interfaceProxies.isNotEmpty && effectiveVisitor != null) {
        final proxyResult =
            tryCreateInterfaceProxyWithVisitor<T>(arg, effectiveVisitor);
        if (proxyResult != null) return proxyResult;
      }
    }

    // RC-3: Cross-package type coercion.
    // When the unwrapped value has the same conceptual type but from a
    // different package (e.g., painting.TextStyle vs dart:ui.TextStyle),
    // use a registered coercion to convert.
    if (unwrapped != null && _typeCoercionsByType.isNotEmpty) {
      final sourceType = unwrapped.runtimeType;
      for (final entry in _typeCoercionsByType.entries) {
        if (entry.key.sourceType == sourceType) {
          final coerced = entry.value(unwrapped);
          if (coerced is T) return coerced;
        }
      }
    }

    final actualType = arg is BridgedInstance
        ? arg.nativeObject.runtimeType
        : arg is InterpretedInstance
            ? 'InterpretedInstance(${arg.klass.name})'
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
  static T? extractBridgedArgOrNull<T>(Object? arg, String paramName,
      [InterpreterVisitor? visitor]) {
    if (arg == null) return null;
    return extractBridgedArg<T>(arg, paramName, visitor);
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
  /// Throws [ArgumentD4rtException] if the argument is missing.
  /// For nullable required parameters (e.g., `required bool? value`),
  /// null is a valid value — only absence is an error.
  static T getRequiredNamedArg<T>(
    Map<String, Object?> named,
    String paramName,
    String methodName,
  ) {
    if (!named.containsKey(paramName)) {
      throw ArgumentD4rtException(
        '$methodName: Missing required named argument "$paramName"',
      );
    }
    final value = named[paramName];
    if (value == null) return null as T;
    return extractBridgedArg<T>(value, paramName);
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
  /// The result is automatically unwrapped: [BridgedInstance] returns its
  /// [BridgedInstance.nativeObject], [BridgedEnumValue] returns its
  /// [BridgedEnumValue.nativeValue], and all other values pass through.
  /// This ensures generated bridge code casts (e.g., `as Widget`) succeed
  /// when the interpreter returns wrapped bridge values.
  ///
  /// Returns the unwrapped native result of calling the callback.
  static Object? callInterpreterCallback(
    InterpreterVisitor visitor,
    Object? callback,
    List<Object?> args, [
    Map<String, Object?> namedArgs = const {},
  ]) {
    final Object? result;
    if (callback is InterpretedFunction) {
      result = callback.call(visitor, args, namedArgs);
    } else if (callback is NativeFunction) {
      result = callback.call(visitor, args, namedArgs);
    } else if (callback is Callable) {
      result = callback.call(visitor, args, namedArgs);
    } else {
      throw ArgumentD4rtException(
        'Expected a callable function, got ${callback?.runtimeType}',
      );
    }
    return unwrapInterpreterValue(result);
  }

  /// ENG-011: Safely cast a callback result to the expected type [R].
  ///
  /// This handles the case where a generic method callback may return null
  /// but the expected type [R] may or may not be nullable. For example,
  /// `SynchronousFuture.then<R>()` where `R` could be `String` (non-nullable)
  /// or `String?` (nullable).
  ///
  /// Usage in generated bridge code:
  /// ```dart
  /// return t.then((p0) {
  ///   final result = D4.callInterpreterCallback(visitor!, fn, [p0]);
  ///   return D4.castCallbackResult<R>(result);
  /// });
  /// ```
  static R castCallbackResult<R>(Object? result) {
    if (result == null) {
      // Check if R accepts null (i.e., R is nullable like `String?`)
      // The `null is R` test returns true for nullable types.
      if (null is R) {
        return null as R;
      }
      throw ArgumentD4rtException(
        'Callback returned null but expected non-nullable type',
      );
    }
    // Attempt to cast to R - explicit cast needed for AOT
    if (result is R) {
      return result as R;
    }
    // If direct cast fails, try unwrapping bridge values
    final unwrapped = unwrapInterpreterValue(result);
    if (unwrapped is R) {
      // ignore: unnecessary_cast
      return unwrapped as R; // Explicit cast for AOT
    }
    throw ArgumentD4rtException(
      'Callback returned ${result.runtimeType}, expected $R',
    );
  }

  /// Unwrap an interpreter value to its native representation.
  ///
  /// - [BridgedInstance] → [BridgedInstance.nativeObject]
  /// - [BridgedEnumValue] → [BridgedEnumValue.nativeValue]
  /// - All other values (null, String, num, bool, List, Map, etc.)
  ///   pass through unchanged.
  ///
  /// Note: Lists and Maps are NOT recursively unwrapped because doing so
  /// destroys Dart's reified generic type information. For example,
  /// `Map<String, String>` would become `Map<Object?, Object?>` after
  /// `.map()`. If a callback returns a List/Map containing BridgedInstance
  /// values, the generated bridge code must handle the element-level
  /// unwrapping explicitly.
  static Object? unwrapInterpreterValue(Object? value) {
    if (value is BridgedInstance) {
      return value.nativeObject;
    }
    if (value is BridgedEnumValue) {
      return value.nativeValue;
    }
    return value;
  }

  // ==========================================================================
  // RC-1: Interface Proxy Helpers
  // ==========================================================================

  /// Try to create an interface proxy with a visitor context.
  ///
  /// This is the full version that can actually create proxies.
  /// Called from contexts where the visitor is available.
  static T? tryCreateInterfaceProxyWithVisitor<T>(
    InterpretedInstance instance,
    InterpreterVisitor visitor,
  ) {
    final klass = instance.klass;

    // Walk hierarchy: bridgedSuperclass, bridgedInterfaces, bridgedMixins
    final candidates = <String>[];
    if (klass.bridgedSuperclass != null) {
      candidates.add(klass.bridgedSuperclass!.name);
    }
    for (final iface in klass.bridgedInterfaces) {
      candidates.add(iface.name);
    }
    for (final mixin in klass.bridgedMixins) {
      candidates.add(mixin.name);
    }

    for (final name in candidates) {
      final factory = _interfaceProxies[name];
      if (factory != null) {
        final proxy = factory(visitor, instance);
        if (proxy is T) return proxy;
      }
    }

    return null;
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

/// Base class for user-provided relaxer factories.
///
/// Extend this class to add type argument cases to existing auto-generated
/// relaxer wrappers, or to register entirely new wrapper classes for generic
/// types not covered by generation.
///
/// Classes extending [D4UserRelaxer] are automatically excluded from bridge
/// generation (same as [D4UserBridge]).
///
/// Example:
/// ```dart
/// class ValueNotifierUserRelaxer extends D4UserRelaxer {
///   @override
///   String get baseTypeName => 'ValueNotifier';
///
///   static Object? relaxFactory(Object value, String innerTypeArg) {
///     if (value is! ValueNotifier) return null;
///     return switch (innerTypeArg) {
///       'MyCustomModel' => $RelaxedValueNotifier<MyCustomModel>(value),
///       _ => null,
///     };
///   }
/// }
/// ```
abstract class D4UserRelaxer {
  /// The unparameterized base type name this relaxer targets.
  /// E.g., 'ValueNotifier', 'Animation', 'ReactiveStream'.
  String get baseTypeName;
}

// =============================================================================
// RC-3: Type Pair Key for Coercion Map
// =============================================================================

/// Key for the type coercion map, pairing source and target [Type] objects.
class _TypePair {
  final Type sourceType;
  final Type targetType;

  const _TypePair(this.sourceType, this.targetType);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TypePair &&
          sourceType == other.sourceType &&
          targetType == other.targetType;

  @override
  int get hashCode => Object.hash(sourceType, targetType);
}
