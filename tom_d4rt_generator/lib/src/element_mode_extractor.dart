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
// ignore: implementation_imports
import 'package:analyzer/src/dart/element/inheritance_manager3.dart'
    show InheritanceManager3, Name;
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
        mapPrivateSdkLibrary,
        normalizeLibraryIdentifier;
import 'type_rendering.dart' as shared_type_rendering;

/// Walks a resolved `LibraryElement` and fills collections equivalent to the
/// AST `_ResolvedClassVisitor` outputs.
class ElementModeExtractor {
  final bool skipPrivate;
  final bool generateDeprecatedElements;

  /// Plan Phase 1 / B4: when true, declared class members are emitted in
  /// source order (sorted by `firstFragment.nameOffset`) before inherited
  /// members are appended. OFF by default — the emitter and signature-maps
  /// don't depend on source order in Phase 2. Flip on in Phase 3 if bridge
  /// diffs show unstable map iteration order.
  final bool sortDeclaredMembersBySourceOrder;

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
    this.sortDeclaredMembersBySourceOrder = false,
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

    // Plan Phase 1 / W1+W2+B3: the analyzer's element flags
    // (`annotation.isInternal` / `.isMustBeOverridden` /
    // `.isVisibleForOverriding`) are the canonical source. The AST twin's
    // `toSource()` string-compare fallback is redundant here — element
    // metadata is already populated from either source or `.sum` bundles.
    for (final annotation in element.metadata.annotations) {
      if (annotation.isInternal ||
          annotation.isMustBeOverridden ||
          annotation.isVisibleForOverriding) {
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
          var uri = normalizeLibraryIdentifier(aliasLibrary.identifier);
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
      var uri = normalizeLibraryIdentifier(library.identifier);

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

  /// Plan Phase 1 / W6: renders a [DartType] to Dart source-like text while
  /// preserving *function-typedef* aliases (e.g. `VoidCallback`, `ValueChanged<T>`).
  ///
  /// Phase 4 extracted the rendering rules into the shared
  /// [shared_type_rendering.renderDartType] helper so `ProxyGenerator` uses
  /// identical rules. This instance method is kept as a thin forwarder so
  /// all in-file call sites continue to compile unchanged and so future
  /// extractor-specific rendering tweaks have an obvious seam.
  ///
  /// - `FunctionType` with alias → `AliasName<arg1, arg2>?`
  /// - `InterfaceType` → `BaseName<arg1, arg2>?` (alias dropped intentionally)
  /// - `FunctionType` (no alias) → `ReturnType Function(params)?`
  /// - Anything else → `type.getDisplayString()`
  String _renderDartType(DartType type) =>
      shared_type_rendering.renderDartType(type);

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
          type: _renderDartType(p.type),
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
    // Plan Phase 1 / Private-typedef parity: the AST twin historically leaked
    // private typedefs (e.g. `_PerformanceModeCleanupCallback`) into generated
    // bridges because `_hasPrivateIdentifierName` was only applied to classes.
    // The element path treats a leading underscore as private — if
    // `skipPrivate` is on, the typedef is filtered out. This is the intended
    // semantics: private typedefs are implementation detail and must not be
    // referenced from generated bridge code. Plan §4.1 records this as the
    // chosen policy for Phase 1.
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
        type: _renderDartType(p.type),
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
    // Skip unnamed extensions: per Dart 3 semantics, an unnamed extension is
    // library-private — only the library that declares it can invoke its
    // members. The generated bridge file is a different library from the one
    // that defines the extension, so emitting a direct call
    // (`(target as T).method()`) won't compile. Bridges only support *named*
    // extensions reachable through public exports.
    if (name == null || name.isEmpty) return;
    if (skipPrivate && name.startsWith('_')) return;
    if (_isInternalOrSkippable(ext)) return;
    if (!generateDeprecatedElements && _hasDeprecatedAnnotation(ext)) {
      skippedDeprecatedCount++;
      return;
    }

    final extendedType = ext.extendedType;
    // Plan Phase 1 / W5: extensions with generic on-types are skipped today.
    // AST path used `onTypeName.contains('<')`; the element API lets us check
    // directly via `InterfaceType.typeArguments.isNotEmpty`.
    if (extendedType is InterfaceType &&
        extendedType.typeArguments.isNotEmpty) {
      return;
    }

    String? onTypeUri;
    String onTypeName = _renderDartType(extendedType);
    if (extendedType is InterfaceType) {
      final element = extendedType.element;
      final library = element.library;
      onTypeUri = normalizeLibraryIdentifier(library.identifier);
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
        final bound = tp.bound;
        typeParamsMap[tpName] = bound != null ? _renderDartType(bound) : null;
      }
    }

    globalFunctions.add(
      GlobalFunctionInfo(
        name: name,
        returnType: _renderDartType(returnType),
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
        type: _renderDartType(returnType),
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
        type: _renderDartType(type),
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
        final uri = normalizeLibraryIdentifier(
          first.element.library.identifier,
        );
        // Match AST path: only store package: URIs, not dart: (mirrors
        // `_ResolvedClassVisitor.visitClassDeclaration`).
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
          final uri = normalizeLibraryIdentifier(
            supertype.element.library.identifier,
          );
          // Match AST path: only store package: URIs.
          if (uri.startsWith('package:')) {
            superclassUri = uri;
          }
        }
      }
    }

