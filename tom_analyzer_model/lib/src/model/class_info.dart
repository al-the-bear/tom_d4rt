part of 'model.dart';

/// Represents a class declaration and its members.
class ClassInfo extends TypeDeclaration {
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

  final bool isAbstract;
  final bool isSealed;
  final bool isFinal;
  final bool isBase;
  final bool isInterface;
  final bool isMixin;
  final TypeReference? superclass;
  final List<TypeReference> interfaces;
  final List<TypeReference> mixins;
  final List<TypeParameterInfo> typeParameters;
  final List<ConstructorInfo> constructors;
  final List<MethodInfo> methods;
  final List<FieldInfo> fields;
  final List<GetterInfo> getters;
  final List<SetterInfo> setters;

  ClassInfo({
    required this.id,
    required this.name,
    required this.qualifiedName,
    required this.library,
    required this.sourceFile,
    required this.location,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.isAbstract = false,
    this.isSealed = false,
    this.isFinal = false,
    this.isBase = false,
    this.isInterface = false,
    this.isMixin = false,
    this.superclass,
    this.interfaces = const [],
    this.mixins = const [],
    this.typeParameters = const [],
    this.constructors = const [],
    this.methods = const [],
    this.fields = const [],
    this.getters = const [],
    this.setters = const [],
  });

  List<MethodInfo> get operators => methods.where((m) => m.isOperator).toList();

  ClassStaticMembers get staticMembers => ClassStaticMembers(
        methods: methods.where((m) => m.isStatic).toList(),
        fields: fields.where((f) => f.isStatic).toList(),
        getters: getters.where((g) => g.isStatic).toList(),
        setters: setters.where((s) => s.isStatic).toList(),
      );
}
