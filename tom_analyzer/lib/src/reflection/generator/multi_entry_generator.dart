/// Multi-entry-point reflection generator.
///
/// Handles generating reflection for configurations with multiple entry points,
/// either as separate files or as a combined output.
library;

import 'dart:io';

import 'package:analyzer/dart/element/element.dart';

import 'entry_point_analyzer.dart';
import 'reflection_config.dart';
import 'reflection_generator.dart';

/// Result of multi-entry-point generation.
class MultiEntryResult {
  /// Generated files and their paths.
  final Map<String, String> generatedFiles;

  /// Errors encountered during generation.
  final List<String> errors;

  /// Whether generation was successful.
  bool get isSuccess => errors.isEmpty;

  const MultiEntryResult({
    this.generatedFiles = const {},
    this.errors = const [],
  });
}

/// Generates reflection for multiple entry points.
///
/// Behavior depends on configuration:
/// - If `output` is specified: merges all entry points into one file
/// - If `output` is null: generates separate .r.dart for each entry point
class MultiEntryGenerator {
  /// The configuration.
  final ReflectionConfig config;

  MultiEntryGenerator(this.config);

  /// Create from a configuration file.
  factory MultiEntryGenerator.fromFile(String path) {
    return MultiEntryGenerator(ReflectionConfig.load(path: path));
  }

  /// Detect if this configuration has multiple entry points.
  bool get hasMultipleEntryPoints => config.hasMultipleEntryPoints;

  /// Check if output should be combined or separate.
  bool get shouldCombineOutput => config.shouldCombineOutput;

  /// Generate reflection for all entry points.
  ///
  /// Returns a [MultiEntryResult] with the generated files and any errors.
  Future<MultiEntryResult> generate() async {
    if (config.entryPoints.isEmpty) {
      return const MultiEntryResult(
        errors: ['No entry points specified in configuration'],
      );
    }

    if (!hasMultipleEntryPoints) {
      // Single entry point - use standard generator
      return _generateSingleEntry();
    }

    if (shouldCombineOutput) {
      // Multiple entry points with explicit output - merge all
      return _generateCombinedOutput();
    } else {
      // Multiple entry points without output - generate separately
      return _generateSeparateOutputs();
    }
  }

  /// Generate for a single entry point.
  Future<MultiEntryResult> _generateSingleEntry() async {
    try {
      final generator = ReflectionGenerator(config);
      final code = await generator.generate();
      final outputPath = config.getOutputPath();

      return MultiEntryResult(
        generatedFiles: {outputPath: code},
      );
    } catch (e) {
      return MultiEntryResult(
        errors: ['Failed to generate: $e'],
      );
    }
  }

  /// Generate separate .r.dart files for each entry point.
  Future<MultiEntryResult> _generateSeparateOutputs() async {
    final generatedFiles = <String, String>{};
    final errors = <String>[];

    for (final entryPoint in config.entryPoints) {
      try {
        // Create a config for just this entry point
        final singleConfig = ReflectionConfig(
          entryPoints: [entryPoint],
          output: null, // Each gets its own output based on entry name
          defaults: config.defaults,
          filters: config.filters,
          dependencyConfig: config.dependencyConfig,
          coverageConfig: config.coverageConfig,
          includePrivate: config.includePrivate,
          raw: config.raw,
        );

        final generator = ReflectionGenerator(singleConfig);
        final code = await generator.generate();
        final outputPath = config.getOutputPathFor(entryPoint);

        generatedFiles[outputPath] = code;
      } catch (e) {
        errors.add('Failed to generate for $entryPoint: $e');
      }
    }

    return MultiEntryResult(
      generatedFiles: generatedFiles,
      errors: errors,
    );
  }

  /// Generate a combined output from all entry points.
  Future<MultiEntryResult> _generateCombinedOutput() async {
    try {
      // Analyze all entry points
      final allResults = <ReflectionAnalysisResult>[];

      for (final entryPoint in config.entryPoints) {
        final singleConfig = ReflectionConfig(
          entryPoints: [entryPoint],
          output: null,
          defaults: config.defaults,
          filters: config.filters,
          dependencyConfig: config.dependencyConfig,
          coverageConfig: config.coverageConfig,
          includePrivate: config.includePrivate,
          raw: config.raw,
        );

        final analyzer = EntryPointAnalyzer(singleConfig);
        final result = await analyzer.analyze();
        allResults.add(result);
      }

      // Merge all results into one
      final mergedResult = _mergeResults(allResults);

      // Generate from merged result
      final generator = ReflectionGenerator(config);
      // We need to set the analysis result directly
      final code = await generator.generateFromResult(mergedResult);
      final outputPath = config.getOutputPath();

      return MultiEntryResult(
        generatedFiles: {outputPath: code},
      );
    } catch (e) {
      return MultiEntryResult(
        errors: ['Failed to generate combined output: $e'],
      );
    }
  }

  /// Merge multiple analysis results into one.
  ReflectionAnalysisResult _mergeResults(List<ReflectionAnalysisResult> results) {
    // Use sets to deduplicate
    final classes = <ClassElement>{};
    final enums = <EnumElement>{};
    final mixins = <MixinElement>{};
    final extensionTypes = <ExtensionTypeElement>{};
    final extensions = <ExtensionElement>{};
    final typeAliases = <TypeAliasElement>{};
    final globalFunctions = <TopLevelFunctionElement>{};
    final globalVariables = <TopLevelVariableElement>{};
    final packageLibraries = <String, Set<String>>{};
    final libraryTypes = <String, Set<InterfaceElement>>{};

    for (final result in results) {
      classes.addAll(result.classes);
      enums.addAll(result.enums);
      mixins.addAll(result.mixins);
      extensionTypes.addAll(result.extensionTypes);
      extensions.addAll(result.extensions);
      typeAliases.addAll(result.typeAliases);
      globalFunctions.addAll(result.globalFunctions);
      globalVariables.addAll(result.globalVariables);

      for (final entry in result.packageLibraries.entries) {
        packageLibraries.putIfAbsent(entry.key, () => <String>{}).addAll(entry.value);
      }

      for (final entry in result.libraryTypes.entries) {
        libraryTypes.putIfAbsent(entry.key, () => <InterfaceElement>{}).addAll(entry.value);
      }
    }

    return ReflectionAnalysisResult(
      classes: classes.toList(),
      enums: enums.toList(),
      mixins: mixins.toList(),
      extensionTypes: extensionTypes.toList(),
      extensions: extensions.toList(),
      typeAliases: typeAliases.toList(),
      globalFunctions: globalFunctions.toList(),
      globalVariables: globalVariables.toList(),
      packageLibraries: packageLibraries.map((k, v) => MapEntry(k, v.toList())),
      libraryTypes: libraryTypes.map((k, v) => MapEntry(k, v.toList())),
    );
  }

  /// Generate and write all files to disk.
  Future<MultiEntryResult> generateToFiles() async {
    final result = await generate();

    if (!result.isSuccess) {
      return result;
    }

    for (final entry in result.generatedFiles.entries) {
      final file = File(entry.key);
      final dir = file.parent;
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
      file.writeAsStringSync(entry.value);
    }

    return result;
  }
}
