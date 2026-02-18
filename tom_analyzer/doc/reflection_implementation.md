# Tom Analyzer Reflection Implementation

This document describes the reflection system design, API, and implementation details.

## Overview

The reflection generator produces a `.r.dart` file containing:

- `reflectionApi`: The main entry point (`ReflectionApi`)
- Type mirrors (`ClassMirror<T>`, `EnumMirror<T>`, `MixinMirror<T>`, etc.)
- Member mirrors (`MethodMirror<R>`, `FieldMirror<T>`, etc.)
- Invocation closures for methods, constructors, getters, setters, and global symbols
- Collection factories for creating typed Lists and Maps
- Filter and processor utilities for traversing the reflection graph

The generated code avoids `dart:mirrors` by using statically generated invokers.

## Design Principles

1. **Type-safe**: All descriptors are generic (`ClassMirror<T>`, `FieldMirror<T>`) and provide access to Dart's `Type` system
2. **Intuitive**: Type relationships are expressed as methods on descriptors (`cls.isSubtypeOf(other)`)
3. **Dual naming**: Access by short name (`MyClass`) or qualified name (`package:my_pkg/file.dart.MyClass`)
4. **Collection factories**: Create typed collections (`List<T>`, `Map<K, V>`) directly from descriptors
5. **Unified hierarchy**: Global and class members share common base types with `isGlobal` discriminator
6. **Trait interfaces**: Common behaviors (`Annotated`, `Invokable`, `Named`) with filter/processor support
7. **Scoped APIs**: `PackageApi` and `LibraryApi` for focused reflection within a scope
8. **Filter/Process pattern**: Every `getXXX` has corresponding `filterXXX` and `processXXX` methods

---

## Trait Interfaces

Traits represent common capabilities shared across different mirror types. Each trait comes with corresponding Filter and Processor classes.

### Element

The base trait that all reflection elements implement. Combines identification, naming, and annotation capabilities into one unified interface.

```dart
/// Base trait for all reflection elements.
/// 
/// Every mirror type implements this, ensuring that fundamental
/// identification, naming, and annotation properties are always accessible.
abstract class Element {
  // ─────────────────────────────────────────────────────────────────
  // Identification
  // ─────────────────────────────────────────────────────────────────
  
  /// Short name (e.g., "MyClass", "myMethod").
  String get name;
  
  /// Fully qualified name (e.g., "package:my_pkg/src/file.dart.MyClass.myMethod").
  String get qualifiedName;
  
  /// Library URI containing this element (e.g., "package:my_pkg/src/file.dart").
  String get libraryUri;
  
  /// Package name (e.g., "my_pkg").
  String get package;
  
  /// The kind of element (class, method, field, etc.).
  ElementKind get kind;
  
  // ─────────────────────────────────────────────────────────────────
  // Annotations
  // ─────────────────────────────────────────────────────────────────
  
  /// Annotations on this element.
  List<AnnotationMirror> get annotations;
  
  /// Check if this element has an annotation of the given type.
  bool hasAnnotation<T>();
  
  /// Check if this element has an annotation matching the predicate.
  bool hasAnnotationWhere(bool Function(AnnotationMirror) predicate);
  
  /// Get the first annotation of the given type, or null.
  AnnotationMirror? getAnnotation<T>();
  
  /// Get all annotations of the given type.
  List<AnnotationMirror> getAnnotationsOfType<T>();
}

/// Enumeration of element kinds.
enum ElementKind {
  class_,
  enum_,
  mixin_,
  extension_,
  extensionType,
  typeAlias,
  method,
  field,
  getter,
  setter,
  constructor,
  parameter,
  typeParameter,
}

/// Filter for any element.
/// 
/// This is the most general filter, applicable to all reflection elements.
/// Use this when you want to filter across all element types uniformly.
class ElementFilter {
  /// Filter applied to all elements.
  final bool Function(Element)? filter;
  
  /// Type-specific filters (optional refinement).
  final bool Function(ClassMirror)? filterClass;
  final bool Function(EnumMirror)? filterEnum;
  final bool Function(MixinMirror)? filterMixin;
  final bool Function(ExtensionMirror)? filterExtension;
  final bool Function(MethodMirror)? filterMethod;
  final bool Function(FieldMirror)? filterField;
  final bool Function(GetterMirror)? filterGetter;
  final bool Function(SetterMirror)? filterSetter;
  final bool Function(ConstructorMirror)? filterConstructor;
  final bool Function(ParameterMirror)? filterParameter;
  
  const ElementFilter({
    this.filter,
    this.filterClass,
    this.filterEnum,
    this.filterMixin,
    this.filterExtension,
    this.filterMethod,
    this.filterField,
    this.filterGetter,
    this.filterSetter,
    this.filterConstructor,
    this.filterParameter,
  });
  
  /// Evaluate the filter for an element.
  bool evaluate(Element element) {
    final preSelected = filter?.call(element) ?? true;
    if (!preSelected) return false;
    
    final typeFilter = _getTypeFilter(element);
    if (typeFilter != null) return typeFilter();
    return preSelected;
  }
  
  bool Function()? _getTypeFilter(Element element) {
    if (element is ClassMirror && filterClass != null) return () => filterClass!(element);
    if (element is EnumMirror && filterEnum != null) return () => filterEnum!(element);
    if (element is MixinMirror && filterMixin != null) return () => filterMixin!(element);
    if (element is ExtensionMirror && filterExtension != null) return () => filterExtension!(element);
    if (element is MethodMirror && filterMethod != null) return () => filterMethod!(element);
    if (element is FieldMirror && filterField != null) return () => filterField!(element);
    if (element is GetterMirror && filterGetter != null) return () => filterGetter!(element);
    if (element is SetterMirror && filterSetter != null) return () => filterSetter!(element);
    if (element is ConstructorMirror && filterConstructor != null) return () => filterConstructor!(element);
    if (element is ParameterMirror && filterParameter != null) return () => filterParameter!(element);
    return null;
  }
  
  // Static factory methods
  static ElementFilter byName(String name) => ElementFilter(
    filter: (e) => e.name == name,
  );
  
  static ElementFilter nameMatches(RegExp pattern) => ElementFilter(
    filter: (e) => pattern.hasMatch(e.name),
  );
  
  static ElementFilter inPackage(String package) => ElementFilter(
    filter: (e) => e.package == package,
  );
  
  static ElementFilter inLibrary(String libraryUri) => ElementFilter(
    filter: (e) => e.libraryUri == libraryUri,
  );
  
  static ElementFilter ofKind(ElementKind kind) => ElementFilter(
    filter: (e) => e.kind == kind,
  );
  
  static ElementFilter hasAnnotation<T>() => ElementFilter(
    filter: (e) => e.hasAnnotation<T>(),
  );
}

/// Processor for any element.
class ElementProcessor {
  /// Process any element.
  final void Function(Element)? process;
  
  /// Type-specific processors.
  final void Function(ClassMirror)? processClass;
  final void Function(EnumMirror)? processEnum;
  final void Function(MixinMirror)? processMixin;
  final void Function(ExtensionMirror)? processExtension;
  final void Function(MethodMirror)? processMethod;
  final void Function(FieldMirror)? processField;
  final void Function(GetterMirror)? processGetter;
  final void Function(SetterMirror)? processSetter;
  final void Function(ConstructorMirror)? processConstructor;
  final void Function(ParameterMirror)? processParameter;
  
  const ElementProcessor({
    this.process,
    this.processClass,
    this.processEnum,
    this.processMixin,
    this.processExtension,
    this.processMethod,
    this.processField,
    this.processGetter,
    this.processSetter,
    this.processConstructor,
    this.processParameter,
  });
  
  /// Execute the processor for an element.
  void call(Element element) {
    // Generic processing first
    process?.call(element);
    
    // Type-specific processing
    if (element is ClassMirror) processClass?.call(element);
    else if (element is EnumMirror) processEnum?.call(element);
    else if (element is MixinMirror) processMixin?.call(element);
    else if (element is ExtensionMirror) processExtension?.call(element);
    else if (element is MethodMirror) processMethod?.call(element);
    else if (element is FieldMirror) processField?.call(element);
    else if (element is GetterMirror) processGetter?.call(element);
    else if (element is SetterMirror) processSetter?.call(element);
    else if (element is ConstructorMirror) processConstructor?.call(element);
    else if (element is ParameterMirror) processParameter?.call(element);
  }
}
```

**Usage examples:**

```dart
// Find all elements in a specific package
final packageElements = reflectionApi.filterElements(
  ElementFilter.inPackage('my_package'),
);

// Process all deprecated elements
reflectionApi.processElements(
  ElementFilter.hasAnnotation<Deprecated>(),
  ElementProcessor(
    process: (e) => print('Deprecated: ${e.qualifiedName}'),
  ),
);

// Get all elements matching a name pattern
final testElements = reflectionApi.filterElements(
  ElementFilter.nameMatches(RegExp(r'^test')),
);

// Filter by annotation with type-specific refinement
reflectionApi.processElements(
  ElementFilter(
    filter: (e) => e.hasAnnotation<Serializable>(),
    filterClass: (cls) => !cls.isAbstract,  // Only concrete classes
    filterField: (f) => !f.isStatic,         // Only instance fields
  ),
  ElementProcessor(
    processClass: (cls) => generateSerializer(cls),
    processField: (f) => registerField(f),
  ),
);
```

**Trait Hierarchy:**

```
Element (base - identification, naming, annotations)
├── Typed<T> (reflectedType, typeMirror, isSubtypeOf)
├── Invokable (parameters, typeParameters, acceptsArguments)
├── OwnedElement (owner, isGlobal, isStatic, isInstance)
├── GenericElement (typeParameters, isGeneric)
└── Accessible<T> (isReadable, isWritable, isReadOnly) extends Typed<T>
```

**Mirror Hierarchy:**

```
Element
├── TypeMirror<T> (implements Typed<T>, GenericElement)
│   ├── ClassMirror<T>
│   ├── EnumMirror<T>
│   ├── MixinMirror<T>
│   ├── ExtensionTypeMirror<T>
│   └── TypeAliasMirror
├── ExtensionMirror
├── MemberMirror (implements OwnedElement)
│   ├── MethodMirror<R> (also implements Invokable, GenericElement)
│   ├── FieldMirror<T> (also implements Accessible<T>)
│   ├── GetterMirror<T> (also implements Accessible<T>)
│   ├── SetterMirror<T> (also implements Accessible<T>)
│   └── ConstructorMirror<T> (also implements Invokable, GenericElement)
└── ParameterMirror<T> (implements Typed<T>)
```

### Typed<T>

Elements with an associated type (fields, getters, setters, parameters, type mirrors):

```dart
/// Trait for elements with an associated type.
abstract class Typed<T> implements Element {
  /// The Dart runtime Type (e.g., String, int, MyClass).
  Type get reflectedType;
  
  /// The type as a TypeMirror (if available in reflection).
  TypeMirror<T>? get typeMirror;
  
  /// Check if this element's type is a subtype of another.
  bool isSubtypeOf<S>();
  
  /// Check if this element's type is assignable to another.
  bool isAssignableTo<S>();
}

/// Filter for typed elements.
class TypedFilter {
  /// Trait-level filter applied to all Typed elements.
  final bool Function(Typed)? filterTyped;
  
  /// Type-specific filters.
  final bool Function(TypeMirror)? filterType;
  final bool Function(FieldMirror)? filterField;
  final bool Function(GetterMirror)? filterGetter;
  final bool Function(SetterMirror)? filterSetter;
  final bool Function(ParameterMirror)? filterParameter;
  
  const TypedFilter({
    this.filterTyped,
    this.filterType,
    this.filterField,
    this.filterGetter,
    this.filterSetter,
    this.filterParameter,
  });
  
  /// Evaluate the filter.
  bool evaluate(Typed element) {
    final preSelected = filterTyped?.call(element) ?? true;
    if (!preSelected) return false;
    
    final typeFilter = _getTypeFilter(element);
    if (typeFilter != null) return typeFilter();
    return preSelected;
  }
  
  bool Function()? _getTypeFilter(Typed element) {
    if (element is TypeMirror && filterType != null) return () => filterType!(element);
    if (element is FieldMirror && filterField != null) return () => filterField!(element);
    if (element is GetterMirror && filterGetter != null) return () => filterGetter!(element);
    if (element is SetterMirror && filterSetter != null) return () => filterSetter!(element);
    if (element is ParameterMirror && filterParameter != null) return () => filterParameter!(element);
    return null;
  }
  
  // Static factory methods
  static TypedFilter hasType<T>() => TypedFilter(
    filterTyped: (t) => t.reflectedType == T,
  );
  
  static TypedFilter typeMatches(bool Function(Type) predicate) => TypedFilter(
    filterTyped: (t) => predicate(t.reflectedType),
  );
  
  static TypedFilter isSubtypeOf<T>() => TypedFilter(
    filterTyped: (t) => t.isSubtypeOf<T>(),
  );
}

/// Processor for typed elements.
class TypedProcessor {
  /// Process any Typed element.
  final void Function(Typed)? processTyped;
  
  /// Type-specific processors.
  final void Function(TypeMirror)? processType;
  final void Function(FieldMirror)? processField;
  final void Function(GetterMirror)? processGetter;
  final void Function(SetterMirror)? processSetter;
  final void Function(ParameterMirror)? processParameter;
  
  const TypedProcessor({
    this.processTyped,
    this.processType,
    this.processField,
    this.processGetter,
    this.processSetter,
    this.processParameter,
  });
  
  /// Execute the processor.
  void call(Typed element) {
    processTyped?.call(element);
    
    if (element is TypeMirror) processType?.call(element);
    else if (element is FieldMirror) processField?.call(element);
    else if (element is GetterMirror) processGetter?.call(element);
    else if (element is SetterMirror) processSetter?.call(element);
    else if (element is ParameterMirror) processParameter?.call(element);
  }
}
```

