part of 'model.dart';

/// Represents an extension type declaration.
class ExtensionTypeInfo extends TypeDeclaration {
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

  final TypeReference representationType;
  final ConstructorInfo? primaryConstructor;
  final List<TypeParameterInfo> typeParameters;
  final List<MethodInfo> methods;
  final List<FieldInfo> fields;
  final List<GetterInfo> getters;
  final List<SetterInfo> setters;
  final List<ConstructorInfo> constructors;

  ExtensionTypeInfo({
    required this.id,
    required this.name,
    required this.qualifiedName,
    required this.library,
    required this.sourceFile,
    required this.location,
    required this.representationType,
    this.primaryConstructor,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.typeParameters = const [],
    this.methods = const [],
    this.fields = const [],
    this.getters = const [],
    this.setters = const [],
    this.constructors = const [],
  });
}
