/// ExtensionMirror - Reflects a Dart extension.
///
/// Provides access to extension members and the extended type.
library;

import 'type_mirror.dart';
import 'element.dart';
import 'annotation_mirror.dart';
import 'generic_element.dart';
import 'method_mirror.dart';
import 'field_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ExtensionMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a Dart extension.
///
/// Extensions have:
/// - Extended type (the type being extended)
/// - Members (methods, getters, setters, operators)
/// - Optional name (can be unnamed)
abstract class ExtensionMirror<T>
    with ElementMixin, GenericElementMixin
    implements Element, GenericElement {
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
  ElementKind get kind => ElementKind.extension_;

  @override
  List<AnnotationMirror> get annotations;

  // ─────────────────────────────────────────────────────────────────────────
  // GenericElement Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  List<TypeParameterMirror> get typeParameters;

  // ─────────────────────────────────────────────────────────────────────────
  // Extension Properties
  // ─────────────────────────────────────────────────────────────────────────

  /// The extended type as a mirror (if available).
  TypeMirror<T>? get extendedType;

  /// The extended type as a string.
  String get extendedTypeName;

  /// Whether this is an unnamed extension.
  bool get isUnnamed => name.isEmpty;

  /// Whether this extension is named.
  bool get isNamed => name.isNotEmpty;

  /// Documentation comment for this extension.
  String? get docComment;

  // ─────────────────────────────────────────────────────────────────────────
  // Members
  // ─────────────────────────────────────────────────────────────────────────

  /// All methods in this extension.
  Map<String, MethodMirror<Object?>> get methods;

  /// Get a method by name.
  MethodMirror<Object?>? getMethod(String name);

  /// All fields (static only, extensions can't have instance fields).
  Map<String, FieldMirror<Object?>> get staticFields;

  /// Get a static field by name.
  FieldMirror<Object?>? getStaticField(String name);

  // ─────────────────────────────────────────────────────────────────────────
  // Invocation
  // ─────────────────────────────────────────────────────────────────────────

  /// Invoke an extension method on an instance.
  Object? invokeMethod(
    Object instance,
    String methodName,
    List<dynamic> positional, [
    Map<Symbol, dynamic> named = const {},
  ]);
}

// ═══════════════════════════════════════════════════════════════════════════
// ExtensionMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [ExtensionMirror] elements.
class ExtensionMirrorFilter<T> {
  /// Filter function.
  final bool Function(ExtensionMirror<T>)? filter;

  const ExtensionMirrorFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(ExtensionMirror<T> ext) {
    return filter?.call(ext) ?? true;
  }

  /// Filter for named extensions.
  static ExtensionMirrorFilter<T> named<T>() => ExtensionMirrorFilter<T>(
        filter: (e) => e.isNamed,
      );

  /// Filter for unnamed extensions.
  static ExtensionMirrorFilter<T> unnamed<T>() => ExtensionMirrorFilter<T>(
        filter: (e) => e.isUnnamed,
      );

  /// Filter by extended type name.
  static ExtensionMirrorFilter<T> extendsType<T>(String typeName) =>
      ExtensionMirrorFilter<T>(
        filter: (e) => e.extendedTypeName == typeName,
      );

  /// Filter for extensions with a specific method.
  static ExtensionMirrorFilter<T> hasMethod<T>(String name) =>
      ExtensionMirrorFilter<T>(
        filter: (e) => e.methods.containsKey(name),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// ExtensionMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [ExtensionMirror] elements.
class ExtensionMirrorProcessor<T> {
  /// Process any extension mirror.
  final void Function(ExtensionMirror<T>)? process;

  const ExtensionMirrorProcessor({this.process});

  /// Execute the processor.
  void execute(ExtensionMirror<T> ext) {
    process?.call(ext);
  }
}
