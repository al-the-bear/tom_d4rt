part of 'model.dart';

/// Represents a Dart library and its contained declarations.
class LibraryInfo extends ContainerElement {
  @override
  final String id;

  @override
  final String name;

  @override
  final String? documentation;

  @override
  final List<AnnotationInfo> annotations;

  @override
  final bool isDeprecated;

  final Uri uri;
  final PackageInfo package;
  final FileInfo mainSourceFile;
  final List<FileInfo> partFiles;
  final List<ClassInfo> classes;
  final List<EnumInfo> enums;
  final List<MixinInfo> mixins;
  final List<ExtensionInfo> extensions;
  final List<ExtensionTypeInfo> extensionTypes;
  final List<TypeAliasInfo> typeAliases;
  final List<FunctionInfo> functions;
  final List<VariableInfo> variables;
  final List<GetterInfo> getters;
  final List<SetterInfo> setters;
  final List<ExportInfo> exports;
  final List<ImportInfo> imports;

  LibraryInfo({
    required this.id,
    required this.name,
    required this.uri,
    required this.package,
    required this.mainSourceFile,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.partFiles = const [],
    this.classes = const [],
    this.enums = const [],
    this.mixins = const [],
    this.extensions = const [],
    this.extensionTypes = const [],
    this.typeAliases = const [],
    this.functions = const [],
    this.variables = const [],
    this.getters = const [],
    this.setters = const [],
    this.exports = const [],
    this.imports = const [],
  });

  List<FileInfo> get sourceFiles => [mainSourceFile, ...partFiles];

  List<TypeDeclaration> get typeDeclarations => [
        ...classes,
        ...enums,
        ...mixins,
        ...extensions,
        ...extensionTypes,
        ...typeAliases,
      ];

  List<ExecutableElement> get executables => [
        ...functions,
        ...getters,
        ...setters,
        ...classes.expand((c) => c.methods),
        ...classes.expand((c) => c.getters),
        ...classes.expand((c) => c.setters),
        ...enums.expand((e) => e.methods),
        ...enums.expand((e) => e.getters),
        ...enums.expand((e) => e.setters),
        ...mixins.expand((m) => m.methods),
        ...mixins.expand((m) => m.getters),
        ...mixins.expand((m) => m.setters),
      ];
}
