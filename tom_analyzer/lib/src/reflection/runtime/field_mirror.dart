/// FieldMirror - Reflects a field (instance or static).
///
/// Fields are accessible elements that store values.
library;

import 'element.dart';
import 'annotation_mirror.dart';
import 'accessible.dart';
import 'owned_element.dart';

// ═══════════════════════════════════════════════════════════════════════════
// FieldMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a field (instance or static).
///
/// Fields have:
/// - Type and value access
/// - Owner (the class/mixin they belong to)
/// - Modifiers (static, final, const, late)
abstract class FieldMirror<T>
    with ElementMixin, AccessibleMixin<T>, OwnedElementMixin
    implements Element, Accessible<T>, OwnedElement {
  // ─────────────────────────────────────────────────────────────────────────
  // Element Implementation
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
  ElementKind get kind => ElementKind.field;

  @override
  List<AnnotationMirror> get annotations;

  // ─────────────────────────────────────────────────────────────────────────
  // OwnedElement Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Element? get owner;

  @override
  String? get declaringTypeName;

  @override
  bool get isInherited;

  // ─────────────────────────────────────────────────────────────────────────
  // Accessible Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  bool get canRead;

  @override
  bool get canWrite;

  @override
  bool get isStatic;

  @override
  bool get hasAccessor;

  // ─────────────────────────────────────────────────────────────────────────
  // Field Properties
  // ─────────────────────────────────────────────────────────────────────────

  /// The declared type as a string.
  String get typeName;

  /// The Dart [Type] of this field.
  Type get fieldType;

  /// Whether this field is final.
  bool get isFinal;

  /// Whether this field is const.
  bool get isConst;

  /// Whether this field is late.
  bool get isLate;

  /// Whether this field has an initializer.
  bool get hasInitializer;

  /// The initializer expression as source code (if available).
  String? get initializerCode;

  /// Documentation comment for this field.
  String? get docComment;
}

// ═══════════════════════════════════════════════════════════════════════════
// FieldMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [FieldMirror] elements.
class FieldMirrorFilter<T> {
  /// Filter function.
  final bool Function(FieldMirror<T>)? filter;

  const FieldMirrorFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(FieldMirror<T> field) {
    return filter?.call(field) ?? true;
  }

  /// Filter for static fields.
  static FieldMirrorFilter<T> static_<T>() => FieldMirrorFilter<T>(
        filter: (f) => f.isStatic,
      );

  /// Filter for instance fields.
  static FieldMirrorFilter<T> instance<T>() => FieldMirrorFilter<T>(
        filter: (f) => !f.isStatic,
      );

  /// Filter for final fields.
  static FieldMirrorFilter<T> final_<T>() => FieldMirrorFilter<T>(
        filter: (f) => f.isFinal,
      );

  /// Filter for const fields.
  static FieldMirrorFilter<T> const_<T>() => FieldMirrorFilter<T>(
        filter: (f) => f.isConst,
      );

  /// Filter for late fields.
  static FieldMirrorFilter<T> late_<T>() => FieldMirrorFilter<T>(
        filter: (f) => f.isLate,
      );

  /// Filter for mutable fields.
  static FieldMirrorFilter<T> mutable<T>() => FieldMirrorFilter<T>(
        filter: (f) => !f.isFinal && !f.isConst,
      );

  /// Filter for readable fields.
  static FieldMirrorFilter<T> readable<T>() => FieldMirrorFilter<T>(
        filter: (f) => f.canRead,
      );

  /// Filter for writable fields.
  static FieldMirrorFilter<T> writable<T>() => FieldMirrorFilter<T>(
        filter: (f) => f.canWrite,
      );

  /// Filter for inherited fields.
  static FieldMirrorFilter<T> inherited<T>() => FieldMirrorFilter<T>(
        filter: (f) => f.isInherited,
      );

  /// Filter for declared (non-inherited) fields.
  static FieldMirrorFilter<T> declared<T>() => FieldMirrorFilter<T>(
        filter: (f) => !f.isInherited,
      );

  /// Filter by type name.
  static FieldMirrorFilter<T> ofType<T>(String typeName) =>
      FieldMirrorFilter<T>(
        filter: (f) => f.typeName == typeName,
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// FieldMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [FieldMirror] elements.
class FieldMirrorProcessor<T> {
  /// Process any field mirror.
  final void Function(FieldMirror<T>)? process;

  const FieldMirrorProcessor({this.process});

  /// Execute the processor.
  void execute(FieldMirror<T> field) {
    process?.call(field);
  }
}
