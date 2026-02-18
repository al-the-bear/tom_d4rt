/// Base trait interfaces for the reflection system.
///
/// This file contains the core [Element] trait and [ElementKind] enum
/// that all reflection elements implement.
library;

import 'annotation_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ElementKind Enum
// ═══════════════════════════════════════════════════════════════════════════

/// Enumeration of element kinds in the reflection system.
enum ElementKind {
  /// A class declaration.
  class_,

  /// An enum declaration.
  enum_,

  /// A mixin declaration.
  mixin_,

  /// An extension declaration.
  extension_,

  /// An extension type declaration.
  extensionType,

  /// A type alias (typedef) declaration.
  typeAlias,

  /// A method (instance or static).
  method,

  /// A field (instance or static).
  field,

  /// A getter (instance or static).
  getter,

  /// A setter (instance or static).
  setter,

  /// A constructor (named, unnamed, or factory).
  constructor,

  /// A parameter of a method, constructor, or function.
  parameter,

  /// A type parameter (generic).
  typeParameter,

  /// A top-level function.
  function,

  /// A top-level variable.
  variable,
}

// ═══════════════════════════════════════════════════════════════════════════
// Element Trait
// ═══════════════════════════════════════════════════════════════════════════

/// Base trait for all reflection elements.
///
/// Every mirror type implements this, ensuring that fundamental
/// identification, naming, and annotation properties are always accessible.
abstract class Element {
  // ─────────────────────────────────────────────────────────────────────────
  // Identification
  // ─────────────────────────────────────────────────────────────────────────

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

  // ─────────────────────────────────────────────────────────────────────────
  // Annotations
  // ─────────────────────────────────────────────────────────────────────────

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

// ═══════════════════════════════════════════════════════════════════════════
// ElementMixin - Default Implementation
// ═══════════════════════════════════════════════════════════════════════════

/// Mixin providing default implementations for [Element] annotation methods.
mixin ElementMixin implements Element {
  @override
  bool hasAnnotation<T>() {
    return annotations.any((a) => a.isType<T>());
  }

  @override
  bool hasAnnotationWhere(bool Function(AnnotationMirror) predicate) {
    return annotations.any(predicate);
  }

  @override
  AnnotationMirror? getAnnotation<T>() {
    for (final annotation in annotations) {
      if (annotation.isType<T>()) {
        return annotation;
      }
    }
    return null;
  }

  @override
  List<AnnotationMirror> getAnnotationsOfType<T>() {
    return annotations.where((a) => a.isType<T>()).toList();
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ElementFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for any element.
///
/// This is the most general filter, applicable to all reflection elements.
/// Use this when you want to filter across all element types uniformly.
class ElementFilter {
  /// Filter applied to all elements.
  final bool Function(Element)? filter;

  const ElementFilter({this.filter});

  /// Evaluate the filter for an element.
  bool evaluate(Element element) {
    return filter?.call(element) ?? true;
  }

  /// Create a filter that matches elements by name.
  static ElementFilter byName(String name) => ElementFilter(
        filter: (e) => e.name == name,
      );

  /// Create a filter that matches elements by name pattern.
  static ElementFilter nameMatches(RegExp pattern) => ElementFilter(
        filter: (e) => pattern.hasMatch(e.name),
      );

  /// Create a filter that matches elements in a specific package.
  static ElementFilter inPackage(String package) => ElementFilter(
        filter: (e) => e.package == package,
      );

  /// Create a filter that matches elements in a specific library.
  static ElementFilter inLibrary(String libraryUri) => ElementFilter(
        filter: (e) => e.libraryUri == libraryUri,
      );

  /// Create a filter that matches elements of a specific kind.
  static ElementFilter ofKind(ElementKind kind) => ElementFilter(
        filter: (e) => e.kind == kind,
      );

  /// Create a filter that matches elements with a specific annotation type.
  static ElementFilter withAnnotation<T>() => ElementFilter(
        filter: (e) => e.hasAnnotation<T>(),
      );

  /// Combine multiple filters with AND logic.
  ElementFilter and(ElementFilter other) => ElementFilter(
        filter: (e) => evaluate(e) && other.evaluate(e),
      );

  /// Combine multiple filters with OR logic.
  ElementFilter or(ElementFilter other) => ElementFilter(
        filter: (e) => evaluate(e) || other.evaluate(e),
      );

  /// Negate this filter.
  ElementFilter get not => ElementFilter(
        filter: (e) => !evaluate(e),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// ElementProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for any element.
///
/// Use this to apply operations to elements that match certain criteria.
class ElementProcessor {
  /// Process any element.
  final void Function(Element)? process;

  const ElementProcessor({this.process});

  /// Execute the processor on an element.
  void execute(Element element) {
    process?.call(element);
  }

  /// Create a processor that collects elements into a list.
  static (ElementProcessor, List<Element>) collector() {
    final list = <Element>[];
    return (ElementProcessor(process: list.add), list);
  }

  /// Create a processor that counts elements.
  static (ElementProcessor, int Function()) counter() {
    var count = 0;
    return (ElementProcessor(process: (_) => count++), () => count);
  }
}
