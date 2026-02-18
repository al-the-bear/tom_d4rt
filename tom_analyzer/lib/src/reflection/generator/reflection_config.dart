/// Reflection generator configuration.
///
/// Parses `tom_analyzer.yaml` or build.yaml configuration for reflection
/// generation. Supports entry points, output paths, filters, dependency
/// configuration, and coverage configuration.
library;

import 'dart:io';

import 'package:yaml/yaml.dart';

/// Configuration for reflection generation.
///
/// This class represents the complete configuration for the reflection
/// generator, parsed from `tom_analyzer.yaml` or `build.yaml`.
class ReflectionConfig {
  /// Entry point files for analysis.
  ///
  /// These are the starting points for reachability analysis. All types
  /// reachable from these files are candidates for reflection.
  final List<String> entryPoints;

  /// Output file path (without .r.dart extension).
  ///
  /// The generator will add `.r.dart` automatically. If null, defaults
  /// to the first entry point path with `.dart` replaced.
  final String? output;

  /// Default settings applied before filters.
  final ReflectionDefaults defaults;

  /// Filters to apply in order.
  final List<ReflectionFilter> filters;

  /// Configuration for transitive dependency inclusion.
  final DependencyConfig dependencyConfig;

  /// Configuration for coverage (what invokers to generate).
  final CoverageConfig coverageConfig;

  /// Configuration for source code extraction (optional, memory-intensive).
  final SourceExtractionConfig sourceExtractionConfig;

  /// Whether to include private members (default: false).
  final bool includePrivate;

  /// Raw configuration map (for extensions).
  final Map<String, dynamic> raw;

  const ReflectionConfig({
    this.entryPoints = const [],
    this.output,
    this.defaults = const ReflectionDefaults(),
    this.filters = const [],
    this.dependencyConfig = const DependencyConfig(),
    this.coverageConfig = const CoverageConfig(),
    this.sourceExtractionConfig = const SourceExtractionConfig(),
    this.includePrivate = false,
    this.raw = const {},
  });

  /// Load configuration from a file path.
  ///
  /// If [path] is null, looks for `tom_analyzer.yaml` in the current directory.
  static ReflectionConfig load({String? path}) {
    final configPath = path ?? _defaultConfigPath();
    if (configPath == null) {
      return const ReflectionConfig();
    }
    final file = File(configPath);
    if (!file.existsSync()) {
      return const ReflectionConfig();
    }
    final yaml = loadYaml(file.readAsStringSync());
    if (yaml is! YamlMap) {
      return const ReflectionConfig();
    }
    return fromMap(Map<String, dynamic>.from(yaml));
  }

  /// Parse configuration from a map (YAML content).
  static ReflectionConfig fromMap(Map<String, dynamic> map) {
    final entryPoints = _readStringList(map['entry_points']);
    final output = _readString(map['output']);

    // Parse defaults
    final defaultsMap = map['defaults'];
    final defaults = defaultsMap is Map<String, dynamic>
        ? ReflectionDefaults.fromMap(defaultsMap)
        : const ReflectionDefaults();

    // Parse filters
    final filtersList = map['filters'];
    final filters = <ReflectionFilter>[];
    if (filtersList is List) {
      for (final item in filtersList) {
        if (item is Map<String, dynamic>) {
          filters.add(ReflectionFilter.fromMap(item));
        }
      }
    }

    // Parse dependency_config
    final depMap = map['dependency_config'];
    final dependencyConfig = depMap is Map<String, dynamic>
        ? DependencyConfig.fromMap(depMap)
        : const DependencyConfig();

    // Parse coverage_config
    final covMap = map['coverage_config'];
    final coverageConfig = covMap is Map<String, dynamic>
        ? CoverageConfig.fromMap(covMap)
        : const CoverageConfig();

    // Parse source_extraction_config
    final sourceMap = map['source_extraction'];
    final sourceExtractionConfig = sourceMap is Map<String, dynamic>
        ? SourceExtractionConfig.fromMap(sourceMap)
        : const SourceExtractionConfig();

    final includePrivate = map['include_private'] == true;

    return ReflectionConfig(
      entryPoints: entryPoints,
      output: output,
      defaults: defaults,
      filters: filters,
      dependencyConfig: dependencyConfig,
      coverageConfig: coverageConfig,
      sourceExtractionConfig: sourceExtractionConfig,
      includePrivate: includePrivate,
      raw: map,
    );
  }

