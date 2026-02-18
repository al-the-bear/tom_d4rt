import 'package:tom_analyzer_model/tom_analyzer_model.dart';

import 'reflection_model.dart';

/// Generates reflection code from analysis results.
class ReflectionGenerator {
  final bool includeDeprecatedMembers;

  const ReflectionGenerator({this.includeDeprecatedMembers = false});

  String generate(ReflectionModel model) {
    final result = model.analysisResult;
    final buffer = StringBuffer();
    final libraries = result.libraries.values.toList()
      ..sort((a, b) => a.uri.toString().compareTo(b.uri.toString()));

    final usedLibraryUris = <Uri>{};

    for (final cls in result.allClasses) {
      if (_isPrivate(cls.name) || !_canImport(cls.library.uri)) {
        continue;
      }
      if (!_shouldInclude(cls)) {
        continue;
      }
      usedLibraryUris.add(cls.library.uri);
    }

    for (final enm in result.allEnums) {
      if (_isPrivate(enm.name) || !_canImport(enm.library.uri)) {
        continue;
      }
      if (!_shouldInclude(enm)) {
        continue;
      }
      usedLibraryUris.add(enm.library.uri);
    }

    for (final mixin in result.allMixins) {
      if (_isPrivate(mixin.name) || !_canImport(mixin.library.uri)) {
        continue;
      }
      if (!_shouldInclude(mixin)) {
        continue;
      }
      usedLibraryUris.add(mixin.library.uri);
    }

    for (final ext in result.allExtensions) {
      if (_isPrivate(ext.name) || !_canImport(ext.library.uri)) {
        continue;
      }
      if (!_shouldInclude(ext)) {
        continue;
      }
      usedLibraryUris.add(ext.library.uri);
    }

    for (final extType in result.allExtensionTypes) {
      if (_isPrivate(extType.name) || !_canImport(extType.library.uri)) {
        continue;
      }
      if (!_shouldInclude(extType)) {
        continue;
      }
      usedLibraryUris.add(extType.library.uri);
    }

    for (final alias in result.allTypeAliases) {
      if (_isPrivate(alias.name) || !_canImport(alias.library.uri)) {
        continue;
      }
      if (!_shouldInclude(alias)) {
        continue;
      }
      usedLibraryUris.add(alias.library.uri);
    }

    for (final library in libraries) {
      if (!_canImport(library.uri)) {
        continue;
      }

      var hasGlobals = false;
      for (final variable in library.variables) {
        if (_isPrivate(variable.name) || !_shouldInclude(variable)) continue;
        hasGlobals = true;
        break;
      }
      if (!hasGlobals) {
        for (final getter in library.getters) {
          if (_isPrivate(getter.name) || !_shouldInclude(getter)) continue;
          hasGlobals = true;
          break;
        }
      }
      if (!hasGlobals) {
        for (final setter in library.setters) {
          if (_isPrivate(setter.name) || !_shouldInclude(setter)) continue;
          hasGlobals = true;
          break;
        }
      }
      if (!hasGlobals) {
        for (final function in library.functions) {
          if (_isPrivate(function.name) || !_shouldInclude(function)) continue;
          hasGlobals = true;
          break;
        }
      }

      if (hasGlobals) {
        usedLibraryUris.add(library.uri);
      }
    }

    final importAliases = <Uri, String>{};
    var importIndex = 0;
    for (final uri in usedLibraryUris.toList()
      ..sort((a, b) => a.toString().compareTo(b.toString()))) {
      if (!_canImport(uri)) {
        continue;
      }
      importAliases[uri] = 'lib${importIndex++}';
    }

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('// coverage:ignore-file');
    buffer.writeln("import 'package:tom_analyzer/tom_analyzer.dart' as ta;");
    for (final entry in importAliases.entries) {
      buffer.writeln("import '${entry.key}' as ${entry.value};");
    }
    buffer.writeln();

    buffer.writeln('final _classes = <String, ta.ClassDescriptor>{');
    for (final cls in result.allClasses..sort(_byQualifiedName)) {
      if (_isPrivate(cls.name) || !_canImport(cls.library.uri)) {
        continue;
      }
      if (!_shouldInclude(cls)) {
        continue;
      }
      buffer.writeln(_classDescriptor(cls, importAliases, result));
    }
    buffer.writeln('};');

    buffer.writeln('final _enums = <String, ta.MemberContainerDescriptor>{');
    for (final enm in result.allEnums..sort(_byQualifiedName)) {
      if (_isPrivate(enm.name) || !_canImport(enm.library.uri)) {
        continue;
      }
      if (!_shouldInclude(enm)) {
        continue;
      }
      buffer.writeln(_memberContainer(enm, TypeKindWrapper.enumType, importAliases));
    }
    buffer.writeln('};');

    buffer.writeln('final _mixins = <String, ta.MemberContainerDescriptor>{');
    for (final mix in result.allMixins..sort(_byQualifiedName)) {
      if (_isPrivate(mix.name) || !_canImport(mix.library.uri)) {
        continue;
      }
      if (!_shouldInclude(mix)) {
        continue;
      }
      buffer.writeln(_memberContainer(mix, TypeKindWrapper.mixinType, importAliases));
    }
    buffer.writeln('};');

    buffer.writeln('final _extensions = <String, ta.ExtensionDescriptor>{');
    for (final ext in result.allExtensions..sort(_byQualifiedName)) {
      if (_isPrivate(ext.name) || !_canImport(ext.library.uri)) {
        continue;
      }
      if (!_shouldInclude(ext)) {
        continue;
      }
      buffer.writeln(_extensionDescriptor(ext, importAliases));
    }
    buffer.writeln('};');

    buffer.writeln('final _extensionTypes = <String, ta.MemberContainerDescriptor>{');
    for (final extType in result.allExtensionTypes..sort(_byQualifiedName)) {
      if (_isPrivate(extType.name) || !_canImport(extType.library.uri)) {
        continue;
      }
      if (!_shouldInclude(extType)) {
        continue;
      }
      buffer.writeln(_memberContainer(extType, TypeKindWrapper.extensionType, importAliases));
    }
    buffer.writeln('};');

    buffer.writeln('final _typeAliases = <String, ta.TypeAliasDescriptor>{');
    for (final alias in result.allTypeAliases..sort(_byQualifiedName)) {
      if (_isPrivate(alias.name) || !_canImport(alias.library.uri)) {
        continue;
      }
      if (!_shouldInclude(alias)) {
        continue;
      }
      buffer.writeln(_typeAliasDescriptor(alias));
    }
    buffer.writeln('};');

    buffer.writeln('final _globals = <String, ta.GlobalDescriptor>{');
    for (final library in libraries) {
      if (!_canImport(library.uri)) {
        continue;
      }
      final alias = importAliases[library.uri];
      if (alias == null) {
        continue;
      }

      for (final variable in library.variables..sort(_byName)) {
        if (_isPrivate(variable.name)) {
          continue;
        }
        if (!_shouldInclude(variable)) {
          continue;
        }
        buffer.writeln(_globalVariable(variable, alias));
      }
      for (final getter in library.getters..sort(_byName)) {
        if (_isPrivate(getter.name)) {
          continue;
        }
        if (!_shouldInclude(getter)) {
          continue;
        }
        buffer.writeln(_globalGetter(getter, alias));
      }
      for (final setter in library.setters..sort(_byName)) {
        if (_isPrivate(setter.name)) {
          continue;
        }
        if (!_shouldInclude(setter)) {
          continue;
        }
        buffer.writeln(_globalSetter(setter, alias));
      }
      for (final function in library.functions..sort(_byName)) {
        if (_isPrivate(function.name)) {
          continue;
        }
        if (!_shouldInclude(function)) {
          continue;
        }
        buffer.writeln(_globalFunction(function, alias));
      }
    }
    buffer.writeln('};');

    buffer.writeln('final reflectionApi = ta.ReflectionApi(');
    buffer.writeln('  classesByQualifiedName: _classes,');
    buffer.writeln('  enumsByQualifiedName: _enums,');
    buffer.writeln('  mixinsByQualifiedName: _mixins,');
    buffer.writeln('  extensionsByQualifiedName: _extensions,');
    buffer.writeln('  extensionTypesByQualifiedName: _extensionTypes,');
    buffer.writeln('  typeAliasesByQualifiedName: _typeAliases,');
    buffer.writeln('  globalsByQualifiedName: _globals,');
    buffer.writeln(');');

    return buffer.toString();
  }

