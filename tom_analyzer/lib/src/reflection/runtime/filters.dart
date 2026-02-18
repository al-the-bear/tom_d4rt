/// Specialized filters for reflection elements.
///
/// Provides static factory methods for creating common filter predicates.
library;

import 'class_mirror.dart';
import 'enum_mirror.dart';
import 'mixin_mirror.dart';
import 'extension_mirror.dart';
import 'extension_type_mirror.dart';
import 'type_mirror.dart';
import 'type_alias_mirror.dart';
import 'method_mirror.dart';
import 'field_mirror.dart';
import 'getter_setter_mirror.dart';
import 'constructor_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ClassFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Static factory methods for creating [ClassMirror] filter predicates.
///
/// Example:
/// ```dart
/// final widgets = reflectionApi.filterClasses(
///   ClassFilter.and([
///     ClassFilter.extendsClass(widgetMirror),
///     ClassFilter.isConcrete,
///   ]),
/// );
/// ```
class ClassFilter {
  ClassFilter._();

  /// Filter by annotation type.
  static bool Function(ClassMirror<Object>) hasAnnotationType<T>() =>
      (cls) => cls.hasAnnotation<T>();

  /// Filter by annotation instance equality.
  static bool Function(ClassMirror<Object>) hasAnnotationInstance(
    Object annotation,
  ) =>
      (cls) => cls.annotations.any((a) => a.value == annotation);

  /// Filter by superclass (checks if class extends the given superclass).
  ///
  /// This checks the class hierarchy, not just direct superclass.
  static bool Function(ClassMirror<Object>) extendsClass(
    ClassMirror<Object> superclass,
  ) =>
      (cls) {
        ClassMirror<Object>? current = cls.superclass;
        while (current != null) {
          if (current.qualifiedName == superclass.qualifiedName) {
            return true;
          }
          current = current.superclass;
        }
        return false;
      };

  /// Filter by interface implementation.
  static bool Function(ClassMirror<Object>) implementsInterface(
    ClassMirror<Object> interface,
  ) =>
      (cls) => cls.implementsInterface(interface);

  /// Filter by mixin usage.
  static bool Function(ClassMirror<Object>) usesMixin(
    MixinMirror<Object> mixin,
  ) =>
      (cls) => cls.hasMixin(mixin);

  /// Filter abstract classes.
  static bool Function(ClassMirror<Object>) get isAbstract =>
      (cls) => cls.isAbstract;

  /// Filter concrete (non-abstract) classes.
  static bool Function(ClassMirror<Object>) get isConcrete =>
      (cls) => !cls.isAbstract;

  /// Filter sealed classes.
  static bool Function(ClassMirror<Object>) get isSealed =>
      (cls) => cls.isSealed;

  /// Filter final classes.
  static bool Function(ClassMirror<Object>) get isFinal =>
      (cls) => cls.isFinal;

  /// Filter interface classes.
  static bool Function(ClassMirror<Object>) get isInterface =>
      (cls) => cls.isInterface;

  /// Filter mixin classes.
  static bool Function(ClassMirror<Object>) get isMixinClass =>
      (cls) => cls.isMixinClass;

  /// Filter by package.
  static bool Function(ClassMirror<Object>) inPackage(String package) =>
      (cls) => cls.package == package;

  /// Filter by library.
  static bool Function(ClassMirror<Object>) inLibrary(String libraryUri) =>
      (cls) => cls.libraryUri == libraryUri;

  /// Filter by name pattern.
  static bool Function(ClassMirror<Object>) nameMatches(RegExp pattern) =>
      (cls) => pattern.hasMatch(cls.name);

  /// Filter by exact name.
  static bool Function(ClassMirror<Object>) named(String name) =>
      (cls) => cls.name == name;

  /// Combine filters with AND.
  static bool Function(ClassMirror<Object>) and(
    List<bool Function(ClassMirror<Object>)> filters,
  ) =>
      (cls) => filters.every((f) => f(cls));