  /// Get the output file path with .r.dart extension.
  String getOutputPath() {
    if (output != null) {
      return output!.endsWith('.r.dart') ? output! : '$output.r.dart';
    }
    if (entryPoints.isNotEmpty) {
      final first = entryPoints.first;
      if (first.endsWith('.dart')) {
        return '${first.substring(0, first.length - 5)}.r.dart';
      }
      return '$first.r.dart';
    }
    return 'reflection.r.dart';
  }

  /// Get the output path for a specific entry point (for multi-entry-point mode).
  String getOutputPathFor(String entryPoint) {
    if (entryPoint.endsWith('.dart')) {
      return '${entryPoint.substring(0, entryPoint.length - 5)}.r.dart';
    }
    return '$entryPoint.r.dart';
  }

  /// Whether this config has multiple entry points.
  bool get hasMultipleEntryPoints => entryPoints.length > 1;

  /// Whether to generate combined output (when output is explicitly specified).
  ///
  /// - If `output` is set: all entry points merge into one file
  /// - If `output` is null: each entry point gets its own .r.dart file
  bool get shouldCombineOutput => output != null && hasMultipleEntryPoints;

  static String? _defaultConfigPath() {
    final file = File('tom_analyzer.yaml');
    if (file.existsSync()) {
      return file.path;
    }
    return null;
  }
}

/// Default settings applied before filters.
class ReflectionDefaults {
  /// Packages to always exclude (glob patterns).
  final List<String> excludePackages;

  /// Packages to always include (glob patterns).
  final List<String> includePackages;

  /// Annotations that trigger automatic inclusion.
  final List<String> includeAnnotations;

  const ReflectionDefaults({
    this.excludePackages = const [],
    this.includePackages = const [],
    this.includeAnnotations = const [],
  });

  static ReflectionDefaults fromMap(Map<String, dynamic> map) {
    return ReflectionDefaults(
      excludePackages: _readStringList(map['exclude_packages']),
      includePackages: _readStringList(map['include_packages']),
      includeAnnotations: _readStringList(map['include_annotations']),
    );
  }
}

/// A single include or exclude filter.
class ReflectionFilter {
  /// Whether this is an include filter (true) or exclude filter (false).
  final bool isInclude;

  /// Package patterns to match (glob syntax).
  final List<String> packages;

  /// Annotation patterns to match.
  final List<String> annotations;

  /// File path patterns to match (glob syntax).
  final List<String> paths;

  /// Type name patterns to match (glob syntax).
  final List<String> types;

  /// Individual element identifiers.
  final List<String> elements;

  const ReflectionFilter({
    required this.isInclude,
    this.packages = const [],
    this.annotations = const [],
    this.paths = const [],
    this.types = const [],
    this.elements = const [],
  });

  static ReflectionFilter fromMap(Map<String, dynamic> map) {
    final includeMap = map['include'];
    final excludeMap = map['exclude'];

    if (includeMap is Map<String, dynamic>) {
      return ReflectionFilter._fromSelectorMap(includeMap, isInclude: true);
    }
    if (excludeMap is Map<String, dynamic>) {
      return ReflectionFilter._fromSelectorMap(excludeMap, isInclude: false);
    }
    // Handle 'include: reachable' shorthand
    if (map['include'] == 'reachable') {
      return const ReflectionFilter(isInclude: true);
    }
    return const ReflectionFilter(isInclude: true);
  }

  static ReflectionFilter _fromSelectorMap(
    Map<String, dynamic> map, {
    required bool isInclude,
  }) {
    return ReflectionFilter(
      isInclude: isInclude,
      packages: _readStringList(map['packages']),
      annotations: _readStringList(map['annotations']),
      paths: _readStringList(map['paths']),
      types: _readStringList(map['types']),
      elements: _readStringList(map['elements']),
    );
  }

  /// Check if this filter has any selectors.
  bool get hasSelectors =>
      packages.isNotEmpty ||
      annotations.isNotEmpty ||
      paths.isNotEmpty ||
      types.isNotEmpty ||
      elements.isNotEmpty;
}

/// Configuration for transitive dependency inclusion.
class DependencyConfig {
  /// Superclass inclusion settings.
  final SuperclassConfig superclasses;

  /// Interface inclusion settings.
  final InterfaceConfig interfaces;

  /// Mixin inclusion settings.
  final MixinConfig mixins;

  /// Type argument inclusion settings.
  final TypeArgumentConfig typeArguments;

  /// Type annotation inclusion settings.
  final TypeAnnotationConfig typeAnnotations;