  /// Collects inherited methods from superclass chain and mixins.
  /// Returns a map of method name to (MethodInfo, declaringClassQualifiedName).
  Map<String, (MethodInfo, String)> _collectInheritedMethods(
    ClassInfo cls,
    Set<String> ownMethodNames,
  ) {
    final result = <String, (MethodInfo, String)>{};

    // Walk superclass chain (closest superclass first)
    var current = cls.superclass?.resolveAsClass();
    while (current != null) {
      for (final method in current.methods) {
        if (!_isPrivate(method.name) &&
            !method.isStatic &&
            !ownMethodNames.contains(method.name) &&
            !result.containsKey(method.name)) {
          result[method.name] = (method, current.qualifiedName);
        }
      }
      current = current.superclass?.resolveAsClass();
    }

    // Walk mixins (in order - later mixins override earlier ones)
    for (final mixinRef in cls.mixins) {
      final mixinInfo = mixinRef.resolveAsMixin();
      if (mixinInfo != null) {
        for (final method in mixinInfo.methods) {
          if (!_isPrivate(method.name) &&
              !method.isStatic &&
              !ownMethodNames.contains(method.name)) {
            // Mixins can override superclass members
            result[method.name] = (method, mixinInfo.qualifiedName);
          }
        }
      }
    }

    return result;
  }

  /// Collects inherited fields from superclass chain and mixins.
  Map<String, (FieldInfo, String)> _collectInheritedFields(
    ClassInfo cls,
    Set<String> ownFieldNames,
  ) {
    final result = <String, (FieldInfo, String)>{};

    var current = cls.superclass?.resolveAsClass();
    while (current != null) {
      for (final field in current.fields) {
        if (!_isPrivate(field.name) &&
            !field.isStatic &&
            !ownFieldNames.contains(field.name) &&
            !result.containsKey(field.name)) {
          result[field.name] = (field, current.qualifiedName);
        }
      }
      current = current.superclass?.resolveAsClass();
    }

    for (final mixinRef in cls.mixins) {
      final mixinInfo = mixinRef.resolveAsMixin();
      if (mixinInfo != null) {
        for (final field in mixinInfo.fields) {
          if (!_isPrivate(field.name) &&
              !field.isStatic &&
              !ownFieldNames.contains(field.name)) {
            result[field.name] = (field, mixinInfo.qualifiedName);
          }
        }
      }
    }

    return result;
  }

  /// Collects inherited getters from superclass chain and mixins.
  Map<String, (GetterInfo, String)> _collectInheritedGetters(
    ClassInfo cls,
    Set<String> ownGetterNames,
  ) {
    final result = <String, (GetterInfo, String)>{};

    var current = cls.superclass?.resolveAsClass();
    while (current != null) {
      for (final getter in current.getters) {
        if (!_isPrivate(getter.name) &&
            !getter.isStatic &&
            !ownGetterNames.contains(getter.name) &&
            !result.containsKey(getter.name)) {
          result[getter.name] = (getter, current.qualifiedName);
        }
      }
      current = current.superclass?.resolveAsClass();
    }

    for (final mixinRef in cls.mixins) {
      final mixinInfo = mixinRef.resolveAsMixin();
      if (mixinInfo != null) {
        for (final getter in mixinInfo.getters) {
          if (!_isPrivate(getter.name) &&
              !getter.isStatic &&
              !ownGetterNames.contains(getter.name)) {
            result[getter.name] = (getter, mixinInfo.qualifiedName);
          }
        }
      }
    }

    return result;
  }

  /// Collects inherited setters from superclass chain and mixins.
  Map<String, (SetterInfo, String)> _collectInheritedSetters(
    ClassInfo cls,
    Set<String> ownSetterNames,
  ) {
    final result = <String, (SetterInfo, String)>{};

    var current = cls.superclass?.resolveAsClass();
    while (current != null) {
      for (final setter in current.setters) {
        if (!_isPrivate(setter.name) &&
            !setter.isStatic &&
            !ownSetterNames.contains(setter.name) &&
            !result.containsKey(setter.name)) {
          result[setter.name] = (setter, current.qualifiedName);
        }
      }
      current = current.superclass?.resolveAsClass();
    }

    for (final mixinRef in cls.mixins) {
      final mixinInfo = mixinRef.resolveAsMixin();
      if (mixinInfo != null) {
        for (final setter in mixinInfo.setters) {
          if (!_isPrivate(setter.name) &&
              !setter.isStatic &&
              !ownSetterNames.contains(setter.name)) {
            result[setter.name] = (setter, mixinInfo.qualifiedName);
          }
        }
      }
    }

    return result;
  }

  /// Collects extension methods that apply to this class.
  /// Returns a list of (ExtensionInfo, MethodInfo) pairs.
  List<(ExtensionInfo, MethodInfo)> _collectExtensionMethods(
    ClassInfo cls,
    AnalysisResult result,
    Set<String> ownMethodNames,
    Map<String, (MethodInfo, String)> inheritedMethods,
  ) {
    final extensionMethods = <(ExtensionInfo, MethodInfo)>[];
    
    // Find all extensions that apply to this class
    final extensions = result.allExtensions
        .where((ext) => ext.extendedType.qualifiedName == cls.qualifiedName);
    
    for (final ext in extensions) {
      for (final method in ext.methods) {
        // Skip private, static, and methods that already exist
        if (_isPrivate(method.name) || method.isStatic) continue;
        if (ownMethodNames.contains(method.name)) continue;
        if (inheritedMethods.containsKey(method.name)) continue;
        extensionMethods.add((ext, method));
      }
    }
    
    return extensionMethods;
  }

  /// Collects extension getters that apply to this class.
  List<(ExtensionInfo, GetterInfo)> _collectExtensionGetters(
    ClassInfo cls,
    AnalysisResult result,
    Set<String> ownGetterNames,
    Map<String, (GetterInfo, String)> inheritedGetters,
  ) {
    final extensionGetters = <(ExtensionInfo, GetterInfo)>[];
    
    final extensions = result.allExtensions
        .where((ext) => ext.extendedType.qualifiedName == cls.qualifiedName);
    
    for (final ext in extensions) {
      for (final getter in ext.getters) {
        if (_isPrivate(getter.name) || getter.isStatic) continue;
        if (ownGetterNames.contains(getter.name)) continue;
        if (inheritedGetters.containsKey(getter.name)) continue;
        extensionGetters.add((ext, getter));
      }
    }
    
    return extensionGetters;
  }

