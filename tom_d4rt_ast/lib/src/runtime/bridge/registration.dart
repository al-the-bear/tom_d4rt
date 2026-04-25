import '../exceptions.dart';
import '../interpreter_visitor.dart'; // Import InterpreterVisitor for adapters
import '../runtime_interfaces.dart'; // Import RuntimeType for type arguments
import '../runtime_types.dart'; // Import InterpretedExtension for bridge extension
import '../callable.dart'; // Import NativeExtensionCallable
import 'bridged_enum.dart';
import 'bridged_types.dart'; // Import BridgedInstance for unwrap helper

// The idea is that these functions will encapsulate the native call
// and type conversion.

/// Calls a native constructor.
typedef BridgedConstructorCallable = Object? Function(
    InterpreterVisitor
        visitor, // For potential evaluation of args or access env
    List<Object?> positionalArgs, // Interpretted arguments
    Map<String, Object?> namedArgs // Interpretted arguments
    );

/// Calls a native method/getter/setter.
typedef BridgedMethodCallable = Object? Function(
    InterpreterVisitor visitor,
    Object
        target, // The native target object (for instance methods/getters/setters)
    List<Object?> positionalArgs,
    Map<String, Object?> namedArgs);

typedef BridgedMethodAdapter = Object? Function(
    InterpreterVisitor visitor, // The current visitor
    Object target, // The native target object to call the method on
    List<Object?> positionalArguments, // Interpretted arguments
    Map<String, Object?> namedArguments, // Interpretted arguments
    List<RuntimeType>? typeArguments, // Type arguments for generic methods
    );

/// Adapter for bridged static methods.
/// Takes interpreter context, positional args, named args, type args.
/// Returns the result of the native static method call.
typedef BridgedStaticMethodAdapter = Object? Function(
    InterpreterVisitor visitor,
    List<Object?> positionalArguments,
    Map<String, Object?> namedArguments,
    List<RuntimeType>? typeArguments);

/// Adapter for bridged static getters.
/// Takes interpreter context.
/// Returns the result of the native static getter.
typedef BridgedStaticGetterAdapter = Object? Function(
    InterpreterVisitor visitor);

/// Adapter for bridged static setters.
/// Takes interpreter context, the value to set.
typedef BridgedStaticSetterAdapter = void Function(
    InterpreterVisitor visitor, Object? value);

/// Adapter for bridged instance getters.
/// Takes interpreter context, the native target object.
/// Returns the result of the native instance getter.
typedef BridgedInstanceGetterAdapter = Object? Function(
    InterpreterVisitor? visitor, Object target);

/// Adapter for bridged instance setters.
/// Takes interpreter context, the native target object, the value to set.
typedef BridgedInstanceSetterAdapter = void Function(
    InterpreterVisitor? visitor, Object target, Object? value);

class BridgedEnumDefinition<T extends Enum> {
  /// The name under which the enum will be known in the interpreter.
  final String name;

  /// The list of native enum values (e.g. `MyEnum.values`).
  final List<T> values;

  /// Adapters for instance getters on enum values.
  /// The key is the getter name.
  final Map<String, BridgedInstanceGetterAdapter> getters;

  /// Adapters for instance methods on enum values.
  /// The key is the method name.
  final Map<String, BridgedMethodAdapter> methods;

  /// Adapters for static getters on the enum type itself.
  /// These are non-constant static members like `WidgetState.any`.
  final Map<String, Object? Function()> staticGetters;

  BridgedEnumDefinition({
    required this.name,
    required this.values,
    this.getters = const {},
    this.methods = const {},
    this.staticGetters = const {},
  }) {
    // Validation: Ensure the value list is not empty
    if (values.isEmpty) {
      throw ArgumentD4rtException('Cannot bridge an enum with no values: $name');
    }
  }

  /// Builds the [BridgedEnum] object from this definition.
  BridgedEnum buildBridgedEnum() {
    // Placeholder for the main enum, will be replaced by the real instance after creation.
    // This is necessary because BridgedEnumValue needs a reference to its type,
    // but the full type (BridgedEnum) needs the value list.
    final placeholderEnum = BridgedEnum(name, {});
    final bridgedValues = <String, BridgedEnumValue>{};

    // Share instance adapters with all created values
    placeholderEnum.getters = getters;
    placeholderEnum.methods = methods;

    for (final nativeValue in values) {
      final valueName = nativeValue.name; // Use the .name getter of Dart enums
      final index = nativeValue.index;

      // Create the bridged value for this enum element, using the placeholder
      // Note: Adapters are also passed here
      final bridgedValue = BridgedEnumValue(
        placeholderEnum, // Pass the placeholder initially
        valueName,
        index,
        nativeValue, // Store the native value
        getters: getters, // Pass the adapters
        methods: methods, // Pass the adapters
      );

      bridgedValues[valueName] = bridgedValue;
    }

    // Create the main BridgedEnum object with the finalized value map.
    final bridgedEnum = BridgedEnum(name, bridgedValues);

    // Copy adapters into the final instance as well
    bridgedEnum.getters = getters;
    bridgedEnum.methods = methods;
    bridgedEnum.staticGetters = staticGetters;

    final finalBridgedValues = <String, BridgedEnumValue>{};
    for (final nativeValue in values) {
      final valueName = nativeValue.name;
      final index = nativeValue.index;
      finalBridgedValues[valueName] = BridgedEnumValue(
        bridgedEnum,
        valueName,
        index,
        nativeValue,
        getters: getters,
        methods: methods,
      );
    }

    // Update the value map in the final BridgedEnum.
    bridgedEnum.values.clear();
    bridgedEnum.values.addAll(finalBridgedValues);

    return bridgedEnum;
  }
}

