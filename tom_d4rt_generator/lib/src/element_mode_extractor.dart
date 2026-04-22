/// Element-based extractor used as a fallback when the analyzer refuses to
/// resolve a library by path (e.g., when a `.sum` summary bundle shadows the
/// source file and `getResolvedLibrary` returns a `NotPathOfUriResult`).
///
/// This walks the `LibraryElement` tree instead of the AST and produces the
/// same `ClassInfo`, `GlobalFunctionInfo`, `GlobalVariableInfo`, `EnumInfo`,
/// and `ExtensionInfo` outputs that the `_ResolvedClassVisitor` AST path
/// populates. The output is intentionally kept compatible so the rest of the
/// bridge generator pipeline is indifferent to which path was used.
///
/// This is a twin of `_ResolvedClassVisitor` in `bridge_generator.dart`, but
/// there are unavoidable divergences because the element API exposes types
/// and annotations rather than source tokens. See the report in the commit
/// message for the known deltas.
library;

// ignore_for_file: unintended_html_in_doc_comment

import 'dart:io';

// ignore: implementation_imports
import 'package:analyzer/src/dart/element/element.dart' show ElementAnnotationImpl;
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'bridge_generator.dart'
    show
        BridgeGenerator,
        ClassInfo,
        ConstructorInfo,
        EnumInfo,
        EnumMethodDetail,
        ExtensionInfo,
        FunctionTypeInfo,
        GlobalFunctionInfo,
        GlobalVariableInfo,
        MemberInfo,
        ParameterInfo,
        mapPrivateSdkLibrary;

/// Walks a resolved `LibraryElement` and fills collections equivalent to the
/// AST `_ResolvedClassVisitor` outputs.
class ElementModeExtractor {
  final bool skipPrivate;
  final bool generateDeprecatedElements;

  final List<ClassInfo> classes = [];
  final List<GlobalFunctionInfo> globalFunctions = [];
  final List<GlobalVariableInfo> globalVariables = [];
  final List<EnumInfo> enums = [];
  final List<ExtensionInfo> extensions = [];

  /// GEN-054: Setter names for getter/setter matching.
  final Set<String> globalSetterNames = {};

  /// Count of elements skipped because they were @deprecated.
  int skippedDeprecatedCount = 0;

  /// Typedef name → expanded function signature (for barrel-fallback).
  final Map<String, String> typedefExpansions = {};

  /// GEN-074: Non-function type aliases. Alias name → target class name.
  final Map<String, String> typeAliases = {};

  /// GEN-017: Global type name → package URI, registered as types are seen.
  final Map<String, String> globalTypeToUri = {};

  String? _currentSourceFile;

  ElementModeExtractor({
    this.skipPrivate = true,
    this.generateDeprecatedElements = false,
  });

  /// Entry point: extracts all top-level members from [library]. The
  /// [sourceFilePath] is attached to each info record as the source of truth
  /// for the source file (used by downstream lookup).
  void extract(LibraryElement library, String sourceFilePath) {
    _currentSourceFile = sourceFilePath;

    // Type aliases first — populates typeAliases/typedefExpansions so that
    // downstream class/function processing can reference them.
    for (final alias in library.typeAliases) {
      _processTypeAlias(alias);
    }

    for (final enumEl in library.enums) {
      _processEnum(enumEl);
    }

    for (final ext in library.extensions) {
      _processExtension(ext);
    }

    for (final cls in library.classes) {
      _processClass(cls, isMixin: false);
    }

    for (final mixinEl in library.mixins) {
      _processClass(mixinEl, isMixin: true);
    }

    for (final func in library.topLevelFunctions) {
      _processFunction(func);
    }

    for (final getter in library.getters) {
      _processTopLevelGetter(getter);
    }

    for (final setter in library.setters) {
      _processTopLevelSetter(setter);
    }

    for (final variable in library.topLevelVariables) {
      _processTopLevelVariable(variable);
    }
  }

  // ---------------------------------------------------------------------------
  // Annotation helpers (element-based)
  // ---------------------------------------------------------------------------