  /// Collects extension setters that apply to this class.
  List<(ExtensionInfo, SetterInfo)> _collectExtensionSetters(
    ClassInfo cls,
    AnalysisResult result,
    Set<String> ownSetterNames,
    Map<String, (SetterInfo, String)> inheritedSetters,
  ) {
    final extensionSetters = <(ExtensionInfo, SetterInfo)>[];
    
    final extensions = result.allExtensions
        .where((ext) => ext.extendedType.qualifiedName == cls.qualifiedName);
    
    for (final ext in extensions) {
      for (final setter in ext.setters) {
        if (_isPrivate(setter.name) || setter.isStatic) continue;
        if (ownSetterNames.contains(setter.name)) continue;
        if (inheritedSetters.containsKey(setter.name)) continue;
        extensionSetters.add((ext, setter));
      }
    }
    
    return extensionSetters;
  }

  /// Builds a method map including own, inherited, and extension methods.
  String _methodMapWithInheritedAndExtensions(
    List<MethodInfo> ownMethods,
    Map<String, (MethodInfo, String)> inheritedMethods,
    List<(ExtensionInfo, MethodInfo)> extensionMethods,
    String alias,
    String typeName,
    Map<Uri, String> importAliases, {
    required bool isStatic,
  }) {
    final entries = <String>[];
    
    // Add own methods (declaringClass = null means declared here)
    for (final method in ownMethods) {
      if (_isPrivate(method.name) ||
          method.isStatic != isStatic ||
          !_shouldInclude(method)) {
        continue;
      }
      entries.add(_methodDescriptor(method, alias, typeName));
    }
    
    // Add inherited methods (with declaringClass set)
    if (!isStatic) {
      for (final entry in inheritedMethods.entries) {
        final (method, declaringClass) = entry.value;
        if (!_shouldInclude(method)) {
          continue;
        }
        entries.add(_methodDescriptor(method, alias, typeName,
            declaringClassQualifiedName: declaringClass));
      }
      
      // Add extension methods (with declaringClass set to extension)
      for (final (ext, method) in extensionMethods) {
        if (!_shouldInclude(ext) || !_shouldInclude(method)) {
          continue;
        }
        final extAlias = importAliases[ext.library.uri] ?? alias;
        entries.add(_extensionMethodDescriptor(method, extAlias, ext.name, alias, typeName,
            declaringClassQualifiedName: ext.qualifiedName));
      }
    }
    
    if (entries.isEmpty) return 'const {}';
    return '<String, ta.MethodDescriptor>{\n${entries.join()}  }';
  }

  /// Generates a method descriptor for an extension method.
  /// Extension methods need explicit extension application for invocation.
  String _extensionMethodDescriptor(
    MethodInfo method,
    String extAlias,
    String extName,
    String targetAlias,
    String targetTypeName, {
    String? declaringClassQualifiedName,
  }) {
    final isOp = _isOperator(method.name);
    // Extension methods can always be invoked (they're never abstract)
    // Use explicit extension application: ExtName(instance).method(...)
    final invoker = 
        '(Object instance, List<dynamic> positional, Map<Symbol, dynamic> named) => '
        'Function.apply($extAlias.$extName(instance as $targetAlias.$targetTypeName).${method.name}, positional, named)';

    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';

    return "  '${_escape(method.name)}': ta.MethodDescriptor(\n"
        "    name: '${_escape(method.name)}',\n"
        "    isStatic: false,\n"
        "    isAbstract: false,\n"
        "    isOperator: $isOp,\n"
        "    returnTypeQualifiedName: '${_escape(method.returnType.qualifiedName)}',\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    typeParameters: ${_typeParameterList(method.typeParameters)},\n"
        "    parameters: ${_parameterList(method.parameters)},\n"
        "    annotations: ${_annotationList(method.annotations)},\n"
        "    invokeOn: $invoker,\n"
        "    invokeStatic: null,\n"
        "  ),\n";
  }

  /// Builds a field map including both own and inherited fields.
  String _fieldMapWithInherited(
    List<FieldInfo> ownFields,
    Map<String, (FieldInfo, String)> inheritedFields,
    String alias,
    String typeName, {
    required bool isStatic,
  }) {
    final entries = <String>[];
    
    for (final field in ownFields) {
      if (_isPrivate(field.name) ||
          field.isStatic != isStatic ||
          !_shouldInclude(field)) {
        continue;
      }
      entries.add(_fieldDescriptor(field, alias, typeName));
    }
    
    if (!isStatic) {
      for (final entry in inheritedFields.entries) {
        final (field, declaringClass) = entry.value;
        if (!_shouldInclude(field)) {
          continue;
        }
        entries.add(_fieldDescriptor(field, alias, typeName,
            declaringClassQualifiedName: declaringClass));
      }
    }
    
    if (entries.isEmpty) return 'const {}';
    return '<String, ta.FieldDescriptor>{\n${entries.join()}  }';
  }

  /// Builds a getter map including own, inherited, and extension getters.
  String _getterMapWithInheritedAndExtensions(
    List<GetterInfo> ownGetters,
    Map<String, (GetterInfo, String)> inheritedGetters,
    List<(ExtensionInfo, GetterInfo)> extensionGetters,
    String alias,
    String typeName,
    Map<Uri, String> importAliases, {
    required bool isStatic,
  }) {
    final entries = <String>[];
    
    for (final getter in ownGetters) {
      if (_isPrivate(getter.name) ||
          getter.isStatic != isStatic ||
          !_shouldInclude(getter)) {
        continue;
      }
      entries.add(_getterDescriptor(getter, alias, typeName));
    }
    
    if (!isStatic) {
      for (final entry in inheritedGetters.entries) {
        final (getter, declaringClass) = entry.value;
        if (!_shouldInclude(getter)) {
          continue;
        }
        entries.add(_getterDescriptor(getter, alias, typeName,
            declaringClassQualifiedName: declaringClass));
      }
      
      // Add extension getters
      for (final (ext, getter) in extensionGetters) {
        if (!_shouldInclude(ext) || !_shouldInclude(getter)) {
          continue;
        }
        final extAlias = importAliases[ext.library.uri] ?? alias;
        entries.add(_extensionGetterDescriptor(getter, extAlias, ext.name, alias, typeName,
            declaringClassQualifiedName: ext.qualifiedName));
      }
    }
    
    if (entries.isEmpty) return 'const {}';
    return '<String, ta.GetterDescriptor>{\n${entries.join()}  }';
  }

