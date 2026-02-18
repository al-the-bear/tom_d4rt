/// ReflectionApi - Main entry point for the reflection system.
///
/// Provides type lookup, filtering, and processing capabilities.
library;

import 'element.dart';
import 'typed.dart';
import 'invokable.dart';
import 'owned_element.dart';
import 'generic_element.dart';
import 'accessible.dart';

import 'type_mirror.dart';
import 'class_mirror.dart';
import 'enum_mirror.dart';
import 'mixin_mirror.dart';
import 'extension_mirror.dart';
import 'extension_type_mirror.dart';
import 'type_alias_mirror.dart';

import 'method_mirror.dart';
import 'field_mirror.dart';
import 'constructor_mirror.dart';
import 'getter_setter_mirror.dart';
import 'reflection_data.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ReflectionApi
// ═══════════════════════════════════════════════════════════════════════════

/// Main entry point for the reflection system.
///
/// Provides comprehensive access to:
/// - Type lookup by Dart type or name
/// - Instance reflection
/// - Filtering and processing of types and members
/// - Scoped APIs for packages and libraries
/// - Trait-based element processing
abstract class ReflectionApi {
  /// Create a reflection API from generated data.
  ///
  /// Note: This factory method requires a concrete implementation to be
  /// provided. Use the generator to create a ReflectionApi implementation.
  static ReflectionApi fromData(ReflectionData data) {
    // TODO: Replace with generated implementation
    throw UnimplementedError(
      'ReflectionApi.fromData requires a generated implementation. '
      'Use the reflection generator to create a concrete ReflectionApi.',
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // Type Lookup by Dart Type (compile-time type known)
  // ═══════════════════════════════════════════════════════════════════════

  /// Get the ClassMirror for a Dart type (compile-time type known).
  ClassMirror<T>? findClassByType<T>();

  /// Get the EnumMirror for a Dart type.
  EnumMirror<T>? findEnumByType<T extends Enum>();

  /// Get the MixinMirror for a Dart type.
  MixinMirror<T>? findMixinByType<T>();

  /// Get the ExtensionTypeMirror for a Dart type.
  ExtensionTypeMirror<T>? findExtensionTypeByType<T>();

  /// Get any TypeMirror for a Dart type.
  TypeMirror<T>? findTypeByType<T>();

  // ═══════════════════════════════════════════════════════════════════════
  // Type Lookup by Name (runtime name lookup)
  // ═══════════════════════════════════════════════════════════════════════

  /// Find a class by name.
  ///
  /// Accepts either:
  /// - Short name: "MyClass"
  /// - Qualified name: "package:my_pkg/file.dart.MyClass"
  ///
  /// Throws [AmbiguousNameError] if short name is not unique.
  ClassMirror<Object>? findClassByName(String name);

  /// Find an enum by name.
  EnumMirror<Object>? findEnumByName(String name);

  /// Find a mixin by name.
  MixinMirror<Object>? findMixinByName(String name);

  /// Find an extension type by name.
  ExtensionTypeMirror<Object>? findExtensionTypeByName(String name);

  /// Find a type alias by name.
  TypeAliasMirror? findTypeAliasByName(String name);

  /// Find an extension by name.
  ExtensionMirror<Object>? findExtensionByName(String name);

  /// Find all types matching a short name (for ambiguous names).
  List<TypeMirror<Object>> findAllByName(String shortName);

  /// Check if a short name is unique among all types.
  bool isUniqueName(String shortName);

  // ═══════════════════════════════════════════════════════════════════════
  // Instance Reflection
  // ═══════════════════════════════════════════════════════════════════════

  /// Get the ClassMirror for an object's runtime type.
  ClassMirror<Object>? reflectInstance(Object instance);

  // ═══════════════════════════════════════════════════════════════════════
  // All Types - Access
  // ═══════════════════════════════════════════════════════════════════════

  /// All classes in the reflection system.
  List<ClassMirror<Object>> get allClasses;

  /// All enums in the reflection system.
  List<EnumMirror<Object>> get allEnums;

  /// All mixins in the reflection system.
  List<MixinMirror<Object>> get allMixins;

  /// All extension types in the reflection system.
  List<ExtensionTypeMirror<Object>> get allExtensionTypes;

  /// All extensions in the reflection system.
  List<ExtensionMirror<Object>> get allExtensions;

  /// All type aliases in the reflection system.
  List<TypeAliasMirror> get allTypeAliases;

  // ═══════════════════════════════════════════════════════════════════════
  // All Types - Filter and Process
  // ═══════════════════════════════════════════════════════════════════════

  /// Filter classes matching the predicate.
  Iterable<ClassMirror<Object>> filterClasses(
    bool Function(ClassMirror<Object>) filter,
  );

  /// Process all classes.
  void processClasses(void Function(ClassMirror<Object>) processor);

  /// Process classes matching the filter.
  void processClassesWhere(
    bool Function(ClassMirror<Object>) filter,
    void Function(ClassMirror<Object>) processor,
  );

  /// Filter enums matching the predicate.
  Iterable<EnumMirror<Object>> filterEnums(
    bool Function(EnumMirror<Object>) filter,
  );

  /// Process all enums.
  void processEnums(void Function(EnumMirror<Object>) processor);

  /// Filter mixins matching the predicate.
  Iterable<MixinMirror<Object>> filterMixins(
    bool Function(MixinMirror<Object>) filter,
  );

  /// Process all mixins.
  void processMixins(void Function(MixinMirror<Object>) processor);

  // ═══════════════════════════════════════════════════════════════════════
  // Global Members - Access
  // ═══════════════════════════════════════════════════════════════════════

  /// All global methods (top-level functions).
  List<MethodMirror<Object?>> get allGlobalMethods;

  /// All global fields (top-level variables).
  List<FieldMirror<Object?>> get allGlobalFields;

  /// All global getters.
  List<GetterMirror<Object?>> get allGlobalGetters;

  /// All global setters.
  List<SetterMirror<Object?>> get allGlobalSetters;

  // ═══════════════════════════════════════════════════════════════════════
  // Global Members - Lookup
  // ═══════════════════════════════════════════════════════════════════════

  /// Find a global method by name.
  MethodMirror<Object?>? findGlobalMethod(String name);

  /// Find a global field by name.
  FieldMirror<Object?>? findGlobalField(String name);

  /// Find a global getter by name.
  GetterMirror<Object?>? findGlobalGetter(String name);

  /// Find a global setter by name.
  SetterMirror<Object?>? findGlobalSetter(String name);

  // ═══════════════════════════════════════════════════════════════════════
  // Global Members - Filter and Process
  // ═══════════════════════════════════════════════════════════════════════

  /// Filter global methods.
  Iterable<MethodMirror<Object?>> filterGlobalMethods(
    bool Function(MethodMirror<Object?>) filter,
  );

  /// Process global methods.
  void processGlobalMethods(void Function(MethodMirror<Object?>) processor);

  /// Filter global fields.
  Iterable<FieldMirror<Object?>> filterGlobalFields(
    bool Function(FieldMirror<Object?>) filter,
  );

  /// Process global fields.
  void processGlobalFields(void Function(FieldMirror<Object?>) processor);

  // ═══════════════════════════════════════════════════════════════════════
  // All Members (class + global combined)
  // ═══════════════════════════════════════════════════════════════════════

  /// All methods (instance, static, and global).
  Iterable<MethodMirror<Object?>> get allMethods;

  /// All fields (instance, static, and global).
  Iterable<FieldMirror<Object?>> get allFields;

  /// All getters (instance, static, and global).
  Iterable<GetterMirror<Object?>> get allGetters;

  /// All setters (instance, static, and global).
  Iterable<SetterMirror<Object?>> get allSetters;

  /// All constructors across all classes.
  Iterable<ConstructorMirror<Object>> get allConstructors;

  /// Filter all methods (class + global).
  Iterable<MethodMirror<Object?>> filterAllMethods(
    bool Function(MethodMirror<Object?>) filter,
  );

  /// Process all methods (class + global).
  void processAllMethods(void Function(MethodMirror<Object?>) processor);

  /// Filter all fields (class + global).
  Iterable<FieldMirror<Object?>> filterAllFields(
    bool Function(FieldMirror<Object?>) filter,
  );

  /// Process all fields (class + global).
  void processAllFields(void Function(FieldMirror<Object?>) processor);

  // ═══════════════════════════════════════════════════════════════════════
  // Scoped APIs
  // ═══════════════════════════════════════════════════════════════════════

  /// Get a package-scoped API.
  PackageApi forPackage(String package);

  /// Get a library-scoped API.
  LibraryApi forLibrary(String libraryUri);

  /// Get all packages with reflected types.
  List<String> get packages;

  /// Get all libraries with reflected types.
  List<String> get libraries;

  // ═══════════════════════════════════════════════════════════════════════
  // Trait-Based Processing
  // ═══════════════════════════════════════════════════════════════════════

  /// Filter typed elements.
  Iterable<Typed<Object>> filterTyped(TypedFilter<Object> filter);

  /// Process typed elements.
  void processTyped(
    TypedFilter<Object> filter,
    TypedProcessor<Object> processor,
  );

  /// Filter invokable elements.
  Iterable<Invokable<Object?>> filterInvokable(InvokableFilter<Object?> filter);

  /// Process invokable elements.
  void processInvokable(
    InvokableFilter<Object?> filter,
    InvokableProcessor<Object?> processor,
  );

  /// Filter owned elements.
  Iterable<OwnedElement> filterOwned(OwnedElementFilter filter);

  /// Process owned elements.
  void processOwned(OwnedElementFilter filter, OwnedElementProcessor processor);

  /// Filter generic elements.
  Iterable<GenericElement> filterGeneric(GenericElementFilter filter);

  /// Process generic elements.
  void processGeneric(
    GenericElementFilter filter,
    GenericElementProcessor processor,
  );

  /// Filter accessible elements.
  Iterable<Accessible<Object?>> filterAccessible(AccessibleFilter<Object?> filter);

  /// Process accessible elements.
  void processAccessible(
    AccessibleFilter<Object?> filter,
    AccessibleProcessor<Object?> processor,
  );

  // ═══════════════════════════════════════════════════════════════════════
  // Element-Based Processing
  // ═══════════════════════════════════════════════════════════════════════

  /// All reflection elements (types, members, parameters).
  Iterable<Element> get allElements;

  /// All type elements (classes, enums, mixins, etc.).
  Iterable<Element> get allTypeElements;

  /// Filter all elements.
  Iterable<Element> filterElements(ElementFilter filter);

  /// Process all elements.
  void processElements(ElementFilter filter, ElementProcessor processor);
}

// ═══════════════════════════════════════════════════════════════════════════
// PackageApi
// ═══════════════════════════════════════════════════════════════════════════

/// Scoped API for a specific package.
abstract class PackageApi {
  /// The package name.
  String get package;

  /// All classes in this package.
  List<ClassMirror<Object>> get classes;

  /// All enums in this package.
  List<EnumMirror<Object>> get enums;

  /// All mixins in this package.
  List<MixinMirror<Object>> get mixins;

  /// All extensions in this package.
  List<ExtensionMirror<Object>> get extensions;

  /// All extension types in this package.
  List<ExtensionTypeMirror<Object>> get extensionTypes;

  /// All type aliases in this package.
  List<TypeAliasMirror> get typeAliases;

  /// All global methods in this package.
  List<MethodMirror<Object?>> get globalMethods;

  /// All global fields in this package.
  List<FieldMirror<Object?>> get globalFields;

  /// All libraries in this package.
  List<String> get libraries;
}

// ═══════════════════════════════════════════════════════════════════════════
// LibraryApi
// ═══════════════════════════════════════════════════════════════════════════

/// Scoped API for a specific library.
abstract class LibraryApi {
  /// The library URI.
  String get libraryUri;

  /// The package this library belongs to.
  String get package;

  /// All classes in this library.
  List<ClassMirror<Object>> get classes;

  /// All enums in this library.
  List<EnumMirror<Object>> get enums;

  /// All mixins in this library.
  List<MixinMirror<Object>> get mixins;

  /// All extensions in this library.
  List<ExtensionMirror<Object>> get extensions;

  /// All extension types in this library.
  List<ExtensionTypeMirror<Object>> get extensionTypes;

  /// All type aliases in this library.
  List<TypeAliasMirror> get typeAliases;

  /// All global methods in this library.
  List<MethodMirror<Object?>> get globalMethods;

  /// All global fields in this library.
  List<FieldMirror<Object?>> get globalFields;

  /// All global getters in this library.
  List<GetterMirror<Object?>> get globalGetters;

  /// All global setters in this library.
  List<SetterMirror<Object?>> get globalSetters;
}

// ═══════════════════════════════════════════════════════════════════════════
// ReflectionApiBase - Helper Mixin
// ═══════════════════════════════════════════════════════════════════════════

/// Base mixin providing default implementations for common operations.
mixin ReflectionApiBase implements ReflectionApi {
  @override
  Iterable<ClassMirror<Object>> filterClasses(
    bool Function(ClassMirror<Object>) filter,
  ) {
    return allClasses.where(filter);
  }

  @override
  void processClasses(void Function(ClassMirror<Object>) processor) {
    for (final cls in allClasses) {
      processor(cls);
    }
  }

  @override
  void processClassesWhere(
    bool Function(ClassMirror<Object>) filter,
    void Function(ClassMirror<Object>) processor,
  ) {
    for (final cls in allClasses.where(filter)) {
      processor(cls);
    }
  }

  @override
  Iterable<EnumMirror<Object>> filterEnums(
    bool Function(EnumMirror<Object>) filter,
  ) {
    return allEnums.where(filter);
  }

  @override
  void processEnums(void Function(EnumMirror<Object>) processor) {
    for (final e in allEnums) {
      processor(e);
    }
  }

  @override
  Iterable<MixinMirror<Object>> filterMixins(
    bool Function(MixinMirror<Object>) filter,
  ) {
    return allMixins.where(filter);
  }

  @override
  void processMixins(void Function(MixinMirror<Object>) processor) {
    for (final m in allMixins) {
      processor(m);
    }
  }

  @override
  Iterable<MethodMirror<Object?>> filterGlobalMethods(
    bool Function(MethodMirror<Object?>) filter,
  ) {
    return allGlobalMethods.where(filter);
  }

  @override
  void processGlobalMethods(void Function(MethodMirror<Object?>) processor) {
    for (final m in allGlobalMethods) {
      processor(m);
    }
  }

  @override
  Iterable<FieldMirror<Object?>> filterGlobalFields(
    bool Function(FieldMirror<Object?>) filter,
  ) {
    return allGlobalFields.where(filter);
  }

  @override
  void processGlobalFields(void Function(FieldMirror<Object?>) processor) {
    for (final f in allGlobalFields) {
      processor(f);
    }
  }

  @override
  Iterable<MethodMirror<Object?>> filterAllMethods(
    bool Function(MethodMirror<Object?>) filter,
  ) {
    return allMethods.where(filter);
  }

  @override
  void processAllMethods(void Function(MethodMirror<Object?>) processor) {
    for (final m in allMethods) {
      processor(m);
    }
  }

  @override
  Iterable<FieldMirror<Object?>> filterAllFields(
    bool Function(FieldMirror<Object?>) filter,
  ) {
    return allFields.where(filter);
  }

  @override
  void processAllFields(void Function(FieldMirror<Object?>) processor) {
    for (final f in allFields) {
      processor(f);
    }
  }

  @override
  Iterable<Element> filterElements(ElementFilter filter) {
    return allElements.where(filter.evaluate);
  }

  @override
  void processElements(ElementFilter filter, ElementProcessor processor) {
    for (final e in allElements.where(filter.evaluate)) {
      processor.execute(e);
    }
  }
}