  /// Subtype inclusion settings.
  final SubtypeConfig subtypes;

  /// Code body analysis settings.
  final CodeBodyConfig codeBodies;

  /// Marker annotation scanning settings.
  final MarkerAnnotationConfig markerAnnotations;

  const DependencyConfig({
    this.superclasses = const SuperclassConfig(),
    this.interfaces = const InterfaceConfig(),
    this.mixins = const MixinConfig(),
    this.typeArguments = const TypeArgumentConfig(),
    this.typeAnnotations = const TypeAnnotationConfig(),
    this.subtypes = const SubtypeConfig(),
    this.codeBodies = const CodeBodyConfig(),
    this.markerAnnotations = const MarkerAnnotationConfig(),
  });

  static DependencyConfig fromMap(Map<String, dynamic> map) {
    final superMap = map['superclasses'];
    final intfMap = map['interfaces'];
    final mixMap = map['mixins'];
    final typeArgMap = map['type_arguments'];
    final typeAnnMap = map['type_annotations'];
    final subMap = map['subtypes'];
    final codeMap = map['code_bodies'];
    final markerMap = map['marker_annotations'];

    return DependencyConfig(
      superclasses: superMap is Map<String, dynamic>
          ? SuperclassConfig.fromMap(superMap)
          : const SuperclassConfig(),
      interfaces: intfMap is Map<String, dynamic>
          ? InterfaceConfig.fromMap(intfMap)
          : const InterfaceConfig(),
      mixins: mixMap is Map<String, dynamic>
          ? MixinConfig.fromMap(mixMap)
          : const MixinConfig(),
      typeArguments: typeArgMap is Map<String, dynamic>
          ? TypeArgumentConfig.fromMap(typeArgMap)
          : const TypeArgumentConfig(),
      typeAnnotations: typeAnnMap is Map<String, dynamic>
          ? TypeAnnotationConfig.fromMap(typeAnnMap)
          : const TypeAnnotationConfig(),
      subtypes: subMap is Map<String, dynamic>
          ? SubtypeConfig.fromMap(subMap)
          : const SubtypeConfig(),
      codeBodies: codeMap is Map<String, dynamic>
          ? CodeBodyConfig.fromMap(codeMap)
          : const CodeBodyConfig(),
      markerAnnotations: markerMap is Map<String, dynamic>
          ? MarkerAnnotationConfig.fromMap(markerMap)
          : const MarkerAnnotationConfig(),
    );
  }
}

/// Superclass chain inclusion configuration.
class SuperclassConfig {
  /// Whether to include superclasses.
  final bool enabled;

  /// Depth limit (-1 = unlimited, 0 = none, N = N levels).
  final int depth;

  /// Max packages deep to follow.
  final int externalDepth;

  /// Types to exclude (stop at these types).
  final List<String> excludeTypes;

  const SuperclassConfig({
    this.enabled = true,
    this.depth = -1,
    this.externalDepth = 2,
    this.excludeTypes = const [],
  });

  static SuperclassConfig fromMap(Map<String, dynamic> map) {
    return SuperclassConfig(
      enabled: map['enabled'] != false,
      depth: _readInt(map['depth']) ?? -1,
      externalDepth: _readInt(map['external_depth']) ?? 2,
      excludeTypes: _readStringList(map['exclude_types']),
    );
  }
}

/// Interface inclusion configuration.
class InterfaceConfig {
  /// Whether to include interfaces.
  final bool enabled;

  /// Whether to include external interfaces.
  final bool external;

  const InterfaceConfig({
    this.enabled = true,
    this.external = true,
  });

  static InterfaceConfig fromMap(Map<String, dynamic> map) {
    return InterfaceConfig(
      enabled: map['enabled'] != false,
      external: map['external'] != false,
    );
  }
}

/// Mixin inclusion configuration.
class MixinConfig {
  /// Whether to include mixins.
  final bool enabled;

  /// Whether to include external mixins.
  final bool external;

  const MixinConfig({
    this.enabled = true,
    this.external = true,
  });

  static MixinConfig fromMap(Map<String, dynamic> map) {
    return MixinConfig(
      enabled: map['enabled'] != false,
      external: map['external'] != false,
    );
  }
}

/// Type argument inclusion configuration.
class TypeArgumentConfig {
  /// Whether to include type arguments.
  final bool enabled;

  /// Whether to include external type arguments.
  final bool external;

  const TypeArgumentConfig({
    this.enabled = true,
    this.external = true,
  });