  /// Generates a getter descriptor for an extension getter.
  String _extensionGetterDescriptor(
    GetterInfo getter,
    String extAlias,
    String extName,
    String targetAlias,
    String targetTypeName, {
    String? declaringClassQualifiedName,
  }) {
    // Extension getters: ExtName(instance).getter
    final instanceGetter =
        '(Object instance) => $extAlias.$extName(instance as $targetAlias.$targetTypeName).${getter.name}';

    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';

    return "  '${_escape(getter.name)}': ta.GetterDescriptor(\n"
        "    name: '${_escape(getter.name)}',\n"
        "    typeQualifiedName: '${_escape(getter.returnType.qualifiedName)}',\n"
        "    isStatic: false,\n"
        "    isAbstract: false,\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    annotations: ${_annotationList(getter.annotations)},\n"
        "    getInstance: $instanceGetter,\n"
        "    getStatic: null,\n"
        "  ),\n";
  }

  /// Builds a setter map including own, inherited, and extension setters.
  String _setterMapWithInheritedAndExtensions(
    List<SetterInfo> ownSetters,
    Map<String, (SetterInfo, String)> inheritedSetters,
    List<(ExtensionInfo, SetterInfo)> extensionSetters,
    String alias,
    String typeName,
    Map<Uri, String> importAliases, {
    required bool isStatic,
  }) {
    final entries = <String>[];
    
    for (final setter in ownSetters) {
      if (_isPrivate(setter.name) ||
          setter.isStatic != isStatic ||
          !_shouldInclude(setter)) {
        continue;
      }
      entries.add(_setterDescriptor(setter, alias, typeName));
    }
    
    if (!isStatic) {
      for (final entry in inheritedSetters.entries) {
        final (setter, declaringClass) = entry.value;
        if (!_shouldInclude(setter)) {
          continue;
        }
        entries.add(_setterDescriptor(setter, alias, typeName,
            declaringClassQualifiedName: declaringClass));
      }
      
      // Add extension setters
      for (final (ext, setter) in extensionSetters) {
        if (!_shouldInclude(ext) || !_shouldInclude(setter)) {
          continue;
        }
        final extAlias = importAliases[ext.library.uri] ?? alias;
        entries.add(_extensionSetterDescriptor(setter, extAlias, ext.name, alias, typeName,
            declaringClassQualifiedName: ext.qualifiedName));
      }
    }
    
    if (entries.isEmpty) return 'const {}';
    return '<String, ta.SetterDescriptor>{\n${entries.join()}  }';
  }

  /// Generates a setter descriptor for an extension setter.
  String _extensionSetterDescriptor(
    SetterInfo setter,
    String extAlias,
    String extName,
    String targetAlias,
    String targetTypeName, {
    String? declaringClassQualifiedName,
  }) {
    // Extension setters: ExtName(instance).setter = value
    final instanceSetter =
        '(Object instance, Object? value) { $extAlias.$extName(instance as $targetAlias.$targetTypeName).${setter.name} = value as dynamic; return null; }';

    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';

    return "  '${_escape(setter.name)}': ta.SetterDescriptor(\n"
        "    name: '${_escape(setter.name)}',\n"
        "    typeQualifiedName: '${_escape(setter.parameter.type.qualifiedName)}',\n"
        "    isStatic: false,\n"
        "    isAbstract: false,\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    annotations: ${_annotationList(setter.annotations)},\n"
        "    setInstance: $instanceSetter,\n"
        "    setStatic: null,\n"
        "  ),\n";
  }

  String _classDescriptor(
    ClassInfo cls,
    Map<Uri, String> importAliases,
    AnalysisResult result,
  ) {
    final alias = importAliases[cls.library.uri]!;
    final qualifiedName = cls.qualifiedName;
    final constructors = <String>[
      for (final ctor in cls.constructors..sort(_byName))
        if (!_isPrivate(ctor.name) && _shouldInclude(ctor))
          _constructorDescriptor(ctor, alias, cls.name,
              isAbstractClass: cls.isAbstract),
    ];

    // Collect own members (no declaringClass = declared here)
    final ownMethodNames = cls.methods.where((m) => !_isPrivate(m.name) && !m.isStatic).map((m) => m.name).toSet();
    final ownFieldNames = cls.fields.where((f) => !_isPrivate(f.name) && !f.isStatic).map((f) => f.name).toSet();
    final ownGetterNames = cls.getters.where((g) => !_isPrivate(g.name) && !g.isStatic).map((g) => g.name).toSet();
    final ownSetterNames = cls.setters.where((s) => !_isPrivate(s.name) && !s.isStatic).map((s) => s.name).toSet();

    // Collect inherited members from superclass chain and mixins
    final inheritedMethods = _collectInheritedMethods(cls, ownMethodNames);
    final inheritedFields = _collectInheritedFields(cls, ownFieldNames);
    final inheritedGetters = _collectInheritedGetters(cls, ownGetterNames);
    final inheritedSetters = _collectInheritedSetters(cls, ownSetterNames);

    // Collect extension members
    final extensionMethods = _collectExtensionMethods(cls, result, ownMethodNames, inheritedMethods);
    final extensionGetters = _collectExtensionGetters(cls, result, ownGetterNames, inheritedGetters);
    final extensionSetters = _collectExtensionSetters(cls, result, ownSetterNames, inheritedSetters);

    // Build combined method maps
    final methods = _methodMapWithInheritedAndExtensions(
      cls.methods, inheritedMethods, extensionMethods, alias, cls.name, importAliases, isStatic: false);
    final staticMethods = _methodMap(cls.methods, alias, cls.name, isStatic: true);
    final fields = _fieldMapWithInherited(
      cls.fields, inheritedFields, alias, cls.name, isStatic: false);
    final staticFields = _fieldMap(cls.fields, alias, cls.name, isStatic: true);
    final getters = _getterMapWithInheritedAndExtensions(
      cls.getters, inheritedGetters, extensionGetters, alias, cls.name, importAliases, isStatic: false);
    final staticGetters = _getterMap(cls.getters, alias, cls.name, isStatic: true);
    final setters = _setterMapWithInheritedAndExtensions(
      cls.setters, inheritedSetters, extensionSetters, alias, cls.name, importAliases, isStatic: false);
    final staticSetters = _setterMap(cls.setters, alias, cls.name, isStatic: true);

    final appliedExtensions = _appliedExtensions(cls, result);

    return "'${_escape(qualifiedName)}': ta.ClassDescriptor(\n"
        "  name: '${_escape(cls.name)}',\n"
        "  qualifiedName: '${_escape(qualifiedName)}',\n"
        "  libraryUri: '${_escape(cls.library.uri.toString())}',\n"
        "  package: '${_escape(cls.library.package.name)}',\n"
        "  annotations: ${_annotationList(cls.annotations)},\n"
        "  typeParameters: ${_typeParameterList(cls.typeParameters)},\n"
        "  isAbstract: ${cls.isAbstract},\n"
        "  isSealed: ${cls.isSealed},\n"
        "  isFinal: ${cls.isFinal},\n"
        "  isBase: ${cls.isBase},\n"
        "  isInterface: ${cls.isInterface},\n"
        "  isMixinClass: ${cls.isMixin},\n"
        "  methods: $methods,\n"
        "  staticMethods: $staticMethods,\n"
        "  fields: $fields,\n"
        "  staticFields: $staticFields,\n"
        "  getters: $getters,\n"
        "  staticGetters: $staticGetters,\n"
        "  setters: $setters,\n"
        "  staticSetters: $staticSetters,\n"
        "  superclassQualifiedName: ${_stringOrNull(cls.superclass?.qualifiedName)},\n"
        "  interfaceQualifiedNames: ${_stringList(cls.interfaces.map((e) => e.qualifiedName))},\n"
        "  mixinQualifiedNames: ${_stringList(cls.mixins.map((e) => e.qualifiedName))},\n"
        "  appliedExtensionQualifiedNames: $appliedExtensions,\n"
        "  constructors: <String, ta.ConstructorDescriptor>{\n${constructors.join()}  },\n"
        "  isInstance: (Object instance) => instance is $alias.${cls.name},\n"
        "),";
  }