### Invokable

Elements that can be invoked (methods, constructors):

```dart
/// Trait for callable elements.
abstract class Invokable implements Element {
  /// Parameters of this callable.
  List<ParameterMirror> get parameters;
  
  /// Type parameters (generics) of this callable.
  List<TypeParameterMirror> get typeParameters;
  
  /// Number of required positional parameters.
  int get requiredParameterCount;
  
  /// Number of optional positional parameters.
  int get optionalParameterCount;
  
  /// Whether this callable has named parameters.
  bool get hasNamedParameters;
  
  /// Check if the given arguments would be valid.
  bool acceptsArguments(List<dynamic> positional, Map<Symbol, dynamic> named);
}

/// Filter for invokable elements.
class InvokableFilter {
  /// Trait-level filter applied to all Invokable elements.
  final bool Function(Invokable)? filterInvokable;
  
  /// Type-specific filters.
  final bool Function(MethodMirror)? filterMethod;
  final bool Function(ConstructorMirror)? filterConstructor;
  
  const InvokableFilter({
    this.filterInvokable,
    this.filterMethod,
    this.filterConstructor,
  });
  
  /// Evaluate the filter.
  bool evaluate(Invokable element) {
    final preSelected = filterInvokable?.call(element) ?? true;
    if (!preSelected) return false;
    
    if (element is MethodMirror && filterMethod != null) return filterMethod!(element);
    if (element is ConstructorMirror && filterConstructor != null) return filterConstructor!(element);
    return preSelected;
  }
  
  // Static factory methods
  static InvokableFilter parameterCount(int count) => InvokableFilter(
    filterInvokable: (i) => i.parameters.length == count,
  );
  
  static InvokableFilter hasRequiredParams(int count) => InvokableFilter(
    filterInvokable: (i) => i.requiredParameterCount == count,
  );
  
  static InvokableFilter hasNamedParam(String name) => InvokableFilter(
    filterInvokable: (i) => i.parameters.any((p) => p.isNamed && p.name == name),
  );
  
  static InvokableFilter hasTypeParameter(String name) => InvokableFilter(
    filterInvokable: (i) => i.typeParameters.any((tp) => tp.name == name),
  );
  
  static InvokableFilter noParameters() => InvokableFilter(
    filterInvokable: (i) => i.parameters.isEmpty,
  );
}

/// Processor for invokable elements.
class InvokableProcessor {
  /// Process any Invokable element.
  final void Function(Invokable)? processInvokable;
  
  /// Type-specific processors.
  final void Function(MethodMirror)? processMethod;
  final void Function(ConstructorMirror)? processConstructor;
  
  const InvokableProcessor({
    this.processInvokable,
    this.processMethod,
    this.processConstructor,
  });
  
  /// Execute the processor.
  void call(Invokable element) {
    processInvokable?.call(element);
    
    if (element is MethodMirror) processMethod?.call(element);
    else if (element is ConstructorMirror) processConstructor?.call(element);
  }
}
```

### OwnedElement

Elements that belong to a class/type or are top-level (global):

```dart
/// Trait for elements that have an owner (class, mixin, etc.) or are global.
abstract class OwnedElement implements Element {
  /// The class/mixin/enum this member belongs to, or null if global.
  TypeMirror? get owner;
  
  /// True if this is a top-level (global/library-level) element.
  bool get isGlobal;
  
  /// True if this is a static member or global element.
  bool get isStatic;
  
  /// True if this is an instance member (not static, not global).
  bool get isInstance => !isStatic && !isGlobal;
}

/// Filter for owned elements.
class OwnedElementFilter {
  /// Trait-level filter applied to all OwnedElement elements.
  final bool Function(OwnedElement)? filterOwned;
  
  /// Type-specific filters.
  final bool Function(MethodMirror)? filterMethod;
  final bool Function(FieldMirror)? filterField;
  final bool Function(GetterMirror)? filterGetter;
  final bool Function(SetterMirror)? filterSetter;
  final bool Function(ConstructorMirror)? filterConstructor;
  
  const OwnedElementFilter({
    this.filterOwned,
    this.filterMethod,
    this.filterField,
    this.filterGetter,
    this.filterSetter,
    this.filterConstructor,
  });
  
  /// Evaluate the filter.
  bool evaluate(OwnedElement element) {
    final preSelected = filterOwned?.call(element) ?? true;
    if (!preSelected) return false;
    
    if (element is MethodMirror && filterMethod != null) return filterMethod!(element);
    if (element is FieldMirror && filterField != null) return filterField!(element);
    if (element is GetterMirror && filterGetter != null) return filterGetter!(element);
    if (element is SetterMirror && filterSetter != null) return filterSetter!(element);
    if (element is ConstructorMirror && filterConstructor != null) return filterConstructor!(element);
    return preSelected;
  }
  
  // Static factory methods
  static OwnedElementFilter global() => OwnedElementFilter(
    filterOwned: (o) => o.isGlobal,
  );
  
  static OwnedElementFilter staticMembers() => OwnedElementFilter(
    filterOwned: (o) => o.isStatic && !o.isGlobal,
  );
  
  static OwnedElementFilter instanceMembers() => OwnedElementFilter(
    filterOwned: (o) => o.isInstance,
  );
  
  static OwnedElementFilter inType<T>() => OwnedElementFilter(
    filterOwned: (o) => o.owner?.reflectedType == T,
  );
  
  static OwnedElementFilter ownedBy(TypeMirror type) => OwnedElementFilter(
    filterOwned: (o) => o.owner == type,
  );
}

/// Processor for owned elements.
class OwnedElementProcessor {
  /// Process any OwnedElement.
  final void Function(OwnedElement)? processOwned;
  
  /// Type-specific processors.
  final void Function(MethodMirror)? processMethod;
  final void Function(FieldMirror)? processField;
  final void Function(GetterMirror)? processGetter;
  final void Function(SetterMirror)? processSetter;
  final void Function(ConstructorMirror)? processConstructor;
  
  const OwnedElementProcessor({
    this.processOwned,
    this.processMethod,
    this.processField,
    this.processGetter,
    this.processSetter,
    this.processConstructor,
  });
  
  /// Execute the processor.
  void call(OwnedElement element) {
    processOwned?.call(element);
    
    if (element is MethodMirror) processMethod?.call(element);
    else if (element is FieldMirror) processField?.call(element);
    else if (element is GetterMirror) processGetter?.call(element);
    else if (element is SetterMirror) processSetter?.call(element);
    else if (element is ConstructorMirror) processConstructor?.call(element);
  }
}
```

### GenericElement

Elements that have type parameters (generics):

```dart
/// Trait for elements that have type parameters.
abstract class GenericElement implements Element {
  /// Type parameters (generics) of this element.
  List<TypeParameterMirror> get typeParameters;
  
  /// Whether this element is generic (has type parameters).
  bool get isGeneric => typeParameters.isNotEmpty;
  
  /// Number of type parameters.
  int get typeParameterCount => typeParameters.length;
}

/// Filter for generic elements.
class GenericElementFilter {
  /// Trait-level filter.
  final bool Function(GenericElement)? filterGeneric;
  
  /// Type-specific filters.
  final bool Function(TypeMirror)? filterType;
  final bool Function(MethodMirror)? filterMethod;
  final bool Function(ConstructorMirror)? filterConstructor;
  
  const GenericElementFilter({
    this.filterGeneric,
    this.filterType,
    this.filterMethod,
    this.filterConstructor,
  });
  
  // Static factory methods
  static GenericElementFilter hasTypeParams() => GenericElementFilter(
    filterGeneric: (g) => g.isGeneric,
  );
  
  static GenericElementFilter typeParamCount(int count) => GenericElementFilter(
    filterGeneric: (g) => g.typeParameterCount == count,
  );
  
  static GenericElementFilter hasTypeParam(String name) => GenericElementFilter(
    filterGeneric: (g) => g.typeParameters.any((tp) => tp.name == name),
  );
}

/// Processor for generic elements.
class GenericElementProcessor {
  final void Function(GenericElement)? processGeneric;
  final void Function(TypeMirror)? processType;
  final void Function(MethodMirror)? processMethod;
  final void Function(ConstructorMirror)? processConstructor;
  
  const GenericElementProcessor({
    this.processGeneric,
    this.processType,
    this.processMethod,
    this.processConstructor,
  });
  
  void call(GenericElement element) {
    processGeneric?.call(element);
    
    if (element is TypeMirror) processType?.call(element);
    else if (element is MethodMirror) processMethod?.call(element);
    else if (element is ConstructorMirror) processConstructor?.call(element);
  }
}
```

### Accessible

Elements that can be read and/or written (fields, getters, setters):

```dart
/// Trait for elements that provide read/write access.
abstract class Accessible<T> implements Typed<T> {
  /// Whether this element can be read.
  bool get isReadable;
  
  /// Whether this element can be written.
  bool get isWritable;
  
  /// Whether this is read-only (readable but not writable).
  bool get isReadOnly => isReadable && !isWritable;
  
  /// Whether this is write-only (writable but not readable).
  bool get isWriteOnly => isWritable && !isReadable;
}

/// Filter for accessible elements.
class AccessibleFilter {
  final bool Function(Accessible)? filterAccessible;
  final bool Function(FieldMirror)? filterField;
  final bool Function(GetterMirror)? filterGetter;
  final bool Function(SetterMirror)? filterSetter;
  
  const AccessibleFilter({
    this.filterAccessible,
    this.filterField,
    this.filterGetter,
    this.filterSetter,
  });
  
  static AccessibleFilter readable() => AccessibleFilter(
    filterAccessible: (a) => a.isReadable,
  );
  
  static AccessibleFilter writable() => AccessibleFilter(
    filterAccessible: (a) => a.isWritable,
  );
  
  static AccessibleFilter readOnly() => AccessibleFilter(
    filterAccessible: (a) => a.isReadOnly,
  );
}

/// Processor for accessible elements.
class AccessibleProcessor {
  final void Function(Accessible)? processAccessible;
  final void Function(FieldMirror)? processField;
  final void Function(GetterMirror)? processGetter;
  final void Function(SetterMirror)? processSetter;
  
  const AccessibleProcessor({
    this.processAccessible,
    this.processField,
    this.processGetter,
    this.processSetter,
  });
  
  void call(Accessible element) {
    processAccessible?.call(element);
    
    if (element is FieldMirror) processField?.call(element);
    else if (element is GetterMirror) processGetter?.call(element);
    else if (element is SetterMirror) processSetter?.call(element);
  }
}
```

---

## Core Types

### TypeMirror<T>

Base class for all type mirrors:

```dart
/// Represents any reflected type (class, enum, mixin, etc.)
/// Implements Typed<T> for type information access.
abstract class TypeMirror<T> implements Typed<T> {
  /// The Dart runtime Type.
  @override
  Type get reflectedType; // e.g., MyClass
  
  /// Type parameters (if generic).
  List<TypeParameterMirror> get typeParameters;
  
  /// The type this mirrors as a TypeMirror (returns self).
  @override
  TypeMirror<T>? get typeMirror => this;
}
```

### ClassMirror<T>

The primary descriptor for classes:

