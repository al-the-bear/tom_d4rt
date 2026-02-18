part of 'model.dart';

/// Represents a constructor declaration.
class ConstructorInfo extends ExecutableElement {
  @override
  final String id;

  @override
  final String name;

  @override
  final String qualifiedName;

  final TypeDeclaration declaringType;

  @override
  LibraryInfo get library => declaringType.library;

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

  @override
  final List<ParameterInfo> parameters;

  @override
  final bool isAsync;

  @override
  final bool isExternal;

  @override
  final bool isStatic;

  final bool isConst;
  final bool isFactory;
  final String? redirectedConstructor;
  final String? superConstructorInvocation;

  ConstructorInfo({
    required this.id,
    required this.name,
    required this.qualifiedName,
    required this.declaringType,
    required this.sourceFile,
    required this.location,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.parameters = const [],
    this.isAsync = false,
    this.isExternal = false,
    this.isConst = false,
    this.isFactory = false,
    this.redirectedConstructor,
    this.superConstructorInvocation,
  }) : isStatic = false;
}
