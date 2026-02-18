/// Entry point analyzer for reflection generation.
///
/// Analyzes Dart entry points to discover types and members that should
/// be included in reflection output based on reachability and filters.
library;

// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as p;

import 'filter_matcher.dart';
import 'reflection_config.dart';
import 'source_info.dart';

/// Result of entry point analysis for reflection generation.
///
/// Contains all types and members discovered from entry points,
/// categorized by kind and filtered according to configuration.
class ReflectionAnalysisResult {
  /// All discovered classes.
  final List<ClassElement> classes;

  /// All discovered enums.
  final List<EnumElement> enums;

  /// All discovered mixins.
  final List<MixinElement> mixins;

  /// All discovered extension types.
  final List<ExtensionTypeElement> extensionTypes;

  /// All discovered extensions.
  final List<ExtensionElement> extensions;

  /// All discovered type aliases.
  final List<TypeAliasElement> typeAliases;

  /// All discovered global (top-level) functions.
  final List<TopLevelFunctionElement> globalFunctions;

  /// All discovered global (top-level) variables.
  final List<TopLevelVariableElement> globalVariables;

  /// Package to library URI mapping.
  final Map<String, List<String>> packageLibraries;

  /// Library URI to types mapping.
  final Map<String, List<InterfaceElement>> libraryTypes;

  /// Source code information (optional, only populated if enabled in config).
  ///
  /// This provides access to source code, comments, and AST information
  /// for all discovered declarations. Memory-intensive when enabled.
  final SourceInfoCollection? sourceInfo;

  ReflectionAnalysisResult({
    this.classes = const [],
    this.enums = const [],
    this.mixins = const [],
    this.extensionTypes = const [],
    this.extensions = const [],
    this.typeAliases = const [],
    this.globalFunctions = const [],
    this.globalVariables = const [],
    this.packageLibraries = const {},
    this.libraryTypes = const {},
    this.sourceInfo,
  });

  /// Total number of types discovered.
  int get typeCount =>
      classes.length +
      enums.length +
      mixins.length +
      extensionTypes.length +
      typeAliases.length;

  /// Total number of global members discovered.
  int get globalMemberCount => globalFunctions.length + globalVariables.length;

  // ═══════════════════════════════════════════════════════════════════════════
  // Flattened member access (all members across all types)
  // ═══════════════════════════════════════════════════════════════════════════

  /// All methods from all classes.
  List<MethodElement> get allMethods =>
      classes.expand((c) => c.methods).toList();

  /// All fields from all classes.
  List<FieldElement> get allFields => classes.expand((c) => c.fields).toList();

  /// All constructors from all classes.
  List<ConstructorElement> get allConstructors =>
      classes.expand((c) => c.constructors).toList();

  /// All accessors (getters/setters) from all classes.
  List<PropertyAccessorElement> get allAccessors =>
      classes.expand((c) => [...c.getters, ...c.setters]).toList();

  // ═══════════════════════════════════════════════════════════════════════════
  // Annotation API (convenience methods for annotation discovery)
  // ═══════════════════════════════════════════════════════════════════════════

  /// All discovered annotations with their usages.
  ///
  /// Lazily computed on first access. Returns a map from annotation name
  /// to [AnnotationInfo] containing all usages.
  Map<String, AnnotationInfo> get annotations {
    if (_annotationsCache != null) return _annotationsCache!;
    _annotationsCache = _collectAnnotations();
    return _annotationsCache!;
  }

  Map<String, AnnotationInfo>? _annotationsCache;

  /// Find all elements annotated with a specific annotation name.
  List<Element> getAnnotatedElements(String annotationName) {
    final info = annotations[annotationName];
    if (info == null) return const [];
    return info.usages.map((u) => u.element).toList();
  }

  /// Check if any element has a specific annotation.
  bool hasAnnotation(String annotationName) =>
      annotations.containsKey(annotationName);

