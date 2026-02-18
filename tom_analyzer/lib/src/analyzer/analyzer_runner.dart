import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart' as analysis_context;
import 'package:analyzer/dart/analysis/results.dart' as analysis_results;
import 'package:analyzer/dart/element/element.dart' as analyzer;
import 'package:analyzer/dart/element/type.dart' as analyzer_types;
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'package:tom_analyzer_model/tom_analyzer_model.dart';

import 'analyzer_context_builder.dart';
import 'annotation_parser.dart';

/// Runs analyzer-based extraction of model information.
class TomAnalyzer {
  final AnnotationParser _annotationParser = AnnotationParser();

  Future<AnalysisResult> analyzeBarrel({
    required String barrelPath,
    String? workspaceRoot,
    bool followReExports = true,
    List<String>? followReExportPackages,
    List<String> skipReExports = const [],
  }) async {
    final resolvedPath = p.normalize(p.absolute(barrelPath));
    final rootPath = workspaceRoot != null
        ? p.normalize(p.absolute(workspaceRoot))
        : p.normalize(p.absolute(p.dirname(resolvedPath)));

    final contextBuilder = AnalyzerContextBuilder();
    final collection = contextBuilder.build(
      rootPath: rootPath,
      includedPaths: [rootPath],
    );

    final context = collection.contextFor(resolvedPath);
    final session = context.currentSession;
    final libraryResult = await session.getResolvedLibrary(resolvedPath);

    if (libraryResult is! analysis_results.ResolvedLibraryResult) {
      throw StateError('Failed to resolve library at $resolvedPath');
    }

    final pubspec = _readPubspec(rootPath);
    final packageName = pubspec['name'] as String? ?? p.basename(rootPath);
    final packageVersion = pubspec['version'] as String?;

    final idGen = IdGenerator();
    final registry = _ModelRegistry(idGen);

    final analysisResult = AnalysisResult(
      id: idGen.nextId('analysis'),
      timestamp: DateTime.now(),
      dartSdkVersion: 'unknown',
      analyzerVersion: '8.x',
      schemaVersion: '1.0',
      rootPackage: registry.createPackage(
        id: idGen.nextId('pkg'),
        name: packageName,
        version: packageVersion,
        rootPath: rootPath,
        isRoot: true,
      ),
      packages: {},
      libraries: {},
      files: {},
      errors: [],
      metadata: {
        'barrelPath': resolvedPath,
      },
    );

    registry.attachAnalysisResult(analysisResult);

    await _collectLibraries(
      analysisResult,
      registry,
      context,
      rootPath,
      packageName,
      followReExports: followReExports,
      followReExportPackages: followReExportPackages,
      skipReExports: skipReExports,
    );

    analysisResult.packages[analysisResult.rootPackage.name] = analysisResult.rootPackage;

    // Resolve TypeReferences to their corresponding type declarations
    registry.resolveTypeReferences(analysisResult);

    return analysisResult;
  }