  String _memberContainer(
    TypeDeclaration type,
    TypeKindWrapper kind,
    Map<Uri, String> importAliases,
  ) {
    final alias = importAliases[type.library.uri]!;
    final methods = type is ClassInfo
        ? _methodMap(type.methods, alias, type.name, isStatic: false)
        : type is EnumInfo
            ? _methodMap(type.methods, alias, type.name, isStatic: false)
            : type is MixinInfo
                ? _methodMap(type.methods, alias, type.name, isStatic: false)
                : type is ExtensionInfo
                    ? _methodMap(type.methods, alias, type.name, isStatic: false)
                    : type is ExtensionTypeInfo
                        ? _methodMap(type.methods, alias, type.name, isStatic: false)
                        : 'const {}';
    final staticMethods = type is ClassInfo
        ? _methodMap(type.methods, alias, type.name, isStatic: true)
        : 'const {}';

    final fields = type is ClassInfo
        ? _fieldMap(type.fields, alias, type.name, isStatic: false)
        : type is EnumInfo
            ? _fieldMap(type.fields, alias, type.name, isStatic: false)
            : type is MixinInfo
                ? _fieldMap(type.fields, alias, type.name, isStatic: false)
                : type is ExtensionInfo
                    ? _fieldMap(type.fields, alias, type.name, isStatic: false)
                    : type is ExtensionTypeInfo
                        ? _fieldMap(type.fields, alias, type.name, isStatic: false)
                        : 'const {}';
    final staticFields = type is ClassInfo
        ? _fieldMap(type.fields, alias, type.name, isStatic: true)
        : 'const {}';
    final getters = type is ClassInfo
        ? _getterMap(type.getters, alias, type.name, isStatic: false)
        : type is EnumInfo
            ? _getterMap(type.getters, alias, type.name, isStatic: false)
            : type is MixinInfo
                ? _getterMap(type.getters, alias, type.name, isStatic: false)
                : type is ExtensionInfo
                    ? _getterMap(type.getters, alias, type.name, isStatic: false)
                    : type is ExtensionTypeInfo
                        ? _getterMap(type.getters, alias, type.name, isStatic: false)
                        : 'const {}';
    final staticGetters = type is ClassInfo
        ? _getterMap(type.getters, alias, type.name, isStatic: true)
        : 'const {}';
    final setters = type is ClassInfo
        ? _setterMap(type.setters, alias, type.name, isStatic: false)
        : type is EnumInfo
            ? _setterMap(type.setters, alias, type.name, isStatic: false)
            : type is MixinInfo
                ? _setterMap(type.setters, alias, type.name, isStatic: false)
                : type is ExtensionInfo
                    ? _setterMap(type.setters, alias, type.name, isStatic: false)
                    : type is ExtensionTypeInfo
                        ? _setterMap(type.setters, alias, type.name, isStatic: false)
                        : 'const {}';
    final staticSetters = type is ClassInfo
        ? _setterMap(type.setters, alias, type.name, isStatic: true)
        : 'const {}';

    return "'${_escape(type.qualifiedName)}': ta.MemberContainerDescriptor(\n"
        "  kind: ta.TypeKind.${kind.name},\n"
        "  name: '${_escape(type.name)}',\n"
        "  qualifiedName: '${_escape(type.qualifiedName)}',\n"
        "  libraryUri: '${_escape(type.library.uri.toString())}',\n"
        "  package: '${_escape(type.library.package.name)}',\n"
        "  annotations: ${_annotationList(type.annotations)},\n"
        "  typeParameters: ${_typeParameterList(_typeParametersFor(type))},\n"
        "  methods: $methods,\n"
        "  staticMethods: $staticMethods,\n"
        "  fields: $fields,\n"
        "  staticFields: $staticFields,\n"
        "  getters: $getters,\n"
        "  staticGetters: $staticGetters,\n"
        "  setters: $setters,\n"
        "  staticSetters: $staticSetters,\n"
        "),";
  }

  String _extensionDescriptor(
    ExtensionInfo ext,
    Map<Uri, String> importAliases,
  ) {
    final methods = _methodMapMetadataOnly(ext.methods);
    final fields = _fieldMapMetadataOnly(ext.fields);
    final getters = _getterMapMetadataOnly(ext.getters);
    final setters = _setterMapMetadataOnly(ext.setters);

    return "'${_escape(ext.qualifiedName)}': ta.ExtensionDescriptor(\n"
        "  name: '${_escape(ext.name)}',\n"
        "  qualifiedName: '${_escape(ext.qualifiedName)}',\n"
        "  libraryUri: '${_escape(ext.library.uri.toString())}',\n"
        "  package: '${_escape(ext.library.package.name)}',\n"
        "  extendedTypeQualifiedName: '${_escape(ext.extendedType.qualifiedName)}',\n"
        "  annotations: ${_annotationList(ext.annotations)},\n"
        "  typeParameters: ${_typeParameterList(ext.typeParameters)},\n"
        "  methods: $methods,\n"
        "  fields: $fields,\n"
        "  getters: $getters,\n"
        "  setters: $setters,\n"
        "),";
  }

  String _typeAliasDescriptor(TypeAliasInfo alias) {
    return "'${_escape(alias.qualifiedName)}': ta.TypeAliasDescriptor(\n"
        "  name: '${_escape(alias.name)}',\n"
        "  qualifiedName: '${_escape(alias.qualifiedName)}',\n"
        "  libraryUri: '${_escape(alias.library.uri.toString())}',\n"
        "  package: '${_escape(alias.library.package.name)}',\n"
        "  aliasedTypeQualifiedName: '${_escape(alias.aliasedType.qualifiedName)}',\n"
        "  annotations: ${_annotationList(alias.annotations)},\n"
        "  typeParameters: ${_typeParameterList(alias.typeParameters)},\n"
        "),";
  }

  String _methodMap(
    List<MethodInfo> methods,
    String alias,
    String typeName, {
    required bool isStatic,
    String? declaringClassQualifiedName,
  }) {
    final entries = <String>[];
    for (final method in methods) {
      if (_isPrivate(method.name) ||
          method.isStatic != isStatic ||
          !_shouldInclude(method)) {
        continue;
      }
      // Include operators - they will have null invokers but are tracked
      entries.add(_methodDescriptor(method, alias, typeName,
          declaringClassQualifiedName: declaringClassQualifiedName));
    }
    if (entries.isEmpty) {
      return 'const {}';
    }
    return '<String, ta.MethodDescriptor>{\n${entries.join()}  }';
  }

  /// Returns true if the method name is a Dart operator
  bool _isOperator(String name) {
    const operators = {
      '+', '-', '*', '/', '~/', '%', // arithmetic
      '==', '<', '>', '<=', '>=', // comparison
      '[]', '[]=', // indexing
      '|', '&', '^', '~', '<<', '>>', '>>>', // bitwise
      'unary-', // unary minus
    };
    return operators.contains(name);
  }