  Map<String, AnnotationInfo> _collectAnnotations() {
    final result = <String, AnnotationInfo>{};

    void processElement(Element element, String kind, {String? parent}) {
      for (final annotation in element.metadata.annotations) {
        final annotationElement = annotation.element;
        if (annotationElement == null) continue;

        String? annotationName;
        String? sourceLibrary;

        if (annotationElement is ConstructorElement) {
          final cls = annotationElement.enclosingElement;
          annotationName = cls.name;
          sourceLibrary = cls.library.firstFragment.source.uri.toString();
        } else if (annotationElement is PropertyAccessorElement) {
          annotationName = annotationElement.name;
          sourceLibrary = annotationElement.library.firstFragment.source.uri.toString();
        }

        if (annotationName == null) continue;
        final info = result.putIfAbsent(
          annotationName,
          () => AnnotationInfo(
            name: annotationName!,
            qualifiedName: '$sourceLibrary#$annotationName',
            sourceLibrary: sourceLibrary ?? 'unknown',
          ),
        );

        final qualifiedName =
            parent != null ? '$parent.${element.name}' : element.name ?? '';

        info.usages.add(AnnotatedElementInfo(
          name: element.name ?? '<unnamed>',
          qualifiedName: qualifiedName,
          kind: kind,
          library: element.library?.firstFragment.source.uri.toString() ?? 'unknown',
          element: element,
        ));
      }
    }

    // Process all elements
    for (final cls in classes) {
      processElement(cls, 'class');
      for (final field in cls.fields) {
        processElement(field, 'field', parent: cls.name);
      }
      for (final method in cls.methods) {
        processElement(method, 'method', parent: cls.name);
      }
      for (final getter in cls.getters) {
        processElement(getter, 'getter', parent: cls.name);
      }
      for (final setter in cls.setters) {
        processElement(setter, 'setter', parent: cls.name);
      }
      for (final ctor in cls.constructors) {
        processElement(ctor, 'constructor', parent: cls.name);
      }
    }

    for (final e in enums) {
      processElement(e, 'enum');
      for (final value in e.fields.where((f) => f.isEnumConstant)) {
        processElement(value, 'enum value', parent: e.name);
      }
    }

    for (final fn in globalFunctions) {
      processElement(fn, 'function');
    }

    for (final v in globalVariables) {
      processElement(v, 'variable');
    }

    return result;
  }
}

/// Information about an annotation and all its usages.
class AnnotationInfo {
  /// Annotation name (e.g., "override", "Deprecated", "tomReflector").
  final String name;

  /// Fully qualified name of the annotation class/variable.
  final String qualifiedName;

  /// Source library URI.
  final String sourceLibrary;

  /// All elements annotated with this annotation.
  final List<AnnotatedElementInfo> usages = [];

  AnnotationInfo({
    required this.name,
    required this.qualifiedName,
    required this.sourceLibrary,
  });

  /// Number of usages.
  int get usageCount => usages.length;

  /// Usages grouped by element kind.
  Map<String, List<AnnotatedElementInfo>> get usagesByKind {
    final result = <String, List<AnnotatedElementInfo>>{};
    for (final usage in usages) {
      result.putIfAbsent(usage.kind, () => []).add(usage);
    }
    return result;
  }
}

/// Information about an annotated element.
class AnnotatedElementInfo {
  /// Element name.
  final String name;

  /// Fully qualified name.
  final String qualifiedName;

  /// Element kind (class, method, field, etc.).
  final String kind;

  /// Library containing the element.
  final String library;

  /// The actual element (for further analysis).
  final Element element;

  AnnotatedElementInfo({
    required this.name,
    required this.qualifiedName,
    required this.kind,
    required this.library,
    required this.element,
  });
}

/// Analyzes entry points to discover types for reflection.
class EntryPointAnalyzer {
  /// The configuration for reflection generation.
  final ReflectionConfig config;

  /// The inclusion resolver for filtering.
  late final InclusionResolver _inclusionResolver;

  /// Visited libraries (to avoid re-processing).
  final Set<String> _visitedLibraries = {};

  /// Collected classes.
  final List<ClassElement> _classes = [];

  /// Collected enums.
  final List<EnumElement> _enums = [];

  /// Collected mixins.
  final List<MixinElement> _mixins = [];

  /// Collected extension types.
  final List<ExtensionTypeElement> _extensionTypes = [];

  /// Collected extensions.
  final List<ExtensionElement> _extensions = [];

  /// Collected type aliases.
  final List<TypeAliasElement> _typeAliases = [];

  /// Collected global functions.
  final List<TopLevelFunctionElement> _globalFunctions = [];

  /// Collected global variables.
  final List<TopLevelVariableElement> _globalVariables = [];

