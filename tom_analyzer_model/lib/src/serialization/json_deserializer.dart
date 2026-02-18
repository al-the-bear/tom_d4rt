import 'dart:convert';

import '../model/model.dart';

/// Deserializes analysis results from JSON format.
class JsonDeserializer {
  static AnalysisResult decode(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! Map) {
      throw const FormatException('Invalid JSON: expected a map at the root.');
    }
    return fromMap(decoded.cast<String, dynamic>());
  }

  static AnalysisResult fromMap(Map<String, dynamic> data) {
    return _JsonReader().read(data);
  }
}

class _JsonReader {
  AnalysisResult read(Map<String, dynamic> data) {
    final packageRecords = <String, _PackageRecord>{};

    final packagesData = _requireList(data['packages'], 'packages');
    for (final entry in packagesData) {
      if (entry is! Map) {
        throw const FormatException('Invalid package entry in packages list.');
      }
      _addPackageRecord(packageRecords, entry.cast<String, dynamic>());
    }

    final rootPackageId = _readOptionalString(data['rootPackageId']);
    if (rootPackageId == null) {
      final rootPackageData = _requireMap(data['rootPackage'], 'rootPackage');
      _addPackageRecord(packageRecords, rootPackageData, isRootOverride: true);
    }

    final packageById = <String, PackageInfo>{};
    for (final record in packageRecords.values) {
      packageById[record.package.id] = record.package;
    }

    final filesData = _requireList(data['files'], 'files');
    final filesById = <String, FileInfo>{};
    final filesByPath = <String, FileInfo>{};

    for (final entry in filesData) {
      if (entry is! Map) {
        throw const FormatException('Invalid file entry in files list.');
      }
      final file = _readFile(entry.cast<String, dynamic>(), packageById);
      filesById[file.id] = file;
      filesByPath[file.path] = file;
    }

    final librariesData = _requireList(data['libraries'], 'libraries');
    final librariesByUri = <Uri, LibraryInfo>{};
    final librariesById = <String, LibraryInfo>{};
    final libraryDataById = <String, Map<String, dynamic>>{};
    for (final entry in librariesData) {
      if (entry is! Map) {
        throw const FormatException('Invalid library entry in libraries list.');
      }
      final entryMap = entry.cast<String, dynamic>();
      final library = _readLibrary(
        entryMap,
        packageById,
        filesById,
      );
      librariesByUri[library.uri] = library;
      librariesById[library.id] = library;
      libraryDataById[library.id] = entryMap;
      library.package.libraries.add(library);
    }

    for (final entry in libraryDataById.entries) {
      final library = librariesById[entry.key];
      if (library != null) {
        _populateLibraryMembers(
          library,
          entry.value,
          librariesById,
          filesById,
        );
      }
    }

    final errors = _readErrors(data['errors']);

    final rootPackage = _resolveRootPackage(packageRecords, rootPackageId);
    final analysisResult = AnalysisResult(
      id: _requireString(data['id'], 'id'),
      timestamp: _readDateTime(data['timestamp'], 'timestamp'),
      dartSdkVersion: _requireString(data['dartSdkVersion'], 'dartSdkVersion'),
      analyzerVersion: _requireString(data['analyzerVersion'], 'analyzerVersion'),
      schemaVersion: _requireString(data['schemaVersion'], 'schemaVersion'),
      rootPackage: rootPackage,
      packages: {
        for (final record in packageRecords.values) record.package.name: record.package,
      },
      libraries: librariesByUri,
      files: filesByPath,
      errors: errors,
      metadata: _readMetadata(data['metadata']),
    );

    for (final record in packageRecords.values) {
      record.package.attachAnalysisResult(analysisResult);
    }

    _attachDependencies(packageRecords);

    return analysisResult;
  }

  PackageInfo _resolveRootPackage(
    Map<String, _PackageRecord> records,
    String? rootPackageId,
  ) {
    if (rootPackageId != null) {
      for (final record in records.values) {
        if (record.package.id == rootPackageId) {
          return record.package;
        }
      }
      throw FormatException('Unknown rootPackageId "$rootPackageId".');
    }
    final rootRecord = records.values.firstWhere(
      (record) => record.package.isRoot,
      orElse: () => throw const FormatException('Missing root package definition.'),
    );
    return rootRecord.package;
  }

  void _addPackageRecord(
    Map<String, _PackageRecord> records,
    Map<String, dynamic> data, {
    bool isRootOverride = false,
  }) {
    final name = _requireString(data['name'], 'name');
    if (records.containsKey(name)) {
      return;
    }
    final id = _requireString(data['id'], 'id');
    final rootPath = _requireString(data['rootPath'], 'rootPath');
    final version = _readOptionalString(data['version']);
    final isRoot = data['isRoot'] as bool? ?? isRootOverride;

    final dependencies = _readStringList(data['dependencies']);
    final devDependencies = _readStringList(data['devDependencies']);

    final record = _PackageRecord(
      package: PackageInfo(
        id: id,
        name: name,
        version: version,
        rootPath: rootPath,
        isRoot: isRoot,
        libraries: <LibraryInfo>[],
        dependencies: <String, PackageInfo>{},
        devDependencies: <String, PackageInfo>{},
      ),
      dependencyNames: dependencies,
      devDependencyNames: devDependencies,
    );

    records[name] = record;
  }