  static TypeArgumentConfig fromMap(Map<String, dynamic> map) {
    return TypeArgumentConfig(
      enabled: map['enabled'] != false,
      external: map['external'] != false,
    );
  }
}

/// Type annotation inclusion configuration.
class TypeAnnotationConfig {
  /// Whether to include type annotations.
  final bool enabled;

  /// Whether to follow annotations transitively.
  ///
  /// If true, when an annotation type is discovered, also discover
  /// annotations used on that annotation type (meta-annotations).
  final bool transitive;

  /// Whether to include external annotation types.
  final bool external;

  /// Whether to include types referenced in annotation arguments.
  ///
  /// For example: `@MyAnnotation(SomeClass)` would include `SomeClass`.
  final bool includeArgumentTypes;

  /// Whether to scan for all types marked with discovered annotations.
  ///
  /// If true, when a marker annotation like `@tomReflection` is discovered,
  /// the analyzer will scan the codebase for all types using that annotation.
  final bool scanMarkedTypes;

  const TypeAnnotationConfig({
    this.enabled = true,
    this.transitive = false,
    this.external = true,
    this.includeArgumentTypes = true,
    this.scanMarkedTypes = false,
  });

  static TypeAnnotationConfig fromMap(Map<String, dynamic> map) {
    return TypeAnnotationConfig(
      enabled: map['enabled'] != false,
      transitive: map['transitive'] == true,
      external: map['external'] != false,
      includeArgumentTypes: map['include_argument_types'] != false,
      scanMarkedTypes: map['scan_marked_types'] == true,
    );
  }
}

/// Subtype inclusion configuration.
class SubtypeConfig {
  /// Whether to include subtypes of covered classes.
  final bool enabled;

  const SubtypeConfig({
    this.enabled = false,
  });

  static SubtypeConfig fromMap(Map<String, dynamic> map) {
    return SubtypeConfig(
      enabled: map['enabled'] == true,
    );
  }
}

/// Configuration for analyzing code bodies (method/constructor/function bodies).
class CodeBodyConfig {
  /// Whether to analyze code bodies for type references.
  final bool enabled;

  /// Whether to include external types found in code bodies.
  final bool external;

  /// Depth limit for following types in code bodies (-1 = unlimited).
  final int depth;

  /// Whether to include types used in variable declarations.
  final bool includeVariableTypes;

  /// Whether to include types used in constructor/method invocations.
  final bool includeInvocationTypes;

  /// Whether to include types used in type casts and type tests.
  final bool includeTypeOperations;

  const CodeBodyConfig({
    this.enabled = false,
    this.external = true,
    this.depth = 1,
    this.includeVariableTypes = true,
    this.includeInvocationTypes = true,
    this.includeTypeOperations = true,
  });

  static CodeBodyConfig fromMap(Map<String, dynamic> map) {
    return CodeBodyConfig(
      enabled: map['enabled'] == true,
      external: map['external'] != false,
      depth: _readInt(map['depth']) ?? 1,
      includeVariableTypes: map['include_variable_types'] != false,
      includeInvocationTypes: map['include_invocation_types'] != false,
      includeTypeOperations: map['include_type_operations'] != false,
    );
  }
}

/// Configuration for marker annotation scanning.
///
/// This allows discovering all types marked with specific annotations,
/// similar to how dependency injection frameworks work.
class MarkerAnnotationConfig {
  /// Whether marker annotation scanning is enabled.
  final bool enabled;

  /// Annotation names to treat as markers (e.g., 'tomReflection').
  ///
  /// When one of these annotations is discovered (either directly
  /// or transitively), scan the codebase for all types using it.
  final List<String> markerAnnotations;

  /// Package patterns to scan for marked types (glob patterns).
  ///
  /// If empty, only scans packages already in scope.
  final List<String> scanPackages;

  /// Whether to follow annotation chains.
  ///
  /// If true: `@tomReflectionInfo` uses `tomReflection`, so finding
  /// `tomReflectionInfo` also triggers scanning for `tomReflection` markers.
  final bool followAnnotationChains;

  const MarkerAnnotationConfig({
    this.enabled = false,
    this.markerAnnotations = const [],
    this.scanPackages = const [],
    this.followAnnotationChains = true,
  });

  static MarkerAnnotationConfig fromMap(Map<String, dynamic> map) {
    return MarkerAnnotationConfig(
      enabled: map['enabled'] == true,
      markerAnnotations: _readStringList(map['marker_annotations']),
      scanPackages: _readStringList(map['scan_packages']),
      followAnnotationChains: map['follow_annotation_chains'] != false,
    );
  }
}