  /// Package to libraries mapping.
  final Map<String, List<String>> _packageLibraries = {};

  /// Library to types mapping.
  final Map<String, List<InterfaceElement>> _libraryTypes = {};

  /// Types pending dependency resolution.
  final Set<InterfaceElement> _pendingDependencies = {};

  /// Discovered annotation types for marker scanning.
  final Set<String> _discoveredAnnotations = {};

  /// Analysis context collection for marker scanning.
  AnalysisContextCollection? _analysisCollection;

  /// Libraries already scanned for markers.
  final Set<String> _markerScannedLibraries = {};

  /// Elements already processed for annotations (prevent infinite recursion).
  final Set<Element> _processedAnnotationElements = {};

  /// Source info collection (if source extraction is enabled).
  SourceInfoCollection? _sourceInfoCollection;

  /// Source info extractor (if source extraction is enabled).
  SourceInfoExtractor? _sourceInfoExtractor;

  /// Map of file paths to their resolved units (for AST access).
  final Map<String, ResolvedUnitResult> _resolvedUnits = {};

  EntryPointAnalyzer(this.config) {
    _inclusionResolver = InclusionResolver(
      defaultsConfig: config.defaults,
      filterConfigs: config.filters,
    );

    // Initialize source extraction if enabled
    if (config.sourceExtractionConfig.enabled) {
      _sourceInfoCollection = SourceInfoCollection();
      _sourceInfoExtractor = SourceInfoExtractor(
        options: SourceExtractionOptions(
          includeSourceCode: config.sourceExtractionConfig.includeSourceCode,
          includeDocComments: config.sourceExtractionConfig.includeDocComments,
          includeAllComments: config.sourceExtractionConfig.includeAllComments,
          includeLineInfo: config.sourceExtractionConfig.includeLineInfo,
          maxSourceLength: config.sourceExtractionConfig.maxSourceLength,
        ),
      );
    }
  }

  /// Analyze entry points and return discovered types.
  Future<ReflectionAnalysisResult> analyze() async {
    if (config.entryPoints.isEmpty) {
      return ReflectionAnalysisResult();
    }

    // Resolve entry points to absolute paths
    final absolutePaths = config.entryPoints.map((ep) {
      return p.isAbsolute(ep) ? p.absolute(ep) : p.absolute(ep);
    }).toList();

    // Create analysis context
    final collection = AnalysisContextCollection(
      includedPaths: absolutePaths,
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );

    // Analyze each entry point
    for (final entryPoint in absolutePaths) {
      final context = collection.contextFor(entryPoint);

      // Get resolved unit for AST access (needed for source extraction)
      if (config.sourceExtractionConfig.enabled) {
        final unitResult =
            await context.currentSession.getResolvedUnit(entryPoint);
        if (unitResult is ResolvedUnitResult) {
          _resolvedUnits[entryPoint] = unitResult;
          if (config.sourceExtractionConfig.storeFileContents) {
            _sourceInfoCollection?.registerSource(
              unitResult.uri.toString(),
              unitResult.content,
            );
          }
        }
      }

      final result =
          await context.currentSession.getResolvedLibrary(entryPoint);
      if (result is ResolvedLibraryResult) {
        // Store all unit results for source extraction
        if (config.sourceExtractionConfig.enabled) {
          for (final unit in result.units) {
            _resolvedUnits[unit.path] = unit;
            if (config.sourceExtractionConfig.storeFileContents) {
              _sourceInfoCollection?.registerSource(
                unit.uri.toString(),
                unit.content,
              );
            }
          }
        }
        await _processLibrary(result.element);
      }
    }

    // Resolve transitive dependencies
    await _resolveDependencies();

    // Extract source info for all collected elements
    if (config.sourceExtractionConfig.enabled) {
      await _extractSourceInfo();
    }

    return ReflectionAnalysisResult(
      classes: List.unmodifiable(_classes),
      enums: List.unmodifiable(_enums),
      mixins: List.unmodifiable(_mixins),
      extensionTypes: List.unmodifiable(_extensionTypes),
      extensions: List.unmodifiable(_extensions),
      typeAliases: List.unmodifiable(_typeAliases),
      globalFunctions: List.unmodifiable(_globalFunctions),
      globalVariables: List.unmodifiable(_globalVariables),
      packageLibraries: Map.unmodifiable(_packageLibraries),
      libraryTypes: Map.unmodifiable(_libraryTypes),
      sourceInfo: _sourceInfoCollection,
    );
  }

