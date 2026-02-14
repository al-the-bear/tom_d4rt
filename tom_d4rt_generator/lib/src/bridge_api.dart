/// Public API for D4rt Bridge Generation
///
/// Provides a simple API for programmatic bridge generation.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

import 'bridge_config.dart';
import 'bridge_generator.dart';
import 'build_config_loader.dart';
import 'd4rtgen_logging.dart';
import 'file_generators.dart';

/// Result of a bridge generation operation.
class GenerationResult {
  /// Total number of classes generated across all modules.
  final int totalClasses;
  
  /// Total number of modules processed.
  final int totalModules;
  
  /// List of output files generated.
  final List<String> outputFiles;
  
  /// Configuration used for generation.
  final BridgeConfig config;
  
  /// Any errors encountered.
  final List<String> errors;

  const GenerationResult({
    required this.totalClasses,
    required this.totalModules,
    required this.outputFiles,
    required this.config,
    this.errors = const [],
  });
  
  /// Whether generation was successful (no errors).
  bool get isSuccess => errors.isEmpty;
}

/// Generate D4rt bridges for a project.
///
/// Generates bridges from a [BridgeConfig] or from a buildkit.yaml file path.
///
/// Either [config] or [configPath] must be provided.
///
/// When using [config], specify [projectPath] to set the project root directory
/// for resolving relative paths in the config. Defaults to [Directory.current].
///
/// Example using config object:
/// ```dart
/// final config = BridgeConfig.fromJson({...});
/// final result = await generateBridges(
///   config: config,
///   projectPath: '/path/to/project',
/// );
/// ```
///
/// Example using config file:
/// ```dart
/// final result = await generateBridges(
///   configPath: '/path/to/project/buildkit.yaml',
/// );
/// ```
Future<GenerationResult> generateBridges({
  BridgeConfig? config,
  String? configPath,
  String? projectPath,
}) async {
  if (config == null && configPath == null) {
    throw ArgumentError('Either config or configPath must be provided');
  }
  
  if (config != null && configPath != null) {
    throw ArgumentError('Only one of config or configPath should be provided');
  }
  
  // Resolve project directory: explicit projectPath > configPath parent > cwd
  final projectDir = projectPath ??
      (configPath != null ? p.dirname(configPath) : Directory.current.path);
  final bridgeConfig = config ?? BuildConfigLoader.loadFromTomBuildYaml(projectDir);
  if (bridgeConfig == null) {
    throw ArgumentError('No d4rtgen configuration found in $projectDir');
  }

  // Log invocation at project level (once per generateBridges call)
  logD4rtgenInvocation(
    source: 'API',
    details: 'project: ${bridgeConfig.name}, modules: ${bridgeConfig.modules.length}, projectDir: $projectDir',
    includeStackTrace: true,
  );
  
  var totalClasses = 0;
  final outputFiles = <String>[];
  final errors = <String>[];
  
  try {
    // Generate bridges for each module
    for (final module in bridgeConfig.modules) {
      // Determine sourceImport: use barrelImport if provided, otherwise first barrel file
      final sourceImport = module.barrelImport ?? module.barrelFiles.first;
      
      // Build list of barrel imports for getImportBlock() generation.
      // The barrel imports are used by D4rt scripts (not by the bridge code itself,
      // which imports directly from source files).
      final sourceImports = module.barrelFiles
          .where((f) => f.startsWith('package:'))
          .toList();

      final generator = BridgeGenerator(
        workspacePath: projectDir,
        packageName: bridgeConfig.name,
        sourceImport: sourceImport,
        sourceImports: sourceImports,
        helpersImport: bridgeConfig.helpersImport ?? 
            'package:tom_d4rt/tom_d4rt.dart',
        recursiveBoundTypes: bridgeConfig.recursiveBoundTypes.isNotEmpty
            ? bridgeConfig.recursiveBoundTypes
                .map(RecursiveBoundType.fromString)
                .toList()
            : null, // Use defaults if not configured
      );

      // Resolve barrel files - if they're package URIs, pass as-is; otherwise join with projectDir
      final barrelFiles = module.barrelFiles.map((f) {
        if (f.startsWith('package:')) {
          return f; // Package URI - generator will resolve it
        }
        return p.join(projectDir, f);
      }).toList();

      final normalizedOutputPath = ensureBDartExtension(module.outputPath);
      final result = await generator.generateBridgesFromExports(
        barrelFiles: barrelFiles,
        outputPath: p.join(projectDir, normalizedOutputPath),
        moduleName: module.name,
        excludePatterns: module.excludePatterns,
        excludeClasses: module.excludeClasses,
        excludeEnums: module.excludeEnums,
        excludeFunctions: module.excludeFunctions,
        excludeVariables: module.excludeVariables,
        excludeSourcePatterns: module.excludeSourcePatterns,
        importShowClause: module.importShowClause,
        importHideClause: module.importHideClause,
      );

      totalClasses += result.classesGenerated;
      outputFiles.add(p.join(projectDir, normalizedOutputPath));
      errors.addAll(result.errors);
    }

    // Generate barrel file if requested
    if (bridgeConfig.generateBarrel && bridgeConfig.barrelPath != null) {
      final barrelPath = p.join(projectDir, ensureBDartExtension(bridgeConfig.barrelPath!));
      await _generateBarrelFile(barrelPath, bridgeConfig);
      outputFiles.add(barrelPath);
    }

    // Generate dartscript file if requested
    if (bridgeConfig.generateDartscript && bridgeConfig.dartscriptPath != null) {
      final dartscriptPath = p.join(projectDir, ensureBDartExtension(bridgeConfig.dartscriptPath!));
      await _generateDartscriptFile(dartscriptPath, bridgeConfig);
      outputFiles.add(dartscriptPath);
    }

    // Generate test runner file if requested
    if (bridgeConfig.generateTestRunner && bridgeConfig.testRunnerPath != null) {
      final testRunnerPath = p.join(projectDir, ensureBDartExtension(bridgeConfig.testRunnerPath!));
      await _generateTestRunnerFile(testRunnerPath, bridgeConfig);
      outputFiles.add(testRunnerPath);
    }
  } catch (e) {
    errors.add(e.toString());
  }
  
  return GenerationResult(
    totalClasses: totalClasses,
    totalModules: bridgeConfig.modules.length,
    outputFiles: outputFiles,
    config: bridgeConfig,
    errors: errors,
  );
}

/// Generate barrel file that exports all bridge modules.
Future<void> _generateBarrelFile(String barrelPath, BridgeConfig config) async {
  await File(barrelPath).writeAsString(generateBarrelFileContent(config));
}

/// Generate dartscript file with combined bridge registration.
Future<void> _generateDartscriptFile(String dartscriptPath, BridgeConfig config) async {
  final normalizedDartscriptPath = config.dartscriptPath != null
      ? ensureBDartExtension(config.dartscriptPath!)
      : null;
  await File(dartscriptPath).writeAsString(
    generateDartscriptFileContent(config, dartscriptPath: normalizedDartscriptPath),
  );
}

/// Generate test runner file for testing bridges.
Future<void> _generateTestRunnerFile(String testRunnerPath, BridgeConfig config) async {
  final dir = File(testRunnerPath).parent;
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  final normalizedTestRunnerPath = config.testRunnerPath != null
      ? ensureBDartExtension(config.testRunnerPath!)
      : null;
  await File(testRunnerPath).writeAsString(
    generateTestRunnerContent(config, testRunnerPath: normalizedTestRunnerPath),
  );
}