  String _methodDescriptor(MethodInfo method, String alias, String typeName,
      {String? declaringClassQualifiedName}) {
    // Abstract methods and operators can't have invokers via Function.apply
    final isOp = _isOperator(method.name);
    final canInvoke = !method.isAbstract && !isOp;
    final invoker = method.isStatic
        ? '(List<dynamic> positional, Map<Symbol, dynamic> named) => '
            'Function.apply($alias.$typeName.${method.name}, positional, named)'
        : '(Object instance, List<dynamic> positional, Map<Symbol, dynamic> named) => '
            'Function.apply((instance as $alias.$typeName).${method.name}, positional, named)';

    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';

    return "  '${_escape(method.name)}': ta.MethodDescriptor(\n"
        "    name: '${_escape(method.name)}',\n"
        "    isStatic: ${method.isStatic},\n"
        "    isAbstract: ${method.isAbstract},\n"
        "    isOperator: $isOp,\n"
        "    returnTypeQualifiedName: '${_escape(method.returnType.qualifiedName)}',\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    typeParameters: ${_typeParameterList(method.typeParameters)},\n"
        "    parameters: ${_parameterList(method.parameters)},\n"
        "    annotations: ${_annotationList(method.annotations)},\n"
        "    invokeOn: ${method.isStatic || !canInvoke ? 'null' : invoker},\n"
        "    invokeStatic: ${method.isStatic && canInvoke ? invoker : 'null'},\n"
        "  ),\n";
  }

  String _methodMapMetadataOnly(List<MethodInfo> methods) {
    final entries = <String>[];
    for (final method in methods) {
      if (_isPrivate(method.name) || !_shouldInclude(method)) {
        continue;
      }
      entries.add(_methodDescriptorMetadata(method));
    }
    if (entries.isEmpty) {
      return 'const {}';
    }
    return '<String, ta.MethodDescriptor>{\n${entries.join()}  }';
  }

  String _methodDescriptorMetadata(MethodInfo method,
      {String? declaringClassQualifiedName}) {
    final isOp = _isOperator(method.name);
    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';
    return "  '${_escape(method.name)}': ta.MethodDescriptor(\n"
        "    name: '${_escape(method.name)}',\n"
        "    isStatic: ${method.isStatic},\n"
        "    isAbstract: ${method.isAbstract},\n"
        "    isOperator: $isOp,\n"
        "    returnTypeQualifiedName: '${_escape(method.returnType.qualifiedName)}',\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    typeParameters: ${_typeParameterList(method.typeParameters)},\n"
        "    parameters: ${_parameterList(method.parameters)},\n"
        "    annotations: ${_annotationList(method.annotations)},\n"
        "    invokeOn: null,\n"
        "    invokeStatic: null,\n"
        "  ),\n";
  }

  String _constructorDescriptor(
    ConstructorInfo ctor,
    String alias,
    String typeName, {
    required bool isAbstractClass,
  }) {
    final ctorName = ctor.name.isEmpty ? 'new' : ctor.name;
    // Can't tear off generative constructors of abstract classes
    final canInvoke = !isAbstractClass || ctor.isFactory;
    final invoker = canInvoke
        ? '(List<dynamic> positional, Map<Symbol, dynamic> named) => '
            'Function.apply($alias.$typeName.$ctorName, positional, named)'
        : 'null';
    return "    '${_escape(ctor.name)}': ta.ConstructorDescriptor(\n"
        "      name: '${_escape(ctor.name)}',\n"
        "      isFactory: ${ctor.isFactory},\n"
        "      parameters: ${_parameterList(ctor.parameters)},\n"
        "      annotations: ${_annotationList(ctor.annotations)},\n"
        "      invoke: $invoker,\n"
        "    ),\n";
  }

  String _fieldMap(
    List<FieldInfo> fields,
    String alias,
    String typeName, {
    required bool isStatic,
  }) {
    final entries = <String>[];
    for (final field in fields) {
      if (_isPrivate(field.name) ||
          field.isStatic != isStatic ||
          !_shouldInclude(field)) {
        continue;
      }
      entries.add(_fieldDescriptor(field, alias, typeName));
    }
    if (entries.isEmpty) {
      return 'const {}';
    }
    return '<String, ta.FieldDescriptor>{\n${entries.join()}  }';
  }

  String _fieldDescriptor(FieldInfo field, String alias, String typeName,
      {String? declaringClassQualifiedName}) {
    // Only create getters if the field actually has a getter
    final instanceGetter = !field.hasGetter
        ? 'null'
        : '(Object instance) => (instance as $alias.$typeName).${field.name}';
    // Only create setters if the field actually has a setter
    // (not final/const and not a synthetic field backing a getter-only property)
    final instanceSetter = !field.hasSetter
        ? 'null'
        : '(Object instance, Object? value) { (instance as $alias.$typeName).${field.name} = value as dynamic; return null; }';
    final staticGetter = !field.hasGetter
        ? 'null'
        : '() => $alias.$typeName.${field.name}';
    final staticSetter = !field.hasSetter
        ? 'null'
        : '(Object? value) { $alias.$typeName.${field.name} = value as dynamic; return null; }';

    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';

    return "  '${_escape(field.name)}': ta.FieldDescriptor(\n"
        "    name: '${_escape(field.name)}',\n"
        "    typeQualifiedName: '${_escape(field.type.qualifiedName)}',\n"
        "    isStatic: ${field.isStatic},\n"
        "    isFinal: ${field.isFinal},\n"
        "    isConst: ${field.isConst},\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    annotations: ${_annotationList(field.annotations)},\n"
        "    getInstance: ${field.isStatic ? 'null' : instanceGetter},\n"
        "    setInstance: ${field.isStatic ? 'null' : instanceSetter},\n"
        "    getStatic: ${field.isStatic ? staticGetter : 'null'},\n"
        "    setStatic: ${field.isStatic ? staticSetter : 'null'},\n"
        "  ),\n";
  }

  String _fieldMapMetadataOnly(List<FieldInfo> fields) {
    final entries = <String>[];
    for (final field in fields) {
      if (_isPrivate(field.name) || !_shouldInclude(field)) {
        continue;
      }
      entries.add(_fieldDescriptorMetadata(field));
    }
    if (entries.isEmpty) {
      return 'const {}';
    }
    return '<String, ta.FieldDescriptor>{\n${entries.join()}  }';
  }

  String _fieldDescriptorMetadata(FieldInfo field,
      {String? declaringClassQualifiedName}) {
    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';
    return "  '${_escape(field.name)}': ta.FieldDescriptor(\n"
        "    name: '${_escape(field.name)}',\n"
        "    typeQualifiedName: '${_escape(field.type.qualifiedName)}',\n"
        "    isStatic: ${field.isStatic},\n"
        "    isFinal: ${field.isFinal},\n"
        "    isConst: ${field.isConst},\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    annotations: ${_annotationList(field.annotations)},\n"
        "    getInstance: null,\n"
        "    setInstance: null,\n"
        "    getStatic: null,\n"
        "    setStatic: null,\n"
        "  ),\n";
  }

