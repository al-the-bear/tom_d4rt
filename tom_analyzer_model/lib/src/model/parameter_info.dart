part of 'model.dart';

/// Information about a callable parameter.
class ParameterInfo {
  final String id;
  final String name;
  final TypeReference type;
  final bool isRequired;
  final bool isNamed;
  final bool isPositional;
  final bool hasDefaultValue;
  final String? defaultValue;
  final ArgumentValue? defaultValueParsed;
  final String? documentation;
  final List<AnnotationInfo> annotations;
  final ExecutableElement? declaringCallable;

  const ParameterInfo({
    required this.id,
    required this.name,
    required this.type,
    required this.isRequired,
    required this.isNamed,
    required this.isPositional,
    required this.hasDefaultValue,
    this.defaultValue,
    this.defaultValueParsed,
    this.documentation,
    this.annotations = const [],
    this.declaringCallable,
  });
}
