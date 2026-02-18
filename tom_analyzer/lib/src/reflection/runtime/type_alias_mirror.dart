/// TypeAliasMirror - Reflects a Dart type alias (typedef).
///
/// Type aliases provide alternative names for types.
library;

import 'element.dart';
import 'annotation_mirror.dart';
import 'generic_element.dart';

// ═══════════════════════════════════════════════════════════════════════════
// TypeAliasMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a Dart type alias (typedef).
///
/// Type aliases have:
/// - A name
/// - Type parameters (if generic)
/// - The aliased type
abstract class TypeAliasMirror
    with ElementMixin, GenericElementMixin
    implements Element, GenericElement {
  @override
  String get name;

  @override
  String get qualifiedName;

  @override
  String get libraryUri;

  @override
  String get package;

  @override
  ElementKind get kind => ElementKind.typeAlias;

  @override
  List<AnnotationMirror> get annotations;

  @override
  List<TypeParameterMirror> get typeParameters;

  /// The aliased type as a string.
  String get aliasedTypeName;

  /// Whether this is a function type alias.
  bool get isFunctionTypeAlias;

  /// Documentation comment for this type alias.
  String? get docComment;
}

// ═══════════════════════════════════════════════════════════════════════════
// TypeAliasMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [TypeAliasMirror] elements.
class TypeAliasMirrorFilter {
  final bool Function(TypeAliasMirror)? filter;

  const TypeAliasMirrorFilter({this.filter});

  bool evaluate(TypeAliasMirror alias) {
    return filter?.call(alias) ?? true;
  }

  /// Filter for function type aliases.
  static const TypeAliasMirrorFilter functionType = TypeAliasMirrorFilter(
    filter: _isFunctionType,
  );

  /// Filter for non-function type aliases.
  static const TypeAliasMirrorFilter nonFunctionType = TypeAliasMirrorFilter(
    filter: _isNonFunctionType,
  );

  static bool _isFunctionType(TypeAliasMirror a) => a.isFunctionTypeAlias;
  static bool _isNonFunctionType(TypeAliasMirror a) => !a.isFunctionTypeAlias;

  /// Filter for generic type aliases.
  static const TypeAliasMirrorFilter generic = TypeAliasMirrorFilter(
    filter: _isGeneric,
  );

  static bool _isGeneric(TypeAliasMirror a) => a.isGeneric;
}

// ═══════════════════════════════════════════════════════════════════════════
// TypeAliasMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [TypeAliasMirror] elements.
class TypeAliasMirrorProcessor {
  final void Function(TypeAliasMirror)? process;

  const TypeAliasMirrorProcessor({this.process});

  void execute(TypeAliasMirror alias) {
    process?.call(alias);
  }
}