  bool _hasInternalElementAnnotation(Element element) {
    final dynamic dyn = element;
    try {
      if (dyn.isInternal == true ||
          dyn.isMustBeOverridden == true ||
          dyn.isVisibleForOverriding == true) {
        return true;
      }
    } catch (_) {
      // fall through
    }

    for (final annotation in element.metadata.annotations) {
      if (annotation.isInternal ||
          annotation.isMustBeOverridden ||
          annotation.isVisibleForOverriding) {
        return true;
      }
      final annotationType =
          annotation.computeConstantValue()?.type?.getDisplayString();
      if (annotationType == 'Internal' ||
          annotationType == 'MustBeOverridden' ||
          annotationType == 'VisibleForOverriding') {
        return true;
      }
    }
    return false;
  }

  bool _hasDeprecatedAnnotation(Element element) {
    final dynamic dyn = element;
    try {
      if (dyn.hasDeprecated == true || dyn.isDeprecated == true) {
        return true;
      }
    } catch (_) {
      // fall through
    }
    for (final annotation in element.metadata.annotations) {
      if (annotation.isDeprecated) return true;
    }
    return false;
  }

  /// Matches `_hasInternalAnnotation` for AnnotatedNode (AST). Same predicate,
  /// but applied to an element.
  bool _isInternalOrSkippable(Element element) =>
      _hasInternalElementAnnotation(element);

  // ---------------------------------------------------------------------------
  // Type collection
  // ---------------------------------------------------------------------------

  /// Recursively collects URIs and type→URI mappings from a DartType.
  /// Mirrors `_ResolvedClassVisitor._collectInfoFromDartType`.
  void _collectInfoFromDartType(
    DartType? dartType,
    Set<String> uris,
    Map<String, String> typeToUri, {
    Set<String>? functionTypeAliases,
  }) {
    if (dartType == null) return;
    if (dartType is InvalidType) return;

    if (dartType is FunctionType) {
      final alias = dartType.alias;
      if (alias != null) {
        final aliasName = alias.element.name;
        if (aliasName != null) {
          functionTypeAliases?.add(aliasName);
          final aliasLibrary = alias.element.library;
          var uri = aliasLibrary.identifier;
          if (uri.startsWith('dart:_')) {
            final mapped = mapPrivateSdkLibrary(uri);
            if (mapped == null) return;
            uri = mapped;
          }
          if (uri.startsWith('file:')) {
            final filePath = Uri.parse(uri).toFilePath();
            uri = _getPackageUriFromFilePath(filePath);
          }
          if (!uri.startsWith('dart:core')) {
            uris.add(uri);
            typeToUri[aliasName] = uri;
            globalTypeToUri[aliasName] = uri;
          }
          if (!typedefExpansions.containsKey(aliasName)) {
            typedefExpansions[aliasName] = _expandFunctionType(dartType);
          }
        }
      }
      _collectInfoFromDartType(
        dartType.returnType,
        uris,
        typeToUri,
        functionTypeAliases: functionTypeAliases,
      );
      for (final param in dartType.formalParameters) {
        _collectInfoFromDartType(
          param.type,
          uris,
          typeToUri,
          functionTypeAliases: functionTypeAliases,
        );
      }
      return;
    }

    if (dartType is InterfaceType) {
      final element = dartType.element;
      final library = element.library;
      var uri = library.identifier;

      if (uri.startsWith('dart:_')) {
        final mapped = mapPrivateSdkLibrary(uri);
        if (mapped == null) {
          for (final typeArg in dartType.typeArguments) {
            _collectInfoFromDartType(
              typeArg,
              uris,
              typeToUri,
              functionTypeAliases: functionTypeAliases,
            );
          }
          return;
        }
        uri = mapped;
      }

      if (uri.startsWith('file:')) {
        final filePath = Uri.parse(uri).toFilePath();
        uri = _getPackageUriFromFilePath(filePath);
      }

      if (!uri.startsWith('dart:core')) {
        uris.add(uri);
        final name = element.name;
        if (name != null) {
          typeToUri[name] = uri;
          globalTypeToUri[name] = uri;
        }
      }

      for (final typeArg in dartType.typeArguments) {
        _collectInfoFromDartType(
          typeArg,
          uris,
          typeToUri,
          functionTypeAliases: functionTypeAliases,
        );
      }
    }

    // TypeParameterType — handled elsewhere (no import needed).
  }