  Future<void> _processLibrary(LibraryElement library) async {
    final uri = library.firstFragment.source.uri.toString();
    if (_visitedLibraries.contains(uri)) return;
    _visitedLibraries.add(uri);

    // Track package
    final packageName = _getPackageName(library);
    if (packageName != null) {
      _packageLibraries.putIfAbsent(packageName, () => []).add(uri);
    }

    // Process top-level declarations directly from the library
    for (final cls in library.classes) {
      if (_shouldInclude(cls)) {
        _addClass(cls, uri);
      }
    }

    for (final enm in library.enums) {
      if (_shouldInclude(enm)) {
        _addEnum(enm, uri);
      }
    }

    for (final mixin in library.mixins) {
      if (_shouldInclude(mixin)) {
        _addMixin(mixin, uri);
      }
    }

    for (final extType in library.extensionTypes) {
      if (_shouldInclude(extType)) {
        _addExtensionType(extType, uri);
      }
    }

    for (final ext in library.extensions) {
      if (_shouldIncludeExtension(ext)) {
        _addExtension(ext);
      }
    }

    for (final alias in library.typeAliases) {
      if (_shouldInclude(alias)) {
        _addTypeAlias(alias);
      }
    }

    for (final func in library.topLevelFunctions) {
      if (_shouldInclude(func)) {
        _addGlobalFunction(func);
      }
    }

    for (final variable in library.topLevelVariables) {
      if (_shouldInclude(variable)) {
        _addGlobalVariable(variable);
      }
    }

    // Follow exports/imports
    for (final export in library.exportedLibraries) {
      await _processLibrary(export);
    }
  }

  /// Extract source info for all collected elements.
  Future<void> _extractSourceInfo() async {
    if (_sourceInfoExtractor == null || _sourceInfoCollection == null) return;

    // Get AST nodes for each element by looking up their declarations
    for (final cls in _classes) {
      await _extractElementSourceInfo(cls, 'class');
    }
    for (final enm in _enums) {
      await _extractElementSourceInfo(enm, 'enum');
    }
    for (final mixin in _mixins) {
      await _extractElementSourceInfo(mixin, 'mixin');
    }
    for (final func in _globalFunctions) {
      await _extractElementSourceInfo(func, 'function');
    }
    for (final v in _globalVariables) {
      await _extractElementSourceInfo(v, 'variable');
    }
  }

  /// Extract source info for a single element.
  Future<void> _extractElementSourceInfo(Element element, String kind) async {
    final source = element.firstFragment.libraryFragment?.source;
    if (source == null) return;

    final path = source.fullName;
    var unitResult = _resolvedUnits[path];

    // If we don't have the resolved unit, try to get it
    if (unitResult == null && _analysisCollection != null) {
      try {
        final context = _analysisCollection!.contextFor(path);
        final result = await context.currentSession.getResolvedUnit(path);
        if (result is ResolvedUnitResult) {
          unitResult = result;
          _resolvedUnits[path] = result;
          if (config.sourceExtractionConfig.storeFileContents) {
            _sourceInfoCollection?.registerSource(
              result.uri.toString(),
              result.content,
            );
          }
        }
      } catch (_) {
        // File might not be in the analysis context
        return;
      }
    }

    if (unitResult == null) return;

    // Find the AST node for this element
    final node = _findDeclarationNode(unitResult.unit, element);
    if (node == null) return;

    // Extract source info
    final sourceInfo = _sourceInfoExtractor!.extractFromDeclaration(
      node,
      source.uri.toString(),
      unitResult.content,
    );

    if (sourceInfo != null) {
      final qualifiedName = _getQualifiedName(element);
      _sourceInfoCollection!.add(qualifiedName, sourceInfo);
    }
  }

