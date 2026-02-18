part of 'model.dart';

/// Represents an enum declaration and its values.
class EnumInfo extends TypeDeclaration {
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

  final List<EnumValueInfo> values;
  final List<TypeReference> interfaces;
  final List<TypeReference> mixins;
  final List<FieldInfo> fields;
  final List<MethodInfo> methods;
  final List<GetterInfo> getters;
  final List<SetterInfo> setters;
  final List<ConstructorInfo> constructors;

  EnumInfo({
    required this.id,
    required this.name,
    required this.qualifiedName,
    required this.library,
    required this.sourceFile,
    required this.location,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.values = const [],
    this.interfaces = const [],
    this.mixins = const [],
    this.fields = const [],
    this.methods = const [],
    this.getters = const [],
    this.setters = const [],
    this.constructors = const [],
  });
}