```dart
abstract class ClassMirror<T> extends TypeMirror<T> {
  // ─────────────────────────────────────────────────────────────────
  // Type Access
  // ─────────────────────────────────────────────────────────────────
  
  /// The Dart Type for this class.
  @override
  Type get reflectedType; // Returns T's Type
  
  // ─────────────────────────────────────────────────────────────────
  // Type Relationships
  // ─────────────────────────────────────────────────────────────────
  
  /// Superclass mirror (null for Object).
  ClassMirror<Object>? get superclass;
  
  /// Implemented interfaces.
  List<ClassMirror<Object>> get interfaces;
  
  /// Applied mixins.
  List<MixinMirror<Object>> get mixins;
  
  /// Check if [object] is an instance of T.
  bool isInstanceOf(Object? object); // object is T
  
  /// Check if T is a subtype of S.
  bool isSubtypeOf<S>(); // T is S
  
  /// Check if T is a subtype of another type descriptor.
  bool isSubtypeOfMirror(TypeMirror other);
  
  /// Check if T is a supertype of another type descriptor.
  bool isSupertypeOfMirror(TypeMirror other);
  
  /// Check if this class implements the given interface.
  bool implements(ClassMirror interface);
  
  /// Check if this class uses the given mixin.
  bool hasMixin(MixinMirror mixin);
  
  /// Check if this class is abstract.
  bool get isAbstract;
  
  /// Check if this class is sealed.
  bool get isSealed;
  
  /// Check if this class is final (no subtypes allowed).
  bool get isFinal;
  
  // ─────────────────────────────────────────────────────────────────
  // Extension Support
  // ─────────────────────────────────────────────────────────────────
  
  /// All extensions that apply to this class.
  List<ExtensionMirror> get applicableExtensions;
  
  /// Check if the given extension applies to this class.
  bool hasExtension(ExtensionMirror extension);
  
  /// Find an extension by name that applies to this class.
  ExtensionMirror? findApplicableExtension(String name);
  
  // ─────────────────────────────────────────────────────────────────
  // Collection Factories
  // ─────────────────────────────────────────────────────────────────
  
  /// Create an empty List<T>.
  List<T> createList();
  
  /// Create an empty List<T?>.
  List<T?> createNullableList();
  
  /// Create a List<T> filled with [length] copies of [fill].
  List<T> createFilledList(int length, T fill);
  
  /// Create an empty Set<T>.
  Set<T> createSet();
  
  /// Create an empty Set<T?>.
  Set<T?> createNullableSet();
  
  /// Create an empty Map<String, T>.
  Map<String, T> createStringKeyedMap();
  
  /// Create an empty Map<String, T?>.
  Map<String, T?> createStringKeyedNullableMap();
  
  /// Create an empty Map<T, Object?>.
  Map<T, Object?> createKeyedObjectMap();
  
  /// Create an empty Map<T, Object>.
  Map<T, Object> createKeyedNonNullObjectMap();
  
  /// Create an empty Map<K, T>.
  Map<K, T> createValuedMap<K>();
  
  /// Create an empty Map<T, V>.
  Map<T, V> createKeyedMap<V>();
  
  // ─────────────────────────────────────────────────────────────────
  // Members - Get, Filter, Process
  // ─────────────────────────────────────────────────────────────────
  
  /// All instance methods (inherited + declared).
  Map<String, MethodMirror<Object?>> get instanceMethods;
  
  /// All static methods (excludes factory constructors).
  Map<String, MethodMirror<Object?>> get staticMethods;
  
  /// Filter instance methods.
  Iterable<MethodMirror<Object?>> filterInstanceMethods(bool Function(MethodMirror) filter);
  
  /// Process instance methods.
  void processInstanceMethods(void Function(MethodMirror) processor);
  
  /// All instance fields.
  Map<String, FieldMirror<Object?>> get instanceFields;
  
  /// All static fields.
  Map<String, FieldMirror<Object?>> get staticFields;
  
  /// Filter instance fields.
  Iterable<FieldMirror<Object?>> filterInstanceFields(bool Function(FieldMirror) filter);
  
  /// All instance getters (explicit + implicit from fields).
  Map<String, GetterMirror<Object?>> get instanceGetters;
  
  /// All static getters.
  Map<String, GetterMirror<Object?>> get staticGetters;
  
  /// All instance setters.
  Map<String, SetterMirror<Object?>> get instanceSetters;
  
  /// All static setters.
  Map<String, SetterMirror<Object?>> get staticSetters;
  
  /// All constructors (including factory constructors).
  Map<String, ConstructorMirror<T>> get constructors;
  
  /// Get the unnamed constructor (name == '').
  ConstructorMirror<T>? get defaultConstructor;
  
  // ─────────────────────────────────────────────────────────────────
  // Property Introspection
  // ─────────────────────────────────────────────────────────────────
  
  /// Check if the given property is read-only (no setter, or final field).
  bool isPropertyReadOnly(String name);
  
  /// Check if the given static property is read-only.
  bool isStaticPropertyReadOnly(String name);
  
  // ─────────────────────────────────────────────────────────────────
  // Invocation
  // ─────────────────────────────────────────────────────────────────
  
  /// Create a new instance using a constructor or static factory method.
  /// 
  /// Use '' (empty string) for the unnamed constructor.
  /// 
  /// **Lookup behavior:**
  /// 1. First searches `constructors` (regular and factory constructors)
  /// 2. If not found, searches `staticMethods` for methods returning T
  /// 
  /// This allows using `newInstance` for both factory constructors and
  /// static factory methods that return the type.
  T newInstance(String constructorName, [List<dynamic> positional = const [], Map<Symbol, dynamic> named = const {}]);
  
  /// Invoke an instance method.
  Object? invokeMethod(T instance, String methodName, [List<dynamic> positional = const [], Map<Symbol, dynamic> named = const {}]);
  
  /// Invoke a static method or factory constructor.
  /// 
  /// **Lookup behavior:**
  /// 1. First searches `staticMethods`
  /// 2. If not found, searches `constructors` for factory constructors
  /// 
  /// This allows using `invokeStaticMethod` for both static methods and
  /// factory constructors (which are semantically similar).
  Object? invokeStaticMethod(String methodName, [List<dynamic> positional = const [], Map<Symbol, dynamic> named = const {}]);
  
  /// Get an instance property value (field or getter).
  Object? getProperty(T instance, String name);
  
  /// Set an instance property value (field or setter).
  /// Throws if property is read-only.
  void setProperty(T instance, String name, Object? value);
  
  /// Get a static property value.
  Object? getStaticProperty(String name);
  
  /// Set a static property value.
  /// Throws if property is read-only.
  void setStaticProperty(String name, Object? value);
}
```

### Factory Constructors vs Static Methods

**Factory constructors** and **static methods** that return instances are conceptually similar. The API allows flexible invocation:

| Aspect | Factory Constructor | Static Factory Method |
|--------|---------------------|----------------------|
| Declaration | `factory User.fromJson(...)` | `static User parse(...)` |
| Location | `constructors` map | `staticMethods` map |
| `ConstructorMirror.isFactory` | `true` | N/A |

**Flexible invocation - both methods search across types:**

| Method | Primary Lookup | Fallback Lookup |
|--------|----------------|-----------------|
| `newInstance(name)` | `constructors` | `staticMethods` returning T |
| `invokeStaticMethod(name)` | `staticMethods` | `constructors` (factory only) |

```dart
// All of these work:

// Factory constructor via newInstance (primary)
final user1 = userClass.newInstance('fromJson', [jsonMap]);

// Factory constructor via invokeStaticMethod (fallback)
final user2 = userClass.invokeStaticMethod('fromJson', [jsonMap]) as User;

// Static factory method via invokeStaticMethod (primary)
final user3 = userClass.invokeStaticMethod('parse', [jsonString]) as User;

// Static factory method via newInstance (fallback, if it returns User)
final user4 = userClass.newInstance('parse', [jsonString]);
```

**Note:** The `constructors` and `staticMethods` getters still return their respective types only - the flexible lookup only applies to the invocation methods.

### EnumMirror<T>, MixinMirror<T>, ExtensionTypeMirror<T>

```dart
abstract class EnumMirror<T extends Enum> extends TypeMirror<T> {
  /// All enum values.
  List<T> get values;
  
  /// Get enum value by name.
  T? valueOf(String name);
  
  /// Create List<T>.
  List<T> createList();
  
  // Member accessors similar to ClassMirror...
}

abstract class MixinMirror<T> extends TypeMirror<T> {
  /// Superclass constraint (on clause).
  ClassMirror<Object>? get superclassConstraint;
  
  /// Interface constraints.
  List<ClassMirror<Object>> get interfaceConstraints;
  
  // Member accessors...
}

abstract class ExtensionTypeMirror<T> extends TypeMirror<T> {
  /// The representation type.
  TypeMirror get representationType;
  
  /// Create List<T>.
  List<T> createList();
  
  // Member accessors and invocation...
}
```

### ExtensionMirror

Extensions add members to existing types. They are visible in both `allExtensions` and as `applicableExtensions` on types:

```dart
abstract class ExtensionMirror implements Element {
  /// The type this extension extends.
  TypeMirror get extendedType;
  
  /// Check if this extension applies to the given type.
  bool appliesTo(TypeMirror type);
  
  /// Check if this extension applies to instances of the given class.
  bool appliesToClass(ClassMirror cls);
  
  /// Methods added by this extension.
  Map<String, MethodMirror<Object?>> get methods;
  
  /// Getters added by this extension.
  Map<String, GetterMirror<Object?>> get getters;
  
  /// Setters added by this extension.
  Map<String, SetterMirror<Object?>> get setters;
  
  /// Static methods in this extension.
  Map<String, MethodMirror<Object?>> get staticMethods;
  
  /// Operators defined by this extension.
  Map<String, MethodMirror<Object?>> get operators;
}
```

**Extension members on ClassMirror:**

Extension methods appear in the ClassMirror member accessors with appropriate markers:

```dart
final userClass = reflectionApi.findClassByType<User>()!;

// Get all instance methods including extension methods
for (final method in userClass.instanceMethods.values) {
  if (method.isExtensionMember) {
    print('${method.name} is from extension ${method.extension!.name}');
  }
}

// Find extensions that apply to this class
for (final ext in userClass.applicableExtensions) {
  print('Extension ${ext.name} applies to User');
}

// Check if a specific extension applies
final jsonExt = reflectionApi.findExtensionByName('JsonExtensions')!;
if (userClass.hasExtension(jsonExt)) {
  // Use extension methods
}
```

### TypeAliasMirror

```dart
abstract class TypeAliasMirror implements Element {
  /// The aliased type descriptor.
  TypeMirror? get aliasedType;
  
  /// The aliased Dart Type.
  Type get aliasedReflectedType;
  
  List<TypeParameterMirror> get typeParameters;
  List<AnnotationMirror> get annotations;
}
```

---

## Member Mirrors

All member mirrors share common traits and have an `owner` reference for navigation.

### MemberMirror (Base)

```dart
/// Base for all member mirrors.
/// Implements OwnedElement for owner/static/global access.
abstract class MemberMirror implements OwnedElement {
  /// The type/class this member belongs to, or null if global.
  @override
  TypeMirror? get owner;
  
  /// True if this is a global (top-level) member.
  @override
  bool get isGlobal;
  
  /// True if this is static (class-level) or global.
  @override
  bool get isStatic;
  
  /// True if this is an instance member.
  @override
  bool get isInstance;
  
  /// True if this member comes from an extension.
  bool get isExtensionMember;
  
  /// The extension this member comes from (if isExtensionMember).
  ExtensionMirror? get extension;
}
```

### MethodMirror<R>

Methods with typed return type:

```dart
/// Mirror for methods with return type R.
abstract class MethodMirror<R> extends MemberMirror implements Invokable {
  /// Return type as a TypeMirror.
  TypeMirror<R>? get returnType;
  
  /// Return type as Dart Type.
  Type get returnReflectedType;
  
  @override
  List<ParameterMirror> get parameters;
  
  @override
  List<TypeParameterMirror> get typeParameters;
  
  bool get isAbstract;
  
  /// True if this is an operator (e.g., operator +).
  bool get isOperator;
  
  /// Invoke on an instance.
  /// For global/static methods, pass null as instance.
  R invoke(Object? instance, [List<dynamic> positional = const [], Map<Symbol, dynamic> named = const {}]);
}
```

### FieldMirror<T>

Fields with simplified accessor model:

```dart
/// Mirror for fields of type T.
abstract class FieldMirror<T> extends MemberMirror implements Typed<T> {
  /// Field type as TypeMirror.
  @override
  TypeMirror<T>? get typeMirror;
  
  /// Field type as Dart Type.
  @override
  Type get reflectedType;
  
  bool get isFinal;
  bool get isConst;
  bool get isLate;
  
  /// True if this field cannot be written (final, const, or no setter).
  bool get isReadOnly;
  
  /// Get field value.
  /// For instance fields, pass the instance.
  /// For static/global fields, pass null.
  T getValue(Object? instance);
  
  /// Set field value.
  /// Throws [ReadOnlyFieldError] if isReadOnly is true.
  void setValue(Object? instance, T value);
}
```

**Note:** The distinction between instance/static is via `isStatic` and `isGlobal`. A single `getValue`/`setValue` pair handles both cases - pass `null` for static/global access.

### GetterMirror<T>

```dart
/// Mirror for getters returning type T.
abstract class GetterMirror<T> extends MemberMirror implements Typed<T> {
  /// Return type as TypeMirror.
  @override
  TypeMirror<T>? get typeMirror;
  
  /// Return type as Dart Type.
  @override
  Type get reflectedType;
  
  /// True if this is an implicit getter for a field.
  bool get isImplicit;
  
  /// The field this getter is derived from (if isImplicit).
  FieldMirror<T>? get field;
  
  /// Get the value.
  /// For instance getters, pass the instance.
  /// For static/global getters, pass null.
  T getValue(Object? instance);
}
```

### SetterMirror<T>

```dart
/// Mirror for setters accepting type T.
abstract class SetterMirror<T> extends MemberMirror implements Typed<T> {
  /// Value type as TypeMirror.
  @override
  TypeMirror<T>? get typeMirror;
  
  /// Value type as Dart Type.
  @override
  Type get reflectedType;
  
  /// True if this is an implicit setter for a field.
  bool get isImplicit;
  
  /// The field this setter is derived from (if isImplicit).
  FieldMirror<T>? get field;
  
  /// Set the value.
  /// For instance setters, pass the instance.
  /// For static/global setters, pass null.
  void setValue(Object? instance, T value);
}
```

### ConstructorMirror<T>

```dart
/// Mirror for constructors creating instances of T.
abstract class ConstructorMirror<T> extends MemberMirror implements Invokable {
  /// Constructor name (empty string '' for unnamed constructor).
  @override
  String get name;
  
  /// Whether this is a factory constructor.
  bool get isFactory;
  
  /// Whether this is a const constructor.
  bool get isConst;
  
  /// Whether this is a generative (non-factory) constructor.
  bool get isGenerative;
  
  @override
  List<ParameterMirror> get parameters;
  
  /// Invoke the constructor.
  @override
  T invoke([List<dynamic> positional = const [], Map<Symbol, dynamic> named = const {}]);
}
```