  ({
    Set<String> uris,
    Map<String, String> typeToUri,
    bool isFunctionTypeAlias,
    FunctionTypeInfo? functionTypeInfo,
  })
  _collectTypeInfo(DartType? dartType) {
    final uris = <String>{};
    final typeToUri = <String, String>{};
    final functionTypeAliases = <String>{};

    if (dartType == null) {
      return (
        uris: uris,
        typeToUri: typeToUri,
        isFunctionTypeAlias: false,
        functionTypeInfo: null,
      );
    }

    _collectInfoFromDartType(
      dartType,
      uris,
      typeToUri,
      functionTypeAliases: functionTypeAliases,
    );

    final aliasName = dartType.alias?.element.name;
    final isFunctionTypeAlias =
        aliasName != null && functionTypeAliases.contains(aliasName);

    FunctionTypeInfo? funcInfo;
    if (dartType is FunctionType) {
      funcInfo = BridgeGenerator.extractFunctionTypeInfoFromDartType(dartType);
    }

    return (
      uris: uris,
      typeToUri: typeToUri,
      isFunctionTypeAlias: isFunctionTypeAlias,
      functionTypeInfo: funcInfo,
    );
  }

  String _expandFunctionType(FunctionType funcType) {
    final returnType = funcType.returnType.getDisplayString();
    final positionalParams = funcType.formalParameters
        .where((p) => !p.isNamed)
        .map((p) => p.type.getDisplayString())
        .toList();
    final namedParams = funcType.formalParameters.where((p) => p.isNamed).map((
      p,
    ) {
      final required = p.isRequiredNamed ? 'required ' : '';
      return '$required${p.type.getDisplayString()} ${p.name}';
    }).toList();
    final sb = StringBuffer();
    sb.write(positionalParams.join(', '));
    if (namedParams.isNotEmpty) {
      if (positionalParams.isNotEmpty) sb.write(', ');
      sb.write('{${namedParams.join(', ')}}');
    }
    return '$returnType Function($sb)';
  }

  String _getPackageUriFromFilePath(String sourceFile) {
    final libIndex = sourceFile.indexOf('/lib/');
    if (libIndex != -1) {
      final pkgName = _getPackageNameFromPath(sourceFile);
      if (pkgName != null) {
        final relativePath = sourceFile.substring(libIndex + 5);
        return 'package:$pkgName/$relativePath';
      }
    }
    return sourceFile;
  }

