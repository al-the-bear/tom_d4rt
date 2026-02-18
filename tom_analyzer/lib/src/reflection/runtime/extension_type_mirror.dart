/// ExtensionTypeMirror - Reflects a Dart extension type.
///
/// Extension types provide zero-cost abstraction over existing types.
library;

import 'type_mirror.dart';
import 'element.dart';
import 'method_mirror.dart';
import 'constructor_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ExtensionTypeMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a Dart extension type.
///
/// Extension types have:
/// - A representation type (the underlying type)
/// - Methods and operators
/// - Constructors
/// - Optional interfaces
abstract class ExtensionTypeMirror<T> extends TypeMirror<T> {
  @override
  ElementKind get kind => ElementKind.extensionType;

  // ─────────────────────────────────────────────────────────────────────────
  // Representation Type
  // ─────────────────────────────────────────────────────────────────────────

  /// The representation type (the underlying type being wrapped).
  TypeMirror<Object>? get representationType;

  /// The representation type as a string.
  String get representationTypeName;

  /// The name of the representation field.
  String get representationFieldName;

  // ─────────────────────────────────────────────────────────────────────────
  // Interfaces
  // ─────────────────────────────────────────────────────────────────────────

  /// Interfaces implemented by this extension type.
  List<TypeMirror<Object>> get interfaces;

  // ─────────────────────────────────────────────────────────────────────────
  // Members
  // ─────────────────────────────────────────────────────────────────────────

  /// All methods in this extension type.
  Map<String, MethodMirror<Object?>> get methods;

  /// Get a method by name.
  MethodMirror<Object?>? getMethod(String name);

  /// All constructors.
  Map<String, ConstructorMirror<T>> get constructors;

  /// Get a constructor by name.
  ConstructorMirror<T>? getConstructor(String name);

  /// Get the unnamed constructor.
  ConstructorMirror<T>? get defaultConstructor;

  // ─────────────────────────────────────────────────────────────────────────
  // Instance Creation
  // ─────────────────────────────────────────────────────────────────────────

  /// Create a new instance using a constructor.
  T newInstance(String constructor, List<dynamic> positional);

  /// Create a new instance with named parameters.
  T newInstanceNamed(
    String constructor,
    List<dynamic> positional,
    Map<Symbol, dynamic> named,
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Invocation
  // ─────────────────────────────────────────────────────────────────────────

  /// Invoke a method on an instance.
  Object? invokeMethod(
    Object instance,
    String methodName,
    List<dynamic> positional, [
    Map<Symbol, dynamic> named = const {},
  ]);
}

// ═══════════════════════════════════════════════════════════════════════════
// ExtensionTypeMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [ExtensionTypeMirror] elements.
class ExtensionTypeMirrorFilter<T> {
  /// Filter function.
  final bool Function(ExtensionTypeMirror<T>)? filter;

  const ExtensionTypeMirrorFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(ExtensionTypeMirror<T> extType) {
    return filter?.call(extType) ?? true;
  }

  /// Filter by representation type name.
  static ExtensionTypeMirrorFilter<T> representsType<T>(String typeName) =>
      ExtensionTypeMirrorFilter<T>(
        filter: (e) => e.representationTypeName == typeName,
      );

  /// Filter for extension types with a specific method.
  static ExtensionTypeMirrorFilter<T> hasMethod<T>(String name) =>
      ExtensionTypeMirrorFilter<T>(
        filter: (e) => e.methods.containsKey(name),
      );

  /// Filter for extension types with a specific constructor.
  static ExtensionTypeMirrorFilter<T> hasConstructor<T>(String name) =>
      ExtensionTypeMirrorFilter<T>(
        filter: (e) => e.constructors.containsKey(name),
      );

  /// Filter for extension types with interfaces.
  static ExtensionTypeMirrorFilter<T> hasInterfaces<T>() =>
      ExtensionTypeMirrorFilter<T>(
        filter: (e) => e.interfaces.isNotEmpty,
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// ExtensionTypeMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [ExtensionTypeMirror] elements.
class ExtensionTypeMirrorProcessor<T> {
  /// Process any extension type mirror.
  final void Function(ExtensionTypeMirror<T>)? process;

  const ExtensionTypeMirrorProcessor({this.process});

  /// Execute the processor.
  void execute(ExtensionTypeMirror<T> extType) {
    process?.call(extType);
  }
}
