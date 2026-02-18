/// TypeMirror - Base class for all type mirrors.
///
/// This is the abstract base for ClassMirror, EnumMirror, MixinMirror,
/// ExtensionMirror, and ExtensionTypeMirror.
library;

import 'element.dart';
import 'annotation_mirror.dart';
import 'generic_element.dart';
import 'typed.dart';

// ═══════════════════════════════════════════════════════════════════════════
// TypeMirror Base Class
// ═══════════════════════════════════════════════════════════════════════════

/// Base class for all type mirrors.
///
/// Represents any reflected type (class, enum, mixin, extension, etc.).
/// Implements [Element], [Typed], and [GenericElement] traits.
abstract class TypeMirror<T>
    with ElementMixin, TypedMixin<T>, GenericElementMixin
    implements Element, Typed<T>, GenericElement {
  // ─────────────────────────────────────────────────────────────────────────
  // Element Implementation - Abstract
  // ─────────────────────────────────────────────────────────────────────────

  @override
  String get name;

  @override
  String get qualifiedName;

  @override
  String get libraryUri;

  @override
  String get package;

  @override
  ElementKind get kind;

  @override
  List<AnnotationMirror> get annotations;

  // ─────────────────────────────────────────────────────────────────────────
  // GenericElement Implementation - Abstract
  // ─────────────────────────────────────────────────────────────────────────

  @override
  List<TypeParameterMirror> get typeParameters;

  // ─────────────────────────────────────────────────────────────────────────
  // Type Flags
  // ─────────────────────────────────────────────────────────────────────────

  /// Whether this type is abstract.
  bool get isAbstract;

  /// Whether this type is final (cannot be extended/implemented).
  bool get isFinal;

  /// Whether this type is sealed (can only be extended in same library).
  bool get isSealed;

  /// Whether this type is a base class (can only be extended, not implemented).
  bool get isBase;

  /// Whether this type is an interface class.
  bool get isInterface;

  /// Whether this type is a mixin class.
  bool get isMixinClass;

  // ─────────────────────────────────────────────────────────────────────────
  // Documentation
  // ─────────────────────────────────────────────────────────────────────────

  /// Documentation comment for this type (if available).
  String? get docComment;
}

// ═══════════════════════════════════════════════════════════════════════════
// TypeMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [TypeMirror] elements.
class TypeMirrorFilter<T> {
  /// Filter function.
  final bool Function(TypeMirror<T>)? filter;

  const TypeMirrorFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(TypeMirror<T> type) {
    return filter?.call(type) ?? true;
  }

  /// Filter for abstract types.
  static TypeMirrorFilter<T> abstract_<T>() => TypeMirrorFilter<T>(
        filter: (t) => t.isAbstract,
      );

  /// Filter for concrete (non-abstract) types.
  static TypeMirrorFilter<T> concrete<T>() => TypeMirrorFilter<T>(
        filter: (t) => !t.isAbstract,
      );

  /// Filter for final types.
  static TypeMirrorFilter<T> final_<T>() => TypeMirrorFilter<T>(
        filter: (t) => t.isFinal,
      );

  /// Filter for sealed types.
  static TypeMirrorFilter<T> sealed<T>() => TypeMirrorFilter<T>(
        filter: (t) => t.isSealed,
      );

  /// Filter for generic types.
  static TypeMirrorFilter<T> generic<T>() => TypeMirrorFilter<T>(
        filter: (t) => t.isGeneric,
      );

  /// Filter for non-generic types.
  static TypeMirrorFilter<T> nonGeneric<T>() => TypeMirrorFilter<T>(
        filter: (t) => !t.isGeneric,
      );

  /// Filter by element kind.
  static TypeMirrorFilter<T> ofKind<T>(ElementKind kind) => TypeMirrorFilter<T>(
        filter: (t) => t.kind == kind,
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// TypeMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [TypeMirror] elements.
class TypeMirrorProcessor<T> {
  /// Process any type mirror.
  final void Function(TypeMirror<T>)? process;

  const TypeMirrorProcessor({this.process});

  /// Execute the processor.
  void execute(TypeMirror<T> type) {
    process?.call(type);
  }
}
