part of 'model.dart';

/// Represents a top-level variable declaration.
class VariableInfo extends VariableElement {
  @override
  final String id;

  @override
  final String name;

  @override
  final String qualifiedName;

  final LibraryInfo owningLibrary;

  @override
  LibraryInfo get library => owningLibrary;

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
  final TypeReference type;

  @override
  final bool isFinal;

  @override
  final bool isConst;

  @override
  final bool isLate;

  @override
  final bool isStatic;

  final bool hasInitializer;

  /// Whether this variable has a getter.
  final bool hasGetter;

  /// Whether this variable has a setter.
  final bool hasSetter;

  VariableInfo({
    required this.id,
    required this.name,
    required this.qualifiedName,
    required this.owningLibrary,
    required this.sourceFile,
    required this.location,
    required this.type,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.isFinal = false,
    this.isConst = false,
    this.isLate = false,
    this.hasInitializer = false,
    this.hasGetter = true,
    this.hasSetter = true,
  }) : isStatic = true;
}