/// Definition for a bridged native extension.
///
/// This is the generator-facing API for registering native Dart extensions
/// with the D4rt interpreter. The [buildInterpretedExtension] method converts
/// this definition into an [InterpretedExtension] that the runtime can use
/// for extension method resolution.
///
/// ## Example (generated code):
/// ```dart
/// BridgedExtensionDefinition(
///   name: 'StringHelpers',
///   onTypeName: 'String',
///   getters: {
///     'isPalindrome': (visitor, target) => (target as String) == (target as String).split('').reversed.join(),
///   },
///   methods: {
///     'repeat': (visitor, target, positional, named, typeArgs) {
///       return (target as String) * (positional[0] as int);
///     },
///   },
/// )
/// ```
class BridgedExtensionDefinition {
  /// The name of the extension (null for unnamed extensions).
  final String? name;

  /// The name of the type this extension applies to (e.g., 'String', 'DateTime').
  /// Resolved to a [RuntimeType] at registration time.
  final String onTypeName;

  /// Adapters for instance getters.
  final Map<String, BridgedInstanceGetterAdapter> getters;

  /// Adapters for instance setters.
  final Map<String, BridgedInstanceSetterAdapter> setters;

  /// Adapters for instance methods.
  final Map<String, BridgedMethodAdapter> methods;

  const BridgedExtensionDefinition({
    this.name,
    required this.onTypeName,
    this.getters = const {},
    this.setters = const {},
    this.methods = const {},
  });

  /// Builds an [InterpretedExtension] from this definition.
  ///
  /// The [onType] is the resolved [RuntimeType] for [onTypeName], provided
  /// by the caller (typically the module loader) after the type has been
  /// looked up in the environment.
  InterpretedExtension buildInterpretedExtension(RuntimeType onType) {
    final members = <String, Callable>{};

    // Wrap getters as NativeExtensionCallable
    for (final entry in getters.entries) {
      members[entry.key] = NativeExtensionCallable(
        name: entry.key,
        adapter: (InterpreterVisitor visitor,
            List<Object?> positionalArgs,
            Map<String, Object?> namedArgs,
            List<RuntimeType>? typeArgs) {
          final target = _unwrapBridgedEnum(positionalArgs[0]);
          return entry.value(visitor, target!);
        },
        isGetter: true,
        arity: 1,
      );
    }

    // Wrap setters as NativeExtensionCallable
    for (final entry in setters.entries) {
      members[entry.key] = NativeExtensionCallable(
        name: entry.key,
        adapter: (InterpreterVisitor visitor,
            List<Object?> positionalArgs,
            Map<String, Object?> namedArgs,
            List<RuntimeType>? typeArgs) {
          final target = _unwrapBridgedEnum(positionalArgs[0]);
          final value = positionalArgs.length > 1
              ? _unwrapBridgedEnum(positionalArgs[1])
              : null;
          entry.value(visitor, target!, value);
          return null;
        },
        isSetter: true,
        arity: 2,
      );
    }

    // Wrap methods as NativeExtensionCallable
    for (final entry in methods.entries) {
      members[entry.key] = NativeExtensionCallable(
        name: entry.key,
        adapter: (InterpreterVisitor visitor,
            List<Object?> positionalArgs,
            Map<String, Object?> namedArgs,
            List<RuntimeType>? typeArgs) {
          // Bucket #4 fix: Unwrap BridgedEnumValue → nativeValue so the
          // generated adapter (which casts target to the native interface)
          // receives the native enum, not the wrapper. Right operands of
          // operator methods (e.g. `WidgetState.a | WidgetState.b`) need
          // the same treatment.
          final target = _unwrapBridgedEnum(positionalArgs[0]);
          final methodArgs = positionalArgs
              .sublist(1)
              .map(_unwrapBridgedEnum)
              .toList();
          final unwrappedNamed = namedArgs
              .map((k, v) => MapEntry(k, _unwrapBridgedEnum(v)));
          return entry.value(
              visitor, target!, methodArgs, unwrappedNamed, typeArgs);
        },
        // Mark operator methods (e.g. `|`, `&`, `~`, `[]`, `==`) so the
        // binary/unary operator dispatch sites recognise them as operator
        // overloads rather than plain extension methods.
        isOperator: _isDartOperatorName(entry.key),
        arity: 1,
      );
    }

    return InterpretedExtension(
      name: name,
      onType: onType,
      members: members,
    );
  }
}

/// Unwraps a [BridgedEnumValue] to its underlying native enum value, and a
/// [BridgedInstance] to its underlying native object, so that generated bridge
/// adapters (which cast target/operands to the native interface) can use them
/// directly.
///
/// Bucket #4 (enums) introduced this helper for `WidgetState.a | WidgetState.b`
/// style operator dispatch. Bucket #11 extends it to [BridgedInstance] so that
/// extension members on bridged primitives — e.g. `String.characters` where
/// `String` reaches the adapter wrapped as `BridgedInstance<String>` — can
/// satisfy the adapter's `target as String` cast. This mirrors the unwrap that
/// `D4.extractBridgedArg` already performs for method arguments.
Object? _unwrapBridgedEnum(Object? value) {
  if (value is BridgedEnumValue) return value.nativeValue;
  if (value is BridgedInstance) return value.nativeObject;
  return value;
}

/// Set of method names that correspond to overloadable Dart operators.
const Set<String> _dartOperatorNames = {
  '+', '-', '*', '/', '~/', '%',
  '<<', '>>', '>>>',
  '<', '<=', '>', '>=',
  '==',
  '&', '|', '^',
  '~', // unary bitwise not
  '[]', '[]=',
  'unary-',
};

bool _isDartOperatorName(String name) => _dartOperatorNames.contains(name);
