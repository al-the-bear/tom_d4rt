import '../exceptions.dart';
import '../interpreter_visitor.dart'; // Import InterpreterVisitor for adapters
import '../runtime_interfaces.dart'; // Import RuntimeType for type arguments
import '../runtime_types.dart'; // Import InterpretedExtension for bridge extension
import '../callable.dart'; // Import NativeExtensionCallable
import 'bridged_enum.dart';

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

  BridgedEnumDefinition({
    required this.name,
    required this.values,
    this.getters = const {},
    this.methods = const {},
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
          final target = positionalArgs[0];
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
          final target = positionalArgs[0];
          final value = positionalArgs.length > 1 ? positionalArgs[1] : null;
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
          final target = positionalArgs[0];
          final methodArgs = positionalArgs.sublist(1);
          return entry.value(visitor, target!, methodArgs, namedArgs, typeArgs);
        },
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