  FileInfo _readFile(Map<String, dynamic> data, Map<String, PackageInfo> packageById) {
    final id = _requireString(data['id'], 'id');
    final path = _requireString(data['path'], 'path');
    final packageId = _requireString(data['packageId'], 'packageId');
    final package = packageById[packageId];
    if (package == null) {
      throw FormatException('Unknown packageId "$packageId" for file "$path".');
    }

    return FileInfo(
      id: id,
      path: path,
      package: package,
      library: null,
      isPart: data['isPart'] as bool? ?? false,
      partOfDirective: _readOptionalString(data['partOfDirective']),
      lines: _readInt(data['lines'], 'lines'),
      contentHash: _requireString(data['contentHash'], 'contentHash'),
      modified: _readDateTime(data['modified'], 'modified'),
    );
  }

  LibraryInfo _readLibrary(
    Map<String, dynamic> data,
    Map<String, PackageInfo> packageById,
    Map<String, FileInfo> filesById,
  ) {
    final id = _requireString(data['id'], 'id');
    final name = _requireString(data['name'], 'name');
    final uri = Uri.parse(_requireString(data['uri'], 'uri'));
    final packageId = _requireString(data['packageId'], 'packageId');
    final package = packageById[packageId];
    if (package == null) {
      throw FormatException('Unknown packageId "$packageId" for library "$name".');
    }

    final mainSourceFileId = _requireString(data['mainSourceFileId'], 'mainSourceFileId');
    final mainSourceFile = filesById[mainSourceFileId];
    if (mainSourceFile == null) {
      throw FormatException('Unknown mainSourceFileId "$mainSourceFileId" for library "$name".');
    }

    final partFileIds = _readStringList(data['partFileIds']);
    final partFiles = <FileInfo>[];
    for (final partId in partFileIds) {
      final file = filesById[partId];
      if (file != null) {
        partFiles.add(file);
      }
    }

    return LibraryInfo(
      id: id,
      name: name,
      uri: uri,
      package: package,
      mainSourceFile: mainSourceFile,
      partFiles: partFiles,
      documentation: _readOptionalString(data['documentation']),
      annotations: _readAnnotations(data['annotations']),
      isDeprecated: _readBool(data['isDeprecated']),
      classes: <ClassInfo>[],
      enums: <EnumInfo>[],
      mixins: <MixinInfo>[],
      extensions: <ExtensionInfo>[],
      extensionTypes: <ExtensionTypeInfo>[],
      typeAliases: <TypeAliasInfo>[],
      functions: <FunctionInfo>[],
      variables: <VariableInfo>[],
      getters: <GetterInfo>[],
      setters: <SetterInfo>[],
      exports: <ExportInfo>[],
      imports: <ImportInfo>[],
    );
  }

  void _populateLibraryMembers(
    LibraryInfo library,
    Map<String, dynamic> data,
    Map<String, LibraryInfo> librariesById,
    Map<String, FileInfo> filesById,
  ) {
    final classes = _readList(data['classes']);
    final enums = _readList(data['enums']);
    final mixins = _readList(data['mixins']);
    final extensions = _readList(data['extensions']);
    final extensionTypes = _readList(data['extensionTypes']);
    final typeAliases = _readList(data['typeAliases']);
    final functions = _readList(data['functions']);

    for (final entry in classes) {
      if (entry is Map) {
        library.classes.add(_readClass(entry.cast<String, dynamic>(), library, librariesById, filesById));
      }
    }
    for (final entry in enums) {
      if (entry is Map) {
        library.enums.add(_readEnum(entry.cast<String, dynamic>(), library, librariesById, filesById));
      }
    }
    for (final entry in mixins) {
      if (entry is Map) {
        library.mixins.add(_readMixin(entry.cast<String, dynamic>(), library, librariesById, filesById));
      }
    }
    for (final entry in extensions) {
      if (entry is Map) {
        library.extensions.add(
          _readExtension(entry.cast<String, dynamic>(), library, librariesById, filesById),
        );
      }
    }
    for (final entry in extensionTypes) {
      if (entry is Map) {
        library.extensionTypes.add(
          _readExtensionType(entry.cast<String, dynamic>(), library, librariesById, filesById),
        );
      }
    }
    for (final entry in typeAliases) {
      if (entry is Map) {
        library.typeAliases.add(
          _readTypeAlias(entry.cast<String, dynamic>(), library, librariesById, filesById),
        );
      }
    }
    for (final entry in functions) {
      if (entry is Map) {
        library.functions.add(
          _readFunction(entry.cast<String, dynamic>(), library, librariesById, filesById),
        );
      }
    }
  }