/// Configuration for coverage (what invokers to generate).
class CoverageConfig {
  /// Instance member coverage.
  final MemberCoverageConfig instanceMembers;

  /// Static member coverage.
  final StaticCoverageConfig staticMembers;

  /// Constructor coverage.
  final ConstructorCoverageConfig constructors;

  /// Top-level member coverage.
  final TopLevelCoverageConfig topLevel;

  /// Metadata coverage.
  final MetadataCoverageConfig metadata;

  /// Type information coverage.
  final TypeInfoCoverageConfig typeInfo;

  /// Declaration coverage.
  final DeclarationCoverageConfig declarations;

  const CoverageConfig({
    this.instanceMembers = const MemberCoverageConfig(),
    this.staticMembers = const StaticCoverageConfig(),
    this.constructors = const ConstructorCoverageConfig(),
    this.topLevel = const TopLevelCoverageConfig(),
    this.metadata = const MetadataCoverageConfig(),
    this.typeInfo = const TypeInfoCoverageConfig(),
    this.declarations = const DeclarationCoverageConfig(),
  });

  static CoverageConfig fromMap(Map<String, dynamic> map) {
    final instMap = map['instance_members'];
    final staticMap = map['static_members'];
    final constMap = map['constructors'];
    final topMap = map['top_level'];
    final metaMap = map['metadata'];
    final typeMap = map['type_info'];
    final declMap = map['declarations'];

    return CoverageConfig(
      instanceMembers: instMap is Map<String, dynamic>
          ? MemberCoverageConfig.fromMap(instMap)
          : const MemberCoverageConfig(),
      staticMembers: staticMap is Map<String, dynamic>
          ? StaticCoverageConfig.fromMap(staticMap)
          : const StaticCoverageConfig(),
      constructors: constMap is Map<String, dynamic>
          ? ConstructorCoverageConfig.fromMap(constMap)
          : const ConstructorCoverageConfig(),
      topLevel: topMap is Map<String, dynamic>
          ? TopLevelCoverageConfig.fromMap(topMap)
          : const TopLevelCoverageConfig(),
      metadata: metaMap is Map<String, dynamic>
          ? MetadataCoverageConfig.fromMap(metaMap)
          : const MetadataCoverageConfig(),
      typeInfo: typeMap is Map<String, dynamic>
          ? TypeInfoCoverageConfig.fromMap(typeMap)
          : const TypeInfoCoverageConfig(),
      declarations: declMap is Map<String, dynamic>
          ? DeclarationCoverageConfig.fromMap(declMap)
          : const DeclarationCoverageConfig(),
    );
  }
}

/// Instance member coverage configuration.
class MemberCoverageConfig {
  /// Whether to generate invokers for instance members.
  final bool enabled;

  /// Glob pattern for member names (empty = all).
  final String? pattern;

  /// Only members with these annotations.
  final List<String> annotations;

  /// Whether to exclude inherited members.
  final bool excludeInherited;

  const MemberCoverageConfig({
    this.enabled = true,
    this.pattern,
    this.annotations = const [],
    this.excludeInherited = false,
  });

  static MemberCoverageConfig fromMap(Map<String, dynamic> map) {
    return MemberCoverageConfig(
      enabled: map['enabled'] != false,
      pattern: _readString(map['pattern']),
      annotations: _readStringList(map['annotations']),
      excludeInherited: map['exclude_inherited'] == true,
    );
  }
}

/// Static member coverage configuration.
class StaticCoverageConfig {
  /// Whether to generate invokers for static members.
  final bool enabled;

  const StaticCoverageConfig({
    this.enabled = true,
  });

  static StaticCoverageConfig fromMap(Map<String, dynamic> map) {
    return StaticCoverageConfig(
      enabled: map['enabled'] != false,
    );
  }
}

/// Constructor coverage configuration.
class ConstructorCoverageConfig {
  /// Whether to generate invokers for constructors.
  final bool enabled;

  /// Glob pattern for constructor names.
  final String? pattern;

  /// Whether to include unnamed constructor.
  final bool unnamed;

  const ConstructorCoverageConfig({
    this.enabled = true,
    this.pattern,
    this.unnamed = true,
  });

  static ConstructorCoverageConfig fromMap(Map<String, dynamic> map) {
    return ConstructorCoverageConfig(
      enabled: map['enabled'] != false,
      pattern: _readString(map['pattern']),
      unnamed: map['unnamed'] != false,
    );
  }
}