  Future<void> _collectLibraries(
    AnalysisResult analysisResult,
    _ModelRegistry registry,
    analysis_context.AnalysisContext context,
    String rootPath,
    String packageName,
    {
    required bool followReExports,
    List<String>? followReExportPackages,
    List<String> skipReExports = const [],
  }
  ) async {
    final session = context.currentSession;
    final analyzedFiles = context.contextRoot.analyzedFiles();
    final queuedUris = <Uri>{};
    final pendingExports = <String>[];

    for (final path in analyzedFiles) {
      if (!path.endsWith('.dart')) {
        continue;
      }

      final result = await session.getResolvedLibrary(path);
      if (result is! analysis_results.ResolvedLibraryResult) {
        continue;
      }

      final uri = result.element.firstFragment.source.uri;
      if (!_isInPackage(uri, rootPath, packageName)) {
        continue;
      }
      if (analysisResult.libraries.containsKey(uri)) {
        continue;
      }

      final libraryInfo = _buildLibraryInfo(
        analysisResult,
        registry,
        result.element,
        rootPath,
      );
      analysisResult.libraries[libraryInfo.uri] = libraryInfo;
      if (!analysisResult.rootPackage.libraries.contains(libraryInfo)) {
        analysisResult.rootPackage.libraries.add(libraryInfo);
      }

      if (followReExports) {
        for (final exportedLibrary in result.element.exportedLibraries) {
          final exportUri = exportedLibrary.firstFragment.source.uri;
          if (_shouldFollowReExport(
            exportUri,
            rootPath,
            packageName,
            followReExportPackages,
            skipReExports,
          )) {
            if (queuedUris.add(exportUri)) {
              pendingExports.add(exportedLibrary.firstFragment.source.fullName);
            }
          }
        }
      }
    }

    while (pendingExports.isNotEmpty) {
      final exportPath = pendingExports.removeLast();
      final exportResult = await session.getResolvedLibrary(exportPath);
      if (exportResult is! analysis_results.ResolvedLibraryResult) {
        continue;
      }
      final exportUri = exportResult.element.firstFragment.source.uri;
      if (analysisResult.libraries.containsKey(exportUri)) {
        continue;
      }

      final libraryInfo = _buildLibraryInfo(
        analysisResult,
        registry,
        exportResult.element,
        rootPath,
      );
      analysisResult.libraries[libraryInfo.uri] = libraryInfo;

      if (followReExports) {
        for (final exportedLibrary in exportResult.element.exportedLibraries) {
          final nextUri = exportedLibrary.firstFragment.source.uri;
          if (_shouldFollowReExport(
            nextUri,
            rootPath,
            packageName,
            followReExportPackages,
            skipReExports,
          )) {
            if (queuedUris.add(nextUri)) {
              pendingExports.add(exportedLibrary.firstFragment.source.fullName);
            }
          }
        }
      }
    }
  }

  bool _isInPackage(Uri uri, String rootPath, String packageName) {
    if (uri.scheme == 'package') {
      if (uri.pathSegments.isEmpty) return false;
      return uri.pathSegments.first == packageName;
    }
    if (uri.scheme == 'file') {
      final filePath = uri.toFilePath();
      return p.isWithin(rootPath, filePath);
    }
    return false;
  }

  bool _shouldFollowReExport(
    Uri uri,
    String rootPath,
    String rootPackageName,
    List<String>? followReExportPackages,
    List<String> skipReExports,
  ) {
    String? package;
    if (uri.scheme == 'package') {
      package = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    } else if (uri.scheme == 'file') {
      if (p.isWithin(rootPath, uri.toFilePath())) {
        package = rootPackageName;
      }
    }

    if (package != null && skipReExports.contains(package)) {
      return false;
    }

    if (followReExportPackages != null && followReExportPackages.isNotEmpty) {
      return package != null && followReExportPackages.contains(package);
    }

    return true;
  }