  /// Find the AST declaration node for an element.
  Declaration? _findDeclarationNode(CompilationUnit unit, Element element) {
    final name = element.name;
    if (name == null) return null;

    for (final decl in unit.declarations) {
      if (decl is ClassDeclaration && decl.name.lexeme == name) {
        return decl;
      }
      if (decl is EnumDeclaration && decl.name.lexeme == name) {
        return decl;
      }
      if (decl is MixinDeclaration && decl.name.lexeme == name) {
        return decl;
      }
      if (decl is FunctionDeclaration && decl.name.lexeme == name) {
        return decl;
      }
      if (decl is TopLevelVariableDeclaration) {
        for (final variable in decl.variables.variables) {
          if (variable.name.lexeme == name) {
            return decl;
          }
        }
      }
      if (decl is ExtensionDeclaration && decl.name?.lexeme == name) {
        return decl;
      }
      if (decl is ExtensionTypeDeclaration && decl.name.lexeme == name) {
        return decl;
      }
      if (decl is TypeAlias && decl.name.lexeme == name) {
        return decl;
      }
    }
    return null;
  }

  /// Get qualified name for an element.
  String _getQualifiedName(Element element) {
    final library = element.library;
    final libraryUri = library?.firstFragment.source.uri.toString() ?? 'unknown';
    return '$libraryUri#${element.name}';
  }

  void _addClass(ClassElement cls, String libraryUri) {
    if (_classes.any((c) => c.name == cls.name && c.library == cls.library)) {
      return;
    }
    _classes.add(cls);
    _libraryTypes.putIfAbsent(libraryUri, () => []).add(cls);
    _pendingDependencies.add(cls);
  }

  void _addEnum(EnumElement enm, String libraryUri) {
    if (_enums.any((e) => e.name == enm.name && e.library == enm.library)) {
      return;
    }
    _enums.add(enm);
    _libraryTypes.putIfAbsent(libraryUri, () => []).add(enm);
    _pendingDependencies.add(enm);
  }

  void _addMixin(MixinElement mixin, String libraryUri) {
    if (_mixins.any((m) => m.name == mixin.name && m.library == mixin.library)) {
      return;
    }
    _mixins.add(mixin);
    _libraryTypes.putIfAbsent(libraryUri, () => []).add(mixin);
    _pendingDependencies.add(mixin);
  }

  void _addExtensionType(ExtensionTypeElement extType, String libraryUri) {
    if (_extensionTypes
        .any((e) => e.name == extType.name && e.library == extType.library)) {
      return;
    }
    _extensionTypes.add(extType);
    _libraryTypes.putIfAbsent(libraryUri, () => []).add(extType);
    _pendingDependencies.add(extType);
  }

  void _addExtension(ExtensionElement ext) {
    if (_extensions.any((e) => e.name == ext.name && e.library == ext.library)) {
      return;
    }
    _extensions.add(ext);
  }

  void _addTypeAlias(TypeAliasElement alias) {
    if (_typeAliases
        .any((a) => a.name == alias.name && a.library == alias.library)) {
      return;
    }
    _typeAliases.add(alias);
  }

  void _addGlobalFunction(TopLevelFunctionElement func) {
    if (_globalFunctions
        .any((f) => f.name == func.name && f.library == func.library)) {
      return;
    }
    _globalFunctions.add(func);
  }

  void _addGlobalVariable(TopLevelVariableElement variable) {
    if (_globalVariables
        .any((v) => v.name == variable.name && v.library == variable.library)) {
      return;
    }
    _globalVariables.add(variable);
  }

  Future<void> _resolveDependencies() async {
    final depConfig = config.dependencyConfig;
    final processed = <InterfaceElement>{};

    while (_pendingDependencies.isNotEmpty) {
      final current = _pendingDependencies.first;
      _pendingDependencies.remove(current);

      if (processed.contains(current)) continue;
      processed.add(current);

      // Process superclasses
      if (depConfig.superclasses.enabled && current is ClassElement) {
        _processSuperclasses(current);
      }

      // Process interfaces
      if (depConfig.interfaces.enabled) {
        _processInterfaces(current);
      }

      // Process mixins
      if (depConfig.mixins.enabled && current is ClassElement) {
        _processMixins(current);
      }

      // Process type arguments
      if (depConfig.typeArguments.enabled) {
        _processTypeArguments(current);
      }

      // Process annotations
      if (depConfig.typeAnnotations.enabled) {
        _processAnnotations(current);
      }
    }

    // Scan for marker annotations if configured
    if (depConfig.markerAnnotations.enabled &&
        _discoveredAnnotations.isNotEmpty) {
      await _scanForMarkerAnnotations();
    }
  }