  String _getterMap(
    List<GetterInfo> getters,
    String alias,
    String typeName, {
    required bool isStatic,
  }) {
    final entries = <String>[];
    for (final getter in getters) {
      if (_isPrivate(getter.name) ||
          getter.isStatic != isStatic ||
          !_shouldInclude(getter)) {
        continue;
      }
      entries.add(_getterDescriptor(getter, alias, typeName));
    }
    if (entries.isEmpty) {
      return 'const {}';
    }
    return '<String, ta.GetterDescriptor>{\n${entries.join()}  }';
  }

  String _getterDescriptor(GetterInfo getter, String alias, String typeName,
      {String? declaringClassQualifiedName}) {
    // Abstract getters can't have invokers
    final canInvoke = !getter.isAbstract;
    final instanceGetter =
        '(Object instance) => (instance as $alias.$typeName).${getter.name}';
    final staticGetter = '$alias.$typeName.${getter.name}';

    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';

    return "  '${_escape(getter.name)}': ta.GetterDescriptor(\n"
        "    name: '${_escape(getter.name)}',\n"
        "    typeQualifiedName: '${_escape(getter.returnType.qualifiedName)}',\n"
        "    isStatic: ${getter.isStatic},\n"
        "    isAbstract: ${getter.isAbstract},\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    annotations: ${_annotationList(getter.annotations)},\n"
        "    getInstance: ${getter.isStatic || !canInvoke ? 'null' : instanceGetter},\n"
        "    getStatic: ${getter.isStatic && canInvoke ? '() => $staticGetter' : 'null'},\n"
        "  ),\n";
  }

  String _getterMapMetadataOnly(List<GetterInfo> getters) {
    final entries = <String>[];
    for (final getter in getters) {
      if (_isPrivate(getter.name) || !_shouldInclude(getter)) {
        continue;
      }
      entries.add(_getterDescriptorMetadata(getter));
    }
    if (entries.isEmpty) {
      return 'const {}';
    }
    return '<String, ta.GetterDescriptor>{\n${entries.join()}  }';
  }

  String _getterDescriptorMetadata(GetterInfo getter,
      {String? declaringClassQualifiedName}) {
    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';
    return "  '${_escape(getter.name)}': ta.GetterDescriptor(\n"
        "    name: '${_escape(getter.name)}',\n"
        "    typeQualifiedName: '${_escape(getter.returnType.qualifiedName)}',\n"
        "    isStatic: ${getter.isStatic},\n"
        "    isAbstract: ${getter.isAbstract},\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    annotations: ${_annotationList(getter.annotations)},\n"
        "    getInstance: null,\n"
        "    getStatic: null,\n"
        "  ),\n";
  }

  String _setterMap(
    List<SetterInfo> setters,
    String alias,
    String typeName, {
    required bool isStatic,
  }) {
    final entries = <String>[];
    for (final setter in setters) {
      if (_isPrivate(setter.name) ||
          setter.isStatic != isStatic ||
          !_shouldInclude(setter)) {
        continue;
      }
      entries.add(_setterDescriptor(setter, alias, typeName));
    }
    if (entries.isEmpty) {
      return 'const {}';
    }
    return '<String, ta.SetterDescriptor>{\n${entries.join()}  }';
  }

  String _setterDescriptor(SetterInfo setter, String alias, String typeName,
      {String? declaringClassQualifiedName}) {
    // Abstract setters can't have invokers
    final canInvoke = !setter.isAbstract;
    // Use 'value as dynamic' to allow assignment to any setter type - runtime type checking applies
    final instanceSetter =
        '(Object instance, Object? value) { (instance as $alias.$typeName).${setter.name} = value as dynamic; return null; }';
    final staticSetter =
        '(Object? value) { $alias.$typeName.${setter.name} = value as dynamic; return null; }';

    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';

    return "  '${_escape(setter.name)}': ta.SetterDescriptor(\n"
        "    name: '${_escape(setter.name)}',\n"
        "    typeQualifiedName: '${_escape(setter.parameter.type.qualifiedName)}',\n"
        "    isStatic: ${setter.isStatic},\n"
        "    isAbstract: ${setter.isAbstract},\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    annotations: ${_annotationList(setter.annotations)},\n"
        "    setInstance: ${setter.isStatic || !canInvoke ? 'null' : instanceSetter},\n"
        "    setStatic: ${setter.isStatic && canInvoke ? staticSetter : 'null'},\n"
        "  ),\n";
  }

  String _setterMapMetadataOnly(List<SetterInfo> setters) {
    final entries = <String>[];
    for (final setter in setters) {
      if (_isPrivate(setter.name) || !_shouldInclude(setter)) {
        continue;
      }
      entries.add(_setterDescriptorMetadata(setter));
    }
    if (entries.isEmpty) {
      return 'const {}';
    }
    return '<String, ta.SetterDescriptor>{\n${entries.join()}  }';
  }

  String _setterDescriptorMetadata(SetterInfo setter,
      {String? declaringClassQualifiedName}) {
    final declaringClass = declaringClassQualifiedName != null
        ? "'${_escape(declaringClassQualifiedName)}'"
        : 'null';
    return "  '${_escape(setter.name)}': ta.SetterDescriptor(\n"
        "    name: '${_escape(setter.name)}',\n"
        "    typeQualifiedName: '${_escape(setter.parameter.type.qualifiedName)}',\n"
        "    isStatic: ${setter.isStatic},\n"
        "    isAbstract: ${setter.isAbstract},\n"
        "    declaringClassQualifiedName: $declaringClass,\n"
        "    annotations: ${_annotationList(setter.annotations)},\n"
        "    setInstance: null,\n"
        "    setStatic: null,\n"
        "  ),\n";
  }

  String _globalVariable(VariableInfo variable, String alias) {
    final getter = variable.hasGetter
        ? '() => $alias.${variable.name}'
        : 'null';
    final setter = variable.hasSetter
        ? '(Object? value) { $alias.${variable.name} = value as dynamic; return null; }'
        : 'null';

    return "  '${_escape(variable.qualifiedName)}': ta.GlobalDescriptor(\n"
        "    kind: ta.GlobalKind.variable,\n"
        "    name: '${_escape(variable.name)}',\n"
        "    qualifiedName: '${_escape(variable.qualifiedName)}',\n"
        "    libraryUri: '${_escape(variable.library.uri.toString())}',\n"
        "    package: '${_escape(variable.library.package.name)}',\n"
        "    typeQualifiedName: '${_escape(variable.type.qualifiedName)}',\n"
        "    annotations: ${_annotationList(variable.annotations)},\n"
        "    getValue: $getter,\n"
        "    setValue: $setter,\n"
        "  ),\n";
  }

  String _globalGetter(GetterInfo getter, String alias) {
    return "  '${_escape(getter.qualifiedName)}': ta.GlobalDescriptor(\n"
        "    kind: ta.GlobalKind.getter,\n"
        "    name: '${_escape(getter.name)}',\n"
        "    qualifiedName: '${_escape(getter.qualifiedName)}',\n"
        "    libraryUri: '${_escape(getter.library.uri.toString())}',\n"
        "    package: '${_escape(getter.library.package.name)}',\n"
        "    typeQualifiedName: '${_escape(getter.returnType.qualifiedName)}',\n"
        "    annotations: ${_annotationList(getter.annotations)},\n"
        "    getValue: () => $alias.${getter.name},\n"
        "  ),\n";
  }