### ParameterMirror<T>

```dart
/// Mirror for parameters of type T.
/// Implements Typed<T> for type information access.
abstract class ParameterMirror<T> implements Typed<T> {
  /// Parameter type as TypeMirror.
  @override
  TypeMirror<T>? get typeMirror;
  
  /// Parameter type as Dart Type.
  @override
  Type get reflectedType;
  
  /// Whether this is a required parameter.
  bool get isRequired;
  
  /// Whether this is an optional parameter.
  bool get isOptional;
  
  /// Whether this is a named parameter.
  bool get isNamed;
  
  /// Whether this is a positional parameter.
  bool get isPositional;
  
  /// Whether this parameter has a default value.
  bool get hasDefaultValue;
  
  /// Default value (if has one and is const).
  T? get defaultValue;
  
  /// The method/constructor this parameter belongs to.
  Invokable get declaringInvokable;
  
  /// Position in the parameter list (0-based).
  int get position;
}
```

### AnnotationMirror

```dart
/// Mirror for annotations.
/// Note: AnnotationMirror does not implement Element since annotations
/// are metadata on elements, not elements themselves. Access the annotated
/// element via the parent.
abstract class AnnotationMirror {
  /// Annotation class name.
  String get name;
  
  /// Qualified name of annotation class.
  String get qualifiedName;
  
  /// Constructor name used (empty string for unnamed).
  String get constructorName;
  
  /// Positional arguments.
  List<Object?> get positionalArguments;
  
  /// Named arguments.
  Map<String, Object?> get namedArguments;
  
  /// The annotation class descriptor (if reflected).
  ClassMirror? get annotationClass;
  
  /// The actual annotation instance (if available as const).
  Object? get instance;
  
  /// Check if this annotation is of the given type.
  bool isType<T>();
}
```

### TypeParameterMirror

```dart
abstract class TypeParameterMirror implements Named {
  @override
  String get name;
  
  /// Upper bound type.
  TypeMirror? get bound;
  
  /// Upper bound as Dart Type.
  Type? get boundReflectedType;
  
  /// Variance (in, out, inout, or null for invariant).
  String? get variance;
}
```

---

## Global Members

Global (top-level) members use the same mirror types as class members, with `isGlobal == true`.

```dart
// Global function is just a MethodMirror where isGlobal == true
final parseJson = reflectionApi.findGlobalMethod('parseJson')!;
assert(parseJson.isGlobal);
assert(parseJson.owner == null);
parseJson.invoke(null, [jsonString]);

// Global variable is a FieldMirror where isGlobal == true
final appName = reflectionApi.findGlobalField('appName')!;
assert(appName.isGlobal);
String name = appName.getValue(null) as String;

// Global getter/setter similarly
final config = reflectionApi.findGlobalGetter('currentConfig')!;
assert(config.isGlobal);
```

The ReflectionApi provides dedicated methods for global access:

---

## ReflectionApi

The main entry point with comprehensive get/filter/process methods:

```dart
abstract class ReflectionApi {
  // ═══════════════════════════════════════════════════════════════════
  // Type Lookup by Dart Type (compile-time type known)
  // ═══════════════════════════════════════════════════════════════════
  
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
  
  // ═══════════════════════════════════════════════════════════════════
  // Type Lookup by Name (runtime name lookup)
  // ═══════════════════════════════════════════════════════════════════
  
  /// Find a class by name.
  /// Throws [AmbiguousNameError] if short name is not unique.
  /// Accepts "MyClass" or "package:my_pkg/file.dart.MyClass".
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
  ExtensionMirror? findExtensionByName(String name);
  
  /// Find all types matching a short name (for ambiguous names).
  List<TypeMirror<Object>> findAllByName(String shortName);
  
  // ═══════════════════════════════════════════════════════════════════
  // Instance Reflection
  // ═══════════════════════════════════════════════════════════════════
  
  /// Get the ClassMirror for an object's runtime type.
  ClassMirror<Object>? reflectInstance(Object instance);
  
  // ═══════════════════════════════════════════════════════════════════
  // All Types - Get, Filter, Process
  // ═══════════════════════════════════════════════════════════════════
  
  List<ClassMirror<Object>> get allClasses;
  List<EnumMirror<Object>> get allEnums;
  List<MixinMirror<Object>> get allMixins;
  List<ExtensionTypeMirror<Object>> get allExtensionTypes;
  List<ExtensionMirror> get allExtensions;
  List<TypeAliasMirror> get allTypeAliases;
  
  /// Filter classes matching the predicate.
  Iterable<ClassMirror<Object>> filterClasses(bool Function(ClassMirror) filter);
  
  /// Filter classes using a ClassFilter.
  Iterable<ClassMirror<Object>> filterClassesBy(ClassFilter filter);
  
  /// Process all classes.
  void processClasses(void Function(ClassMirror) processor);
  
  /// Process classes matching the filter.
  void processClassesWhere(bool Function(ClassMirror) filter, void Function(ClassMirror) processor);
  
  /// Similar for enums, mixins, etc.
  Iterable<EnumMirror<Object>> filterEnums(bool Function(EnumMirror) filter);
  void processEnums(void Function(EnumMirror) processor);
  // ...
  
  // ═══════════════════════════════════════════════════════════════════
  // Global Members - Get, Filter, Process
  // ═══════════════════════════════════════════════════════════════════
  
  /// All global methods (top-level functions).
  List<MethodMirror<Object?>> get allGlobalMethods;
  
  /// All global fields (top-level variables).
  List<FieldMirror<Object?>> get allGlobalFields;
  
  /// All global getters.
  List<GetterMirror<Object?>> get allGlobalGetters;
  
  /// All global setters.
  List<SetterMirror<Object?>> get allGlobalSetters;
  
  /// Find a global method by name.
  MethodMirror<Object?>? findGlobalMethod(String name);
  
  /// Find a global field by name.
  FieldMirror<Object?>? findGlobalField(String name);
  
  /// Find a global getter by name.
  GetterMirror<Object?>? findGlobalGetter(String name);
  
  /// Find a global setter by name.
  SetterMirror<Object?>? findGlobalSetter(String name);
  
  /// Filter global methods.
  Iterable<MethodMirror<Object?>> filterGlobalMethods(bool Function(MethodMirror) filter);
  
  /// Process global methods.
  void processGlobalMethods(void Function(MethodMirror) processor);
  
  // Similar for fields, getters, setters...
  
  // ═══════════════════════════════════════════════════════════════════
  // All Members (class + global combined)
  // ═══════════════════════════════════════════════════════════════════
  
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
  Iterable<MethodMirror<Object?>> filterAllMethods(bool Function(MethodMirror) filter);
  
  /// Process all methods (class + global).
  void processAllMethods(void Function(MethodMirror) processor);
  
  // Similar for fields, getters, setters, constructors...
  
  // ═══════════════════════════════════════════════════════════════════
  // Scoped APIs
  // ═══════════════════════════════════════════════════════════════════
  
  /// Get a package-scoped API.
  PackageApi forPackage(String package);
  
  /// Get a library-scoped API.
  LibraryApi forLibrary(String libraryUri);
  
  /// Get all packages with reflected types.
  List<String> get packages;
  
  /// Get all libraries with reflected types.
  List<String> get libraries;
  
  // ═══════════════════════════════════════════════════════════════════
  // Name Resolution
  // ═══════════════════════════════════════════════════════════════════
  
  /// Check if a short name is unique among all types.
  bool isUniqueName(String shortName);
  
  /// Get all types with the given short name.
  List<TypeMirror<Object>> findAllByName(String shortName);
  
  // ═══════════════════════════════════════════════════════════════════
  // Trait-Based Processing
  // ═══════════════════════════════════════════════════════════════════
  
  /// Filter typed elements.
  Iterable<Typed> filterTyped(TypedFilter filter);
  
  /// Process typed elements.
  void processTyped(TypedFilter filter, TypedProcessor processor);
  
  /// Filter invokable elements.
  Iterable<Invokable> filterInvokable(InvokableFilter filter);
  
  /// Process invokable elements.
  void processInvokable(InvokableFilter filter, InvokableProcessor processor);
  
  /// Filter owned elements.
  Iterable<OwnedElement> filterOwned(OwnedElementFilter filter);
  
  /// Process owned elements.
  void processOwned(OwnedElementFilter filter, OwnedElementProcessor processor);
  
  /// Filter generic elements.
  Iterable<GenericElement> filterGeneric(GenericElementFilter filter);
  
  /// Process generic elements.
  void processGeneric(GenericElementFilter filter, GenericElementProcessor processor);
  
  /// Filter accessible elements.
  Iterable<Accessible> filterAccessible(AccessibleFilter filter);
  
  /// Process accessible elements.
  void processAccessible(AccessibleFilter filter, AccessibleProcessor processor);
  
  // ═══════════════════════════════════════════════════════════════════
  // Element-Based Processing (all elements)
  // ═══════════════════════════════════════════════════════════════════
  
  /// All reflection elements (types, members, parameters).
  Iterable<Element> get allElements;
  
  /// All type elements (classes, enums, mixins, etc.).
  Iterable<Element> get allTypeElements;
  
  /// All member elements (methods, fields, getters, setters, constructors).
  Iterable<Element> get allMemberElements;
  
  /// Filter all elements matching the predicate.
  Iterable<Element> filterElements(bool Function(Element) filter);
  
  /// Filter all elements using an ElementFilter.
  Iterable<Element> filterElementsBy(ElementFilter filter);
  
  /// Process all elements matching the filter.
  void processElements(ElementFilter filter, ElementProcessor processor);
  
  /// Process all elements with a simple processor.
  void processAllElements(void Function(Element) processor);
  
  /// Find elements by kind.
  Iterable<Element> findByKind(ElementKind kind);
  
  /// Find elements in a specific package.
  Iterable<Element> findInPackage(String package);
  
  /// Find elements in a specific library.
  Iterable<Element> findInLibrary(String libraryUri);
}
```

---

## Scoped APIs

### PackageApi

Access reflection within a single package:

```dart
abstract class PackageApi {
  String get package;
  
  List<ClassMirror<Object>> get classes;
  List<EnumMirror<Object>> get enums;
  List<MixinMirror<Object>> get mixins;
  List<ExtensionTypeMirror<Object>> get extensionTypes;
  List<ExtensionMirror> get extensions;
  List<TypeAliasMirror> get typeAliases;
  
  List<MethodMirror<Object?>> get globalMethods;
  List<FieldMirror<Object?>> get globalFields;
  List<GetterMirror<Object?>> get globalGetters;
  List<SetterMirror<Object?>> get globalSetters;
  
  ClassMirror<Object>? findClassByName(String name);
  MethodMirror<Object?>? findGlobalMethod(String name);
  // ... other finders
  
  Iterable<ClassMirror<Object>> filterClasses(bool Function(ClassMirror) filter);
  void processClasses(void Function(ClassMirror) processor);
  // ... other filter/process methods
  
  /// Get a library-scoped API within this package.
  LibraryApi forLibrary(String libraryUri);
  
  /// All libraries in this package.
  List<String> get libraries;
}
```

### LibraryApi

Access reflection within a single library:

```dart
abstract class LibraryApi {
  String get libraryUri;
  String get package;
  
  List<ClassMirror<Object>> get classes;
  List<EnumMirror<Object>> get enums;
  List<MixinMirror<Object>> get mixins;
  List<ExtensionTypeMirror<Object>> get extensionTypes;
  List<ExtensionMirror> get extensions;
  List<TypeAliasMirror> get typeAliases;
  
  List<MethodMirror<Object?>> get globalMethods;
  List<FieldMirror<Object?>> get globalFields;
  List<GetterMirror<Object?>> get globalGetters;
  List<SetterMirror<Object?>> get globalSetters;
  
  ClassMirror<Object>? findClassByName(String name);
  MethodMirror<Object?>? findGlobalMethod(String name);
  // ... other finders
  
  Iterable<ClassMirror<Object>> filterClasses(bool Function(ClassMirror) filter);
  void processClasses(void Function(ClassMirror) processor);
  // ... other filter/process methods
}
```

---

## Filters

Pre-built filter factories for common patterns:

### ClassFilter

```dart
class ClassFilter {
  /// Filter by annotation type.
  static bool Function(ClassMirror) hasAnnotationType<T>() =>
    (cls) => cls.hasAnnotation<T>();
  
  /// Filter by annotation instance equality.
  static bool Function(ClassMirror) hasAnnotationInstance(Object annotation) =>
    (cls) => cls.annotations.any((a) => a.instance == annotation);
  
  /// Filter by superclass.
  static bool Function(ClassMirror) extendsClass(ClassMirror superclass) =>
    (cls) => cls.isSubtypeOfMirror(superclass);
  
  /// Filter by interface implementation.
  static bool Function(ClassMirror) implementsInterface(ClassMirror interface) =>
    (cls) => cls.implements(interface);
  
  /// Filter by mixin usage.
  static bool Function(ClassMirror) usesMixin(MixinMirror mixin) =>
    (cls) => cls.hasMixin(mixin);
  
  /// Filter abstract classes.
  static bool Function(ClassMirror) get isAbstract =>
    (cls) => cls.isAbstract;
  
  /// Filter concrete (non-abstract) classes.
  static bool Function(ClassMirror) get isConcrete =>
    (cls) => !cls.isAbstract;
  
  /// Filter by package.
  static bool Function(ClassMirror) inPackage(String package) =>
    (cls) => cls.package == package;
  
  /// Filter by name pattern.
  static bool Function(ClassMirror) nameMatches(RegExp pattern) =>
    (cls) => pattern.hasMatch(cls.name);
  
  /// Combine filters with AND.
  static bool Function(ClassMirror) and(List<bool Function(ClassMirror)> filters) =>
    (cls) => filters.every((f) => f(cls));
  
  /// Combine filters with OR.
  static bool Function(ClassMirror) or(List<bool Function(ClassMirror)> filters) =>
    (cls) => filters.any((f) => f(cls));
  
  /// Negate a filter.
  static bool Function(ClassMirror) not(bool Function(ClassMirror) filter) =>
    (cls) => !filter(cls);
}
```

