part of 'model.dart';

/// Root container for all analysis results and queries.
class AnalysisResult extends ContainerElement {
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

  final DateTime timestamp;
  final String dartSdkVersion;
  final String analyzerVersion;
  final String schemaVersion;
  final PackageInfo rootPackage;
  final Map<String, PackageInfo> packages;
  final Map<Uri, LibraryInfo> libraries;
  final Map<String, FileInfo> files;
  final List<AnalysisError> errors;
  final Map<String, dynamic> metadata;

  AnalysisResult({
    required this.id,
    required this.timestamp,
    required this.dartSdkVersion,
    required this.analyzerVersion,
    required this.schemaVersion,
    required this.rootPackage,
    required this.packages,
    required this.libraries,
    required this.files,
    this.errors = const [],
    this.metadata = const {},
    this.name = 'analysis_result',
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
  });

  List<ClassInfo> get allClasses => libraries.values.expand((lib) => lib.classes).toList();
  List<EnumInfo> get allEnums => libraries.values.expand((lib) => lib.enums).toList();
  List<MixinInfo> get allMixins => libraries.values.expand((lib) => lib.mixins).toList();
  List<ExtensionInfo> get allExtensions => libraries.values.expand((lib) => lib.extensions).toList();
  List<ExtensionTypeInfo> get allExtensionTypes => libraries.values.expand((lib) => lib.extensionTypes).toList();
  List<TypeAliasInfo> get allTypeAliases => libraries.values.expand((lib) => lib.typeAliases).toList();
  List<FunctionInfo> get allFunctions => libraries.values.expand((lib) => lib.functions).toList();
  List<VariableInfo> get allVariables => libraries.values.expand((lib) => lib.variables).toList();
  List<GetterInfo> get allGetters => libraries.values.expand((lib) => lib.getters).toList();
  List<SetterInfo> get allSetters => libraries.values.expand((lib) => lib.setters).toList();

  List<TypeDeclaration> get allTypeDeclarations => [
        ...allClasses,
        ...allEnums,
        ...allMixins,
        ...allExtensions,
        ...allExtensionTypes,
        ...allTypeAliases,
      ];

  List<ExecutableElement> get allExecutables {
    final executables = <ExecutableElement>[];
    executables.addAll(allFunctions);
    executables.addAll(allGetters);
    executables.addAll(allSetters);
    for (final cls in allClasses) {
      executables.addAll(cls.constructors);
      executables.addAll(cls.methods);
      executables.addAll(cls.getters);
      executables.addAll(cls.setters);
    }
    for (final enm in allEnums) {
      executables.addAll(enm.methods);
      executables.addAll(enm.getters);
      executables.addAll(enm.setters);
    }
    for (final mix in allMixins) {
      executables.addAll(mix.methods);
      executables.addAll(mix.getters);
      executables.addAll(mix.setters);
    }
    return executables;
  }

  List<AnnotationInfo> get allAnnotations {
    final annotations = <AnnotationInfo>[];
    for (final lib in libraries.values) {
      annotations.addAll(lib.annotations);
      for (final type in lib.typeDeclarations) {
        annotations.addAll(type.annotations);
        if (type is ClassInfo) {
          annotations.addAll(type.constructors.expand((c) => c.annotations));
          annotations.addAll(type.methods.expand((m) => m.annotations));
          annotations.addAll(type.fields.expand((f) => f.annotations));
        } else if (type is EnumInfo) {
          annotations.addAll(type.methods.expand((m) => m.annotations));
          annotations.addAll(type.fields.expand((f) => f.annotations));
        }
      }
      for (final exec in lib.executables) {
        annotations.addAll(exec.annotations);
      }
    }
    return annotations;
  }

  ClassInfo getClassOrThrow(String name) {
    final matches = allClasses.where((c) => c.name == name).toList();
    if (matches.isEmpty) {
      throw ElementNotFoundException('No class found with name: $name');
    }
    if (matches.length > 1) {
      throw AmbiguousElementException(
        'Multiple classes found with name "$name": '
        '${matches.map((c) => c.qualifiedName).join(", ")}',
        candidates: matches.map((c) => c.qualifiedName).toList(),
      );
    }
    return matches.first;
  }