  Map<String, dynamic> _readPubspec(String rootPath) {
    final pubspecFile = File(p.join(rootPath, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) {
      return {};
    }
    final content = pubspecFile.readAsStringSync();
    final yaml = loadYaml(content);
    if (yaml is YamlMap) {
      return Map<String, dynamic>.from(yaml);
    }
    return {};
  }

  LibraryInfo _buildLibraryInfo(
    AnalysisResult analysisResult,
    _ModelRegistry registry,
    analyzer.LibraryElement libraryElement,
    String rootPath,
  ) {
    final source = libraryElement.firstFragment.source;
    final uri = source.uri;
    final packageInfo = registry.packageForUri(uri, rootPath);

    final libraryId = registry.idGen.nextId('lib');
    final mainFileInfo = _buildFileInfo(
      registry,
      packageInfo,
      uri,
      source.fullName,
      isPart: false,
      partOfDirective: null,
    );

    final partFiles = <FileInfo>[];
    // TODO: Populate part files once analyzer part element APIs are finalized for this version.

    final libraryInfo = LibraryInfo(
      id: libraryId,
      name: libraryElement.displayName,
      uri: uri,
      package: packageInfo,
      mainSourceFile: mainFileInfo,
      documentation: libraryElement.documentationComment,
      annotations: _annotationParser.parseAll(libraryElement.metadata.annotations),
      isDeprecated: libraryElement.metadata.hasDeprecated,
      partFiles: partFiles,
      classes: [],
      enums: [],
      mixins: [],
      extensions: [],
      extensionTypes: [],
      typeAliases: [],
      functions: [],
      variables: [],
      getters: [],
      setters: [],
      exports: [],
      imports: [],
    );

    registry.registerLibrary(libraryInfo);

    // Map all top-level elements from the library
    for (final element in libraryElement.classes) {
      libraryInfo.classes.add(_mapClass(element, libraryInfo, registry));
    }
    for (final element in libraryElement.enums) {
      libraryInfo.enums.add(_mapEnum(element, libraryInfo, registry));
    }
    for (final element in libraryElement.mixins) {
      libraryInfo.mixins.add(_mapMixin(element, libraryInfo, registry));
    }
    for (final element in libraryElement.extensions) {
      libraryInfo.extensions.add(_mapExtension(element, libraryInfo, registry));
    }
    for (final element in libraryElement.extensionTypes) {
      libraryInfo.extensionTypes.add(_mapExtensionType(element, libraryInfo, registry));
    }
    for (final element in libraryElement.typeAliases) {
      libraryInfo.typeAliases.add(_mapTypeAlias(element, libraryInfo, registry));
    }
    for (final element in libraryElement.topLevelFunctions) {
      libraryInfo.functions.add(_mapFunction(element, libraryInfo, registry));
    }
    for (final element in libraryElement.topLevelVariables) {
      libraryInfo.variables.add(_mapTopLevelVariable(element, libraryInfo, registry));
    }
    for (final element in libraryElement.getters) {
      libraryInfo.getters.add(_mapGetter(element, libraryInfo, registry));
    }
    for (final element in libraryElement.setters) {
      libraryInfo.setters.add(_mapSetter(element, libraryInfo, registry));
    }

    // TODO: Populate imports/exports once analyzer API usage is finalized.

    return libraryInfo;
  }

  FileInfo _buildFileInfo(
    _ModelRegistry registry,
    PackageInfo packageInfo,
    Uri uri,
    String filePath,
    {
    required bool isPart,
    required String? partOfDirective,
  }) {
    final file = File(filePath);
    final content = file.existsSync() ? file.readAsStringSync() : '';
    final hash = sha256.convert(content.codeUnits).toString();
    final lines = content.isEmpty ? 0 : content.split('\n').length;

    final library = registry.libraryForUri(uri, packageInfo.rootPath);
    final fileInfo = FileInfo(
      id: registry.idGen.nextId('file'),
      path: filePath,
      package: packageInfo,
      library: library ?? registry.placeholderLibrary(uri, packageInfo),
      isPart: isPart,
      partOfDirective: partOfDirective,
      lines: lines,
      contentHash: hash,
      modified: file.existsSync() ? file.lastModifiedSync() : DateTime.now(),
    );
    registry.registerFile(fileInfo);
    return fileInfo;
  }

  ClassInfo _mapClass(analyzer.ClassElement element, LibraryInfo libraryInfo, _ModelRegistry registry) {
    final classInfo = ClassInfo(
      id: registry.idGen.nextId('class'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      library: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      isAbstract: element.isAbstract,
      isSealed: element.isSealed,
      isFinal: element.isFinal,
      isBase: element.isBase,
      isInterface: element.isInterface,
      isMixin: element.isMixinClass,
      superclass: element.supertype != null ? _typeRef(element.supertype!, registry) : null,
      interfaces: element.interfaces.map((t) => _typeRef(t, registry)).toList(),
      mixins: element.mixins.map((t) => _typeRef(t, registry)).toList(),
      typeParameters: element.typeParameters.map((t) => _typeParameter(t, registry)).toList(),
      constructors: [],
      methods: [],
      fields: [],
      getters: [],
      setters: [],
    );

    for (final ctor in element.constructors) {
      classInfo.constructors.add(_mapConstructor(ctor, classInfo, registry));
    }

    for (final method in element.methods) {
      classInfo.methods.add(_mapMethod(method, classInfo, registry));
    }

    for (final field in element.fields) {
      classInfo.fields.add(_mapField(field, classInfo, registry));
    }

    // TODO: Populate getters/setters once analyzer accessor API is finalized.

    return classInfo;
  }

  EnumInfo _mapEnum(analyzer.EnumElement element, LibraryInfo libraryInfo, _ModelRegistry registry) {
    final enumInfo = EnumInfo(
      id: registry.idGen.nextId('enum'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      library: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      values: [],
      interfaces: element.interfaces.map((t) => _typeRef(t, registry)).toList(),
      mixins: element.mixins.map((t) => _typeRef(t, registry)).toList(),
      fields: [],
      methods: [],
      getters: [],
      setters: [],
      constructors: [],
    );

    for (final value in element.fields.where((f) => f.isEnumConstant)) {
      enumInfo.values.add(
        EnumValueInfo(
          id: registry.idGen.nextId('enumValue'),
          name: value.displayName,
          parentEnum: enumInfo,
          index: enumInfo.values.length,
          documentation: value.documentationComment,
          annotations: _annotationParser.parseAll(value.metadata.annotations),
        ),
      );
    }

    for (final method in element.methods) {
      enumInfo.methods.add(_mapMethod(method, enumInfo, registry));
    }

    for (final field in element.fields) {
      if (!field.isEnumConstant) {
        enumInfo.fields.add(_mapField(field, enumInfo, registry));
      }
    }

    // TODO: Populate enum getters/setters once analyzer accessor API is finalized.

    for (final ctor in element.constructors) {
      enumInfo.constructors.add(_mapConstructor(ctor, enumInfo, registry));
    }

    return enumInfo;
  }

  MixinInfo _mapMixin(analyzer.MixinElement element, LibraryInfo libraryInfo, _ModelRegistry registry) {
    final mixinInfo = MixinInfo(
      id: registry.idGen.nextId('mixin'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      library: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      onTypes: element.superclassConstraints.map((t) => _typeRef(t, registry)).toList(),
      implementsTypes: element.interfaces.map((t) => _typeRef(t, registry)).toList(),
      typeParameters: element.typeParameters.map((t) => _typeParameter(t, registry)).toList(),
      methods: [],
      fields: [],
      getters: [],
      setters: [],
    );

    mixinInfo.methods.addAll(element.methods.map((m) => _mapMethod(m, mixinInfo, registry)));
    mixinInfo.fields.addAll(element.fields.map((f) => _mapField(f, mixinInfo, registry)));
    // TODO: Populate mixin getters/setters once analyzer accessor API is finalized.

    return mixinInfo;
  }

  ExtensionInfo _mapExtension(analyzer.ExtensionElement element, LibraryInfo libraryInfo, _ModelRegistry registry) {
    final extensionInfo = ExtensionInfo(
      id: registry.idGen.nextId('extension'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      library: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      extendedType: _typeRef(element.extendedType, registry),
      typeParameters: element.typeParameters.map((t) => _typeParameter(t, registry)).toList(),
      methods: [],
      fields: [],
      getters: [],
      setters: [],
    );

    extensionInfo.methods.addAll(element.methods.map((m) => _mapMethod(m, extensionInfo, registry)));
    extensionInfo.fields.addAll(element.fields.map((f) => _mapField(f, extensionInfo, registry)));
    // TODO: Populate extension getters/setters once analyzer accessor API is finalized.

    return extensionInfo;
  }

  ExtensionTypeInfo _mapExtensionType(analyzer.ExtensionTypeElement element, LibraryInfo libraryInfo, _ModelRegistry registry) {
    final extensionTypeInfo = ExtensionTypeInfo(
      id: registry.idGen.nextId('extensionType'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      library: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      representationType: _typeRef(element.representation.type, registry),
      typeParameters: element.typeParameters.map((t) => _typeParameter(t, registry)).toList(),
      methods: [],
      fields: [],
      getters: [],
      setters: [],
      constructors: [],
    );

    extensionTypeInfo.methods
        .addAll(element.methods.map((m) => _mapMethod(m, extensionTypeInfo, registry)));
    extensionTypeInfo.fields
        .addAll(element.fields.map((f) => _mapField(f, extensionTypeInfo, registry)));
    // TODO: Populate extension type getters/setters once analyzer accessor API is finalized.
    extensionTypeInfo.constructors
        .addAll(element.constructors.map((c) => _mapConstructor(c, extensionTypeInfo, registry)));

    return extensionTypeInfo;
  }

  TypeAliasInfo _mapTypeAlias(analyzer.TypeAliasElement element, LibraryInfo libraryInfo, _ModelRegistry registry) {
    return TypeAliasInfo(
      id: registry.idGen.nextId('typedef'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      library: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      aliasedType: _typeRef(element.aliasedType, registry),
      typeParameters: element.typeParameters.map((t) => _typeParameter(t, registry)).toList(),
    );
  }

  FunctionInfo _mapFunction(analyzer.TopLevelFunctionElement element, LibraryInfo libraryInfo, _ModelRegistry registry) {
    return FunctionInfo(
      id: registry.idGen.nextId('function'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      library: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      returnType: _typeRef(element.returnType, registry),
      typeParameters: element.typeParameters.map((t) => _typeParameter(t, registry)).toList(),
      parameters: element.formalParameters.map((p) => _mapParameter(p, registry)).toList(),
      // In analyzer 8.x, isAsynchronous and isGenerator are on the fragment
      isAsync: element.firstFragment.isAsynchronous,
      isGenerator: element.firstFragment.isGenerator,
      isExternal: element.isExternal,
    );
  }

  VariableInfo _mapTopLevelVariable(
    analyzer.TopLevelVariableElement element,
    LibraryInfo libraryInfo,
    _ModelRegistry registry,
  ) {
    final isDeprecated = element.metadata.hasDeprecated ||
        (element.getter?.metadata.hasDeprecated ?? false) ||
        (element.setter?.metadata.hasDeprecated ?? false);
    return VariableInfo(
      id: registry.idGen.nextId('variable'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      owningLibrary: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: isDeprecated,
      type: _typeRef(element.type, registry),
      isFinal: element.isFinal,
      isConst: element.isConst,
      isLate: element.isLate,
      hasInitializer: element.hasInitializer,
      hasGetter: element.getter != null,
      hasSetter: !element.isFinal && !element.isConst && element.setter != null,
    );
  }

  FieldInfo _mapField(
    analyzer.FieldElement element,
    TypeDeclaration? declaringType,
    _ModelRegistry registry, {
    LibraryInfo? library,
  }) {
    final ownerLibrary = declaringType?.library ?? library;
    if (ownerLibrary == null) {
      throw StateError('Field without owning library');
    }
    final isDeprecated = element.metadata.hasDeprecated ||
        (element.getter?.metadata.hasDeprecated ?? false) ||
        (element.setter?.metadata.hasDeprecated ?? false);
    return FieldInfo(
      id: registry.idGen.nextId('field'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      declaringType: declaringType,
      owningLibrary: ownerLibrary,
      sourceFile: ownerLibrary.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: isDeprecated,
      type: _typeRef(element.type, registry),
      isFinal: element.isFinal,
      isConst: element.isConst,
      isLate: element.isLate,
      isStatic: element.isStatic,
      hasInitializer: element.hasInitializer,
      // A field has a getter if it has a getter accessor
      hasGetter: element.getter != null,
      // A field has a setter if it's not final/const and has a setter accessor
      hasSetter: !element.isFinal && !element.isConst && element.setter != null,
    );
  }

  MethodInfo _mapMethod(
    analyzer.MethodElement element,
    TypeDeclaration? declaringType,
    _ModelRegistry registry, {
    LibraryInfo? library,
  }) {
    final ownerLibrary = declaringType?.library ?? library;
    if (ownerLibrary == null) {
      throw StateError('Method without owning library');
    }
    return MethodInfo(
      id: registry.idGen.nextId('method'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      declaringType: declaringType,
      owningLibrary: ownerLibrary,
      sourceFile: declaringType?.sourceFile ?? ownerLibrary.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      returnType: _typeRef(element.returnType, registry),
      typeParameters: element.typeParameters.map((t) => _typeParameter(t, registry)).toList(),
      parameters: element.formalParameters.map((p) => _mapParameter(p, registry)).toList(),
      isAsync: false,
      isGenerator: false,
      isExternal: element.isExternal,
      isStatic: element.isStatic,
      isAbstract: element.isAbstract,
      isOperator: element.isOperator,
    );
  }

  GetterInfo _mapGetter(
    analyzer.PropertyAccessorElement element,
    LibraryInfo libraryInfo,
    _ModelRegistry registry, {
    TypeDeclaration? declaringType,
  }) {
    return GetterInfo(
      id: registry.idGen.nextId('getter'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      declaringType: declaringType,
      owningLibrary: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      returnType: _typeRef(element.returnType, registry),
      isAsync: false,
      isExternal: element.isExternal,
      isStatic: element.isStatic,
      isAbstract: element.isAbstract,
    );
  }

  SetterInfo _mapSetter(
    analyzer.PropertyAccessorElement element,
    LibraryInfo libraryInfo,
    _ModelRegistry registry, {
    TypeDeclaration? declaringType,
  }) {
    final parameter = element.formalParameters.isNotEmpty
      ? _mapParameter(element.formalParameters.first, registry)
        : ParameterInfo(
            id: registry.idGen.nextId('param'),
            name: 'value',
            type: _typeRef(element.returnType, registry),
            isRequired: false,
            isNamed: false,
            isPositional: true,
            hasDefaultValue: false,
          );

    return SetterInfo(
      id: registry.idGen.nextId('setter'),
      name: element.displayName,
      qualifiedName: _qualifiedName(element),
      declaringType: declaringType,
      owningLibrary: libraryInfo,
      sourceFile: libraryInfo.mainSourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      parameter: parameter,
      isAsync: false,
      isExternal: element.isExternal,
      isStatic: element.isStatic,
      isAbstract: element.isAbstract,
    );
  }

  ConstructorInfo _mapConstructor(
    analyzer.ConstructorElement element,
    TypeDeclaration? declaringType,
    _ModelRegistry registry,
  ) {
    final ownerType = declaringType;
    if (ownerType == null) {
      throw StateError('Constructor without declaring type');
    }
    return ConstructorInfo(
      id: registry.idGen.nextId('ctor'),
      // Use element.name which returns '' for unnamed constructors
      // instead of displayName which returns the class name
      name: element.name ?? '',
      qualifiedName: _qualifiedName(element),
      declaringType: ownerType,
      sourceFile: ownerType.sourceFile,
      location: _location(element),
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
      isDeprecated: element.metadata.hasDeprecated,
      parameters: element.formalParameters.map((p) => _mapParameter(p, registry)).toList(),
      isExternal: element.isExternal,
      isConst: element.isConst,
      isFactory: element.isFactory,
      redirectedConstructor: element.redirectedConstructor?.displayName,
      superConstructorInvocation: element.superConstructor?.displayName,
    );
  }

  ParameterInfo _mapParameter(analyzer.FormalParameterElement element, _ModelRegistry registry) {
    return ParameterInfo(
      id: registry.idGen.nextId('param'),
      name: element.displayName,
      type: _typeRef(element.type, registry),
      isRequired: element.isRequiredNamed || element.isRequiredPositional,
      isNamed: element.isNamed,
      isPositional: element.isPositional,
      hasDefaultValue: element.hasDefaultValue,
      defaultValue: element.defaultValueCode,
      documentation: element.documentationComment,
      annotations: _annotationParser.parseAll(element.metadata.annotations),
    );
  }

  TypeParameterInfo _typeParameter(analyzer.TypeParameterElement element, _ModelRegistry registry) {
    return TypeParameterInfo(
      id: registry.idGen.nextId('typeParam'),
      name: element.displayName,
      bound: element.bound != null ? _typeRef(element.bound!, registry, {}) : null,
    );
  }

  TypeReference _typeRef(analyzer_types.DartType type, _ModelRegistry registry, [Set<analyzer_types.DartType>? visited]) {
    // Prevent infinite recursion for self-referential type parameters
    visited ??= {};
    if (visited.contains(type)) {
      return TypeReference(
        id: registry.idGen.nextId('type'),
        name: type.getDisplayString(),
        qualifiedName: type.getDisplayString(),
        isTypeParameter: type is analyzer_types.TypeParameterType,
      );
    }
    visited = {...visited, type};
    
    if (type is analyzer_types.FunctionType) {
      return TypeReference(
        id: registry.idGen.nextId('type'),
        name: type.getDisplayString(),
        qualifiedName: type.getDisplayString(),
        isFunction: true,
        isNullable: type.nullabilitySuffix.name == 'question',
        functionType: FunctionTypeInfo(
          id: registry.idGen.nextId('functionType'),
          returnType: _typeRef(type.returnType, registry, visited),
          typeParameters: type.typeParameters.map((t) => _typeParameter(t, registry)).toList(),
          parameters: type.formalParameters.map((p) => _mapParameter(p, registry)).toList(),
        ),
      );
    }

    if (type is analyzer_types.TypeParameterType) {
      return TypeReference(
        id: registry.idGen.nextId('type'),
        name: type.getDisplayString(),
        qualifiedName: type.getDisplayString(),
        isTypeParameter: true,
        typeParameterBound: _typeRef(type.bound, registry, visited),
      );
    }

    if (type is analyzer_types.InterfaceType) {
      final element = type.element;
      final qualified = _qualifiedName(element);
      final typeRef = TypeReference(
        id: registry.idGen.nextId('type'),
        name: element.displayName,
        qualifiedName: qualified,
        typeArguments: type.typeArguments.map((t) => _typeRef(t, registry, visited)).toList(),
        isNullable: type.nullabilitySuffix.name == 'question',
      );
      registry.trackTypeReference(typeRef);
      return typeRef;
    }

    return TypeReference(
      id: registry.idGen.nextId('type'),
      name: type.getDisplayString(),
      qualifiedName: type.getDisplayString(),
      isDynamic: type is analyzer_types.DynamicType,
      isVoid: type is analyzer_types.VoidType,
    );
  }

  SourceLocation _location(analyzer.Element element) {
    // In analyzer 8.x, nameOffset and nameLength are on the fragment, not the element
    final offset = element.firstFragment.nameOffset ?? 0;
    final length = element.displayName.length;
    return SourceLocation(line: 0, column: 0, offset: offset, length: length);
  }

  String _qualifiedName(analyzer.Element element) {
    // In analyzer 8.x, source is on the fragment, not the element
    final libraryUri = element.library?.firstFragment.source.uri.toString() ?? '';
    final name = element.displayName;
    return '$libraryUri.$name';
  }
}

class _ModelRegistry {
  final IdGenerator idGen;
  AnalysisResult? _analysisResult;
  final Map<Uri, LibraryInfo> _libraries = {};
  final Map<String, PackageInfo> _packages = {};
  final List<TypeReference> _allTypeReferences = [];

  _ModelRegistry(this.idGen);

  /// Track a TypeReference for later resolution.
  void trackTypeReference(TypeReference typeRef) {
    _allTypeReferences.add(typeRef);
  }

  /// Resolve all tracked TypeReferences to their corresponding type declarations.
  void resolveTypeReferences(AnalysisResult result) {
    // Build a lookup map from qualifiedName to TypeDeclaration
    final typeDeclarationMap = <String, TypeDeclaration>{};
    for (final cls in result.allClasses) {
      typeDeclarationMap[cls.qualifiedName] = cls;
    }
    for (final enm in result.allEnums) {
      typeDeclarationMap[enm.qualifiedName] = enm;
    }
    for (final mix in result.allMixins) {
      typeDeclarationMap[mix.qualifiedName] = mix;
    }
    for (final ext in result.allExtensions) {
      typeDeclarationMap[ext.qualifiedName] = ext;
    }
    for (final extType in result.allExtensionTypes) {
      typeDeclarationMap[extType.qualifiedName] = extType;
    }
    for (final alias in result.allTypeAliases) {
      typeDeclarationMap[alias.qualifiedName] = alias;
    }

    // Resolve each tracked TypeReference
    for (final typeRef in _allTypeReferences) {
      final resolved = typeDeclarationMap[typeRef.qualifiedName];
      if (resolved != null) {
        typeRef.setResolvedElement(resolved);
      }
    }
  }

  void attachAnalysisResult(AnalysisResult result) {
    _analysisResult = result;
    for (final package in _packages.values) {
      package.attachAnalysisResult(result);
    }
  }

  void registerFile(FileInfo fileInfo) {
    final result = _analysisResult;
    if (result == null) {
      return;
    }
    result.files[fileInfo.path] = fileInfo;
  }

  PackageInfo createPackage({
    required String id,
    required String name,
    required String rootPath,
    required bool isRoot,
    String? version,
  }) {
    final result = _analysisResult;
    final pkg = PackageInfo(
      id: id,
      name: name,
      rootPath: rootPath,
      analysisResult: result,
      version: version,
      isRoot: isRoot,
      libraries: [],
    );
    if (result != null) {
      pkg.attachAnalysisResult(result);
    }
    _packages[name] = pkg;
    if (result != null) {
      result.packages[name] = pkg;
    }
    return pkg;
  }

  PackageInfo packageForUri(Uri uri, String rootPath) {
    final packageName = uri.scheme == 'package' ? uri.pathSegments.first : p.basename(rootPath);
    return _packages.putIfAbsent(
      packageName,
      () => createPackage(
        id: idGen.nextId('pkg'),
        name: packageName,
        rootPath: rootPath,
        isRoot: packageName == _analysisResult?.rootPackage.name,
      ),
    );
  }

  void registerLibrary(LibraryInfo libraryInfo) {
    _libraries[libraryInfo.uri] = libraryInfo;
    if (!libraryInfo.package.libraries.contains(libraryInfo)) {
      libraryInfo.package.libraries.add(libraryInfo);
    }
  }

  LibraryInfo? libraryForUri(Uri? uri, String rootPath) {
    if (uri == null) return null;
    return _libraries[uri] ?? placeholderLibrary(uri, packageForUri(uri, rootPath));
  }

  LibraryInfo placeholderLibrary(Uri uri, PackageInfo packageInfo) {
    return _libraries.putIfAbsent(uri, () {
      final fileInfo = FileInfo(
        id: idGen.nextId('file'),
        path: uri.toString(),
        package: packageInfo,
        library: null,
        isPart: false,
        lines: 0,
        contentHash: '',
        modified: DateTime.now(),
      );

      final libraryInfo = LibraryInfo(
        id: idGen.nextId('lib'),
        name: uri.pathSegments.isNotEmpty ? uri.pathSegments.last : uri.toString(),
        uri: uri,
        package: packageInfo,
        mainSourceFile: fileInfo,
      );

      return libraryInfo;
    });
  }
}