    // Declared members. Collected as (member, element) pairs so we can
    // optionally apply Plan Phase 1 / B4 source-order sorting by
    // `firstFragment.nameOffset` before handing off to the emitter.
    final declaredPairs = <({MemberInfo member, Element element})>[];

    for (final field in classElement.fields) {
      if (field.isSynthetic) continue;
      final fname = field.name;
      if (fname == null) continue;
      if (skipPrivate && fname.startsWith('_')) continue;
      if (_isInternalOrSkippable(field)) continue;

      final typeInfo = _collectTypeInfo(field.type);
      final fieldTypeText = _renderDartType(field.type);

      declaredPairs.add((
        member: MemberInfo(
          name: fname,
          returnType: fieldTypeText,
          returnTypeImportUris: typeInfo.uris,
          returnTypeToUri: typeInfo.typeToUri,
          isGetter: true,
          isStatic: field.isStatic,
        ),
        element: field,
      ));

      final isLate = field.isLate;
      final hasInit = field.hasInitializer;
      if (!field.isConst && (!field.isFinal || (isLate && !hasInit))) {
        declaredPairs.add((
          member: MemberInfo(
            name: fname,
            returnType: fieldTypeText,
            returnTypeImportUris: typeInfo.uris,
            returnTypeToUri: typeInfo.typeToUri,
            isSetter: true,
            isStatic: field.isStatic,
            functionTypeInfo: typeInfo.functionTypeInfo,
          ),
          element: field,
        ));
      }
    }

    for (final getter in classElement.getters) {
      if (getter.isSynthetic) continue;
      final gname = getter.name;
      if (gname == null) continue;
      if (skipPrivate && gname.startsWith('_')) continue;
      if (_isInternalOrSkippable(getter)) continue;
      final typeInfo = _collectTypeInfo(getter.returnType);
      declaredPairs.add((
        member: MemberInfo(
          name: gname,
          returnType: _renderDartType(getter.returnType),
          returnTypeImportUris: typeInfo.uris,
          returnTypeToUri: typeInfo.typeToUri,
          isGetter: true,
          isStatic: getter.isStatic,
        ),
        element: getter,
      ));
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
      declaredPairs.add((
        member: MemberInfo(
          name: sname,
          returnType:
              paramType != null ? _renderDartType(paramType) : 'dynamic',
          returnTypeImportUris: typeInfo.uris,
          returnTypeToUri: typeInfo.typeToUri,
          isSetter: true,
          isStatic: setter.isStatic,
          functionTypeInfo: typeInfo.functionTypeInfo,
          parameters: params
              .map((p) => ParameterInfo(
                    name: p.name ?? 'value',
                    type: _renderDartType(p.type),
                    isRequired: p.isRequired,
                    isNamed: p.isNamed,
                  ))
              .toList(),
        ),
        element: setter,
      ));
    }

