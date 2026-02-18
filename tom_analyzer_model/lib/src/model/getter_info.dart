part of 'model.dart';

/// Represents a getter declaration.
class GetterInfo extends ExecutableElement {
  @override
  final String id;

  @override
  final String name;

  @override
  final String qualifiedName;

  final TypeDeclaration? declaringType;
  final LibraryInfo? owningLibrary;

  @override
  LibraryInfo get library => declaringType?.library ?? owningLibrary!;

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

  @override
  final List<ParameterInfo> parameters;

  @override
  final bool isAsync;

  @override
  final bool isExternal;

  @override
  final bool isStatic;

  final bool isAbstract;

  GetterInfo({
    required this.id,
    required this.name,
    required this.qualifiedName,
    required this.sourceFile,
    required this.location,
    required this.returnType,
    this.declaringType,
    this.owningLibrary,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.parameters = const [],
    this.isAsync = false,
    this.isExternal = false,
    this.isStatic = false,
    this.isAbstract = false,
  });
}