### MethodFilter

```dart
class MethodFilter {
  /// Filter by annotation type.
  static bool Function(MethodMirror) hasAnnotationType<T>() =>
    (m) => m.hasAnnotation<T>();
  
  /// Filter instance methods only.
  static bool Function(MethodMirror) get isInstance =>
    (m) => !m.isStatic && !m.isGlobal;
  
  /// Filter static methods only.
  static bool Function(MethodMirror) get isStatic =>
    (m) => m.isStatic && !m.isGlobal;
  
  /// Filter global methods only.
  static bool Function(MethodMirror) get isGlobal =>
    (m) => m.isGlobal;
  
  /// Filter by return type.
  static bool Function(MethodMirror) returnsType<T>() =>
    (m) => m.returnReflectedType == T;
  
  /// Filter by parameter count.
  static bool Function(MethodMirror) hasParameterCount(int count) =>
    (m) => m.parameters.length == count;
  
  /// Filter by name pattern.
  static bool Function(MethodMirror) nameMatches(RegExp pattern) =>
    (m) => pattern.hasMatch(m.name);
  
  /// Filter extension methods only.
  static bool Function(MethodMirror) get isExtensionMethod =>
    (m) => m.isExtensionMember;
  
  /// Filter by owner class.
  static bool Function(MethodMirror) inClass(ClassMirror cls) =>
    (m) => m.owner == cls;
}
```

### FieldFilter

```dart
class FieldFilter {
  /// Filter by annotation type.
  static bool Function(FieldMirror) hasAnnotationType<T>() =>
    (f) => f.hasAnnotation<T>();
  
  /// Filter instance fields only.
  static bool Function(FieldMirror) get isInstance =>
    (f) => !f.isStatic && !f.isGlobal;
  
  /// Filter static fields only.
  static bool Function(FieldMirror) get isStatic =>
    (f) => f.isStatic && !f.isGlobal;
  
  /// Filter global fields only.
  static bool Function(FieldMirror) get isGlobal =>
    (f) => f.isGlobal;
  
  /// Filter read-only fields.
  static bool Function(FieldMirror) get isReadOnly =>
    (f) => f.isReadOnly;
  
  /// Filter mutable fields.
  static bool Function(FieldMirror) get isMutable =>
    (f) => !f.isReadOnly;
  
  /// Filter by field type.
  static bool Function(FieldMirror) hasType<T>() =>
    (f) => f.reflectedType == T;
  
  /// Filter by name pattern.
  static bool Function(FieldMirror) nameMatches(RegExp pattern) =>
    (f) => pattern.hasMatch(f.name);
  
  /// Filter by owner class.
  static bool Function(FieldMirror) inClass(ClassMirror cls) =>
    (f) => f.owner == cls;
}
```

### TypeFilter (for TypeMirror hierarchy)

```dart
class TypeFilter {
  /// Filter to classes only.
  static bool Function(TypeMirror) get isClass =>
    (t) => t is ClassMirror;
  
  /// Filter to enums only.
  static bool Function(TypeMirror) get isEnum =>
    (t) => t is EnumMirror;
  
  /// Filter to mixins only.
  static bool Function(TypeMirror) get isMixin =>
    (t) => t is MixinMirror;
  
  /// Filter to extension types only.
  static bool Function(TypeMirror) get isExtensionType =>
    (t) => t is ExtensionTypeMirror;
  
  /// Filter by package.
  static bool Function(TypeMirror) inPackage(String package) =>
    (t) => t.package == package;
  
  /// Filter by library.
  static bool Function(TypeMirror) inLibrary(String libraryUri) =>
    (t) => t.libraryUri == libraryUri;
  
  /// Filter by annotation type.
  static bool Function(TypeMirror) hasAnnotationType<T>() =>
    (t) => t.hasAnnotation<T>();
}
```

---

## Processors

Callback structures for exhaustive processing:

### TypeProcessor

```dart
/// Processor for all type mirror kinds.
class TypeProcessor {
  final void Function(ClassMirror)? onClass;
  final void Function(EnumMirror)? onEnum;
  final void Function(MixinMirror)? onMixin;
  final void Function(ExtensionTypeMirror)? onExtensionType;
  final void Function(ExtensionMirror)? onExtension;
  final void Function(TypeAliasMirror)? onTypeAlias;
  
  const TypeProcessor({
    this.onClass,
    this.onEnum,
    this.onMixin,
    this.onExtensionType,
    this.onExtension,
    this.onTypeAlias,
  });
  
  void process(TypeMirror type) {
    if (type is ClassMirror) onClass?.call(type);
    else if (type is EnumMirror) onEnum?.call(type);
    else if (type is MixinMirror) onMixin?.call(type);
    else if (type is ExtensionTypeMirror) onExtensionType?.call(type);
  }
}
```

### MemberProcessor

```dart
/// Processor for all member mirror kinds.
class MemberProcessor {
  final void Function(MethodMirror)? onMethod;
  final void Function(FieldMirror)? onField;
  final void Function(GetterMirror)? onGetter;
  final void Function(SetterMirror)? onSetter;
  final void Function(ConstructorMirror)? onConstructor;
  
  const MemberProcessor({
    this.onMethod,
    this.onField,
    this.onGetter,
    this.onSetter,
    this.onConstructor,
  });
  
  void process(MemberMirror member) {
    if (member is MethodMirror) onMethod?.call(member);
    else if (member is FieldMirror) onField?.call(member);
    else if (member is GetterMirror) onGetter?.call(member);
    else if (member is SetterMirror) onSetter?.call(member);
    else if (member is ConstructorMirror) onConstructor?.call(member);
  }
}
```

---

## Name Resolution

### Short Names vs Qualified Names

The API supports two naming styles for `findXxxByName` methods:

| Style | Example | Behavior |
|-------|---------|----------|
| Short name | `"MyClass"` | Works if unique, throws if ambiguous |
| Qualified name | `"package:my_pkg/src/file.dart.MyClass"` | Always unambiguous |

```dart
// Compile-time type known: use findClassByType<T>()
final userClass = reflectionApi.findClassByType<User>();

// Runtime name lookup: use findClassByName(String)
final userClass = reflectionApi.findClassByName('User');

// Using qualified name (always works)
final userClass = reflectionApi.findClassByName('package:my_app/models/user.dart.User');

// When short name is ambiguous:
// Given: package:a/file.dart defines User
//        package:b/file.dart defines User
reflectionApi.findClassByName('User'); // Throws AmbiguousNameError

// Solution 1: Use qualified name
reflectionApi.findClassByName('package:a/file.dart.User');

// Solution 2: Find all and filter
final users = reflectionApi.findAllByName('User');
final user = users.firstWhere((t) => t.package == 'a');
```

### AmbiguousNameError

```dart
class AmbiguousNameError extends Error {
  final String name;
  final List<String> qualifiedNames;
  
  AmbiguousNameError(this.name, this.qualifiedNames);
  
  @override
  String toString() => 
    'AmbiguousNameError: "$name" matches multiple types:\n'
    '${qualifiedNames.map((n) => '  - $n').join('\n')}';
}
```

### ReadOnlyFieldError

```dart
class ReadOnlyFieldError extends Error {
  final String fieldName;
  final String ownerName;
  
  ReadOnlyFieldError(this.fieldName, this.ownerName);
  
  @override
  String toString() => 
    'ReadOnlyFieldError: Field "$fieldName" in "$ownerName" is read-only';
}
```

---

## Usage Examples

### Type Relationships

```dart
final animal = reflectionApi.findClassByType<Animal>()!;
final dog = reflectionApi.findClassByType<Dog>()!;
final swimmer = reflectionApi.findMixinByType<Swimmer>()!;

// Check subtype relationships
print(dog.isSubtypeOf<Animal>()); // true
print(dog.isSubtypeOfMirror(animal)); // true
print(animal.isSupertypeOfMirror(dog)); // true

// Check interface implementation
print(dog.implements(reflectionApi.findClassByName('Runnable')!)); // true

// Check mixin usage
print(dog.hasMixin(swimmer)); // true

// Get superclass chain
ClassMirror? current = dog;
while (current != null) {
  print(current.name);
  current = current.superclass;
}
// Prints: Dog, Animal, Object
```

### Collection Factories

```dart
final userClass = reflectionApi.findClassByType<User>()!;

// Create typed collections
List<User> users = userClass.createList();
List<User?> nullableUsers = userClass.createNullableList();
Set<User> userSet = userClass.createSet();

// Create typed maps
Map<String, User> usersByName = userClass.createStringKeyedMap();
Map<String, User?> nullableUsersByName = userClass.createStringKeyedNullableMap();
Map<User, Object?> metadataByUser = userClass.createKeyedObjectMap();
Map<User, Object> nonNullMetadataByUser = userClass.createKeyedNonNullObjectMap();

// Generic map creation
Map<int, User> usersById = userClass.createValuedMap<int>();
Map<User, DateTime> createdAtByUser = userClass.createKeyedMap<DateTime>();
```

### Instance Creation and Invocation

```dart
final userClass = reflectionApi.findClassByType<User>()!;

// Create instances using constructor name
// Use '' (empty string) for unnamed constructor
User user1 = userClass.newInstance('', ['John', 25]);
User user2 = userClass.newInstance('fromJson', [jsonData]);

// Factory constructors are also accessed via newInstance
User user3 = userClass.newInstance('guest', []); // factory User.guest()

// Invoke methods
userClass.invokeMethod(user1, 'greet', ['Hello']);
Object? result = userClass.invokeStaticMethod('defaultAge');

// Property access
String name = userClass.getProperty(user1, 'name') as String;
userClass.setProperty(user1, 'age', 26);

// Check if property is read-only before setting
if (!userClass.isPropertyReadOnly('email')) {
  userClass.setProperty(user1, 'email', 'new@email.com');
}

// Static properties
int count = userClass.getStaticProperty('instanceCount') as int;
```

### Reflecting on Instances

```dart
Object unknownObject = getObject();

// Get the class mirror for this instance
final mirror = reflectionApi.reflectInstance(unknownObject);
if (mirror != null) {
  print('Type: ${mirror.name}');
  
  // Check type
  if (mirror.isSubtypeOfMirror(reflectionApi.findClassByName('Serializable')!)) {
    mirror.invokeMethod(unknownObject, 'toJson');
  }
  
  // Iterate properties
  for (final field in mirror.instanceFields.values) {
    final value = field.getValue(unknownObject);
    print('${field.name}: $value (readOnly: ${field.isReadOnly})');
  }
}
```

### Using Extensions

```dart
final userClass = reflectionApi.findClassByType<User>()!;

// Find extensions that apply to User
for (final ext in userClass.applicableExtensions) {
  print('Extension ${ext.name} applies to User');
  for (final method in ext.methods.values) {
    print('  - ${method.name}');
  }
}

// Check if specific extension applies
final jsonExt = reflectionApi.findExtensionByName('JsonExtensions')!;
if (userClass.hasExtension(jsonExt)) {
  print('User has JsonExtensions');
}

// Extension methods appear in instanceMethods with isExtensionMember == true
for (final method in userClass.instanceMethods.values) {
  if (method.isExtensionMember) {
    print('${method.name} from ${method.extension!.name}');
  }
}
```

### Filtering and Processing

```dart
// Find all classes with @Entity annotation
final entities = reflectionApi.filterClasses(
  ClassFilter.hasAnnotationType<Entity>()
);

// Process all classes implementing Repository
reflectionApi.processClasses(
  ClassFilter.implementsInterface(reflectionApi.findClassByName('Repository')!)
);

// Find all methods returning Future
final asyncMethods = reflectionApi.filterAllMethods(
  MethodFilter.returnsType<Future>()
);

// Process all read-only fields in all classes
reflectionApi.processClasses((cls) {
  for (final field in cls.instanceFields.values) {
    if (field.isReadOnly) {
      print('${cls.name}.${field.name} is read-only');
    }
  }
});

// Use scoped API for package-specific processing
final myPackageApi = reflectionApi.forPackage('my_package');
for (final cls in myPackageApi.classes) {
  print(cls.name);
}

// Complex filter: concrete classes with @Serializable in specific package
final serializable = reflectionApi.filterClasses(
  ClassFilter.and([
    ClassFilter.isConcrete,
    ClassFilter.hasAnnotationType<Serializable>(),
    ClassFilter.inPackage('my_models'),
  ])
);
```

### Working with Global Members