  ClassInfo _readClass(
    Map<String, dynamic> data,
    LibraryInfo library,
    Map<String, LibraryInfo> librariesById,
    Map<String, FileInfo> filesById,
  ) {
    final sourceFile = _resolveFile(filesById, data['sourceFileId']);
    // Use mutable lists so we can add members after construction
    final constructors = <ConstructorInfo>[];
    final methods = <MethodInfo>[];
    final fields = <FieldInfo>[];
    final getters = <GetterInfo>[];
    final setters = <SetterInfo>[];

    final classInfo = ClassInfo(
      id: _requireString(data['id'], 'id'),
      name: _requireString(data['name'], 'name'),
      qualifiedName: _requireString(data['qualifiedName'], 'qualifiedName'),
      library: library,
      sourceFile: sourceFile,
      location: _readSourceLocation(data['location']),
      documentation: _readOptionalString(data['documentation']),
      annotations: _readAnnotations(data['annotations']),
      isDeprecated: _readBool(data['isDeprecated']),
      isAbstract: _readBool(data['isAbstract']),
      isSealed: _readBool(data['isSealed']),
      isFinal: _readBool(data['isFinal']),
      isBase: _readBool(data['isBase']),
      isInterface: _readBool(data['isInterface']),
      isMixin: _readBool(data['isMixin']),
      superclass: _readTypeReference(data['superclass'], librariesById),
      interfaces: _readTypeReferences(data['interfaces'], librariesById),
      mixins: _readTypeReferences(data['mixins'], librariesById),
      typeParameters: _readTypeParameters(data['typeParameters'], librariesById),
      constructors: constructors,
      methods: methods,
      fields: fields,
      getters: getters,
      setters: setters,
    );

    // Now populate members with reference to declaring type
    _readConstructors(data['constructors'], classInfo, filesById, librariesById, constructors);
    _readMethods(data['methods'], classInfo, filesById, librariesById, methods);
    _readFields(data['fields'], classInfo, filesById, librariesById, fields);
    _readGetters(data['getters'], classInfo, filesById, librariesById, getters);
    _readSetters(data['setters'], classInfo, filesById, librariesById, setters);

    return classInfo;
  }

  EnumInfo _readEnum(
    Map<String, dynamic> data,
    LibraryInfo library,
    Map<String, LibraryInfo> librariesById,
    Map<String, FileInfo> filesById,
  ) {
    final sourceFile = _resolveFile(filesById, data['sourceFileId']);
    // Use mutable lists so we can add members after construction
    final values = <EnumValueInfo>[];
    final constructors = <ConstructorInfo>[];
    final methods = <MethodInfo>[];
    final fields = <FieldInfo>[];
    final getters = <GetterInfo>[];
    final setters = <SetterInfo>[];

    final enumInfo = EnumInfo(
      id: _requireString(data['id'], 'id'),
      name: _requireString(data['name'], 'name'),
      qualifiedName: _requireString(data['qualifiedName'], 'qualifiedName'),
      library: library,
      sourceFile: sourceFile,
      location: _readSourceLocation(data['location']),
      documentation: _readOptionalString(data['documentation']),
      annotations: _readAnnotations(data['annotations']),
      isDeprecated: _readBool(data['isDeprecated']),
      values: values,
      interfaces: _readTypeReferences(data['interfaces'], librariesById),
      mixins: _readTypeReferences(data['mixins'], librariesById),
      fields: fields,
      methods: methods,
      getters: getters,
      setters: setters,
      constructors: constructors,
    );

    // Now populate members with reference to declaring type
    _readEnumValues(data['values'], enumInfo, values);
    _readConstructors(data['constructors'], enumInfo, filesById, librariesById, constructors);
    _readMethods(data['methods'], enumInfo, filesById, librariesById, methods);
    _readFields(data['fields'], enumInfo, filesById, librariesById, fields);
    _readGetters(data['getters'], enumInfo, filesById, librariesById, getters);
    _readSetters(data['setters'], enumInfo, filesById, librariesById, setters);

    return enumInfo;
  }

  MixinInfo _readMixin(
    Map<String, dynamic> data,
    LibraryInfo library,
    Map<String, LibraryInfo> librariesById,
    Map<String, FileInfo> filesById,
  ) {
    final sourceFile = _resolveFile(filesById, data['sourceFileId']);
    // Use mutable lists so we can add members after construction
    final methods = <MethodInfo>[];
    final fields = <FieldInfo>[];
    final getters = <GetterInfo>[];
    final setters = <SetterInfo>[];

    final mixinInfo = MixinInfo(
      id: _requireString(data['id'], 'id'),
      name: _requireString(data['name'], 'name'),
      qualifiedName: _requireString(data['qualifiedName'], 'qualifiedName'),
      library: library,
      sourceFile: sourceFile,
      location: _readSourceLocation(data['location']),
      documentation: _readOptionalString(data['documentation']),
      annotations: _readAnnotations(data['annotations']),
      isDeprecated: _readBool(data['isDeprecated']),
      onTypes: _readTypeReferences(data['onTypes'], librariesById),
      implementsTypes: _readTypeReferences(data['implementsTypes'], librariesById),
      typeParameters: _readTypeParameters(data['typeParameters'], librariesById),
      methods: methods,
      fields: fields,
      getters: getters,
      setters: setters,
    );

    // Now populate members with reference to declaring type
    _readMethods(data['methods'], mixinInfo, filesById, librariesById, methods);
    _readFields(data['fields'], mixinInfo, filesById, librariesById, fields);
    _readGetters(data['getters'], mixinInfo, filesById, librariesById, getters);
    _readSetters(data['setters'], mixinInfo, filesById, librariesById, setters);

    return mixinInfo;
  }