  String _globalSetter(SetterInfo setter, String alias) {
    return "  '${_escape(setter.qualifiedName)}': ta.GlobalDescriptor(\n"
        "    kind: ta.GlobalKind.setter,\n"
        "    name: '${_escape(setter.name)}',\n"
        "    qualifiedName: '${_escape(setter.qualifiedName)}',\n"
        "    libraryUri: '${_escape(setter.library.uri.toString())}',\n"
        "    package: '${_escape(setter.library.package.name)}',\n"
        "    typeQualifiedName: '${_escape(setter.parameter.type.qualifiedName)}',\n"
        "    annotations: ${_annotationList(setter.annotations)},\n"
        "    setValue: (Object? value) { $alias.${setter.name} = value as dynamic; return null; },\n"
        "  ),\n";
  }

  String _globalFunction(FunctionInfo function, String alias) {
    return "  '${_escape(function.qualifiedName)}': ta.GlobalDescriptor(\n"
        "    kind: ta.GlobalKind.function,\n"
        "    name: '${_escape(function.name)}',\n"
        "    qualifiedName: '${_escape(function.qualifiedName)}',\n"
        "    libraryUri: '${_escape(function.library.uri.toString())}',\n"
        "    package: '${_escape(function.library.package.name)}',\n"
        "    typeQualifiedName: '${_escape(function.returnType.qualifiedName)}',\n"
        "    annotations: ${_annotationList(function.annotations)},\n"
        "    invokeFunction: (List<dynamic> positional, Map<Symbol, dynamic> named) => Function.apply($alias.${function.name}, positional, named),\n"
        "  ),\n";
  }

  String _annotationList(List<AnnotationInfo> annotations) {
    if (annotations.isEmpty) return 'const []';
    final entries = annotations.map(_annotationDescriptor).join(',\n');
    return '[\n$entries\n]';
  }

  String _annotationDescriptor(AnnotationInfo annotation) {
    return 'ta.AnnotationDescriptor('
        'name: \'${_escape(annotation.name)}\','
        'qualifiedName: \'${_escape(annotation.qualifiedName)}\','
        '${annotation.constructorName != null ? "constructorName: '${_escape(annotation.constructorName!)}'," : ''}'
        'positionalArguments: ${_literalList(annotation.positionalArguments.map((e) => e.value))},'
        'namedArguments: ${_literalMap(annotation.namedArguments.map((k, v) => MapEntry(k, v.value)))},'
        ')';
  }

  String _typeParameterList(List<TypeParameterInfo> typeParameters) {
    if (typeParameters.isEmpty) return 'const []';
    final entries = typeParameters.map((typeParam) {
      final variance = typeParam.variance?.name;
      return 'ta.TypeParameterDescriptor('
          "name: '${_escape(typeParam.name)}',"
          "boundQualifiedName: ${_stringOrNull(typeParam.bound?.qualifiedName)},"
          "variance: ${_stringOrNull(variance)}," 
          ')';
    }).join(',\n');
    return '[\n$entries\n]';
  }

  String _parameterList(List<ParameterInfo> parameters) {
    if (parameters.isEmpty) return 'const []';
    final entries = parameters.map((param) {
      return 'ta.ParameterDescriptor('
          "name: '${_escape(param.name)}',"
          "typeQualifiedName: '${_escape(param.type.qualifiedName)}',"
          'isRequired: ${param.isRequired},'
          'isNamed: ${param.isNamed},'
          'isPositional: ${param.isPositional},'
          'hasDefaultValue: ${param.hasDefaultValue},'
          'defaultValue: ${_literal(param.defaultValueParsed?.value ?? param.defaultValue)},'
          'annotations: ${_annotationList(param.annotations)},'
          ')';
    }).join(',\n');
    return '[\n$entries\n]';
  }

  String _appliedExtensions(ClassInfo cls, AnalysisResult result) {
    final matches = result.allExtensions
        .where((ext) => ext.extendedType.qualifiedName == cls.qualifiedName)
        .where(_shouldInclude)
        .map((ext) => ext.qualifiedName);
    return _stringList(matches);
  }

  List<TypeParameterInfo> _typeParametersFor(TypeDeclaration type) {
    if (type is ClassInfo) return type.typeParameters;
    if (type is EnumInfo) return const [];
    if (type is MixinInfo) return type.typeParameters;
    if (type is ExtensionInfo) return type.typeParameters;
    if (type is ExtensionTypeInfo) return type.typeParameters;
    if (type is TypeAliasInfo) return type.typeParameters;
    return const [];
  }

  String _stringList(Iterable<String> values) {
    final list = values.toList()..sort();
    if (list.isEmpty) return 'const []';
    final entries = list.map((value) => "'${_escape(value)}'").join(', ');
    return '<String>[$entries]';
  }

  String _literalList(Iterable<Object?> values) {
    final entries = values.map(_literal).join(', ');
    return '<Object?>[$entries]';
  }

  String _literalMap(Map<String, Object?> values) {
    if (values.isEmpty) return 'const <String, Object?>{}';
    final entries = values.entries
        .map((entry) => "'${_escape(entry.key)}': ${_literal(entry.value)}")
        .join(', ');
    return '<String, Object?>{$entries}';
  }

  String _literal(Object? value) {
    if (value == null) return 'null';
    if (value is bool || value is int || value is double) {
      return value.toString();
    }
    if (value is String) {
      return "'${_escape(value)}'";
    }
    if (value is List) {
      return _literalList(value.cast<Object?>());
    }
    if (value is Map) {
      final mapped = value.map((key, val) => MapEntry(key.toString(), val));
      return _literalMap(mapped.cast<String, Object?>());
    }
    return "'${_escape(value.toString())}'";
  }

  String _stringOrNull(String? value) =>
      value == null ? 'null' : "'${_escape(value)}'";

  bool _canImport(Uri uri) {
    if (uri.scheme != 'package' && uri.scheme != 'dart') {
      return false;
    }
    if (uri.scheme == 'package' && uri.path.contains('/src/')) {
      return false;
    }
    return true;
  }

  bool _shouldInclude(Element element) {
    if (includeDeprecatedMembers) {
      return true;
    }
    return !element.isDeprecated && !_hasDeprecatedAnnotation(element.annotations);
  }

  bool _hasDeprecatedAnnotation(List<AnnotationInfo> annotations) {
    for (final annotation in annotations) {
      final rawName = annotation.name.trim().toLowerCase();
      final normalizedName = rawName.startsWith('@')
          ? rawName.substring(1)
          : rawName;
      final baseName = normalizedName.split('(').first;
      if (baseName == 'deprecated') {
        return true;
      }
      final qualified = annotation.qualifiedName.toLowerCase();
      if (qualified == 'deprecated' || qualified.endsWith('.deprecated')) {
        return true;
      }
    }
    return false;
  }

  bool _isPrivate(String name) => name.startsWith('_');

  int _byQualifiedName(TypeDeclaration a, TypeDeclaration b) =>
      a.qualifiedName.compareTo(b.qualifiedName);

  int _byName(dynamic a, dynamic b) => a.name.compareTo(b.name);

  String _escape(String value) => value.replaceAll("'", r"\'");
}

enum TypeKindWrapper {
  enumType,
  mixinType,
  extensionType,
}
