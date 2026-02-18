/// GenericElement trait and TypeParameterMirror for generic type support.
///
/// This trait provides access to type parameters for generic classes,
/// methods, and type aliases.
library;

import 'element.dart';
import 'annotation_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// TypeParameterMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a type parameter of a generic declaration.
///
/// Type parameters capture:
/// - Name (e.g., "T", "E", "K", "V")
/// - Bound (e.g., "Object", "num", `Comparable<T>`)
/// - Variance (for future Dart variance support)
class TypeParameterMirror with ElementMixin implements Element {
  @override
  final String name;

  @override
  final String qualifiedName;

  @override
  final String libraryUri;

  @override
  final String package;

  /// The bound of this type parameter as a string.
  ///
  /// For `T extends Comparable<T>`, this would be `Comparable<T>`.
  /// For unbounded type parameters, this is "Object?" or "dynamic".
  final String bound;

  /// Whether this type parameter has an explicit bound.
  final bool hasBound;

  /// Index of this type parameter in the declaration.
  final int index;

  @override
  final List<AnnotationMirror> annotations;

  /// Create a type parameter mirror.
  const TypeParameterMirror({
    required this.name,
    required this.qualifiedName,
    required this.libraryUri,
    required this.package,
    this.bound = 'Object?',
    this.hasBound = false,
    this.index = 0,
    this.annotations = const [],
  });

  @override
  ElementKind get kind => ElementKind.typeParameter;

  @override
  String toString() {
    if (hasBound) {
      return '$name extends $bound';
    }
    return name;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// GenericElement Trait
// ═══════════════════════════════════════════════════════════════════════════

/// Trait for elements that can have type parameters.
///
/// Generic classes, methods, and type aliases implement this trait.
abstract class GenericElement implements Element {
  /// Type parameters of this element.
  ///
  /// Empty if this element is not generic.
  List<TypeParameterMirror> get typeParameters;

  /// Whether this element is generic (has type parameters).
  bool get isGeneric;

  /// Get a type parameter by name.
  TypeParameterMirror? getTypeParameter(String name);

  /// Get a type parameter by index.
  TypeParameterMirror? getTypeParameterAt(int index);
}

// ═══════════════════════════════════════════════════════════════════════════
// GenericElementMixin - Default Implementation
// ═══════════════════════════════════════════════════════════════════════════

/// Mixin providing default implementations for [GenericElement].
mixin GenericElementMixin implements GenericElement {
  @override
  bool get isGeneric => typeParameters.isNotEmpty;

  @override
  TypeParameterMirror? getTypeParameter(String name) {
    for (final param in typeParameters) {
      if (param.name == name) return param;
    }
    return null;
  }

  @override
  TypeParameterMirror? getTypeParameterAt(int index) {
    if (index < 0 || index >= typeParameters.length) return null;
    return typeParameters[index];
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// GenericElementFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [GenericElement] elements.
class GenericElementFilter {
  /// Filter function.
  final bool Function(GenericElement)? filter;

  const GenericElementFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(GenericElement element) {
    return filter?.call(element) ?? true;
  }

  /// Filter for generic elements (with type parameters).
  static const GenericElementFilter generic = GenericElementFilter(
    filter: _isGeneric,
  );

  /// Filter for non-generic elements.
  static const GenericElementFilter nonGeneric = GenericElementFilter(
    filter: _isNonGeneric,
  );

  static bool _isGeneric(GenericElement e) => e.isGeneric;
  static bool _isNonGeneric(GenericElement e) => !e.isGeneric;

  /// Filter by number of type parameters.
  static GenericElementFilter typeParameterCount(int count) =>
      GenericElementFilter(
        filter: (e) => e.typeParameters.length == count,
      );

  /// Filter for elements with at least N type parameters.
  static GenericElementFilter minTypeParameters(int min) =>
      GenericElementFilter(
        filter: (e) => e.typeParameters.length >= min,
      );

  /// Filter for elements with a specific type parameter name.
  static GenericElementFilter hasTypeParameter(String name) =>
      GenericElementFilter(
        filter: (e) => e.getTypeParameter(name) != null,
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// GenericElementProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [GenericElement] elements.
class GenericElementProcessor {
  /// Process any generic element.
  final void Function(GenericElement)? process;

  const GenericElementProcessor({this.process});

  /// Execute the processor.
  void execute(GenericElement element) {
    process?.call(element);
  }
}