  ExtensionInfo _readExtension(
    Map<String, dynamic> data,
    LibraryInfo library,
    Map<String, LibraryInfo> librariesById,
    Map<String, FileInfo> filesById,
  ) {
    final sourceFile = _resolveFile(filesById, data['sourceFileId']);
    final extendedType = _readTypeReference(data['extendedType'], librariesById) ??
        TypeReference(
          id: 'type_unknown',
          name: 'dynamic',
          qualifiedName: 'dynamic',
          isDynamic: true,
        );
    // Use mutable lists so we can add members after construction
    final methods = <MethodInfo>[];
    final fields = <FieldInfo>[];
    final getters = <GetterInfo>[];
    final setters = <SetterInfo>[];

    final extensionInfo = ExtensionInfo(
      id: _requireString(data['id'], 'id'),
      name: _requireString(data['name'], 'name'),
      qualifiedName: _requireString(data['qualifiedName'], 'qualifiedName'),
      library: library,
      sourceFile: sourceFile,
      location: _readSourceLocation(data['location']),
      documentation: _readOptionalString(data['documentation']),
      annotations: _readAnnotations(data['annotations']),
      isDeprecated: _readBool(data['isDeprecated']),
      extendedType: extendedType,
      typeParameters: _readTypeParameters(data['typeParameters'], librariesById),
      methods: methods,
      fields: fields,
      getters: getters,
      setters: setters,
    );

    // Now populate members with reference to declaring type
    _readMethods(data['methods'], extensionInfo, filesById, librariesById, methods);
    _readFields(data['fields'], extensionInfo, filesById, librariesById, fields);
    _readGetters(data['getters'], extensionInfo, filesById, librariesById, getters);
    _readSetters(data['setters'], extensionInfo, filesById, librariesById, setters);

    return extensionInfo;
  }

  ExtensionTypeInfo _readExtensionType(
    Map<String, dynamic> data,
    LibraryInfo library,
    Map<String, LibraryInfo> librariesById,
    Map<String, FileInfo> filesById,
  ) {
    final sourceFile = _resolveFile(filesById, data['sourceFileId']);
    final representationType = _readTypeReference(data['representationType'], librariesById) ??
        TypeReference(
          id: 'type_unknown',
          name: 'dynamic',
          qualifiedName: 'dynamic',
          isDynamic: true,
        );
    // Use mutable lists so we can add members after construction
    final constructors = <ConstructorInfo>[];
    final methods = <MethodInfo>[];
    final fields = <FieldInfo>[];
    final getters = <GetterInfo>[];
    final setters = <SetterInfo>[];

    final extensionTypeInfo = ExtensionTypeInfo(
      id: _requireString(data['id'], 'id'),
      name: _requireString(data['name'], 'name'),
      qualifiedName: _requireString(data['qualifiedName'], 'qualifiedName'),
      library: library,
      sourceFile: sourceFile,
      location: _readSourceLocation(data['location']),
      documentation: _readOptionalString(data['documentation']),
      annotations: _readAnnotations(data['annotations']),
      isDeprecated: _readBool(data['isDeprecated']),
      representationType: representationType,
      primaryConstructor: null, // TODO: Read primary constructor
      typeParameters: _readTypeParameters(data['typeParameters'], librariesById),
      methods: methods,
      fields: fields,
      getters: getters,
      setters: setters,
      constructors: constructors,
    );

    // Now populate members with reference to declaring type
    _readConstructors(data['constructors'], extensionTypeInfo, filesById, librariesById, constructors);
    _readMethods(data['methods'], extensionTypeInfo, filesById, librariesById, methods);
    _readFields(data['fields'], extensionTypeInfo, filesById, librariesById, fields);
    _readGetters(data['getters'], extensionTypeInfo, filesById, librariesById, getters);
    _readSetters(data['setters'], extensionTypeInfo, filesById, librariesById, setters);

    return extensionTypeInfo;
  }