  /// Combine filters with OR.
  static bool Function(ClassMirror<Object>) or(
    List<bool Function(ClassMirror<Object>)> filters,
  ) =>
      (cls) => filters.any((f) => f(cls));

  /// Negate a filter.
  static bool Function(ClassMirror<Object>) not(
    bool Function(ClassMirror<Object>) filter,
  ) =>
      (cls) => !filter(cls);
}

// ═══════════════════════════════════════════════════════════════════════════
// MethodFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Static factory methods for creating [MethodMirror] filter predicates.
///
/// Example:
/// ```dart
/// final asyncMethods = classMirror.filterMethods(
///   MethodFilter.and([
///     MethodFilter.isInstance,
///     (m) => m.isAsync,
///   ]),
/// );
/// ```
class MethodFilter {
  MethodFilter._();

  /// Filter by annotation type.
  static bool Function(MethodMirror<Object?>) hasAnnotationType<T>() =>
      (m) => m.hasAnnotation<T>();

  /// Filter instance methods only.
  static bool Function(MethodMirror<Object?>) get isInstance =>
      (m) => !m.isStatic && !m.isGlobal;

  /// Filter static methods only.
  static bool Function(MethodMirror<Object?>) get isStatic =>
      (m) => m.isStatic && !m.isGlobal;

  /// Filter global methods only.
  static bool Function(MethodMirror<Object?>) get isGlobal => (m) => m.isGlobal;

  /// Filter async methods.
  static bool Function(MethodMirror<Object?>) get isAsync => (m) => m.isAsync;

  /// Filter sync methods.
  static bool Function(MethodMirror<Object?>) get isSync => (m) => !m.isAsync;

  /// Filter generator methods.
  static bool Function(MethodMirror<Object?>) get isGenerator =>
      (m) => m.isGenerator;

  /// Filter by return type name.
  static bool Function(MethodMirror<Object?>) returnsTypeName(String typeName) =>
      (m) => m.returnTypeName == typeName;

  /// Filter void-returning methods.
  static bool Function(MethodMirror<Object?>) get returnsVoid =>
      (m) => m.returnTypeName == 'void';

  /// Filter by parameter count.
  static bool Function(MethodMirror<Object?>) hasParameterCount(int count) =>
      (m) => m.parameters.length == count;

  /// Filter by minimum parameter count.
  static bool Function(MethodMirror<Object?>) hasMinParameters(int count) =>
      (m) => m.parameters.length >= count;

  /// Filter by maximum parameter count.
  static bool Function(MethodMirror<Object?>) hasMaxParameters(int count) =>
      (m) => m.parameters.length <= count;

  /// Filter by required parameter count.
  static bool Function(MethodMirror<Object?>) hasRequiredParameters(
    int count,
  ) =>
      (m) => m.parameters.where((p) => p.isRequired).length == count;

  /// Filter by name pattern.
  static bool Function(MethodMirror<Object?>) nameMatches(RegExp pattern) =>
      (m) => pattern.hasMatch(m.name);

  /// Filter by exact name.
  static bool Function(MethodMirror<Object?>) named(String name) =>
      (m) => m.name == name;

  /// Filter by owner class.
  static bool Function(MethodMirror<Object?>) inClass(
    ClassMirror<Object> cls,
  ) =>
      (m) => m.owner == cls;

  /// Filter by package.
  static bool Function(MethodMirror<Object?>) inPackage(String package) =>
      (m) => m.package == package;

  /// Combine filters with AND.
  static bool Function(MethodMirror<Object?>) and(
    List<bool Function(MethodMirror<Object?>)> filters,
  ) =>
      (m) => filters.every((f) => f(m));

  /// Combine filters with OR.
  static bool Function(MethodMirror<Object?>) or(
    List<bool Function(MethodMirror<Object?>)> filters,
  ) =>
      (m) => filters.any((f) => f(m));

