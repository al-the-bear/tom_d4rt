/// ClassMirror - Reflects a Dart class.
///
/// Provides access to class members (methods, fields, getters, setters,
/// constructors), type relationships (superclass, interfaces, mixins),
/// and instance creation.
library;

import 'type_mirror.dart';
import 'method_mirror.dart';
import 'field_mirror.dart';
import 'constructor_mirror.dart';
import 'mixin_mirror.dart';
import 'extension_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ClassMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a Dart class.
///
/// Provides comprehensive access to:
/// - Type information (superclass, interfaces, mixins)
/// - Class modifiers (abstract, sealed, final, base, interface)
/// - Instance and static members
/// - Constructors and instance creation
/// - Collection factories
abstract class ClassMirror<T> extends TypeMirror<T> {
  // ─────────────────────────────────────────────────────────────────────────
  // Type Relationships
  // ─────────────────────────────────────────────────────────────────────────

  /// Superclass mirror (null for Object).
  ClassMirror<Object>? get superclass;

  /// Implemented interfaces.
  List<ClassMirror<Object>> get interfaces;

  /// Applied mixins.
  List<MixinMirror<Object>> get mixins;

  /// Check if [object] is an instance of T.
  bool isInstanceOf(Object? object);

  /// Check if this class implements the given interface.
  bool implementsInterface(ClassMirror<Object> interface);

  /// Check if this class uses the given mixin.
  bool hasMixin(MixinMirror<Object> mixin);

  // ─────────────────────────────────────────────────────────────────────────
  // Extension Support
  // ─────────────────────────────────────────────────────────────────────────

  /// All extensions that apply to this class.
  List<ExtensionMirror<T>> get applicableExtensions;

  /// Check if the given extension applies to this class.
  bool hasExtension(ExtensionMirror<Object> extension);

  /// Find an extension by name that applies to this class.
  ExtensionMirror<T>? findApplicableExtension(String name);

  // ─────────────────────────────────────────────────────────────────────────
  // Instance Methods
  // ─────────────────────────────────────────────────────────────────────────

  /// All instance methods (inherited + declared).
  Map<String, MethodMirror<Object?>> get instanceMethods;

  /// Get an instance method by name.
  MethodMirror<Object?>? getInstanceMethod(String name);

  /// Filter instance methods.
  Iterable<MethodMirror<Object?>> filterInstanceMethods(
    bool Function(MethodMirror<Object?>) filter,
  );