```dart
// Find global function
final parseJson = reflectionApi.findGlobalMethod('parseJson')!;
assert(parseJson.isGlobal);
final result = parseJson.invoke(null, [jsonString]);

// Find global variable
final appConfig = reflectionApi.findGlobalField('appConfig')!;
assert(appConfig.isGlobal);

if (appConfig.isReadOnly) {
  // Read-only global
  final config = appConfig.getValue(null);
} else {
  // Mutable global
  appConfig.setValue(null, newConfig);
}

// Filter all global methods by annotation
final commands = reflectionApi.filterGlobalMethods(
  MethodFilter.and([
    MethodFilter.isGlobal,
    MethodFilter.hasAnnotationType<Command>(),
  ])
);
```

### Using Processors

```dart
// Process all types with exhaustive handling
reflectionApi.processClasses((cls) {
  TypeProcessor(
    onClass: (c) => print('Class: ${c.name}'),
    onEnum: (e) => print('Enum: ${e.name}'),
    onMixin: (m) => print('Mixin: ${m.name}'),
  ).process(cls);
});

// Process all members of a class
final userClass = reflectionApi.findClassByType<User>()!;
final memberProcessor = MemberProcessor(
  onMethod: (m) => print('Method: ${m.name}'),
  onField: (f) => print('Field: ${f.name} (${f.isReadOnly ? 'readonly' : 'mutable'})'),
  onGetter: (g) => print('Getter: ${g.name}'),
  onSetter: (s) => print('Setter: ${s.name}'),
  onConstructor: (c) => print('Constructor: ${c.name.isEmpty ? '(unnamed)' : c.name}'),
);

for (final method in userClass.instanceMethods.values) {
  memberProcessor.process(method);
}
for (final field in userClass.instanceFields.values) {
  memberProcessor.process(field);
}
```

### Annotation Processing

```dart
// Find all classes with a specific annotation
for (final cls in reflectionApi.allClasses) {
  final jsonAnnotation = cls.annotations.firstWhereOrNull(
    (a) => a.qualifiedName == 'package:json_annotation/json_annotation.dart.JsonSerializable'
  );
  
  if (jsonAnnotation != null) {
    print('${cls.name} is JSON serializable');
    
    // Access annotation arguments
    final explicitNull = jsonAnnotation.namedArguments['explicitToJson'] as bool?;
  }
}

// Using Element filter for annotation-based filtering
final annotatedTypes = reflectionApi.filterElements(
  ElementFilter.hasAnnotation<Serializable>()
);

// Process all deprecated elements
reflectionApi.processElements(
  ElementFilter.hasAnnotation<Deprecated>(),
  ElementProcessor(
    processClass: (cls) => print('Deprecated class: ${cls.name}'),
    processMethod: (m) => print('Deprecated method: ${m.owner?.name}.${m.name}'),
    processField: (f) => print('Deprecated field: ${f.owner?.name}.${f.name}'),
  ),
);
```

### Enum Handling

```dart
final statusEnum = reflectionApi.findEnumByType<Status>()!;

// Get all values
List<Status> allStatuses = statusEnum.values;

// Lookup by name
Status? pending = statusEnum.valueOf('pending');

// Create typed collections
List<Status> statusList = statusEnum.createList();
Set<Status> statusSet = statusEnum.createSet();
```

---

## Generated Output Structure

### Compact Index-Based Format

For practical use with large codebases, reflection data is generated using a **compact index-based format** rather than individual class definitions. This approach minimizes file size and memory usage by:

1. **Storing all elements in flat arrays** indexed by integer
2. **Referencing related elements via integer indices** instead of object references
3. **Using bit flags** for boolean properties instead of individual fields
4. **Sharing common accessor closures** across all classes
5. **Hierarchical package/library structure** for organizational queries
6. **Indexed invokers** referenced by members to reduce closure duplication

This format is based on the proven `tom_reflection` package which handles projects with thousands of classes efficiently.

#### Structure Overview

```dart
// Generated: my_app.reflection.dart

import 'package:tom_analyzer/reflection_runtime.dart' as r;
import 'package:my_app/models/user.dart' as p0;
import 'package:my_app/models/order.dart' as p1;

// ═══════════════════════════════════════════════════════════════════
// Bit flag constants for element descriptors
// ═══════════════════════════════════════════════════════════════════

// Class flags (combined into single int)
const _abstract = 1 << 0;
const _mixin = 1 << 1;
const _sealed = 1 << 2;
const _final = 1 << 3;
// ... etc.

// Member flags
const _static = 1 << 0;
const _final = 1 << 1;
const _const = 1 << 2;
const _late = 1 << 3;
const _getter = 1 << 4;
const _setter = 1 << 5;
const _method = 1 << 6;
const _constructor = 1 << 7;
const _factory = 1 << 8;
const _extension = 1 << 9;  // Extension method (appears on ClassMirror)
// ... etc.

// ═══════════════════════════════════════════════════════════════════
// Package and Library Structure (double-indexed)
// ═══════════════════════════════════════════════════════════════════

// Packages array - each package contains library indices
const _packages = <r.PackageData>[
  // Index 0: my_app package
  r.PackageData('my_app', const [0, 1, 2]),  // library indices
  // Index 1: my_shared package  
  r.PackageData('my_shared', const [3, 4]),
];

// Libraries array - each library belongs to a package
const _libraries = <r.LibraryData>[
  // Index 0: user.dart
  r.LibraryData(
    'package:my_app/models/user.dart',
    0,                    // package index
    const [0, 1],         // type indices in this library
    const [0, 1, 2],      // declaration indices in this library
  ),
  // Index 1: order.dart
  r.LibraryData('package:my_app/models/order.dart', 0, const [2], const [3, 4]),
  // ... more libraries
];

// ═══════════════════════════════════════════════════════════════════
// Invokers Array (referenced by index from members)
// ═══════════════════════════════════════════════════════════════════

// Unified invoker list - both instance and static methods use dynamic dispatch
// Static methods CAN be called via dynamic: (Type as dynamic).staticMethod()
// This allows sharing the invoker infrastructure.
const _invokers = <Function>[
  // Index 0: name getter (shared across all types with 'name' property)
  (dynamic i) => i.name,
  // Index 1: name setter
  (dynamic i, dynamic v) => i.name = v,
  // Index 2: age getter
  (dynamic i) => i.age,
  // Index 3: age setter
  (dynamic i, dynamic v) => i.age = v,
  // Index 4: greet method
  (dynamic i, List args, Map<Symbol, dynamic> named) => 
      Function.apply(i.greet, args, named),
  // Index 5: toString (inherited, shared)
  (dynamic i) => i.toString(),
  // Index 6: hashCode (inherited, shared)
  (dynamic i) => i.hashCode,
  // Index 7: == operator
  (dynamic i, dynamic other) => i == other,
  // Index 8: User.fromJson (static - called via type)
  (List args, Map<Symbol, dynamic> named) => 
      Function.apply(p0.User.fromJson, args, named),
  // Index 9: User() constructor
  (List args, Map<Symbol, dynamic> named) => 
      Function.apply(p0.User.new, args, named),
  // Index 10: JsonExtensions.toJsonString (extension method on User)
  (dynamic i, List args, Map<Symbol, dynamic> named) =>
      Function.apply(JsonExtensions(i).toJsonString, args, named),
  // ... more invokers
];

// ═══════════════════════════════════════════════════════════════════
// Reflection Data Structure
// ═══════════════════════════════════════════════════════════════════

final _reflectionData = r.ReflectionData(
  packages: _packages,
  libraries: _libraries,
  invokers: _invokers,

  // ─────────────────────────────────────────────────────────────────
  // Type mirrors array (classes, enums, mixins, extension types, aliases)
  // Elements reference library by (packageIndex, libraryIndex) or single index
  // ─────────────────────────────────────────────────────────────────
  types: <r.TypeMirrorData>[
    // Index 0: User class
    r.ClassMirrorData<p0.User>(
      'User',                                    // simple name
      0x00000023,                                // descriptor flags
      0,                                         // library index
      const [0, 1, 2, 10],                       // own declaration indices (incl. extension methods!)
      const [3, 4, 5, 6, 7, 0, 1, 2, 10],        // all instance members (inherited + extensions)
      const [8],                                 // static member indices
      1,                                         // superclass type index (-1 if Object)
      const [],                                  // interface type indices
      const [],                                  // mixin type indices
      const [20],                                // applicable extension indices
      const [100],                               // annotation indices
      const [9, 8],                              // constructor invoker indices (unnamed, fromJson)
    ),
    // ... more types
  ],

  // ─────────────────────────────────────────────────────────────────
  // Declaration mirrors (methods, fields, getters, setters)
  // Each references its invoker by index
  // ─────────────────────────────────────────────────────────────────
  declarations: <r.DeclarationMirrorData>[
    // Index 0: User.name field
    r.FieldMirrorData(
      'name',           // name
      0x00000003,       // flags: final, instance
      0,                // owner type index
      50,               // type ref index (String)
      0,                // getter invoker index
      -1,               // setter invoker index (-1 = read-only, no invoker)
      const [],         // annotation indices
    ),
    // Index 1: User.age field
    r.FieldMirrorData('age', 0x00000001, 0, 51, 2, 3, const []),
    // Index 2: User.greet method
    r.MethodMirrorData(
      'greet',          // name
      0x00000040,       // flags: method, instance
      0,                // owner type index
      -1,               // return type index (void = -1)
      4,                // invoker index
      const [0],        // parameter indices
      const [],         // type parameter indices
      const [],         // annotation indices
    ),
    // Index 10: User.toJsonString (extension method - appears on ClassMirror!)
    r.MethodMirrorData(
      'toJsonString',
      0x00000240,       // flags: method, instance, extension
      0,                // owner type index (User, not the extension!)
      52,               // return type index (String)
      10,               // invoker index
      const [],
      const [],
      const [],
    ),
    // ... more declarations
  ],

  // ─────────────────────────────────────────────────────────────────
  // Parameter mirrors array
  // ─────────────────────────────────────────────────────────────────
  parameters: <r.ParameterMirrorData>[
    // Index 0: greet(String message) parameter
    r.ParameterMirrorData('message', 0x00000001, 2, 50, null),
    // ... more parameters
  ],

  // ─────────────────────────────────────────────────────────────────
  // Type references (for generic types and primitives)
  // ─────────────────────────────────────────────────────────────────
  typeRefs: <Type>[
    p0.User,    // 0
    Object,     // 1
    p1.Order,   // 2
    // ... 50: String, 51: int, 52: String, etc.
  ],
);

// ═══════════════════════════════════════════════════════════════════
// Runtime API initialization with lazy filtering
// ═══════════════════════════════════════════════════════════════════

void initializeReflection() {
  r.registerReflectionData(_reflectionData);
}

final reflectionApi = r.ReflectionApi.fromData(_reflectionData);
```

#### Extension Methods on ClassMirror

Extension methods are **included directly on ClassMirror** as regular instance methods with the `isExtensionMember` flag set. Since all applicable extensions are known at generation time, there's no need for a separate lookup mechanism:

```dart
final userClass = reflectionApi.findClassByType<User>()!;

// Extension methods appear alongside regular instance methods
for (final method in userClass.instanceMethods.values) {
  if (method.isExtensionMember) {
    print('${method.name} from extension ${method.extensionName}');
  }
}

// Invoke extension method like any other method
final jsonString = userClass.invokeMethod(user, 'toJsonString');

// Filter to get only extension methods
final extensionMethods = userClass.instanceMethods.values
    .where((m) => m.isExtensionMember);
```

**Why this design:**
1. **Unified access**: All methods on a class in one place
2. **No runtime extension discovery**: We can't support runtime extensions anyway
3. **Simplified invocation**: Same `invokeMethod` API for all methods
4. **Clear ownership**: Extension methods have `owner` pointing to the class they extend