  /// Negate a filter.
  static bool Function(MethodMirror<Object?>) not(
    bool Function(MethodMirror<Object?>) filter,
  ) =>
      (m) => !filter(m);
}

// ═══════════════════════════════════════════════════════════════════════════
// FieldFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Static factory methods for creating [FieldMirror] filter predicates.
///
/// Example:
/// ```dart
/// final mutableFields = classMirror.filterFields(FieldFilter.isMutable);
/// ```
class FieldFilter {
  FieldFilter._();

  /// Filter by annotation type.
  static bool Function(FieldMirror<Object?>) hasAnnotationType<T>() =>
      (f) => f.hasAnnotation<T>();

  /// Filter instance fields only.
  static bool Function(FieldMirror<Object?>) get isInstance =>
      (f) => !f.isStatic && !f.isGlobal;

  /// Filter static fields only.
  static bool Function(FieldMirror<Object?>) get isStatic =>
      (f) => f.isStatic && !f.isGlobal;

  /// Filter global fields only.
  static bool Function(FieldMirror<Object?>) get isGlobal => (f) => f.isGlobal;

  /// Filter read-only fields (final or const).
  static bool Function(FieldMirror<Object?>) get isReadOnly =>
      (f) => f.isFinal || f.isConst;

  /// Filter mutable fields.
  static bool Function(FieldMirror<Object?>) get isMutable =>
      (f) => !f.isFinal && !f.isConst;

  /// Filter final fields.
  static bool Function(FieldMirror<Object?>) get isFinal => (f) => f.isFinal;

  /// Filter const fields.
  static bool Function(FieldMirror<Object?>) get isConst => (f) => f.isConst;

  /// Filter late fields.
  static bool Function(FieldMirror<Object?>) get isLate => (f) => f.isLate;

  /// Filter by field type.
  static bool Function(FieldMirror<Object?>) hasType<T>() =>
      (f) => f.fieldType == T;

  /// Filter by name pattern.
  static bool Function(FieldMirror<Object?>) nameMatches(RegExp pattern) =>
      (f) => pattern.hasMatch(f.name);

  /// Filter by exact name.
  static bool Function(FieldMirror<Object?>) named(String name) =>
      (f) => f.name == name;

  /// Filter by owner class.
  static bool Function(FieldMirror<Object?>) inClass(ClassMirror<Object> cls) =>
      (f) => f.owner == cls;

  /// Filter by package.
  static bool Function(FieldMirror<Object?>) inPackage(String package) =>
      (f) => f.package == package;

  /// Combine filters with AND.
  static bool Function(FieldMirror<Object?>) and(
    List<bool Function(FieldMirror<Object?>)> filters,
  ) =>
      (f) => filters.every((fn) => fn(f));

  /// Combine filters with OR.
  static bool Function(FieldMirror<Object?>) or(
    List<bool Function(FieldMirror<Object?>)> filters,
  ) =>
      (f) => filters.any((fn) => fn(f));

  /// Negate a filter.
  static bool Function(FieldMirror<Object?>) not(
    bool Function(FieldMirror<Object?>) filter,
  ) =>
      (f) => !filter(f);
}

// ═══════════════════════════════════════════════════════════════════════════
// TypeFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Static factory methods for creating [TypeMirror] filter predicates.
///
/// Example:
/// ```dart
/// final enums = reflectionApi.allTypeElements
///     .whereType<TypeMirror>()
///     .where(TypeFilter.isEnum);
/// ```
class TypeFilter {
  TypeFilter._();

  /// Filter to classes only.
  static bool Function(TypeMirror<Object>) get isClass =>
      (t) => t is ClassMirror<Object>;

  /// Filter to enums only.
  static bool Function(TypeMirror<Object>) get isEnum =>
      (t) => t is EnumMirror<Object>;

  /// Filter to mixins only.
  static bool Function(TypeMirror<Object>) get isMixin =>
      (t) => t is MixinMirror<Object>;

  /// Filter to extension types only.
  static bool Function(TypeMirror<Object>) get isExtensionType =>
      (t) => t is ExtensionTypeMirror<Object>;

