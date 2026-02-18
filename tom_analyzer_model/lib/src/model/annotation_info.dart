part of 'model.dart';

/// Represents a resolved annotation with constructor and arguments.
class AnnotationInfo {
  final String name;
  final String qualifiedName;
  final String? constructorName;
  final Map<String, ArgumentValue> namedArguments;
  final List<ArgumentValue> positionalArguments;

  const AnnotationInfo({
    required this.name,
    required this.qualifiedName,
    this.constructorName,
    this.namedArguments = const {},
    this.positionalArguments = const [],
  });
}

/// Wrapper for annotation argument values.
class ArgumentValue {
  final Object? value;

  const ArgumentValue(this.value);

  @override
  String toString() => value?.toString() ?? 'null';
}