  /// Process instance methods.
  void processInstanceMethods(
    void Function(MethodMirror<Object?>) processor,
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Static Methods
  // ─────────────────────────────────────────────────────────────────────────

  /// All static methods (excludes factory constructors).
  Map<String, MethodMirror<Object?>> get staticMethods;

  /// Get a static method by name.
  MethodMirror<Object?>? getStaticMethod(String name);

  /// Filter static methods.
  Iterable<MethodMirror<Object?>> filterStaticMethods(
    bool Function(MethodMirror<Object?>) filter,
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Instance Fields
  // ─────────────────────────────────────────────────────────────────────────

  /// All instance fields.
  Map<String, FieldMirror<Object?>> get instanceFields;

  /// Get an instance field by name.
  FieldMirror<Object?>? getInstanceField(String name);

  /// Filter instance fields.
  Iterable<FieldMirror<Object?>> filterInstanceFields(
    bool Function(FieldMirror<Object?>) filter,
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Static Fields
  // ─────────────────────────────────────────────────────────────────────────

  /// All static fields.
  Map<String, FieldMirror<Object?>> get staticFields;

  /// Get a static field by name.
  FieldMirror<Object?>? getStaticField(String name);

  /// Filter static fields.
  Iterable<FieldMirror<Object?>> filterStaticFields(
    bool Function(FieldMirror<Object?>) filter,
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Constructors
  // ─────────────────────────────────────────────────────────────────────────

  /// All constructors (including factory constructors).
  Map<String, ConstructorMirror<T>> get constructors;

  /// Get a constructor by name.
  ///
  /// Use '' (empty string) for the unnamed constructor.
  ConstructorMirror<T>? getConstructor(String name);

  /// Get the unnamed constructor.
  ConstructorMirror<T>? get defaultConstructor;

  // ─────────────────────────────────────────────────────────────────────────
  // Instance Creation
  // ─────────────────────────────────────────────────────────────────────────

  /// Create a new instance using a constructor.
  ///
  /// Use '' (empty string) for the unnamed constructor.
  ///
  /// ```dart
  /// // Using unnamed constructor
  /// final user = cls.newInstance('', ['Alice', 30]);
  ///
  /// // Using named constructor
  /// final admin = cls.newInstance('admin', ['Bob']);
  ///
  /// // Using named parameters
  /// final guest = cls.newInstanceNamed('', [], {#name: 'Guest'});
  /// ```
  T newInstance(String constructor, List<dynamic> positional);

  /// Create a new instance with named parameters.
  T newInstanceNamed(
    String constructor,
    List<dynamic> positional,
    Map<Symbol, dynamic> named,
  );

  /// Create a new instance from a map of arguments.
  ///
  /// Arguments are matched to constructor parameters by name.
  T newInstanceFromMap(String constructor, Map<String, dynamic> args);

  // ─────────────────────────────────────────────────────────────────────────
  // Method Invocation
  // ─────────────────────────────────────────────────────────────────────────

  /// Invoke an instance method.
  Object? invokeMethod(
    Object instance,
    String methodName,
    List<dynamic> positional, [
    Map<Symbol, dynamic> named = const {},
  ]);

  /// Invoke a static method.
  Object? invokeStaticMethod(
    String methodName,
    List<dynamic> positional, [
    Map<Symbol, dynamic> named = const {},
  ]);

  // ─────────────────────────────────────────────────────────────────────────
  // Field Access
  // ─────────────────────────────────────────────────────────────────────────

  /// Get the value of an instance field.
  Object? getFieldValue(Object instance, String fieldName);

  /// Set the value of an instance field.
  void setFieldValue(Object instance, String fieldName, Object? value);

  /// Get the value of a static field.
  Object? getStaticFieldValue(String fieldName);

  /// Set the value of a static field.
  void setStaticFieldValue(String fieldName, Object? value);

  // ─────────────────────────────────────────────────────────────────────────
  // Property Introspection
  // ─────────────────────────────────────────────────────────────────────────

  /// Check if the given property is read-only (no setter, or final field).
  bool isPropertyReadOnly(String name);

  /// Check if the given static property is read-only.
  bool isStaticPropertyReadOnly(String name);

  // ─────────────────────────────────────────────────────────────────────────
  // Collection Factories
  // ─────────────────────────────────────────────────────────────────────────

  /// Create an empty growable `List<T>`.
  @override
  List<T> createGrowableList();

  /// Create a fixed-length `List<T>` filled with [fill].
  @override
  List<T> createList(int length, {T? fill});

  /// Create an empty `Set<T>`.
  @override
  Set<T> createSet();

  /// Create an empty Map with String keys and T values.
  Map<String, T> createStringKeyedMap();

  /// Create an empty Map with T keys and Object? values.
  Map<T, Object?> createKeyedMap();
}

// ═══════════════════════════════════════════════════════════════════════════
// ClassMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [ClassMirror] elements.
class ClassMirrorFilter<T> {
  /// Filter function.
  final bool Function(ClassMirror<T>)? filter;

  const ClassMirrorFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(ClassMirror<T> cls) {
    return filter?.call(cls) ?? true;
  }

  /// Filter for abstract classes.
  static ClassMirrorFilter<T> abstract_<T>() => ClassMirrorFilter<T>(
        filter: (c) => c.isAbstract,
      );

  /// Filter for concrete classes.
  static ClassMirrorFilter<T> concrete<T>() => ClassMirrorFilter<T>(
        filter: (c) => !c.isAbstract,
      );

  /// Filter for sealed classes.
  static ClassMirrorFilter<T> sealed<T>() => ClassMirrorFilter<T>(
        filter: (c) => c.isSealed,
      );

  /// Filter for final classes.
  static ClassMirrorFilter<T> final_<T>() => ClassMirrorFilter<T>(
        filter: (c) => c.isFinal,
      );

  /// Filter for interface classes.
  static ClassMirrorFilter<T> interface_<T>() => ClassMirrorFilter<T>(
        filter: (c) => c.isInterface,
      );

  /// Filter for mixin classes.
  static ClassMirrorFilter<T> mixinClass<T>() => ClassMirrorFilter<T>(
        filter: (c) => c.isMixinClass,
      );

  /// Filter for classes with a specific method.
  static ClassMirrorFilter<T> hasMethod<T>(String name) => ClassMirrorFilter<T>(
        filter: (c) => c.instanceMethods.containsKey(name),
      );

  /// Filter for classes with a specific field.
  static ClassMirrorFilter<T> hasField<T>(String name) => ClassMirrorFilter<T>(
        filter: (c) => c.instanceFields.containsKey(name),
      );

  /// Filter for classes with a specific constructor.
  static ClassMirrorFilter<T> hasConstructor<T>(String name) =>
      ClassMirrorFilter<T>(
        filter: (c) => c.constructors.containsKey(name),
      );

  /// Filter for classes with the unnamed constructor.
  static ClassMirrorFilter<T> hasDefaultConstructor<T>() =>
      ClassMirrorFilter<T>(
        filter: (c) => c.defaultConstructor != null,
      );

  /// Filter for classes that implement a specific interface.
  static ClassMirrorFilter<T> implementsType<T, I>() => ClassMirrorFilter<T>(
        filter: (c) => c.interfaces.any((i) => i.reflectedType == I),
      );

  /// Filter for classes with a specific mixin.
  static ClassMirrorFilter<T> withMixin<T, M>() => ClassMirrorFilter<T>(
        filter: (c) => c.mixins.any((m) => m.reflectedType == M),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// ClassMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [ClassMirror] elements.
class ClassMirrorProcessor<T> {
  /// Process any class mirror.
  final void Function(ClassMirror<T>)? process;

  const ClassMirrorProcessor({this.process});

  /// Execute the processor.
  void execute(ClassMirror<T> cls) {
    process?.call(cls);
  }
}