  EnumInfo getEnumOrThrow(String name) {
    final matches = allEnums.where((e) => e.name == name).toList();
    if (matches.isEmpty) {
      throw ElementNotFoundException('No enum found with name: $name');
    }
    if (matches.length > 1) {
      throw AmbiguousElementException(
        'Multiple enums found with name "$name": '
        '${matches.map((e) => e.qualifiedName).join(", ")}',
        candidates: matches.map((e) => e.qualifiedName).toList(),
      );
    }
    return matches.first;
  }

  FunctionInfo getFunctionOrThrow(String name) {
    final matches = allFunctions.where((f) => f.name == name).toList();
    if (matches.isEmpty) {
      throw ElementNotFoundException('No function found with name: $name');
    }
    if (matches.length > 1) {
      throw AmbiguousElementException(
        'Multiple functions found with name "$name": '
        '${matches.map((f) => f.qualifiedName).join(", ")}',
        candidates: matches.map((f) => f.qualifiedName).toList(),
      );
    }
    return matches.first;
  }

  ClassInfo? findClass(String qualifiedName) {
    return allClasses.firstWhereOrNull((c) => c.qualifiedName == qualifiedName);
  }

  List<ClassInfo> findClassesByName(String name) {
    return allClasses.where((c) => c.name == name).toList();
  }

  ClassInfo? findClassInLibrary(String name, Uri libraryUri) {
    final lib = libraries[libraryUri];
    return lib?.classes.firstWhereOrNull((c) => c.name == name);
  }

  List<ClassInfo> findClassesWithAnnotation(String annotationName) {
    return allClasses.where((c) => c.hasAnnotation(annotationName)).toList();
  }

  List<FunctionInfo> findFunctionsWithAnnotation(String annotationName) {
    return allFunctions.where((f) => f.hasAnnotation(annotationName)).toList();
  }

  T? findElement<T extends Element>(String qualifiedName) {
    if (T == ClassInfo || T == Element) {
      final result = findClass(qualifiedName);
      if (result != null) return result as T?;
    }
    if (T == FunctionInfo || T == Element) {
      final result = allFunctions.firstWhereOrNull((f) => f.qualifiedName == qualifiedName);
      if (result != null) return result as T?;
    }
    if (T == EnumInfo || T == Element) {
      final result = allEnums.firstWhereOrNull((e) => e.qualifiedName == qualifiedName);
      if (result != null) return result as T?;
    }
    return null;
  }

  List<T> findElementsWithAnnotation<T extends DeclarationElement>(String annotationName) {
    final results = <T>[];
    if (T == ClassInfo || T == DeclarationElement) {
      results.addAll(allClasses.where((c) => c.hasAnnotation(annotationName)) as Iterable<T>);
    }
    if (T == FunctionInfo || T == DeclarationElement) {
      results.addAll(allFunctions.where((f) => f.hasAnnotation(annotationName)) as Iterable<T>);
    }
    if (T == MethodInfo || T == DeclarationElement) {
      final methods = allClasses.expand((c) => c.methods);
      results.addAll(methods.where((m) => m.hasAnnotation(annotationName)) as Iterable<T>);
    }
    return results;
  }

  Set<String> get annotationNames => allAnnotations.map((a) => a.name).toSet();

  PackageElements getPackageElements(String packageName) {
    final packageLibs = libraries.values.where((lib) => lib.package.name == packageName).toList();
    return PackageElements(
      classes: packageLibs.expand((lib) => lib.classes).toList(),
      enums: packageLibs.expand((lib) => lib.enums).toList(),
      functions: packageLibs.expand((lib) => lib.functions).toList(),
      mixins: packageLibs.expand((lib) => lib.mixins).toList(),
      extensions: packageLibs.expand((lib) => lib.extensions).toList(),
    );
  }
}
