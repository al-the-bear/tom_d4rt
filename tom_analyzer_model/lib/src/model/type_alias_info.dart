part of 'model.dart';

/// Represents a typedef declaration.
class TypeAliasInfo extends TypeDeclaration {
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

  final TypeReference aliasedType;
  final List<TypeParameterInfo> typeParameters;

  TypeAliasInfo({
    required this.id,
    required this.name,
    required this.qualifiedName,
    required this.library,
    required this.sourceFile,
    required this.location,
    required this.aliasedType,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.typeParameters = const [],
  });
}
