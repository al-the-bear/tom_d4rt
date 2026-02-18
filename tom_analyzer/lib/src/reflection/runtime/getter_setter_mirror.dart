/// GetterMirror and SetterMirror - Reflects getters and setters.
///
/// These are separate from fields for explicit getter/setter declarations.
library;

import 'element.dart';
import 'annotation_mirror.dart';
import 'accessible.dart';
import 'owned_element.dart';

// ═══════════════════════════════════════════════════════════════════════════
// GetterMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a getter (explicit or implicit from a field).
abstract class GetterMirror<T>
    with ElementMixin, AccessibleMixin<T>, OwnedElementMixin
    implements Element, Accessible<T>, OwnedElement {
  @override
  String get name;

  @override
  String get qualifiedName;

  @override
  String get libraryUri;

  @override
  String get package;

  @override
  ElementKind get kind => ElementKind.getter;

  @override
  List<AnnotationMirror> get annotations;

  @override
  Element? get owner;

  @override
  String? get declaringTypeName;

  @override
  bool get isInherited;

  @override
  bool get canRead => true; // Getters are always readable

  @override
  bool get canWrite => false; // Getters cannot be written

  @override
  bool get isStatic;

  @override
  bool get hasAccessor;

  /// The return type as a string.
  String get returnTypeName;

  /// Whether this getter is abstract.
  bool get isAbstract;

  /// Whether this getter is synthetic (implicit from field).
  bool get isSynthetic;

  /// Documentation comment for this getter.
  String? get docComment;
}

// ═══════════════════════════════════════════════════════════════════════════
// SetterMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a setter (explicit or implicit from a non-final field).
abstract class SetterMirror<T>
    with ElementMixin, AccessibleMixin<T>, OwnedElementMixin
    implements Element, Accessible<T>, OwnedElement {
  @override
  String get name;

  @override
  String get qualifiedName;

  @override
  String get libraryUri;

  @override
  String get package;

  @override
  ElementKind get kind => ElementKind.setter;

  @override
  List<AnnotationMirror> get annotations;

  @override
  Element? get owner;

  @override
  String? get declaringTypeName;

  @override
  bool get isInherited;

  @override
  bool get canRead => false; // Setters cannot be read

  @override
  bool get canWrite => true; // Setters are always writable

  @override
  bool get isStatic;

  @override
  bool get hasAccessor;

  /// The parameter type as a string.
  String get parameterTypeName;

  /// Whether this setter is abstract.
  bool get isAbstract;

  /// Whether this setter is synthetic (implicit from field).
  bool get isSynthetic;

  /// Documentation comment for this setter.
  String? get docComment;
}

// ═══════════════════════════════════════════════════════════════════════════
// GetterMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [GetterMirror] elements.
class GetterMirrorFilter<T> {
  final bool Function(GetterMirror<T>)? filter;

  const GetterMirrorFilter({this.filter});

  bool evaluate(GetterMirror<T> getter) {
    return filter?.call(getter) ?? true;
  }

  static GetterMirrorFilter<T> static_<T>() => GetterMirrorFilter<T>(
        filter: (g) => g.isStatic,
      );

  static GetterMirrorFilter<T> instance<T>() => GetterMirrorFilter<T>(
        filter: (g) => !g.isStatic,
      );

  static GetterMirrorFilter<T> synthetic<T>() => GetterMirrorFilter<T>(
        filter: (g) => g.isSynthetic,
      );

  static GetterMirrorFilter<T> explicit<T>() => GetterMirrorFilter<T>(
        filter: (g) => !g.isSynthetic,
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// SetterMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [SetterMirror] elements.
class SetterMirrorFilter<T> {
  final bool Function(SetterMirror<T>)? filter;

  const SetterMirrorFilter({this.filter});

  bool evaluate(SetterMirror<T> setter) {
    return filter?.call(setter) ?? true;
  }

  static SetterMirrorFilter<T> static_<T>() => SetterMirrorFilter<T>(
        filter: (s) => s.isStatic,
      );

  static SetterMirrorFilter<T> instance<T>() => SetterMirrorFilter<T>(
        filter: (s) => !s.isStatic,
      );

  static SetterMirrorFilter<T> synthetic<T>() => SetterMirrorFilter<T>(
        filter: (s) => s.isSynthetic,
      );

  static SetterMirrorFilter<T> explicit<T>() => SetterMirrorFilter<T>(
        filter: (s) => !s.isSynthetic,
      );
}