  TypeAliasInfo _readTypeAlias(
    Map<String, dynamic> data,
    LibraryInfo library,
    Map<String, LibraryInfo> librariesById,
    Map<String, FileInfo> filesById,
  ) {
    final sourceFile = _resolveFile(filesById, data['sourceFileId']);
    final aliasedType = _readTypeReference(data['aliasedType'], librariesById) ??
        TypeReference(
          id: 'type_unknown',
          name: 'dynamic',
          qualifiedName: 'dynamic',
          isDynamic: true,
        );
    return TypeAliasInfo(
      id: _requireString(data['id'], 'id'),
      name: _requireString(data['name'], 'name'),
      qualifiedName: _requireString(data['qualifiedName'], 'qualifiedName'),
      library: library,
      sourceFile: sourceFile,
      location: _readSourceLocation(data['location']),
      documentation: _readOptionalString(data['documentation']),
      annotations: _readAnnotations(data['annotations']),
      isDeprecated: _readBool(data['isDeprecated']),
      aliasedType: aliasedType,
      typeParameters: _readTypeParameters(data['typeParameters'], librariesById),
    );
  }

  FunctionInfo _readFunction(
    Map<String, dynamic> data,
    LibraryInfo library,
    Map<String, LibraryInfo> librariesById,
    Map<String, FileInfo> filesById,
  ) {
    final sourceFile = _resolveFile(filesById, data['sourceFileId']);
    final returnType = _readTypeReference(data['returnType'], librariesById) ??
        TypeReference(
          id: 'type_unknown',
          name: 'dynamic',
          qualifiedName: 'dynamic',
          isDynamic: true,
        );
    return FunctionInfo(
      id: _requireString(data['id'], 'id'),
      name: _requireString(data['name'], 'name'),
      qualifiedName: _requireString(data['qualifiedName'], 'qualifiedName'),
      library: library,
      sourceFile: sourceFile,
      location: _readSourceLocation(data['location']),
      documentation: _readOptionalString(data['documentation']),
      annotations: _readAnnotations(data['annotations']),
      isDeprecated: _readBool(data['isDeprecated']),
      returnType: returnType,
      typeParameters: _readTypeParameters(data['typeParameters'], librariesById),
      parameters: _readParameters(data['parameters'], librariesById),
      isAsync: _readBool(data['isAsync']),
      isGenerator: _readBool(data['isGenerator']),
      isExternal: _readBool(data['isExternal']),
    );
  }

  FileInfo _resolveFile(Map<String, FileInfo> filesById, Object? idValue) {
    final id = _requireString(idValue, 'sourceFileId');
    final file = filesById[id];
    if (file == null) {
      throw FormatException('Unknown sourceFileId "$id" for element.');
    }
    return file;
  }

  List _readList(Object? value) {
    if (value == null) return const [];
    if (value is List) return value;
    throw const FormatException('Invalid list value.');
  }

  bool _readBool(Object? value) => value is bool ? value : false;

  SourceLocation _readSourceLocation(Object? value) {
    if (value is Map) {
      final map = value.cast<String, dynamic>();
      return SourceLocation(
        line: _readInt(map['line'], 'line'),
        column: _readInt(map['column'], 'column'),
        offset: _readInt(map['offset'], 'offset'),
        length: _readInt(map['length'], 'length'),
      );
    }
    return const SourceLocation(line: 0, column: 0, offset: 0, length: 0);
  }

  List<AnnotationInfo> _readAnnotations(Object? value) {
    if (value == null) return const [];
    if (value is! List) {
      throw const FormatException('Invalid annotations value.');
    }
    return value.whereType<Map>().map((entry) {
      final map = entry.cast<String, dynamic>();
      final namedArguments = <String, ArgumentValue>{};
      final rawNamed = map['namedArguments'];
      if (rawNamed is Map) {
        for (final entry in rawNamed.entries) {
          namedArguments[entry.key.toString()] = ArgumentValue(entry.value);
        }
      }
      final positionalArgs = <ArgumentValue>[];
      final rawPositional = map['positionalArguments'];
      if (rawPositional is List) {
        positionalArgs.addAll(rawPositional.map(ArgumentValue.new));
      }
      return AnnotationInfo(
        name: _requireString(map['name'], 'name'),
        qualifiedName: _requireString(map['qualifiedName'], 'qualifiedName'),
        constructorName: _readOptionalString(map['constructorName']),
        namedArguments: namedArguments,
        positionalArguments: positionalArgs,
      );
    }).toList();
  }

  TypeReference? _readTypeReference(Object? value, Map<String, LibraryInfo> librariesById) {
    if (value == null) return null;
    if (value is! Map) {
      throw FormatException('Invalid type reference value: $value');
    }
    final map = value.cast<String, dynamic>();
    // Name can be null for some types like dart:core.Null
    final name = map['name'] as String? ?? 'Null';
    final qualifiedName = map['qualifiedName'] as String? ?? name;
    return TypeReference(
      id: _requireString(map['id'], 'id'),
      name: name,
      qualifiedName: qualifiedName,
      typeArguments: _readTypeReferences(map['typeArguments'], librariesById),
      isNullable: _readBool(map['isNullable']),
      isDynamic: _readBool(map['isDynamic']),
      isVoid: _readBool(map['isVoid']),
      isFunction: _readBool(map['isFunction']),
      functionType: _readFunctionType(map['functionType'], librariesById),
      definitionLibrary: _readLibraryById(map['definitionLibraryId'], librariesById),
      isTypeParameter: _readBool(map['isTypeParameter']),
      typeParameterBound: _readTypeReference(map['typeParameterBound'], librariesById),
    );
  }