The `ExtensionMirror` type still exists for metadata purposes (getting the extension's name, type constraints, etc.) but is not the primary access point.

#### Static Methods and Dynamic Dispatch

**Q: Can static methods be called via dynamic?**

Yes! In Dart, you can call static members via a `Type` object cast to dynamic:

```dart
// This works at runtime:
final Type userType = User;
(userType as dynamic).fromJson({'name': 'John'});  // ✓ Works!
```

This allows **unified invoker infrastructure** for both instance and static methods:

```dart
// Same invoker pattern for static methods
const _invokers = [
  // Instance method invoker
  (dynamic instance, List args, Map<Symbol, dynamic> named) =>
      Function.apply(instance.greet, args, named),
  
  // Static method invoker - use Type as the "instance"
  (dynamic type, List args, Map<Symbol, dynamic> named) =>
      Function.apply((type as Type).fromJson, args, named),  // Conceptually
  
  // In practice, just call the static directly:
  (List args, Map<Symbol, dynamic> named) =>
      Function.apply(User.fromJson, args, named),
];
```

However, for **simplicity and performance**, static invokers typically call the method directly rather than going through dynamic dispatch, as the target type is known at generation time.

#### Size Comparison

| Approach | ~100 classes | ~1000 classes | ~10000 classes |
|----------|--------------|---------------|----------------|
| Verbose class-per-mirror | ~500 KB | ~5 MB | ~50 MB |
| Compact index-based | ~50 KB | ~500 KB | ~5 MB |
| With invoker dedup | ~40 KB | ~400 KB | ~4 MB |
| **Total Reduction** | **~92%** | **~92%** | **~92%** |

#### Key Design Principles

1. **Index References**: All cross-references use integer indices into arrays
2. **Bit Flags**: Boolean properties packed into descriptor integers
3. **Indexed Invokers**: Invoker closures in a flat list, referenced by index
4. **Package/Library Hierarchy**: Double-indexed structure for organizational queries
5. **Extension Methods on Classes**: Extensions appear directly on ClassMirror
6. **Lazy Resolution**: Mirror objects created on-demand from data
7. **Const Arrays**: All index arrays are `const` for tree-shaking

---

### Scope Filtering with Negative Invoker Indices

To reduce generated code size while maintaining metadata completeness, the reflection system uses **negative invoker indices** within declarations to indicate members that exist but are not fully covered (no invoker generated).

#### Key Insight: Declaration vs Invoker Indices

There are two distinct index spaces:

| Index Type | Where Used | Negative Meaning |
|------------|------------|------------------|
| **Declaration index** | In type's member lists | Always `>= 0` - declarations always exist |
| **Invoker index** | Within a declaration | Negative = no invoker for this member |

This means:
- **Member lists always contain valid declaration indices** (inherited members reference the parent's declaration)
- **The declaration itself indicates whether it's covered** via its invoker index

```dart
// Example: Dog extends Animal
// Animal.walk() is covered, Dog inherits it

declarations: [
  // Index 0: Animal.walk - covered
  r.MethodMirrorData('walk', 0x40, 0, -1, 5, ...),  // invokerIndex = 5 (covered)
  // Index 1: Dog.bark - covered  
  r.MethodMirrorData('bark', 0x40, 1, -1, 6, ...),  // invokerIndex = 6 (covered)
  // Index 2: ExternalBase.foo - NOT covered
  r.MethodMirrorData('foo', 0x40, 2, -1, -1, ...),  // invokerIndex = -1 (not covered)
],

types: [
  // Animal
  r.ClassMirrorData('Animal', ..., const [0], ...),     // own members: [0]
  // Dog - references Animal's declaration directly
  r.ClassMirrorData('Dog', ..., const [0, 1], ...),    // instance members: [0, 1] (inherited + own)
  // MyClass extends ExternalBase
  r.ClassMirrorData('MyClass', ..., const [2, 3], ...), // includes uncovered inherited [2]
],
```

#### Negative Invoker Index Convention

| Invoker Index | Meaning |
|---------------|---------|
| `>= 0` | Fully covered - invoker exists at this index |
| `-1` | **Not covered** - member exists but no invoker generated |
| `-2` | **External** - from external package, not covered |
| `-3` | **Excluded** - explicitly excluded by configuration |
| `-4` | **Private** - private member included for information only |
| `< -100` | **Encoded flags** - bit pattern with multiple conditions |

#### Private Members

Private members (names starting with `_`) can optionally be included in reflection output for informational purposes:

- **Excluded by default** to avoid clutter
- **When included**: Declaration exists with full metadata (name, type, parameters)
- **Never invokable**: Invoker index is always `-4` (private)
- **Use case**: Debugging, documentation, serialization schemas

```yaml
# tom_analyzer.yaml
reflection:
  include_private: true  # Include private members (default: false)
```

```dart
// With include_private: true
r.FieldMirrorData(
  '_internalCache',
  0x00000005,       // flags: private, instance
  0,                // owner type index
  50,               // type index
  -4,               // getter invoker = -4 (private, not invokable)
  -4,               // setter invoker = -4 (private, not invokable)
  const [],
),
```

#### Bit Pattern Encoding (for complex filtering)

For invoker indices less than -100, the value encodes multiple flags:

```dart
// Negative invoker index bit encoding (starting at -101)
// Bits 0-3: Exclusion reason
const _notCovered = 1 << 0;      // No invoker generated
const _external = 1 << 1;        // From external package
const _depthLimited = 1 << 2;    // Beyond inheritance depth limit
const _private = 1 << 3;         // Private member

// Bits 4-7: Element source  
const _fromInterface = 1 << 4;   // Via interface implementation
const _fromMixin = 1 << 5;       // Via mixin application
const _synthetic = 1 << 6;       // Compiler-generated

// Encode: -(101 + flags)
// Decode: flags = -(index + 101)

int encodeFilteredIndex(int flags) => -(101 + flags);
int decodeFlags(int index) => -(index + 101);

// Example: from external mixin, not covered
const exampleIndex = -(101 + _notCovered + _external + _fromMixin);
// = -103 - 32 = -135

// Decode:
final flags = decodeFlags(-135); // = 34 (binary: 100010)
final isNotCovered = (flags & _notCovered) != 0;   // false (bit 0)
final isExternal = (flags & _external) != 0;       // true (bit 1)
final isFromMixin = (flags & _fromMixin) != 0;     // true (bit 5)
```

#### Runtime API for Filtered Elements

```dart
abstract class DeclarationMirror {
  /// The invoker index, or negative if not covered.
  int get invokerIndex;
  
  /// True if this member has an invoker and can be invoked.
  bool get isCovered => invokerIndex >= 0;
  
  /// True if this member exists but is not invokable.
  bool get isNotCovered => invokerIndex < 0;
  
  /// True if this is a private member (included for information only).
  bool get isPrivate => invokerIndex == -4 || 
      (invokerIndex < -100 && (decodeFlags(invokerIndex) & _private) != 0);
  
  /// Get the filter reason (if not covered).
  FilterReason? get filterReason {
    if (invokerIndex >= 0) return null;
    if (invokerIndex == -1) return FilterReason.notCovered;
    if (invokerIndex == -2) return FilterReason.external;
    if (invokerIndex == -3) return FilterReason.excluded;
    if (invokerIndex == -4) return FilterReason.private;
    // Decode bit pattern
    return FilterReason.fromFlags(decodeFlags(invokerIndex));
  }
  
  /// Throws if not covered.
  dynamic invoke(Object instance, [List args = const [], Map<Symbol, dynamic> named = const {}]) {
    if (!isCovered) {
      throw UncoveredMemberError(name, filterReason);
    }
    return _invokers[invokerIndex](instance, args, named);
  }
}

enum FilterReason {
  notCovered,
  external,
  excluded,
  private,
  depthLimited,
  // ... etc.
  
  static FilterReason fromFlags(int flags) {
    // Decode and return most specific reason
  }
}
```

#### Configuration for Scope Filtering

Filters control what gets included and excluded. They are processed **top to bottom**, with later filters refining earlier ones. All elements reachable from entry points are included by default, including their transitive dependencies (interfaces, base classes, mixins).

```yaml
# tom_analyzer.yaml
entry_points:
  - lib/my_app.dart

output: lib/my_app.r.dart

# Filters are processed in order
filters:
  # Filter 1: Include all code reachable from entry points (default behavior)
  - include: reachable
  
  # Filter 2: Exclude framework packages
  - exclude:
      packages:
        - flutter
        - flutter_*        # Wildcard matching
        - dart:*           # Dart SDK
  
  # Filter 3: Also include any class with @Entity annotation
  - include:
      annotations:
        - 'package:my_app/models.dart#Entity'
  
  # Filter 4: Exclude test-only code by path
  - exclude:
      paths:
        - '**/test/**'
        - '**/*_test.dart'

# Global settings
include_private: false              # Include private members (default: false)
follow_reexports: true              # Follow re-exports by default
skip_reexports:                     # Never follow re-exports from these
  - flutter
```

#### Filter Properties

Each filter can use these selectors:

| Selector | Description | Example |
|----------|-------------|---------|
| `packages` | Package names (wildcards allowed) | `my_app`, `flutter_*` |
| `annotations` | Qualified annotation names | `package:my_app/a.dart#Entity` |
| `paths` | File path patterns (glob) | `lib/models/**`, `**/*_test.dart` |
| `classes` | Class name patterns (regex) | `*Service`, `Base*` |
| `external_interfaces` | Auto-include interfaces from external packages | `true/false` |
| `external_mixins` | Auto-include mixins from external packages | `true/false` |
| `external_inheritance_depth` | Limit inheritance depth for external packages | `2` |

#### Transitive Dependency Inclusion

By default, the generator includes all types needed by covered types:

- **Superclasses**: Always included (needed for inheritance)
- **Interfaces**: Included if implemented by covered classes
- **Mixins**: Included if applied to covered classes  
- **Type arguments**: Included if used in generic types
- **Extension methods**: Included if applied to covered types

This ensures consistent reflection data. Even if you don't explicitly "include interfaces", they're included if any covered class implements them.

#### Example: Filtered Output

```dart
// User extends ExternalBase which has 50 methods
// We only want to invoke User's own methods

// Declarations - all exist, but some have negative invoker indices
declarations: [
  // Index 0: User.name - covered
  r.FieldMirrorData('name', 0x03, 0, 50, 0, -1, const []),   // getter invoker=0
  // Index 1: User.age - covered
  r.FieldMirrorData('age', 0x01, 0, 51, 2, 3, const []),     // getter=2, setter=3
  // Index 2: User.greet - covered
  r.MethodMirrorData('greet', 0x40, 0, -1, 4, ...),          // invoker=4
  // Index 3: ExternalBase.someMethod - NOT covered
  r.MethodMirrorData('someMethod', 0x40, 1, -1, -2, ...),    // invoker=-2 (external)
  // Index 4: ExternalBase.anotherMethod - NOT covered
  r.MethodMirrorData('anotherMethod', 0x40, 1, -1, -2, ...),
  // Index 5: Object.toString - covered (commonly used)
  r.MethodMirrorData('toString', 0x40, 2, 52, 5, ...),       // invoker=5
  // Index 6: Object.hashCode - covered
  r.MethodMirrorData('hashCode', 0x50, 2, 51, 6, ...),       // invoker=6
  // Index 7: User._cache - private (info only)
  r.FieldMirrorData('_cache', 0x05, 0, 53, -4, -4, const []), // invoker=-4 (private)
],

// User type - all members referenced by declaration index
r.ClassMirrorData<User>(
  'User',
  0x00000023,
  0,  // library
  const [0, 1, 2, 7],              // own declarations (incl. private)
  const [0, 1, 2, 3, 4, 5, 6, 7],  // all instance members (inherited + own)
  // ...
),
```

#### Benefits

1. **Complete metadata**: Member lists show all members, including inherited and private
2. **Minimal code size**: Invokers only for what's needed
3. **Clear errors**: Attempting to invoke uncovered member gives informative error
4. **Flexible configuration**: Tune coverage per-project
5. **Queryable**: Can filter members by coverage status
6. **Shared declarations**: Inherited members reference parent's declaration (no duplication)

---

## Invocation Strategy

All invocations use statically generated closures:

| Target | Generated Code |
|--------|----------------|
| Instance method | `(instance as Foo).bar(args...)` |
| Static method | `Foo.bar(args...)` |
| Unnamed constructor | `Foo.new(args...)` (name == '') |
| Named constructor | `Foo.named(args...)` |
| Factory constructor | Same as named constructor |
| Instance field get | `(instance as Foo).field` |
| Instance field set | `(instance as Foo).field = value` |
| Static/global field get | `Foo.field` or `globalField` |
| Static/global field set | `Foo.field = value` or `globalField = value` |
| Global function | `myFunction(args...)` |

No `dart:mirrors` is required.

---

## Summary of Type Parameters

| Mirror Type | Type Parameter | Meaning |
|-------------|----------------|---------|
| `ClassMirror<T>` | T | The class type |
| `EnumMirror<T>` | T extends Enum | The enum type |
| `MixinMirror<T>` | T | The mixin type |
| `ExtensionTypeMirror<T>` | T | The extension type |
| `ConstructorMirror<T>` | T | The type being constructed |
| `MethodMirror<R>` | R | The return type |
| `FieldMirror<T>` | T | The field type |
| `GetterMirror<T>` | T | The return type |
| `SetterMirror<T>` | T | The value type |
| `ParameterMirror<T>` | T | The parameter type |

---

## Private Members

Private members (names starting with `_`) are excluded from reflection output to avoid library privacy violations. Only public symbols are reflected.

---

## Project Hierarchy and Scope Management

### The Challenge

When reflecting a hierarchy of packages (a package that depends on other packages), the reflection output can grow very large. Consider:

- Your app depends on 50 packages
- Each package has ~100 classes on average
- Total: ~5000 classes to potentially reflect

Reflecting everything is impractical and unnecessary.

### Single Reflection File Per Entry Point

The reflection generator always produces **exactly one reflection file** per entry point or configuration. This ensures:

1. **Single source of truth** for reflection data
2. **No conflicts** between multiple reflection sources
3. **Predictable behavior** - one import, one API
4. **Correct extension method handling** - extensions are resolved in a single context

For applications with multiple binaries (CLI, server, etc.), each entry point generates its own reflection file:

```yaml
# tom_analyzer.yaml for multi-entry project
entry_points:
  - bin/cli.dart
  - bin/server.dart
```

This generates:
- `bin/cli.r.dart` - reflection for CLI entry point
- `bin/server.r.dart` - reflection for server entry point

### Filtering Strategies

#### 1. Entry Point Reachability (Default)

Analyze only code reachable from the entry point file:

```yaml
# tom_analyzer.yaml
entry_points:
  - lib/main.dart
  - bin/server.dart

filters:
  - include: reachable
```

This follows imports recursively from entry points and includes only types actually used, plus all their dependencies (superclasses, interfaces, mixins).

#### 2. Package Filtering

Include or exclude entire packages:

```yaml
entry_points:
  - lib/main.dart

filters:
  - include: reachable
  - exclude:
      packages:
        - flutter       # Framework internals
        - flutter_*     # Flutter plugins
        - dart:*        # Dart SDK
        - test          # Test-only code
```

#### 3. Annotation-Based Filtering

Include only types with specific annotations:

```yaml
entry_points:
  - lib/main.dart

filters:
  - include:
      annotations:
        - 'package:my_app/annotations.dart#Reflectable'
        - 'package:my_app/annotations.dart#Entity'
        - 'package:tom_core_kernel/reflection.dart#TomReflector'
```

#### 4. Combined Filtering

Multiple strategies can be combined:

```yaml
entry_points:
  - lib/main.dart

filters:
  # Start with reachable code
  - include: reachable
  
  # Exclude framework packages
  - exclude:
      packages:
        - flutter
        - dart:*
  
  # Also include all @Entity classes even if not directly reachable
  - include:
      annotations:
        - 'package:my_app/models.dart#Entity'
  
  # Exclude test files by path
  - exclude:
      paths:
        - '**/test/**'
        - '**/*_test.dart'
```

### Inheritance Depth Configuration

Control how deep to follow type hierarchies into external packages:

```yaml
filters:
  - include: reachable
  - options:
      # How many levels of superclasses from external packages
      external_inheritance_depth: 2  # Default: 2
      
      # Include interface declarations from external packages
      external_interfaces: true  # Default: true (needed for covered classes)
      
      # Include mixin declarations from external packages
      external_mixins: true  # Default: true

  # Packages exempt from depth limits (always full hierarchy)
  - include:
      packages:
        - my_shared_base
        - my_core
      options:
        external_inheritance_depth: -1  # Unlimited for these
```

#### Depth Behavior

| Depth | What's Included |
|-------|-----------------|
| 0 | Only own package types, no external superclasses |
| 1 | Immediate external superclass only |
| 2 (default) | External superclass + its parent |
| -1 (unlimited) | Full hierarchy including dart:core |

### Output File Naming

| Scenario | Output Path |
|----------|-------------|
| Default (entry point) | `lib/main.dart` → `lib/main.r.dart` |
| Explicit output | Specified via `output` in config |
| Binary entry point | `bin/server.dart` → `bin/server.r.dart` |

### Best Practices

1. **One entry point per reflection file**: Each binary or library barrel gets its own reflection
2. **Start with reachable**: Use entry point reachability as the base
3. **Annotate explicitly**: Mark types needing reflection with `@Reflectable`
4. **Exclude frameworks**: Always exclude `flutter`, `dart:*` packages
5. **Monitor output size**: Keep reflection files under 1MB for fast startup
6. **Use path filters** to exclude test code and generated files

### Size Estimation

Approximate reflection file sizes:

| Types Reflected | Approximate Size |
|-----------------|------------------|
| 50 classes | ~25 KB |
| 100 classes | ~50 KB |
| 500 classes | ~250 KB |
| 1000 classes | ~500 KB |
| 5000 classes | ~2.5 MB |

---

## Analysis-Time API

The `EntryPointAnalyzer` provides build-time analysis capabilities separate from the runtime reflection API. These APIs help with code generation, tooling, and static analysis.

### AnalysisResult

The `AnalysisResult` class returned by `EntryPointAnalyzer.analyze()` provides access to all discovered elements:

```dart
class AnalysisResult {
  // Type collections
  final List<ClassElement> classes;
  final List<EnumElement> enums;
  final List<MixinElement> mixins;
  final List<ExtensionElement> extensions;
  final List<ExtensionTypeElement> extensionTypes;
  final List<TypeAliasElement> typeAliases;
  
  // Global members
  final List<FunctionElement> globalFunctions;
  final List<TopLevelVariableElement> globalVariables;
  
  // Package/Library structure
  final Map<String, List<String>> packageLibraries;
  final Map<String, List<InterfaceElement>> libraryTypes;
  
  // Counts
  int get typeCount;
  int get globalMemberCount;
  
  // ═══════════════════════════════════════════════════════════════════
  // Annotation API (convenience methods for annotation discovery)
  // ═══════════════════════════════════════════════════════════════════
  
  /// All discovered annotations with their usages.
  Map<String, AnnotationInfo> get annotations;
  
  /// Find all elements annotated with a specific annotation name.
  List<Element> getAnnotatedElements(String annotationName);
  
  /// Find all elements annotated with a specific type.
  List<Element> getAnnotatedElementsOfType<T>();
  
  /// Check if any element has a specific annotation.
  bool hasAnnotation(String annotationName);
  
  // ═══════════════════════════════════════════════════════════════════
  // Flattened member access (all members across all types)
  // ═══════════════════════════════════════════════════════════════════
  
  /// All methods from all classes.
  List<MethodElement> get allMethods;
  
  /// All fields from all classes.
  List<FieldElement> get allFields;
  
  /// All constructors from all classes.
  List<ConstructorElement> get allConstructors;
  
  /// All accessors (getters/setters) from all classes.
  List<PropertyAccessorElement> get allAccessors;
}
```

### AnnotationInfo

Detailed information about an annotation and its usages:

```dart
class AnnotationInfo {
  /// Annotation name (e.g., "override", "Deprecated", "tomReflector").
  final String name;
  
  /// Fully qualified name of the annotation class/variable.
  final String qualifiedName;
  
  /// Source library URI.
  final String sourceLibrary;
  
  /// All elements annotated with this annotation.
  final List<AnnotatedElementInfo> usages;
  
  /// Number of usages.
  int get usageCount => usages.length;
  
  /// Usages grouped by element kind.
  Map<String, List<AnnotatedElementInfo>> get usagesByKind;
}

class AnnotatedElementInfo {
  /// Element name.
  final String name;
  
  /// Fully qualified name.
  final String qualifiedName;
  
  /// Element kind (class, method, field, etc.).
  final String kind;
  
  /// Library containing the element.
  final String library;
  
  /// The actual element (for further analysis).
  final Element element;
  
  /// Annotation arguments (if available).
  final Map<String, dynamic>? arguments;
}
```

### Usage Examples

```dart
// Analyze entry points
final config = ReflectionConfig.load(path: 'tom_analyzer.yaml');
final analyzer = EntryPointAnalyzer(config);
final result = await analyzer.analyze();

// Find all classes with @tomReflector annotation
final reflectableClasses = result.getAnnotatedElements('tomReflector')
    .whereType<ClassElement>()
    .toList();

// Get annotation usage statistics
for (final entry in result.annotations.entries) {
  final name = entry.key;
  final info = entry.value;
  print('@$name: ${info.usageCount} usages');
  
  for (final kind in info.usagesByKind.keys) {
    print('  $kind: ${info.usagesByKind[kind]!.length}');
  }
}

// Find all deprecated methods
final deprecatedMethods = result.allMethods
    .where((m) => m.metadata.any((a) => 
        a.element?.enclosingElement3?.name == 'Deprecated'))
    .toList();

// Check if serialization annotations are used
if (result.hasAnnotation('JsonSerializable')) {
  print('Project uses JSON serialization');
}
```

### Annotation Filter in Config

Filter types based on annotations in the configuration file:

```yaml
filters:
  - include:
      annotations:
        - tomReflector
        - Serializable
        - JsonSerializable
      options:
        members: all
        
  - exclude:
      annotations:
        - internal
        - deprecated
```

This allows selecting types for reflection based on their annotations without modifying source code.

---

## Source Code Extraction (Optional)

The analyzer supports optional source code extraction for complete AST parsing. This feature is memory-intensive and disabled by default.

### Configuration

Enable source extraction in the configuration:

```yaml
source_extraction:
  enabled: true
  include_source_code: true    # Full source code of declarations
  include_doc_comments: true   # Documentation comments
  include_all_comments: true   # All comments including inline
  include_line_info: true      # Line/column information
  max_source_length: 0         # 0 = unlimited
  store_file_contents: true    # Store complete file source
```

### Programmatic Configuration

```dart
final config = ReflectionConfig(
  entryPoints: ['lib/main.dart'],
  sourceExtractionConfig: const SourceExtractionConfig(
    enabled: true,
    includeSourceCode: true,
    includeDocComments: true,
    includeAllComments: true,
    includeLineInfo: true,
    storeFileContents: true,
  ),
);
```

Preset configurations:
- `SourceExtractionConfig.disabled` - No extraction (default)
- `SourceExtractionConfig.docOnly` - Only doc comments and line info
- `SourceExtractionConfig.full` - Complete source extraction

### SourceInfo Classes

```dart
/// Source range information.
class SourceRange {
  final int offset;
  final int length;
  int get end => offset + length;
}

/// Comment information.
class CommentInfo {
  final CommentType type;  // doc, singleLine, multiLine
  final SourceRange range;
  final String? text;
}

/// Source information for a declaration.
class SourceInfo {
  final String fileUri;
  final SourceRange range;
  final SourceRange? docCommentRange;
  final String? docComment;
  final List<CommentInfo> comments;
  final String? sourceCode;
  final int? line;
  final int? column;
}

/// Collection of source info for all declarations.
class SourceInfoCollection {
  SourceInfo? get(String qualifiedName);
  String? getSource(String fileUri);
  int get count;
  String get estimatedMemorySize;
  
  // Serialization
  Map<String, dynamic> toJson();
  String toJsonString({bool pretty = false});
  factory SourceInfoCollection.fromJsonString(String json);
}
```

### Accessing Source Info

```dart
final result = await analyzer.analyze();

// Check if source info is available
if (result.sourceInfo != null) {
  final sourceInfo = result.sourceInfo!;
  
  // Get source for a class
  for (final cls in result.classes) {
    final qualifiedName = '${cls.library.source.uri}#${cls.name}';
    final info = sourceInfo.get(qualifiedName);
    
    if (info != null) {
      print('${cls.name}:');
      print('  Line: ${info.line}');
      print('  Doc: ${info.docComment?.split('\n').first}');
      print('  Source length: ${info.sourceCode?.length ?? 0}');
    }
  }
  
  // Get stored file contents
  final fileSource = sourceInfo.getSource('file:///path/to/file.dart');
  
  // Serialize for storage
  final json = sourceInfo.toJsonString(pretty: true);
  
  // Memory usage
  print('Memory: ${sourceInfo.estimatedMemorySize}');
}
```

### Use Cases

1. **Source regeneration**: Recreate source code from analysis
2. **Documentation extraction**: Extract all doc comments
3. **Code visualization**: Show source in tools with line numbers
4. **Diff/comparison**: Compare source across versions
5. **AST-based transformations**: Modify source based on analysis

### Memory Considerations

Source extraction is memory-intensive:
- Small codebase (30 classes): ~30 KB
- Medium codebase (600 classes): ~3-5 MB
- Large codebase (1000+ classes): 10+ MB

Use `SourceExtractionConfig.docOnly` for reduced memory when full source isn't needed.

---

## Known Limitations

1. **Type reification**: `isSubtypeOf<S>()` relies on Dart's type system and may not work correctly with generic types at runtime.

2. **Cross-package privates**: Private members cannot be accessed from generated code.

3. **Source extraction memory**: Full source code extraction is memory-intensive - use sparingly for large codebases.

4. **Generic instantiation**: Type arguments for generic classes are not fully preserved at runtime.

5. **Extension method invocation**: Extension methods are visible in metadata and appear in `instanceMethods` with `isExtensionMember == true`, but invoking them requires the extension to be imported in the generated code.

---

## API Summary

| Area | Get | Filter | Process |
|------|-----|--------|---------|
| Classes | `allClasses`, `findClassByType<T>()`, `findClassByName(String)` | `filterClasses`, `filterClassesBy` | `processClasses`, `processClassesWhere` |
| Enums | `allEnums`, `findEnumByType<T>()`, `findEnumByName(String)` | `filterEnums` | `processEnums` |
| Mixins | `allMixins`, `findMixinByType<T>()`, `findMixinByName(String)` | `filterMixins` | `processMixins` |
| Extensions | `allExtensions`, `findExtensionByName(String)` | `filterExtensions` | `processExtensions` |
| Global Methods | `allGlobalMethods`, `findGlobalMethod` | `filterGlobalMethods` | `processGlobalMethods` |
| Global Fields | `allGlobalFields`, `findGlobalField` | `filterGlobalFields` | `processGlobalFields` |
| All Methods | `allMethods` | `filterAllMethods` | `processAllMethods` |
| All Fields | `allFields` | `filterAllFields` | `processAllFields` |

**Trait-based filtering:**

| Trait | Filter Class | Processor Class |
|-------|--------------|-----------------|
| `Typed<T>` | `TypedFilter` | `TypedProcessor` |
| `Invokable` | `InvokableFilter` | `InvokableProcessor` |
| `OwnedElement` | `OwnedElementFilter` | `OwnedElementProcessor` |
| `GenericElement` | `GenericElementFilter` | `GenericElementProcessor` |
| `Accessible<T>` | `AccessibleFilter` | `AccessibleProcessor` |

**Scoped access:**
- `reflectionApi.forPackage('my_pkg')` → `PackageApi`
- `reflectionApi.forLibrary('package:my_pkg/file.dart')` → `LibraryApi`

**Common filters:**
- `ElementFilter.hasAnnotation<T>()`
- `ElementFilter.inPackage('my_pkg')`
- `ElementFilter.nameMatches(RegExp(...))`
- `OwnedElementFilter.instanceMembers()`
- `AccessibleFilter.readOnly()`
- `GenericElementFilter.hasTypeParams()`
- `TypedFilter.isSubtypeOf<T>()`