/// Top-level member coverage configuration.
class TopLevelCoverageConfig {
  /// Whether to generate invokers for top-level members.
  final bool enabled;

  const TopLevelCoverageConfig({
    this.enabled = true,
  });

  static TopLevelCoverageConfig fromMap(Map<String, dynamic> map) {
    return TopLevelCoverageConfig(
      enabled: map['enabled'] != false,
    );
  }
}

/// Metadata coverage configuration.
class MetadataCoverageConfig {
  /// Whether to include metadata in reflection output.
  final bool enabled;

  const MetadataCoverageConfig({
    this.enabled = true,
  });

  static MetadataCoverageConfig fromMap(Map<String, dynamic> map) {
    return MetadataCoverageConfig(
      enabled: map['enabled'] != false,
    );
  }
}

/// Type information coverage configuration.
class TypeInfoCoverageConfig {
  /// Whether to include type mirrors.
  final bool enabled;

  /// Whether to include type relationships.
  final bool relations;

  /// Whether to support reflectedType property.
  final bool reflectedType;

  const TypeInfoCoverageConfig({
    this.enabled = true,
    this.relations = true,
    this.reflectedType = true,
  });

  static TypeInfoCoverageConfig fromMap(Map<String, dynamic> map) {
    return TypeInfoCoverageConfig(
      enabled: map['enabled'] != false,
      relations: map['relations'] != false,
      reflectedType: map['reflected_type'] != false,
    );
  }
}

/// Declaration coverage configuration.
class DeclarationCoverageConfig {
  /// Whether to include declaration lists.
  final bool enabled;

  /// Whether to include parameter info.
  final bool parameters;

  /// Whether to include default values (expensive).
  final bool defaultValues;

  const DeclarationCoverageConfig({
    this.enabled = true,
    this.parameters = true,
    this.defaultValues = false,
  });

  static DeclarationCoverageConfig fromMap(Map<String, dynamic> map) {
    return DeclarationCoverageConfig(
      enabled: map['enabled'] != false,
      parameters: map['parameters'] != false,
      defaultValues: map['default_values'] == true,
    );
  }
}

/// Source extraction configuration.
///
/// Controls whether and how source code, comments, and AST information
/// are extracted during analysis. This is memory-intensive and optional.
class SourceExtractionConfig {
  /// Whether source extraction is enabled.
  final bool enabled;

  /// Whether to include full source code of declarations.
  final bool includeSourceCode;

  /// Whether to include documentation comments.
  final bool includeDocComments;

  /// Whether to include all comments (including inline).
  final bool includeAllComments;

  /// Whether to include line/column information.
  final bool includeLineInfo;

  /// Maximum source code length per declaration (0 = unlimited).
  final int maxSourceLength;

  /// Whether to store file source contents (for regeneration).
  final bool storeFileContents;

  const SourceExtractionConfig({
    this.enabled = false,
    this.includeSourceCode = false,
    this.includeDocComments = true,
    this.includeAllComments = false,
    this.includeLineInfo = true,
    this.maxSourceLength = 0,
    this.storeFileContents = false,
  });

  /// No source extraction (default, fastest).
  static const disabled = SourceExtractionConfig(enabled: false);

  /// Documentation comments only (minimal memory).
  static const docOnly = SourceExtractionConfig(
    enabled: true,
    includeDocComments: true,
    includeLineInfo: true,
  );

  /// Full source extraction (most memory).
  static const full = SourceExtractionConfig(
    enabled: true,
    includeSourceCode: true,
    includeDocComments: true,
    includeAllComments: true,
    includeLineInfo: true,
    storeFileContents: true,
  );

  static SourceExtractionConfig fromMap(Map<String, dynamic> map) {
    return SourceExtractionConfig(
      enabled: map['enabled'] == true,
      includeSourceCode: map['include_source_code'] == true,
      includeDocComments: map['include_doc_comments'] != false,
      includeAllComments: map['include_all_comments'] == true,
      includeLineInfo: map['include_line_info'] != false,
      maxSourceLength: _readInt(map['max_source_length']) ?? 0,
      storeFileContents: map['store_file_contents'] == true,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Helper functions
// ═══════════════════════════════════════════════════════════════════

String? _readString(Object? value) {
  return value is String ? value : null;
}

int? _readInt(Object? value) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}

List<String> _readStringList(Object? value) {
  if (value == null) return const [];
  if (value is List) return value.whereType<String>().toList();
  if (value is String) return [value];
  return const [];
}