  /// Filter to extensions only.
  static bool Function(TypeMirror<Object>) get isExtension =>
      (t) => t is ExtensionMirror<Object>;

  /// Filter to type aliases only.
  static bool Function(TypeMirror<Object>) get isTypeAlias =>
      (t) => t is TypeAliasMirror;

  /// Filter by package.
  static bool Function(TypeMirror<Object>) inPackage(String package) =>
      (t) => t.package == package;

  /// Filter by library.
  static bool Function(TypeMirror<Object>) inLibrary(String libraryUri) =>
      (t) => t.libraryUri == libraryUri;

  /// Filter by annotation type.
  static bool Function(TypeMirror<Object>) hasAnnotationType<T>() =>
      (t) => t.hasAnnotation<T>();

  /// Filter by name pattern.
  static bool Function(TypeMirror<Object>) nameMatches(RegExp pattern) =>
      (t) => pattern.hasMatch(t.name);

  /// Filter by exact name.
  static bool Function(TypeMirror<Object>) named(String name) =>
      (t) => t.name == name;

  /// Filter generic types.
  static bool Function(TypeMirror<Object>) get isGeneric => (t) => t.isGeneric;

  /// Filter non-generic types.
  static bool Function(TypeMirror<Object>) get isNotGeneric =>
      (t) => !t.isGeneric;

  /// Combine filters with AND.
  static bool Function(TypeMirror<Object>) and(
    List<bool Function(TypeMirror<Object>)> filters,
  ) =>
      (t) => filters.every((f) => f(t));

  /// Combine filters with OR.
  static bool Function(TypeMirror<Object>) or(
    List<bool Function(TypeMirror<Object>)> filters,
  ) =>
      (t) => filters.any((f) => f(t));

  /// Negate a filter.
  static bool Function(TypeMirror<Object>) not(
    bool Function(TypeMirror<Object>) filter,
  ) =>
      (t) => !filter(t);
}

// ═══════════════════════════════════════════════════════════════════════════
// ConstructorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Static factory methods for creating [ConstructorMirror] filter predicates.
class ConstructorFilter {
  ConstructorFilter._();

  /// Filter by annotation type.
  static bool Function(ConstructorMirror<Object>) hasAnnotationType<T>() =>
      (c) => c.hasAnnotation<T>();

  /// Filter factory constructors.
  static bool Function(ConstructorMirror<Object>) get isFactory =>
      (c) => c.isFactory;

  /// Filter generative constructors.
  static bool Function(ConstructorMirror<Object>) get isGenerative =>
      (c) => !c.isFactory;

  /// Filter const constructors.
  static bool Function(ConstructorMirror<Object>) get isConst =>
      (c) => c.isConst;

  /// Filter named constructors.
  static bool Function(ConstructorMirror<Object>) get isNamed =>
      (c) => c.isNamed;

  /// Filter unnamed (default) constructors.
  static bool Function(ConstructorMirror<Object>) get isUnnamed =>
      (c) => !c.isNamed;

  /// Filter by parameter count.
  static bool Function(ConstructorMirror<Object>) hasParameterCount(
    int count,
  ) =>
      (c) => c.parameters.length == count;

  /// Filter by name pattern.
  static bool Function(ConstructorMirror<Object>) nameMatches(RegExp pattern) =>
      (c) => pattern.hasMatch(c.name);

  /// Filter by exact name.
  static bool Function(ConstructorMirror<Object>) named(String name) =>
      (c) => c.name == name;

  /// Combine filters with AND.
  static bool Function(ConstructorMirror<Object>) and(
    List<bool Function(ConstructorMirror<Object>)> filters,
  ) =>
      (c) => filters.every((f) => f(c));

  /// Combine filters with OR.
  static bool Function(ConstructorMirror<Object>) or(
    List<bool Function(ConstructorMirror<Object>)> filters,
  ) =>
      (c) => filters.any((f) => f(c));

