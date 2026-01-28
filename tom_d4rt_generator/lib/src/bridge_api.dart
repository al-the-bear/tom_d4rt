/// Public API for D4rt Bridge Generation
///
/// Provides a simple API for programmatic bridge generation.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

import 'bridge_config.dart';
import 'bridge_generator.dart';

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
/// Generates bridges from a [BridgeConfig] or from a configuration file path.
///
/// Either [config] or [configPath] must be provided.
///
/// Example using config object:
/// ```dart
/// final config = BridgeConfig.fromJson({...});
/// final result = await generateBridges(config: config);
/// ```
///
/// Example using config file:
/// ```dart
/// final result = await generateBridges(
///   configPath: '/path/to/d4rt_bridging.json',
/// );
/// ```
Future<GenerationResult> generateBridges({
  BridgeConfig? config,
  String? configPath,
}) async {
  if (config == null && configPath == null) {
    throw ArgumentError('Either config or configPath must be provided');
  }
  
  if (config != null && configPath != null) {
    throw ArgumentError('Only one of config or configPath should be provided');
  }
  
  // Load config from file if needed
  final bridgeConfig = config ?? BridgeConfig.fromFile(configPath!);
  final projectDir = configPath != null ? p.dirname(configPath) : Directory.current.path;
  
  var totalClasses = 0;
  final outputFiles = <String>[];
  final errors = <String>[];
  
  try {
    // Generate bridges for each module
    for (final module in bridgeConfig.modules) {
      // Determine sourceImport: use barrelImport if provided, otherwise first barrel file
      final sourceImport = module.barrelImport ?? module.barrelFiles.first;

      final generator = BridgeGenerator(
        workspacePath: projectDir,
        packageName: bridgeConfig.name,
        sourceImport: sourceImport,
        helpersImport: bridgeConfig.helpersImport ?? 
            'package:tom_d4rt/tom_d4rt.dart',
      );

      // Resolve barrel files - if they're package URIs, pass as-is; otherwise join with projectDir
      final barrelFiles = module.barrelFiles.map((f) {
        if (f.startsWith('package:')) {
          return f; // Package URI - generator will resolve it
        }
        return p.join(projectDir, f);
      }).toList();

      final result = await generator.generateBridgesFromExports(
        barrelFiles: barrelFiles,
        outputPath: p.join(projectDir, module.outputPath),
        moduleName: module.name,
        excludePatterns: module.excludePatterns,
        excludeClasses: module.excludeClasses,
        excludeEnums: module.excludeEnums,
        excludeFunctions: module.excludeFunctions,
        excludeVariables: module.excludeVariables,
      );

      totalClasses += result.classesGenerated;
      outputFiles.add(p.join(projectDir, module.outputPath));
      errors.addAll(result.errors);
    }

    // Generate barrel file if requested
    if (bridgeConfig.generateBarrel && bridgeConfig.barrelPath != null) {
      final barrelPath = p.join(projectDir, bridgeConfig.barrelPath!);
      await _generateBarrelFile(barrelPath, bridgeConfig);
      outputFiles.add(barrelPath);
    }

    // Generate dartscript file if requested
    if (bridgeConfig.generateDartscript && bridgeConfig.dartscriptPath != null) {
      final dartscriptPath = p.join(projectDir, bridgeConfig.dartscriptPath!);
      await _generateDartscriptFile(dartscriptPath, bridgeConfig);
      outputFiles.add(dartscriptPath);
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
  final buffer = StringBuffer();
  buffer.writeln('/// D4rt Bridges for ${config.name}');
  buffer.writeln('library;');
  buffer.writeln();

  for (final module in config.modules) {
    final relativePath = module.outputPath.startsWith('lib/')
        ? module.outputPath.substring(4)
        : module.outputPath;
    buffer.writeln("export '$relativePath';");
  }

  await File(barrelPath).writeAsString(buffer.toString());
}

/// Generate dartscript file with combined bridge registration.
Future<void> _generateDartscriptFile(String dartscriptPath, BridgeConfig config) async {
  final registrationClass = config.registrationClass ?? '${config.name}Bridges';
  final buffer = StringBuffer();

  buffer.writeln('/// D4rt Bridge Registration for ${config.name}');
  buffer.writeln('library;');
  buffer.writeln();
  buffer.writeln("import 'package:tom_d4rt/d4rt.dart';");

  for (final module in config.modules) {
    final relativePath = module.outputPath.startsWith('lib/')
        ? module.outputPath.substring(4)
        : module.outputPath;
    buffer.writeln("import '$relativePath' as ${module.name}_bridges;");
  }

  buffer.writeln();
  buffer.writeln('/// Combined bridge registration for ${config.name}.');
  buffer.writeln('class $registrationClass {');
  buffer.writeln('  /// Register all bridges with D4rt interpreter.');
  buffer.writeln('  static void register([D4rt? interpreter]) {');
  buffer.writeln('    final d4rt = interpreter ?? D4rt();');

  for (final module in config.modules) {
    // Convert module name to PascalCase for class name (e.g., "tom_core_kernel" -> "TomCoreKernel")
    final capitalizedName = toPascalCase(module.name);
    // Use barrelImport if provided, otherwise fall back to package name convention
    final registrationImport = module.barrelImport ?? 'package:${config.name}/${config.name}.dart';
    buffer.writeln('    ${module.name}_bridges.${capitalizedName}Bridge.registerBridges(');
    buffer.writeln('      d4rt,');
    buffer.writeln('      \'$registrationImport\',');
    buffer.writeln('    );');
  }

  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  /// Get import block for all modules.');
  buffer.writeln('  static String getImportBlock() {');
  buffer.writeln('    final buffer = StringBuffer();');

  for (final module in config.modules) {
    final capitalizedName = toPascalCase(module.name);
    buffer.writeln(
        '    buffer.writeln(${module.name}_bridges.${capitalizedName}Bridge.getImportBlock());');
  }

  buffer.writeln('    return buffer.toString();');
  buffer.writeln('  }');
  buffer.writeln('}');

  await File(dartscriptPath).writeAsString(buffer.toString());
}