  /// Process annotations on an element to discover annotation types.
  void _processAnnotations(Element element) {
    // Prevent infinite recursion
    if (_processedAnnotationElements.contains(element)) return;
    _processedAnnotationElements.add(element);

    final depConfig = config.dependencyConfig.typeAnnotations;
    final currentPackage = _getPackageName(element);

    for (final annotation in element.metadata.annotations) {
      final annotationElement = annotation.element;
      if (annotationElement == null) continue;

      // Get the annotation type
      Element? typeElement;
      if (annotationElement is ConstructorElement) {
        typeElement = annotationElement.enclosingElement;
      } else if (annotationElement is PropertyAccessorElement) {
        // Const variable annotation like @tomReflection
        // In analyzer 8.x, use variable3 (nullable) instead of variable2
        final variable = annotationElement.variable3;
        if (variable != null) {
          final varType = variable.type;
          if (varType is InterfaceType) {
            typeElement = varType.element;
          }
        }
      }

      if (typeElement == null) continue;

      // Check if external
      final annotationPackage = _getPackageName(typeElement);
      final isExternal = annotationPackage != currentPackage;

      if (isExternal && !depConfig.external) continue;

      // Add the annotation type
      if (typeElement is ClassElement) {
        final uri = typeElement.library.firstFragment.source.uri.toString();
        _addClass(typeElement, uri);

        // Track for marker scanning
        final markerConfig = config.dependencyConfig.markerAnnotations;
        if (markerConfig.enabled) {
          final typeName = typeElement.name;
          if (typeName != null) {
            _discoveredAnnotations.add(typeName);
          }

          // Also check if this annotation references other marker annotations
          if (markerConfig.followAnnotationChains) {
            _processAnnotations(typeElement);
          }
        }
      }

      // Process annotation arguments for type references
      if (depConfig.includeArgumentTypes) {
        _processAnnotationArguments(annotation, currentPackage);
      }

      // Process transitive annotations
      if (depConfig.transitive && typeElement is ClassElement) {
        _processAnnotations(typeElement);
      }
    }
  }