  List<TypeReference> _readTypeReferences(Object? value, Map<String, LibraryInfo> librariesById) {
    if (value == null) return const [];
    if (value is! List) {
      throw const FormatException('Invalid type references value.');
    }
    return value
        .whereType<Map>()
        .map((entry) => _readTypeReference(entry, librariesById))
        .whereType<TypeReference>()
        .toList();
  }

  FunctionTypeInfo? _readFunctionType(Object? value, Map<String, LibraryInfo> librariesById) {
    if (value == null) return null;
    if (value is! Map) {
      throw const FormatException('Invalid function type value.');
    }
    final map = value.cast<String, dynamic>();
    final returnType = _readTypeReference(map['returnType'], librariesById) ??
        TypeReference(
          id: 'type_unknown',
          name: 'dynamic',
          qualifiedName: 'dynamic',
          isDynamic: true,
        );
    return FunctionTypeInfo(
      id: _requireString(map['id'], 'id'),
      returnType: returnType,
      typeParameters: _readTypeParameters(map['typeParameters'], librariesById),
      parameters: _readParameters(map['parameters'], librariesById),
    );
  }

  List<TypeParameterInfo> _readTypeParameters(
    Object? value,
    Map<String, LibraryInfo> librariesById,
  ) {
    if (value == null) return const [];
    if (value is! List) {
      throw const FormatException('Invalid type parameters value.');
    }
    return value.whereType<Map>().map((entry) {
      final map = entry.cast<String, dynamic>();
      return TypeParameterInfo(
        id: _requireString(map['id'], 'id'),
        name: _requireString(map['name'], 'name'),
        bound: _readTypeReference(map['bound'], librariesById),
        defaultType: _readTypeReference(map['defaultType'], librariesById),
        variance: _readVariance(map['variance']),
      );
    }).toList();
  }

  TypeParameterVariance? _readVariance(Object? value) {
    if (value is! String) return null;
    return TypeParameterVariance.values.firstWhere(
      (v) => v.name == value,
      orElse: () => TypeParameterVariance.invariant,
    );
  }