    for (final method in classElement.methods) {
      final mname = method.name;
      if (mname == null) continue;
      if (skipPrivate && mname.startsWith('_')) continue;
      if (_isInternalOrSkippable(method)) continue;
      declaredPairs.add((
        member: _memberFromMethodElement(method),
        element: method,
      ));
    }

    final members = sortDeclaredMembersBySourceOrder
        ? _sortMembersBySourceOrder(declaredPairs)
        : declaredPairs.map((p) => p.member).toList();

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
        typeParams[tpName] = _renderDartType(bound);
        if (bound is InterfaceType) {
          final bName = bound.element.name;
          if (bName != null) {
            final uri = normalizeLibraryIdentifier(
              bound.element.library.identifier,
            );
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

    // GEN-093: Append inherited members (from all supertypes) so the renderer
    // sees a complete member list — in particular, inherited setters carry
    // `parameters` so the setter signature renders with the typed parameter
    // instead of `dynamic`. Mirrors `_collectInheritedMembersFromElement` in
    // bridge_generator.dart.
    final declaredQualifiedNames = _buildQualifiedMemberNames(members);
    final inherited =
        _collectInheritedMembers(classElement, declaredQualifiedNames);
    members.addAll(inherited);

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

  /// Plan Phase 1 / B4: sorts declared class members by source-order offset
  /// (ascending). The offset is read from each element's
  /// `firstFragment.nameOffset`; elements without a resolvable offset sort
  /// last. Stable sort — pairs with identical offsets keep insertion order
  /// (matters for fields that generate both a getter and a setter pair).
  static List<MemberInfo> _sortMembersBySourceOrder(
    List<({MemberInfo member, Element element})> pairs,
  ) {
    int offsetOf(Element e) {
      try {
        // ignore: avoid_dynamic_calls
        final raw = (e as dynamic).firstFragment?.nameOffset as int?;
        return raw ?? 1 << 30;
      } catch (_) {
        return 1 << 30;
      }
    }

    final indexed = <({int index, int offset, MemberInfo member})>[];
    for (var i = 0; i < pairs.length; i++) {
      indexed.add((
        index: i,
        offset: offsetOf(pairs[i].element),
        member: pairs[i].member,
      ));
    }
    indexed.sort((a, b) {
      final cmp = a.offset.compareTo(b.offset);
      return cmp != 0 ? cmp : a.index.compareTo(b.index);
    });
    return indexed.map((p) => p.member).toList();
  }

  /// GEN-093: Builds a set of member-type-qualified names from a list of
  /// [MemberInfo] objects. Getters are prefixed with `get:`, setters with
  /// `set:`, and methods/operators use their bare name.
  ///
  /// Mirrors `BridgeGenerator._buildQualifiedMemberNames`.
  static Set<String> _buildQualifiedMemberNames(List<MemberInfo> members) {
    final result = <String>{};
    for (final m in members) {
      if (m.isGetter) {
        result.add('get:${m.name}');
      } else if (m.isSetter) {
        result.add('set:${m.name}');
      } else {
        result.add(m.name);
      }
    }
    return result;
  }

  /// Collects inherited members from all supertypes of a class element.
  ///
  /// Twin of `_ResolvedClassVisitor._collectInheritedMembersFromElement` —
  /// static members are skipped (not inherited in Dart), private members are
  /// skipped, and `@internal` / `@visibleForOverriding` / `@mustBeOverridden`
  /// members are skipped.
  List<MemberInfo> _collectInheritedMembers(
    InterfaceElement classElement,
    Set<String> declaredMemberNames,
  ) {
    final result = <MemberInfo>[];
    final processedNames = Set<String>.from(declaredMemberNames);
    final memberIndexByName = <String, int>{};

    final inheritanceManager = InheritanceManager3();

    for (final supertype in classElement.allSupertypes) {
      final supertypeElement = supertype.element;
      final isMixinSupertype = supertypeElement is MixinElement;

      if (supertypeElement.name == 'Object') continue;

      // Build type substitution map from supertype's type parameters to the
      // type arguments on this particular supertype reference.
      final typeSubstitution = <String, DartType>{};
      final typeParams = supertypeElement.typeParameters;
      final typeArgs = supertype.typeArguments;
      for (var i = 0; i < typeParams.length && i < typeArgs.length; i++) {
        final paramName = typeParams[i].name;
        if (paramName != null) {
          typeSubstitution[paramName] = typeArgs[i];
        }
      }

      // Getters.
      for (final getter in supertypeElement.getters) {
        if (getter.isStatic) continue;
        final gname = getter.name;
        if (gname == null) continue;
        if (gname.startsWith('_')) continue;
        if (_hasInternalElementAnnotation(getter)) continue;

        final qualified = 'get:$gname';
        if (processedNames.contains(qualified)) {
          if (!isMixinSupertype) continue;
          final existingIndex = memberIndexByName[qualified];
          if (existingIndex == null) continue;
          final memberInfo =
              _parseMemberFromGetterElement(getter, typeSubstitution);
          if (memberInfo != null) {
            result[existingIndex] = memberInfo;
          }
          continue;
        }

        if (getter.isSynthetic && supertypeElement is EnumElement) continue;

        final memberInfo =
            _parseMemberFromGetterElement(getter, typeSubstitution);
        if (memberInfo != null) {
          result.add(memberInfo);
          memberIndexByName[qualified] = result.length - 1;
          processedNames.add(qualified);
        }
      }

      // Setters.
      for (final setter in supertypeElement.setters) {
        if (setter.isStatic) continue;
        final sname = setter.name;
        if (sname == null) continue;
        if (sname.startsWith('_')) continue;
        if (_hasInternalElementAnnotation(setter)) continue;

        final qualified = 'set:$sname';
        if (processedNames.contains(qualified)) {
          if (!isMixinSupertype) continue;
          final existingIndex = memberIndexByName[qualified];
          if (existingIndex == null) continue;
          final memberInfo =
              _parseMemberFromSetterElement(setter, typeSubstitution);
          if (memberInfo != null) {
            result[existingIndex] = memberInfo;
          }
          continue;
        }

        final memberInfo =
            _parseMemberFromSetterElement(setter, typeSubstitution);
        if (memberInfo != null) {
          result.add(memberInfo);
          memberIndexByName[qualified] = result.length - 1;
          processedNames.add(qualified);
        }
      }

      // Methods (non-operator). Use InheritanceManager3.getMember to resolve
      // covariant parameter narrowing and generic substitution.
      for (final method in supertypeElement.methods) {
        if (method.isStatic) continue;
        final mname = method.name;
        if (mname == null || mname.startsWith('_')) continue;
        if (_hasInternalElementAnnotation(method)) continue;

        MethodElement effectiveMethod = method;
        Map<String, DartType>? effectiveSubstitution = typeSubstitution;
        final resolved = inheritanceManager.getMember(
          classElement,
          Name(null, mname),
        );
        if (resolved is MethodElement) {
          effectiveMethod = resolved as MethodElement;
          effectiveSubstitution = null;
        }

        if (processedNames.contains(mname)) {
          if (!isMixinSupertype) continue;
          final existingIndex = memberIndexByName[mname];
          if (existingIndex == null) continue;
          final memberInfo = _parseMemberFromMethodElement(
            effectiveMethod,
            effectiveSubstitution,
          );
          if (memberInfo != null) {
            result[existingIndex] = memberInfo;
          }
          continue;
        }

        if (method.isOperator) continue;

        final memberInfo = _parseMemberFromMethodElement(
          effectiveMethod,
          effectiveSubstitution,
        );
        if (memberInfo != null) {
          result.add(memberInfo);
          memberIndexByName[mname] = result.length - 1;
          processedNames.add(mname);
        }
      }

      // Operators.
      for (final method in supertypeElement.methods) {
        if (!method.isOperator) continue;
        final mname = method.name;
        if (mname == null || mname.startsWith('_')) continue;
        if (_hasInternalElementAnnotation(method)) continue;

        if (processedNames.contains(mname)) continue;

        final operatorKey = '$mname#${method.formalParameters.length}';
        if (processedNames.contains(operatorKey)) continue;

        final memberInfo =
            _parseMemberFromMethodElement(method, typeSubstitution);
        if (memberInfo != null) {
          result.add(memberInfo);
          processedNames.add(mname);
          processedNames.add(operatorKey);
        }
      }
    }

    return result;
  }

  /// Mirrors `_ResolvedClassVisitor._substituteTypeParameters`.
  String _substituteTypeParameters(
    DartType type,
    Map<String, DartType> substitution,
  ) {
    if (type is TypeParameterType) {
      final tpName = type.element.name;
      if (tpName != null && substitution.containsKey(tpName)) {
        return substitution[tpName]!.getDisplayString();
      }
      return 'dynamic';
    }

    if (type is InterfaceType) {
      final typeArgs = type.typeArguments;
      if (typeArgs.isEmpty) {
        return type.getDisplayString();
      }
      final substitutedArgs = typeArgs
          .map((arg) => _substituteTypeParameters(arg, substitution))
          .join(', ');
      final baseName = type.element.name;
      return '$baseName<$substitutedArgs>';
    }

    if (type is FunctionType) {
      final returnType = _substituteTypeParameters(
        type.returnType,
        substitution,
      );
      final formalParams = type.formalParameters;
      final params = <String>[];
      final optionalParts = <String>[];
      final namedParts = <String>[];
      for (final param in formalParams) {
        final paramType = _substituteTypeParameters(param.type, substitution);
        final paramName = param.name;
        if (param.isRequiredPositional) {
          if (paramName != null && paramName.isNotEmpty) {
            params.add('$paramType $paramName');
          } else {
            params.add(paramType);
          }
        } else if (param.isOptionalPositional) {
          if (paramName != null && paramName.isNotEmpty) {
            optionalParts.add('$paramType $paramName');
          } else {
            optionalParts.add(paramType);
          }
        } else if (param.isNamed) {
          final name = paramName ?? '';
          if (param.isRequiredNamed) {
            namedParts.add('required $paramType $name');
          } else {
            namedParts.add('$paramType $name');
          }
        }
      }
      if (optionalParts.isNotEmpty) {
        params.add('[${optionalParts.join(', ')}]');
      }
      if (namedParts.isNotEmpty) {
        params.add('{${namedParts.join(', ')}}');
      }
      return '$returnType Function(${params.join(', ')})';
    }

    return type.getDisplayString();
  }

  /// Mirrors `_ResolvedClassVisitor._parseMemberFromGetterElement`.
  MemberInfo? _parseMemberFromGetterElement(
    GetterElement getter, [
    Map<String, DartType>? typeSubstitution,
  ]) {
    final name = getter.displayName;
    final rawReturnType = getter.returnType;
    final returnType = typeSubstitution != null && typeSubstitution.isNotEmpty
        ? _substituteTypeParameters(rawReturnType, typeSubstitution)
        : _renderDartType(rawReturnType);
    final typeImportUris = <String>{};
    final typeToUri = <String, String>{};
    _collectInfoFromDartType(rawReturnType, typeImportUris, typeToUri);
    return MemberInfo(
      name: name,
      returnType: returnType,
      returnTypeImportUris: typeImportUris,
      returnTypeToUri: typeToUri,
      isGetter: true,
      isStatic: getter.isStatic,
    );
  }

  /// Mirrors `_ResolvedClassVisitor._parseMemberFromSetterElement`. Critical:
  /// populates `parameters` so the renderer emits the typed parameter.
  MemberInfo? _parseMemberFromSetterElement(
    SetterElement setter, [
    Map<String, DartType>? typeSubstitution,
  ]) {
    final name = setter.displayName;
    final params = setter.formalParameters;
    final rawParamType = params.isNotEmpty ? params.first.type : null;
    final paramType = rawParamType != null
        ? (typeSubstitution != null && typeSubstitution.isNotEmpty
            ? _substituteTypeParameters(rawParamType, typeSubstitution)
            : _renderDartType(rawParamType))
        : 'dynamic';

    final typeImportUris = <String>{};
    final typeToUri = <String, String>{};
    if (rawParamType != null) {
      _collectInfoFromDartType(rawParamType, typeImportUris, typeToUri);
    }

    final functionTypeInfo = rawParamType != null
        ? BridgeGenerator.extractFunctionTypeInfoFromDartType(rawParamType)
        : null;

    return MemberInfo(
      name: name,
      returnType: paramType,
      returnTypeImportUris: typeImportUris,
      returnTypeToUri: typeToUri,
      isSetter: true,
      isStatic: setter.isStatic,
      functionTypeInfo: functionTypeInfo,
      parameters: params.map((p) {
        final pType = typeSubstitution != null && typeSubstitution.isNotEmpty
            ? _substituteTypeParameters(p.type, typeSubstitution)
            : _renderDartType(p.type);
        return ParameterInfo(
          name: p.name ?? 'value',
          type: pType,
          isRequired: p.isRequired,
          isNamed: p.isNamed,
        );
      }).toList(),
    );
  }

  /// Mirrors `_ResolvedClassVisitor._parseMemberFromMethodElement` with
  /// optional type substitution.
  MemberInfo? _parseMemberFromMethodElement(
    MethodElement method, [
    Map<String, DartType>? typeSubstitution,
  ]) {
    final name = method.displayName;
    final rawReturnType = method.returnType;
    final returnType = typeSubstitution != null && typeSubstitution.isNotEmpty
        ? _substituteTypeParameters(rawReturnType, typeSubstitution)
        : _renderDartType(rawReturnType);

    final typeImportUris = <String>{};
    final typeToUri = <String, String>{};
    _collectInfoFromDartType(rawReturnType, typeImportUris, typeToUri);

    final parameters = method.formalParameters.map((p) {
      final paramTypeImportUris = <String>{};
      final paramTypeToUri = <String, String>{};
      _collectInfoFromDartType(p.type, paramTypeImportUris, paramTypeToUri);

      final paramType = typeSubstitution != null && typeSubstitution.isNotEmpty
          ? _substituteTypeParameters(p.type, typeSubstitution)
          : _renderDartType(p.type);

      final funcTypeInfo =
          BridgeGenerator.extractFunctionTypeInfoFromDartType(p.type);

      return ParameterInfo(
        name: p.name ?? '',
        type: paramType,
        isRequired: p.isRequired,
        isNamed: p.isNamed,
        // Plan Phase 1 / B2: prefer `constantInitializer.toSource()` (works
        // for summary-backed params) over `defaultValueCode` (AST-only).
        defaultValue: _defaultValueSource(p),
        typeImportUris: paramTypeImportUris,
        typeToUri: paramTypeToUri,
        functionTypeInfo: funcTypeInfo,
      );
    }).toList();

    final hasTypeParameters = method.typeParameters.isNotEmpty;
    final methodTypeParams = <String, String?>{};
    if (hasTypeParameters) {
      for (final typeParam in method.typeParameters) {
        final bound = typeParam.bound;
        final paramName = typeParam.name;
        if (paramName != null) {
          methodTypeParams[paramName] =
              bound != null ? _renderDartType(bound) : null;
        }
      }
    }

    return MemberInfo(
      name: name,
      returnType: returnType,
      returnTypeImportUris: typeImportUris,
      returnTypeToUri: typeToUri,
      isMethod: !method.isOperator,
      isOperator: method.isOperator,
      isStatic: method.isStatic,
      parameters: parameters,
      hasTypeParameters: hasTypeParameters,
      methodTypeParameters: methodTypeParams,
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
        type: _renderDartType(p.type),
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
      final bound = tp.bound;
      methodTypeParams[tpName] = bound != null ? _renderDartType(bound) : null;
    }

    return MemberInfo(
      name: method.name ?? '',
      returnType: _renderDartType(rawReturnType),
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
