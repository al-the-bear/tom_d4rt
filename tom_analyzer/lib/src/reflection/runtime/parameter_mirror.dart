/// Parameter mirror for representing method/function parameters.
///
/// This file defines the ParameterMirror class which captures all
/// metadata about a parameter: name, type, kind, default value, etc.
library;

import 'element.dart';
import 'annotation_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ParameterKind Enum
// ═══════════════════════════════════════════════════════════════════════════

/// The kind of parameter (required, optional positional, or named).
enum ParameterKind {
  /// Required positional parameter.
  required,

  /// Optional positional parameter (in [...]).
  optionalPositional,

  /// Named parameter (in {...}).
  named,
}

// ═══════════════════════════════════════════════════════════════════════════
// ParameterMirror Class
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a parameter of a method, constructor, or function.
///
/// Parameters capture:
/// - Name and type information
/// - Whether the parameter is required or optional
/// - Whether the parameter is named or positional
/// - Default value (if available)
/// - Annotations on the parameter
class ParameterMirror with ElementMixin implements Element {
  @override
  final String name;

  @override
  final String qualifiedName;

  @override
  final String libraryUri;

  @override
  final String package;

  /// The declared type of this parameter as a string.
  final String typeName;

  /// The kind of this parameter (positional required, optional, or named).
  final ParameterKind parameterKind;

  /// Whether this parameter has a default value.
  final bool hasDefaultValue;

  /// The default value expression as a string.
  ///
  /// This is the source representation of the default value,
  /// not the evaluated value.
  final String? defaultValueCode;

  @override
  final List<AnnotationMirror> annotations;

  /// Index of this parameter in the parameter list.
  final int index;

  /// For named parameters, whether they are marked as required.
  final bool isRequiredNamed;

  /// Create a parameter mirror.
  const ParameterMirror({
    required this.name,
    required this.qualifiedName,
    required this.libraryUri,
    required this.package,
    required this.typeName,
    required this.parameterKind,
    this.hasDefaultValue = false,
    this.defaultValueCode,
    this.annotations = const [],
    this.index = 0,
    this.isRequiredNamed = false,
  });

  // ─────────────────────────────────────────────────────────────────────────
  // Element Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  ElementKind get kind => ElementKind.parameter;

  // ─────────────────────────────────────────────────────────────────────────
  // Type Information
  // ─────────────────────────────────────────────────────────────────────────

  /// The Dart [Type] represented by this parameter.
  ///
  /// This is set by generated code and defaults to [Object].
  Type get reflectedType => Object;

  // ─────────────────────────────────────────────────────────────────────────
  // Convenience Properties
  // ─────────────────────────────────────────────────────────────────────────

  /// Whether this is a named parameter.
  bool get isNamed => parameterKind == ParameterKind.named;

  /// Whether this is a positional parameter (required or optional).
  bool get isPositional => parameterKind != ParameterKind.named;

  /// Whether this parameter is required.
  ///
  /// For positional parameters, this is the [ParameterKind.required] kind.
  /// For named parameters, this checks if the parameter is marked as required.
  bool get isRequired =>
      parameterKind == ParameterKind.required || isRequiredNamed;

  /// Whether this is an optional parameter.
  bool get isOptional => !isRequired;

  /// Whether this is an optional positional parameter.
  bool get isOptionalPositional =>
      parameterKind == ParameterKind.optionalPositional;

  @override
  String toString() {
    final buffer = StringBuffer();

    // Annotations
    for (final ann in annotations) {
      buffer.write('@${ann.name} ');
    }

    // Required keyword for named parameters
    if (isNamed && isRequiredNamed) {
      buffer.write('required ');
    }

    // Type and name
    buffer.write('$typeName $name');

    // Default value
    if (hasDefaultValue && defaultValueCode != null) {
      buffer.write(' = $defaultValueCode');
    }

    return buffer.toString();
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ParameterMirrorFactory
// ═══════════════════════════════════════════════════════════════════════════

/// Factory for creating parameter mirrors from generated code.
class ParameterMirrorFactory {
  const ParameterMirrorFactory._();

  /// Create a required positional parameter.
  static ParameterMirror required({
    required String name,
    required String qualifiedName,
    required String libraryUri,
    required String package,
    required String typeName,
    List<AnnotationMirror> annotations = const [],
    int index = 0,
  }) {
    return ParameterMirror(
      name: name,
      qualifiedName: qualifiedName,
      libraryUri: libraryUri,
      package: package,
      typeName: typeName,
      parameterKind: ParameterKind.required,
      annotations: annotations,
      index: index,
    );
  }

  /// Create an optional positional parameter.
  static ParameterMirror optional({
    required String name,
    required String qualifiedName,
    required String libraryUri,
    required String package,
    required String typeName,
    String? defaultValueCode,
    List<AnnotationMirror> annotations = const [],
    int index = 0,
  }) {
    return ParameterMirror(
      name: name,
      qualifiedName: qualifiedName,
      libraryUri: libraryUri,
      package: package,
      typeName: typeName,
      parameterKind: ParameterKind.optionalPositional,
      hasDefaultValue: defaultValueCode != null,
      defaultValueCode: defaultValueCode,
      annotations: annotations,
      index: index,
    );
  }

  /// Create a named parameter (optional by default).
  static ParameterMirror named({
    required String name,
    required String qualifiedName,
    required String libraryUri,
    required String package,
    required String typeName,
    bool isRequired = false,
    String? defaultValueCode,
    List<AnnotationMirror> annotations = const [],
    int index = 0,
  }) {
    return ParameterMirror(
      name: name,
      qualifiedName: qualifiedName,
      libraryUri: libraryUri,
      package: package,
      typeName: typeName,
      parameterKind: ParameterKind.named,
      hasDefaultValue: defaultValueCode != null,
      defaultValueCode: defaultValueCode,
      annotations: annotations,
      index: index,
      isRequiredNamed: isRequired,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ParameterFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [ParameterMirror] elements.
class ParameterFilter {
  /// Filter function.
  final bool Function(ParameterMirror)? filter;

  const ParameterFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(ParameterMirror param) {
    return filter?.call(param) ?? true;
  }

  /// Filter for required parameters.
  static const ParameterFilter required = ParameterFilter(
    filter: _isRequired,
  );

  /// Filter for optional parameters.
  static const ParameterFilter optional = ParameterFilter(
    filter: _isOptional,
  );

  /// Filter for named parameters.
  static const ParameterFilter named = ParameterFilter(
    filter: _isNamed,
  );

  /// Filter for positional parameters.
  static const ParameterFilter positional = ParameterFilter(
    filter: _isPositional,
  );

  /// Filter for parameters with default values.
  static const ParameterFilter hasDefault = ParameterFilter(
    filter: _hasDefault,
  );

  static bool _isRequired(ParameterMirror p) => p.isRequired;
  static bool _isOptional(ParameterMirror p) => p.isOptional;
  static bool _isNamed(ParameterMirror p) => p.isNamed;
  static bool _isPositional(ParameterMirror p) => p.isPositional;
  static bool _hasDefault(ParameterMirror p) => p.hasDefaultValue;

  /// Create a filter by parameter name.
  static ParameterFilter byName(String name) => ParameterFilter(
        filter: (p) => p.name == name,
      );

  /// Create a filter by type name.
  static ParameterFilter byType(String typeName) => ParameterFilter(
        filter: (p) => p.typeName == typeName,
      );
}