  List<ParameterInfo> _readParameters(Object? value, Map<String, LibraryInfo> librariesById) {
    if (value == null) return const [];
    if (value is! List) {
      throw const FormatException('Invalid parameters value.');
    }
    return value.whereType<Map>().map((entry) {
      final map = entry.cast<String, dynamic>();
      final type = _readTypeReference(map['type'], librariesById) ??
          TypeReference(
            id: 'type_unknown',
            name: 'dynamic',
            qualifiedName: 'dynamic',
            isDynamic: true,
          );
      return ParameterInfo(
        id: _requireString(map['id'], 'id'),
        name: _requireString(map['name'], 'name'),
        type: type,
        isRequired: _readBool(map['isRequired']),
        isNamed: _readBool(map['isNamed']),
        isPositional: _readBool(map['isPositional']),
        hasDefaultValue: _readBool(map['hasDefaultValue']),
        defaultValue: _readOptionalString(map['defaultValue']),
        documentation: _readOptionalString(map['documentation']),
        annotations: _readAnnotations(map['annotations']),
      );
    }).toList();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Member reading methods
  // ═══════════════════════════════════════════════════════════════════════════

  void _readConstructors(
    Object? value,
    TypeDeclaration declaringType,
    Map<String, FileInfo> filesById,
    Map<String, LibraryInfo> librariesById,
    List<ConstructorInfo> target,
  ) {
    if (value == null) return;
    if (value is! List) return;
    for (final entry in value) {
      if (entry is! Map) continue;
      final map = entry.cast<String, dynamic>();
      final sourceFile = _resolveFile(filesById, map['sourceFileId']);
      target.add(ConstructorInfo(
        id: _requireString(map['id'], 'id'),
        name: _requireString(map['name'], 'name'),
        qualifiedName: _requireString(map['qualifiedName'], 'qualifiedName'),
        declaringType: declaringType,
        sourceFile: sourceFile,
        location: _readSourceLocation(map['location']),
        documentation: _readOptionalString(map['documentation']),
        annotations: _readAnnotations(map['annotations']),
        isDeprecated: _readBool(map['isDeprecated']),
        parameters: _readParameters(map['parameters'], librariesById),
        isAsync: _readBool(map['isAsync']),
        isExternal: _readBool(map['isExternal']),
        isConst: _readBool(map['isConst']),
        isFactory: _readBool(map['isFactory']),
        redirectedConstructor: _readOptionalString(map['redirectedConstructor']),
        superConstructorInvocation: _readOptionalString(map['superConstructorInvocation']),
      ));
    }
  }

  void _readMethods(
    Object? value,
    TypeDeclaration declaringType,
    Map<String, FileInfo> filesById,
    Map<String, LibraryInfo> librariesById,
    List<MethodInfo> target,
  ) {
    if (value == null) return;
    if (value is! List) return;
    for (final entry in value) {
      if (entry is! Map) continue;
      final map = entry.cast<String, dynamic>();
      final sourceFile = _resolveFile(filesById, map['sourceFileId']);
      final returnType = _readTypeReference(map['returnType'], librariesById) ??
          TypeReference(
            id: 'type_unknown',
            name: 'dynamic',
            qualifiedName: 'dynamic',
            isDynamic: true,
          );
      target.add(MethodInfo(
        id: _requireString(map['id'], 'id'),
        name: _requireString(map['name'], 'name'),
        qualifiedName: _requireString(map['qualifiedName'], 'qualifiedName'),
        declaringType: declaringType,
        sourceFile: sourceFile,
        location: _readSourceLocation(map['location']),
        documentation: _readOptionalString(map['documentation']),
        annotations: _readAnnotations(map['annotations']),
        isDeprecated: _readBool(map['isDeprecated']),
        returnType: returnType,
        typeParameters: _readTypeParameters(map['typeParameters'], librariesById),
        parameters: _readParameters(map['parameters'], librariesById),
        isAsync: _readBool(map['isAsync']),
        isGenerator: _readBool(map['isGenerator']),
        isExternal: _readBool(map['isExternal']),
        isStatic: _readBool(map['isStatic']),
        isAbstract: _readBool(map['isAbstract']),
        isOperator: _readBool(map['isOperator']),
      ));
    }
  }

  void _readFields(
    Object? value,
    TypeDeclaration declaringType,
    Map<String, FileInfo> filesById,
    Map<String, LibraryInfo> librariesById,
    List<FieldInfo> target,
  ) {
    if (value == null) return;
    if (value is! List) return;
    for (final entry in value) {
      if (entry is! Map) continue;
      final map = entry.cast<String, dynamic>();
      final sourceFile = _resolveFile(filesById, map['sourceFileId']);
      final type = _readTypeReference(map['type'], librariesById) ??
          TypeReference(
            id: 'type_unknown',
            name: 'dynamic',
            qualifiedName: 'dynamic',
            isDynamic: true,
          );
      target.add(FieldInfo(
        id: _requireString(map['id'], 'id'),
        name: _requireString(map['name'], 'name'),
        qualifiedName: _requireString(map['qualifiedName'], 'qualifiedName'),
        declaringType: declaringType,
        sourceFile: sourceFile,
        location: _readSourceLocation(map['location']),
        documentation: _readOptionalString(map['documentation']),
        annotations: _readAnnotations(map['annotations']),
        isDeprecated: _readBool(map['isDeprecated']),
        type: type,
        isFinal: _readBool(map['isFinal']),
        isConst: _readBool(map['isConst']),
        isLate: _readBool(map['isLate']),
        isStatic: _readBool(map['isStatic']),
        hasInitializer: _readBool(map['hasInitializer']),
        hasGetter: map['hasGetter'] as bool? ?? true,
        hasSetter: map['hasSetter'] as bool? ?? true,
      ));
    }
  }

  void _readGetters(
    Object? value,
    TypeDeclaration declaringType,
    Map<String, FileInfo> filesById,
    Map<String, LibraryInfo> librariesById,
    List<GetterInfo> target,
  ) {
    if (value == null) return;
    if (value is! List) return;
    for (final entry in value) {
      if (entry is! Map) continue;
      final map = entry.cast<String, dynamic>();
      final sourceFile = _resolveFile(filesById, map['sourceFileId']);
      final returnType = _readTypeReference(map['returnType'], librariesById) ??
          TypeReference(
            id: 'type_unknown',
            name: 'dynamic',
            qualifiedName: 'dynamic',
            isDynamic: true,
          );
      target.add(GetterInfo(
        id: _requireString(map['id'], 'id'),
        name: _requireString(map['name'], 'name'),
        qualifiedName: _requireString(map['qualifiedName'], 'qualifiedName'),
        declaringType: declaringType,
        sourceFile: sourceFile,
        location: _readSourceLocation(map['location']),
        documentation: _readOptionalString(map['documentation']),
        annotations: _readAnnotations(map['annotations']),
        isDeprecated: _readBool(map['isDeprecated']),
        returnType: returnType,
        isAsync: _readBool(map['isAsync']),
        isExternal: _readBool(map['isExternal']),
        isStatic: _readBool(map['isStatic']),
        isAbstract: _readBool(map['isAbstract']),
      ));
    }
  }

  void _readSetters(
    Object? value,
    TypeDeclaration declaringType,
    Map<String, FileInfo> filesById,
    Map<String, LibraryInfo> librariesById,
    List<SetterInfo> target,
  ) {
    if (value == null) return;
    if (value is! List) return;
    for (final entry in value) {
      if (entry is! Map) continue;
      final map = entry.cast<String, dynamic>();
      final sourceFile = _resolveFile(filesById, map['sourceFileId']);
      final parameters = _readParameters(map['parameters'], librariesById);
      // SetterInfo requires exactly one parameter
      if (parameters.isEmpty) continue;
      target.add(SetterInfo(
        id: _requireString(map['id'], 'id'),
        name: _requireString(map['name'], 'name'),
        qualifiedName: _requireString(map['qualifiedName'], 'qualifiedName'),
        declaringType: declaringType,
        sourceFile: sourceFile,
        location: _readSourceLocation(map['location']),
        documentation: _readOptionalString(map['documentation']),
        annotations: _readAnnotations(map['annotations']),
        isDeprecated: _readBool(map['isDeprecated']),
        parameter: parameters.first,
        isAsync: _readBool(map['isAsync']),
        isExternal: _readBool(map['isExternal']),
        isStatic: _readBool(map['isStatic']),
        isAbstract: _readBool(map['isAbstract']),
      ));
    }
  }

  void _readEnumValues(
    Object? value,
    EnumInfo parentEnum,
    List<EnumValueInfo> target,
  ) {
    if (value == null) return;
    if (value is! List) return;
    var index = 0;
    for (final entry in value) {
      if (entry is! Map) continue;
      final map = entry.cast<String, dynamic>();
      target.add(EnumValueInfo(
        id: _requireString(map['id'], 'id'),
        name: _requireString(map['name'], 'name'),
        parentEnum: parentEnum,
        index: map['index'] as int? ?? index,
        documentation: _readOptionalString(map['documentation']),
        annotations: _readAnnotations(map['annotations']),
      ));
      index++;
    }
  }

  LibraryInfo? _readLibraryById(Object? value, Map<String, LibraryInfo> librariesById) {
    if (value is String) {
      return librariesById[value];
    }
    return null;
  }

  List<AnalysisError> _readErrors(Object? raw) {
    if (raw == null) {
      return const [];
    }
    if (raw is! List) {
      throw const FormatException('Invalid errors list.');
    }
    return raw.map((entry) {
      if (entry is! Map) {
        throw const FormatException('Invalid error entry.');
      }
      final map = entry.cast<String, dynamic>();
      return AnalysisError(
        message: _requireString(map['message'], 'message'),
        severity: AnalysisErrorSeverity.values.firstWhere(
          (value) => value.name == _requireString(map['severity'], 'severity'),
          orElse: () => AnalysisErrorSeverity.info,
        ),
        location: _readLocation(map['location']),
        code: _readOptionalString(map['code']),
      );
    }).toList();
  }

  SourceLocation? _readLocation(Object? raw) {
    if (raw == null) {
      return null;
    }
    if (raw is! Map) {
      throw const FormatException('Invalid location entry.');
    }
    final map = raw.cast<String, dynamic>();
    return SourceLocation(
      line: _readInt(map['line'], 'line'),
      column: _readInt(map['column'], 'column'),
      offset: _readInt(map['offset'], 'offset'),
      length: _readInt(map['length'], 'length'),
    );
  }

  Map<String, dynamic> _readMetadata(Object? raw) {
    if (raw == null) {
      return const {};
    }
    if (raw is! Map) {
      throw const FormatException('Invalid metadata entry.');
    }
    return raw.cast<String, dynamic>();
  }

  void _attachDependencies(Map<String, _PackageRecord> records) {
    final byName = {
      for (final record in records.values) record.package.name: record.package,
    };

    for (final record in records.values) {
      for (final depName in record.dependencyNames) {
        final dep = byName[depName];
        if (dep != null) {
          record.package.dependencies[depName] = dep;
        }
      }
      for (final depName in record.devDependencyNames) {
        final dep = byName[depName];
        if (dep != null) {
          record.package.devDependencies[depName] = dep;
        }
      }
    }
  }

  Map<String, dynamic> _requireMap(Object? value, String field) {
    if (value is Map) {
      return value.cast<String, dynamic>();
    }
    throw FormatException('Invalid "$field": expected map.');
  }

  List _requireList(Object? value, String field) {
    if (value is List) {
      return value;
    }
    throw FormatException('Invalid "$field": expected list.');
  }

  String _requireString(Object? value, String field) {
    if (value is String) {
      return value;
    }
    throw FormatException('Invalid "$field": expected string.');
  }

  String? _readOptionalString(Object? value) {
    return value is String ? value : null;
  }

  List<String> _readStringList(Object? value) {
    if (value == null) {
      return const [];
    }
    if (value is List) {
      return value.whereType<String>().toList();
    }
    throw const FormatException('Invalid list value.');
  }

  int _readInt(Object? value, String field) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    throw FormatException('Invalid "$field": expected int.');
  }

  DateTime _readDateTime(Object? value, String field) {
    final raw = _requireString(value, field);
    return DateTime.parse(raw);
  }
}

class _PackageRecord {
  final PackageInfo package;
  final List<String> dependencyNames;
  final List<String> devDependencyNames;

  _PackageRecord({
    required this.package,
    required this.dependencyNames,
    required this.devDependencyNames,
  });
}