  /// Process annotation arguments to find type references.
  void _processAnnotationArguments(
      ElementAnnotation annotation, String? currentPackage) {
    final depConfig = config.dependencyConfig.typeAnnotations;

    // Get the annotation value
    final value = annotation.computeConstantValue();
    if (value == null) return;

    // Check for Type arguments
    final type = value.type;
    if (type is InterfaceType) {
      // Look through fields for Type values
      for (final field in type.element.fields) {
        if (field.type.isDartCoreType) {
          // This field holds a Type - try to get the actual type
          final fieldName = field.name;
          if (fieldName != null) {
            final fieldValue = value.getField(fieldName);
            if (fieldValue != null) {
              final typeValue = fieldValue.toTypeValue();
              if (typeValue is InterfaceType) {
                final element = typeValue.element;
                final isExternal = _getPackageName(element) != currentPackage;
                if (!isExternal || depConfig.external) {
                  if (element is ClassElement) {
                    final uri = element.library.firstFragment.source.uri.toString();
                    _addClass(element, uri);
                  } else if (element is EnumElement) {
                    final uri = element.library.firstFragment.source.uri.toString();
                    _addEnum(element, uri);
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  /// Scan for all types marked with discovered marker annotations.
  Future<void> _scanForMarkerAnnotations() async {
    final markerConfig = config.dependencyConfig.markerAnnotations;

    // Determine which annotations are markers
    final markersToScan = <String>{};
    for (final annName in _discoveredAnnotations) {
      if (markerConfig.markerAnnotations.isEmpty ||
          markerConfig.markerAnnotations.contains(annName)) {
        markersToScan.add(annName);
      }
    }

    if (markersToScan.isEmpty) return;

    // Scan libraries we've already visited for types with these annotations
    if (_analysisCollection != null) {
      for (final libUri in _visitedLibraries) {
        if (_markerScannedLibraries.contains(libUri)) continue;
        _markerScannedLibraries.add(libUri);

        // Re-process library looking for marked types
        // This is handled implicitly since we process all types
      }
    }
  }

  void _processSuperclasses(ClassElement cls) {
    final depConfig = config.dependencyConfig.superclasses;
    final excludeTypes = depConfig.excludeTypes.toSet();

    var depth = 0;
    var externalDepth = 0;
    var current = cls.supertype?.element;
    final currentPackage = _getPackageName(cls);

    while (current != null) {
      // Check depth limits
      if (depConfig.depth >= 0 && depth >= depConfig.depth) break;

      final superPackage = _getPackageName(current);
      final isExternal = superPackage != currentPackage;

      if (isExternal) {
        externalDepth++;
        if (depConfig.externalDepth >= 0 &&
            externalDepth > depConfig.externalDepth) {
          break;
        }
      }

      // Check exclude types
      if (excludeTypes.contains(current.name)) break;

      // Add the superclass
      if (current is ClassElement) {
        final uri = current.library.firstFragment.source.uri.toString();
        _addClass(current, uri);
      }

      depth++;
      current = (current as ClassElement?)?.supertype?.element;
    }
  }

  void _processInterfaces(InterfaceElement element) {
    final depConfig = config.dependencyConfig.interfaces;
    final currentPackage = _getPackageName(element);

    for (final interface in element.interfaces) {
      final interfaceElement = interface.element;

      // Check if external
      final interfacePackage = _getPackageName(interfaceElement);
      final isExternal = interfacePackage != currentPackage;

      if (isExternal && !depConfig.external) continue;

      // Add interface
      if (interfaceElement is ClassElement) {
        final uri = interfaceElement.library.firstFragment.source.uri.toString();
        _addClass(interfaceElement, uri);
      }
    }
  }

  void _processMixins(ClassElement cls) {
    final depConfig = config.dependencyConfig.mixins;
    final currentPackage = _getPackageName(cls);

    for (final mixin in cls.mixins) {
      final mixinElement = mixin.element;

      // Check if external
      final mixinPackage = _getPackageName(mixinElement);
      final isExternal = mixinPackage != currentPackage;

      if (isExternal && !depConfig.external) continue;

      // Add mixin
      if (mixinElement is MixinElement) {
        final uri = mixinElement.library.firstFragment.source.uri.toString();
        _addMixin(mixinElement, uri);
      }
    }
  }

  void _processTypeArguments(InterfaceElement element) {
    final depConfig = config.dependencyConfig.typeArguments;
    final currentPackage = _getPackageName(element);

    // Process fields
    for (final field in element.fields) {
      _processTypeForArguments(field.type, currentPackage, depConfig.external);
    }

    // Process methods
    for (final method in element.methods) {
      _processTypeForArguments(
          method.returnType, currentPackage, depConfig.external);
      for (final param in method.formalParameters) {
        _processTypeForArguments(
            param.type, currentPackage, depConfig.external);
      }
    }
  }

  void _processTypeForArguments(
      DartType type, String? currentPackage, bool includeExternal) {
    if (type is InterfaceType) {
      // Check if external
      final typePackage = _getPackageName(type.element);
      final isExternal = typePackage != currentPackage;

      if (!isExternal || includeExternal) {
        final element = type.element;
        if (element is ClassElement) {
          final uri = element.library.firstFragment.source.uri.toString();
          _addClass(element, uri);
        } else if (element is EnumElement) {
          final uri = element.library.firstFragment.source.uri.toString();
          _addEnum(element, uri);
        }
      }

      // Process type arguments recursively
      for (final typeArg in type.typeArguments) {
        _processTypeForArguments(typeArg, currentPackage, includeExternal);
      }
    }
  }

  bool _shouldInclude(Element element) {
    // Check private
    if (!config.includePrivate && (element.name?.startsWith('_') ?? false)) {
      return false;
    }

    // Check inclusion resolver
    final result = _inclusionResolver.shouldInclude(element);
    if (result != null) return result;

    // Default: include if reachable
    return true;
  }

  bool _shouldIncludeExtension(ExtensionElement ext) {
    // Extensions without names are anonymous and might be less useful
    if (ext.name == null && !config.includePrivate) {
      return false;
    }

    return _shouldInclude(ext);
  }

  String? _getPackageName(Element element) {
    final uri = element.library?.firstFragment.source.uri;
    if (uri == null) return null;
    if (uri.scheme == 'package') {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }
    if (uri.scheme == 'dart') {
      return 'dart:${uri.path}';
    }
    return null;
  }
}
