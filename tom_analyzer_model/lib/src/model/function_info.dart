part of 'model.dart';

/// Represents a top-level function declaration.
class FunctionInfo extends ExecutableElement {
  @override
  final String id;

  @override
  final String name;

  @override
  final String qualifiedName;

  @override
  final LibraryInfo library;

  @override
  final FileInfo sourceFile;

  @override
  final SourceLocation location;

  @override
  final String? documentation;

  @override
  final List<AnnotationInfo> annotations;

  @override
  final bool isDeprecated;

  final TypeReference returnType;
  final List<TypeParameterInfo> typeParameters;

  @override
  final List<ParameterInfo> parameters;

  @override
  final bool isAsync;

  final bool isGenerator;

  @override
  final bool isExternal;

  @override
  final bool isStatic;

  FunctionInfo({
    required this.id,
    required this.name,
    required this.qualifiedName,
    required this.library,
    required this.sourceFile,
    required this.location,
    required this.returnType,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.typeParameters = const [],
    this.parameters = const [],
    this.isAsync = false,
    this.isGenerator = false,
    this.isExternal = false,
  }) : isStatic = true;
}