  /// Negate a filter.
  static bool Function(ConstructorMirror<Object>) not(
    bool Function(ConstructorMirror<Object>) filter,
  ) =>
      (c) => !filter(c);
}

// ═══════════════════════════════════════════════════════════════════════════
// GetterFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Static factory methods for creating [GetterMirror] filter predicates.
class GetterFilter {
  GetterFilter._();

  /// Filter by annotation type.
  static bool Function(GetterMirror<Object?>) hasAnnotationType<T>() =>
      (g) => g.hasAnnotation<T>();

  /// Filter instance getters only.
  static bool Function(GetterMirror<Object?>) get isInstance =>
      (g) => !g.isStatic && !g.isGlobal;

  /// Filter static getters only.
  static bool Function(GetterMirror<Object?>) get isStatic =>
      (g) => g.isStatic && !g.isGlobal;

  /// Filter global getters only.
  static bool Function(GetterMirror<Object?>) get isGlobal => (g) => g.isGlobal;

  /// Filter by return type name.
  static bool Function(GetterMirror<Object?>) returnsTypeName(String typeName) =>
      (g) => g.returnTypeName == typeName;

  /// Filter by name pattern.
  static bool Function(GetterMirror<Object?>) nameMatches(RegExp pattern) =>
      (g) => pattern.hasMatch(g.name);

  /// Filter by exact name.
  static bool Function(GetterMirror<Object?>) named(String name) =>
      (g) => g.name == name;

  /// Combine filters with AND.
  static bool Function(GetterMirror<Object?>) and(
    List<bool Function(GetterMirror<Object?>)> filters,
  ) =>
      (g) => filters.every((f) => f(g));

  /// Combine filters with OR.
  static bool Function(GetterMirror<Object?>) or(
    List<bool Function(GetterMirror<Object?>)> filters,
  ) =>
      (g) => filters.any((f) => f(g));

  /// Negate a filter.
  static bool Function(GetterMirror<Object?>) not(
    bool Function(GetterMirror<Object?>) filter,
  ) =>
      (g) => !filter(g);
}

// ═══════════════════════════════════════════════════════════════════════════
// SetterFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Static factory methods for creating [SetterMirror] filter predicates.
class SetterFilter {
  SetterFilter._();

  /// Filter by annotation type.
  static bool Function(SetterMirror<Object?>) hasAnnotationType<T>() =>
      (s) => s.hasAnnotation<T>();

  /// Filter instance setters only.
  static bool Function(SetterMirror<Object?>) get isInstance =>
      (s) => !s.isStatic && !s.isGlobal;

  /// Filter static setters only.
  static bool Function(SetterMirror<Object?>) get isStatic =>
      (s) => s.isStatic && !s.isGlobal;

  /// Filter global setters only.
  static bool Function(SetterMirror<Object?>) get isGlobal => (s) => s.isGlobal;

  /// Filter by parameter type name.
  static bool Function(SetterMirror<Object?>) acceptsTypeName(String typeName) =>
      (s) => s.parameterTypeName == typeName;

  /// Filter by name pattern.
  static bool Function(SetterMirror<Object?>) nameMatches(RegExp pattern) =>
      (s) => pattern.hasMatch(s.name);

  /// Filter by exact name.
  static bool Function(SetterMirror<Object?>) named(String name) =>
      (s) => s.name == name;

  /// Combine filters with AND.
  static bool Function(SetterMirror<Object?>) and(
    List<bool Function(SetterMirror<Object?>)> filters,
  ) =>
      (s) => filters.every((f) => f(s));

  /// Combine filters with OR.
  static bool Function(SetterMirror<Object?>) or(
    List<bool Function(SetterMirror<Object?>)> filters,
  ) =>
      (s) => filters.any((f) => f(s));

  /// Negate a filter.
  static bool Function(SetterMirror<Object?>) not(
    bool Function(SetterMirror<Object?>) filter,
  ) =>
      (s) => !filter(s);
}