  String? _getPackageNameFromPath(String filePath) {
    final libIndex = filePath.indexOf('/lib/');
    if (libIndex == -1) return null;
    final packageDir = filePath.substring(0, libIndex);
    final pubspecPath = '$packageDir/pubspec.yaml';
    try {
      final pubspecFile = File(pubspecPath);
      if (pubspecFile.existsSync()) {
        final content = pubspecFile.readAsStringSync();
        final nameMatch = RegExp(
          r'^name:\s*(\S+)',
          multiLine: true,
        ).firstMatch(content);
        if (nameMatch != null) return nameMatch.group(1);
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // Parameter / annotation source extraction
  // ---------------------------------------------------------------------------

  String? _defaultValueSource(FormalParameterElement param) {
    // Prefer the constant initializer AST (works for both source and summary
    // elements where deserialised).
    final init = param.constantInitializer;
    if (init != null) {
      try {
        return init.toSource();
      } catch (_) {
        // Some constant initializers may not be renderable — fall through.
      }
    }
    // Fall back to the defaultValueCode string the element exposes.
    if (param.hasDefaultValue) {
      return param.defaultValueCode;
    }
    return null;
  }

  List<ParameterInfo> _parseFormalParameters(
    List<FormalParameterElement> params,
  ) {
    final result = <ParameterInfo>[];
    for (final p in params) {
      final typeInfo = _collectTypeInfo(p.type);
      result.add(
        ParameterInfo(
          name: p.name ?? '',
          type: p.type.getDisplayString(),
          typeImportUris: typeInfo.uris,
          typeToUri: typeInfo.typeToUri,
          isRequired: p.isRequired,
          isNamed: p.isNamed,
          defaultValue: _defaultValueSource(p),
          isFunctionTypeAlias: typeInfo.isFunctionTypeAlias,
          functionTypeInfo: typeInfo.functionTypeInfo,
        ),
      );
    }
    return result;
  }

  // ---------------------------------------------------------------------------
  // Type aliases
  // ---------------------------------------------------------------------------

  void _processTypeAlias(TypeAliasElement alias) {
    final name = alias.name;
    if (name == null) return;
    if (skipPrivate && name.startsWith('_')) return;
    if (_isInternalOrSkippable(alias)) return;

    final isDeprecated =
        !generateDeprecatedElements && _hasDeprecatedAnnotation(alias);

    final aliased = alias.aliasedType;
    if (aliased is FunctionType) {
      if (isDeprecated) {
        skippedDeprecatedCount++;
        return;
      }
      typedefExpansions[name] = _expandFunctionType(aliased);
      return;
    }

    // Non-function type alias (class alias). Always keep even when
    // deprecated, consistent with GEN-078.
    if (aliased is InterfaceType) {
      final targetName = aliased.element.name;
      if (targetName != null) {
        typeAliases[name] = targetName;
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Enums
  // ---------------------------------------------------------------------------

  void _processEnum(EnumElement enumEl) {
    final name = enumEl.name;
    if (name == null) return;
    if (skipPrivate && name.startsWith('_')) return;
    if (_isInternalOrSkippable(enumEl)) return;
    if (!generateDeprecatedElements && _hasDeprecatedAnnotation(enumEl)) {
      skippedDeprecatedCount++;
      return;
    }

    // Enum values: non-synthetic enum-constant fields.
    final values = <String>[];
    for (final field in enumEl.fields) {
      if (field.isEnumConstant) {
        final fieldName = field.name;
        if (fieldName != null) values.add(fieldName);
      }
    }

    const builtInNames = {
      'name',
      'index',
      'values',
      'hashCode',
      'runtimeType',
    };

    final getterNames = <String>[];
    final methodDetails = <EnumMethodDetail>[];
    final staticGetterNames = <String>[];
    final methodNames = <String>[];

    for (final field in enumEl.fields) {
      if (field.isSynthetic) continue;
      if (field.isPrivate) continue;
      if (field.isStatic) {
        if (!field.isEnumConstant) {
          final fieldName = field.name;
          if (fieldName != null &&
              !builtInNames.contains(fieldName) &&
              !values.contains(fieldName)) {
            staticGetterNames.add(fieldName);
          }
        }
        continue;
      }
      final fieldName = field.name;
      if (fieldName == null) continue;
      if (builtInNames.contains(fieldName)) continue;
      getterNames.add(fieldName);
    }

    for (final accessor in enumEl.getters) {
      if (accessor.isSynthetic) continue;
      if (accessor.isPrivate) continue;
      if (accessor.isStatic) {
        final accessorName = accessor.name;
        if (accessorName != null &&
            !builtInNames.contains(accessorName) &&
            !values.contains(accessorName) &&
            !staticGetterNames.contains(accessorName)) {
          staticGetterNames.add(accessorName);
        }
        continue;
      }
      final accessorName = accessor.name;
      if (accessorName == null) continue;
      if (builtInNames.contains(accessorName)) continue;
      if (getterNames.contains(accessorName)) continue;
      getterNames.add(accessorName);
    }

    for (final method in enumEl.methods) {
      if (method.isSynthetic) continue;
      if (method.isPrivate) continue;
      if (method.isStatic) continue;
      final methodName = method.name;
      if (methodName == null) continue;
      methodNames.add(methodName);
      methodDetails.add(_collectEnumMethodDetail(method));
    }

    // Also collect from mixin supertypes (GEN-053).
    for (final supertype in enumEl.allSupertypes) {
      final supertypeElement = supertype.element;
      if (supertypeElement.name == 'Enum' ||
          supertypeElement.name == 'Object') {
        continue;
      }
      for (final getter in supertypeElement.getters) {
        if (getter.isStatic) continue;
        if (getter.isSynthetic) continue;
        final gname = getter.name;
        if (gname == null) continue;
        if (gname.startsWith('_')) continue;
        if (builtInNames.contains(gname)) continue;
        if (getterNames.contains(gname)) continue;
        getterNames.add(gname);
      }
      for (final method in supertypeElement.methods) {
        if (method.isStatic) continue;
        if (method.isSynthetic) continue;
        final mname = method.name;
        if (mname == null) continue;
        if (mname.startsWith('_')) continue;
        if (methodNames.contains(mname)) continue;
        methodNames.add(mname);
        methodDetails.add(_collectEnumMethodDetail(method));
      }
    }

    enums.add(
      EnumInfo(
        name: name,
        values: values,
        sourceFile: _currentSourceFile ?? '',
        hasMembers: enumEl.methods.isNotEmpty ||
            enumEl.getters.any((g) => !g.isSynthetic) ||
            enumEl.fields.any((f) => !f.isSynthetic && !f.isEnumConstant),
        getterNames: getterNames,
        methodDetails: methodDetails,
        staticGetterNames: staticGetterNames,
      ),
    );
  }

  EnumMethodDetail _collectEnumMethodDetail(MethodElement method) {
    final params = method.formalParameters.map((p) {
      final paramTypeImportUris = <String>{};
      final paramTypeToUri = <String, String>{};
      _collectInfoFromDartType(p.type, paramTypeImportUris, paramTypeToUri);
      return ParameterInfo(
        name: p.name ?? '',
        type: p.type.getDisplayString(),
        isRequired: p.isRequired,
        isNamed: p.isNamed,
        defaultValue: _defaultValueSource(p),
        typeImportUris: paramTypeImportUris,
        typeToUri: paramTypeToUri,
      );
    }).toList();
    return EnumMethodDetail(name: method.name ?? '', parameters: params);
  }

  // ---------------------------------------------------------------------------
  // Extensions
  // ---------------------------------------------------------------------------

  void _processExtension(ExtensionElement ext) {
    final name = ext.name;
    if (skipPrivate && name != null && name.startsWith('_')) return;
    if (_isInternalOrSkippable(ext)) return;
    if (!generateDeprecatedElements && _hasDeprecatedAnnotation(ext)) {
      skippedDeprecatedCount++;
      return;
    }

    final extendedType = ext.extendedType;
    final onTypeDisplay = extendedType.getDisplayString();
    if (onTypeDisplay.contains('<')) return;

    String? onTypeUri;
    String onTypeName = onTypeDisplay;
    if (extendedType is InterfaceType) {
      final element = extendedType.element;
      final library = element.library;
      onTypeUri = library.identifier;
      final elementName = element.name;
      if (elementName != null) {
        onTypeName = elementName;
        globalTypeToUri[elementName] = onTypeUri;
      }
    }

    final getterNames = <String>[];
    final setterNames = <String>[];
    final methodNames = <String>[];
    final methods = <MemberInfo>[];

    for (final getter in ext.getters) {
      if (getter.isStatic) continue;
      if (getter.isSynthetic) continue;
      final gname = getter.name;
      if (gname == null) continue;
      if (skipPrivate && gname.startsWith('_')) continue;
      getterNames.add(gname);
    }
    for (final setter in ext.setters) {
      if (setter.isStatic) continue;
      if (setter.isSynthetic) continue;
      final sname = setter.name;
      if (sname == null) continue;
      if (skipPrivate && sname.startsWith('_')) continue;
      setterNames.add(sname);
    }
    for (final method in ext.methods) {
      if (method.isStatic) continue;
      if (method.isSynthetic) continue;
      if (method.isOperator) continue;
      final mname = method.name;
      if (mname == null) continue;
      if (skipPrivate && mname.startsWith('_')) continue;
      if (_isInternalOrSkippable(method)) continue;
      methodNames.add(mname);
      methods.add(_memberFromMethodElement(method));
    }

    if (getterNames.isEmpty && setterNames.isEmpty && methodNames.isEmpty) {
      return;
    }

    extensions.add(
      ExtensionInfo(
        name: name,
        onTypeName: onTypeName,
        onTypeUri: onTypeUri,
        sourceFile: _currentSourceFile ?? '',
        getterNames: getterNames,
        setterNames: setterNames,
        methodNames: methodNames,
        methods: methods,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top-level functions / getters / setters / variables
  // ---------------------------------------------------------------------------

  void _processFunction(TopLevelFunctionElement func) {
    final name = func.name;
    if (name == null) return;
    if (skipPrivate && name.startsWith('_')) return;
    if (_isInternalOrSkippable(func)) return;
    if (!generateDeprecatedElements && _hasDeprecatedAnnotation(func)) {
      skippedDeprecatedCount++;
      return;
    }

    final returnType = func.returnType;
    final returnTypeInfo = _collectTypeInfo(returnType);
    final parameters = _parseFormalParameters(func.formalParameters);

    final hasTypeParameters = func.typeParameters.isNotEmpty;
    final typeParamsMap = <String, String?>{};
    if (hasTypeParameters) {
      for (final tp in func.typeParameters) {
        final tpName = tp.name;
        if (tpName == null) continue;
        typeParamsMap[tpName] = tp.bound?.getDisplayString();
      }
    }

    globalFunctions.add(
      GlobalFunctionInfo(
        name: name,
        returnType: returnType.getDisplayString(),
        returnTypeImportUris: returnTypeInfo.uris,
        returnTypeToUri: returnTypeInfo.typeToUri,
        parameters: parameters,
        sourceFile: _currentSourceFile ?? '',
        hasTypeParameters: hasTypeParameters,
        typeParameters: typeParamsMap,
      ),
    );
  }

  void _processTopLevelGetter(GetterElement getter) {
    if (getter.isSynthetic) return;
    final name = getter.name;
    if (name == null) return;
    if (skipPrivate && name.startsWith('_')) return;
    if (_isInternalOrSkippable(getter)) return;
    if (!generateDeprecatedElements && _hasDeprecatedAnnotation(getter)) {
      skippedDeprecatedCount++;
      return;
    }

    final returnType = getter.returnType;
    final typeInfo = _collectTypeInfo(returnType);
    globalVariables.add(
      GlobalVariableInfo(
        name: name,
        type: returnType.getDisplayString(),
        typeImportUris: typeInfo.uris,
        typeToUri: typeInfo.typeToUri,
        isFinal: false,
        isConst: false,
        isGetter: true,
        sourceFile: _currentSourceFile ?? '',
      ),
    );
  }

  void _processTopLevelSetter(SetterElement setter) {
    if (setter.isSynthetic) return;
    final name = setter.name;
    if (name == null) return;
    if (skipPrivate && name.startsWith('_')) return;
    if (_isInternalOrSkippable(setter)) return;
    if (!generateDeprecatedElements && _hasDeprecatedAnnotation(setter)) {
      skippedDeprecatedCount++;
      return;
    }
    globalSetterNames.add(name);
  }

  void _processTopLevelVariable(TopLevelVariableElement variable) {
    if (variable.isSynthetic) return;
    final name = variable.name;
    if (name == null) return;
    if (skipPrivate && name.startsWith('_')) return;
    if (_isInternalOrSkippable(variable)) return;
    if (!generateDeprecatedElements && _hasDeprecatedAnnotation(variable)) {
      skippedDeprecatedCount++;
      return;
    }

    final type = variable.type;
    final typeInfo = _collectTypeInfo(type);
    globalVariables.add(
      GlobalVariableInfo(
        name: name,
        type: type.getDisplayString(),
        typeImportUris: typeInfo.uris,
        typeToUri: typeInfo.typeToUri,
        isFinal: variable.isFinal,
        isConst: variable.isConst,
        sourceFile: _currentSourceFile ?? '',
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Classes / mixins
  // ---------------------------------------------------------------------------

  void _processClass(InterfaceElement classElement, {required bool isMixin}) {
    final name = classElement.name;
    if (name == null) return;
    if (skipPrivate && name.startsWith('_')) return;
    if (_isInternalOrSkippable(classElement)) return;
    if (!generateDeprecatedElements &&
        _hasDeprecatedAnnotation(classElement)) {
      skippedDeprecatedCount++;
      return;
    }

    // Superclass (extends / on-clause for mixins).
    String? superclass;
    String? superclassUri;
    if (isMixin) {
      if (classElement is MixinElement &&
          classElement.superclassConstraints.isNotEmpty) {
        final first = classElement.superclassConstraints.first;
        superclass = first.element.name;
        final uri = first.element.library.identifier;
        if (uri.startsWith('package:')) {
          superclassUri = uri;
          if (superclass != null) {
            globalTypeToUri[superclass] = uri;
          }
        }
      }
    } else {
      final supertype = classElement.supertype;
      if (supertype != null) {
        final superName = supertype.element.name;
        if (superName != null && superName != 'Object') {
          superclass = superName;
          final uri = supertype.element.library.identifier;
          if (uri.startsWith('package:')) {
            superclassUri = uri;
          }
        }
      }
    }

    // Members.
    final members = <MemberInfo>[];

    for (final field in classElement.fields) {
      if (field.isSynthetic) continue;
      final fname = field.name;
      if (fname == null) continue;
      if (skipPrivate && fname.startsWith('_')) continue;
      if (_isInternalOrSkippable(field)) continue;

      final typeInfo = _collectTypeInfo(field.type);

      members.add(
        MemberInfo(
          name: fname,
          returnType: field.type.getDisplayString(),
          returnTypeImportUris: typeInfo.uris,
          returnTypeToUri: typeInfo.typeToUri,
          isGetter: true,
          isStatic: field.isStatic,
        ),
      );

      final isLate = field.isLate;
      final hasInit = field.hasInitializer;
      if (!field.isConst && (!field.isFinal || (isLate && !hasInit))) {
        members.add(
          MemberInfo(
            name: fname,
            returnType: field.type.getDisplayString(),
            returnTypeImportUris: typeInfo.uris,
            returnTypeToUri: typeInfo.typeToUri,
            isSetter: true,
            isStatic: field.isStatic,
            functionTypeInfo: typeInfo.functionTypeInfo,
          ),
        );
      }
    }

    for (final getter in classElement.getters) {
      if (getter.isSynthetic) continue;
      final gname = getter.name;
      if (gname == null) continue;
      if (skipPrivate && gname.startsWith('_')) continue;
      if (_isInternalOrSkippable(getter)) continue;
      final typeInfo = _collectTypeInfo(getter.returnType);
      members.add(
        MemberInfo(
          name: gname,
          returnType: getter.returnType.getDisplayString(),
          returnTypeImportUris: typeInfo.uris,
          returnTypeToUri: typeInfo.typeToUri,
          isGetter: true,
          isStatic: getter.isStatic,
        ),
      );
    }

    for (final setter in classElement.setters) {
      if (setter.isSynthetic) continue;
      final sname = setter.name;
      if (sname == null) continue;
      if (skipPrivate && sname.startsWith('_')) continue;
      if (_isInternalOrSkippable(setter)) continue;
      final params = setter.formalParameters;
      final paramType = params.isNotEmpty ? params.first.type : null;
      final typeInfo = _collectTypeInfo(paramType);
      members.add(
        MemberInfo(
          name: sname,
          returnType: paramType?.getDisplayString() ?? 'dynamic',
          returnTypeImportUris: typeInfo.uris,
          returnTypeToUri: typeInfo.typeToUri,
          isSetter: true,
          isStatic: setter.isStatic,
          functionTypeInfo: typeInfo.functionTypeInfo,
          parameters: params
              .map((p) => ParameterInfo(
                    name: p.name ?? 'value',
                    type: p.type.getDisplayString(),
                    isRequired: p.isRequired,
                    isNamed: p.isNamed,
                  ))
              .toList(),
        ),
      );
    }

    for (final method in classElement.methods) {
      final mname = method.name;
      if (mname == null) continue;
      if (skipPrivate && mname.startsWith('_')) continue;
      if (_isInternalOrSkippable(method)) continue;
      members.add(_memberFromMethodElement(method));
    }

    // Constructors.
    final constructors = <ConstructorInfo>[];
    if (!isMixin) {
      for (final ctor in classElement.constructors) {
        if (ctor.isSynthetic) {
          // Collect synthetic unnamed constructor only for non-abstract
          // classes with no explicit constructors (GEN-042).
          continue;
        }
        final ctorName = ctor.name == 'new' ? null : ctor.name;
        if (skipPrivate && ctorName != null && ctorName.startsWith('_')) {
          continue;
        }
        if (_isInternalOrSkippable(ctor)) continue;
        constructors.add(
          ConstructorInfo(
            name: ctorName,
            parameters: _parseFormalParameters(ctor.formalParameters),
            isFactory: ctor.isFactory,
            isConst: ctor.isConst,
          ),
        );
      }

      // GEN-042: Synthetic unnamed constructor for non-abstract classes with
      // no explicit constructors.
      final isAbstract = classElement is ClassElement && classElement.isAbstract;
      if (constructors.isEmpty && !isAbstract) {
        final unnamed = classElement.unnamedConstructor;
        if (unnamed != null && unnamed.isSynthetic) {
          constructors.add(const ConstructorInfo(name: null, parameters: []));
        }
      }
    }

    // Type parameters.
    final typeParams = <String, String?>{};
    for (final tp in classElement.typeParameters) {
      final tpName = tp.name;
      if (tpName == null) continue;
      final bound = tp.bound;
      if (bound != null) {
        typeParams[tpName] = bound.getDisplayString();
        if (bound is InterfaceType) {
          final bName = bound.element.name;
          if (bName != null) {
            final uri = bound.element.library.identifier;
            if (!uri.startsWith('dart:')) {
              globalTypeToUri[bName] = uri;
            }
          }
        }
      } else {
        typeParams[tpName] = null;
      }
    }

    // All supertype names (transitive).
    final allSupertypeNames = <String>{};
    for (final sup in classElement.allSupertypes) {
      final supName = sup.element.name;
      if (supName != null && supName != 'Object') {
        allSupertypeNames.add(supName);
      }
    }

    final isAbstractResolved =
        (classElement is ClassElement && classElement.isAbstract) || isMixin;
    final isSealedResolved =
        classElement is ClassElement && classElement.isSealed;

    classes.add(
      ClassInfo(
        name: name,
        sourceFile: _currentSourceFile ?? '',
        superclass: superclass,
        superclassUri: superclassUri,
        isAbstract: isAbstractResolved,
        isSealed: isSealedResolved,
        isMixin: isMixin,
        constructors: constructors,
        members: members,
        typeParameters: typeParams,
        allSupertypeNames: allSupertypeNames,
      ),
    );
  }

  MemberInfo _memberFromMethodElement(MethodElement method) {
    final rawReturnType = method.returnType;
    final typeInfo = _collectTypeInfo(rawReturnType);

    final parameters = method.formalParameters.map((p) {
      final paramTypeImportUris = <String>{};
      final paramTypeToUri = <String, String>{};
      _collectInfoFromDartType(p.type, paramTypeImportUris, paramTypeToUri);
      final funcTypeInfo =
          BridgeGenerator.extractFunctionTypeInfoFromDartType(p.type);
      return ParameterInfo(
        name: p.name ?? '',
        type: p.type.getDisplayString(),
        isRequired: p.isRequired,
        isNamed: p.isNamed,
        defaultValue: _defaultValueSource(p),
        typeImportUris: paramTypeImportUris,
        typeToUri: paramTypeToUri,
        functionTypeInfo: funcTypeInfo,
      );
    }).toList();

    final hasTypeParameters = method.typeParameters.isNotEmpty;
    final methodTypeParams = <String, String?>{};
    for (final tp in method.typeParameters) {
      final tpName = tp.name;
      if (tpName == null) continue;
      methodTypeParams[tpName] = tp.bound?.getDisplayString();
    }

    return MemberInfo(
      name: method.name ?? '',
      returnType: rawReturnType.getDisplayString(),
      returnTypeImportUris: typeInfo.uris,
      returnTypeToUri: typeInfo.typeToUri,
      isMethod: !method.isOperator,
      isOperator: method.isOperator,
      isStatic: method.isStatic,
      parameters: parameters,
      hasTypeParameters: hasTypeParameters,
      methodTypeParameters: methodTypeParams,
    );
  }
}

/// Helper: allow callers to pull an ElementAnnotationImpl-based source
/// representation of an annotation's arguments. This is used by the extractor's
/// clients when they need to render annotation payloads (step 2 pattern).
String? annotationArgumentsSource(ElementAnnotation annotation) {
  try {
    if (annotation is ElementAnnotationImpl) {
      return annotation.annotationAst.arguments?.toSource();
    }
  } catch (_) {
    // ignore — annotation may not have an AST in summary-backed libs.
  }
  return null;
}
