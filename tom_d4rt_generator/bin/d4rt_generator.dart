#!/usr/bin/env dart
/// D4rt Bridge Generator CLI
///
/// Command-line interface for generating D4rt bridges from configuration files.
///
/// ## Configuration
///
/// The generator reads configuration from:
/// 1. `build.yaml` - under `targets.$default.builders.tom_d4rt_generator:d4rt_bridge_builder.options`
/// 2. `d4rt_bridging.json` - legacy standalone config file (fallback)
///
/// ## Usage
///
/// ```bash
/// # Generate bridges for current project (uses build.yaml or d4rt_bridging.json)
/// dart run tom_d4rt_generator:d4rt_generator
///
/// # Generate for a specific project
/// dart run tom_d4rt_generator:d4rt_generator --project=/path/to/project
///
/// # Specify a JSON configuration file explicitly
/// dart run tom_d4rt_generator:d4rt_generator --config=/path/to/d4rt_bridging.json
///
/// # Scan a specific directory for config files
/// dart run tom_d4rt_generator:d4rt_generator --scan=/path/to/workspace
/// ```
library;

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('project',
        abbr: 'p',
        help: 'Path to project directory (reads build.yaml or d4rt_bridging.json)')
    ..addOption('config',
        abbr: 'c', help: 'Path to specific d4rt_bridging.json file')
    ..addOption('scan',
        abbr: 's', help: 'Scan directory for all config files')
    ..addFlag('recursive',
        abbr: 'r',
        defaultsTo: false,
        help: 'Recursively scan for config files')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage help')
    ..addFlag('verbose', abbr: 'v', negatable: false, help: 'Verbose output');

  final args = parser.parse(arguments);

  if (args['help'] as bool) {
    _printUsage(parser);
    exit(0);
  }

  final verbose = args['verbose'] as bool;
  final recursive = args['recursive'] as bool;

  try {
    // Process based on arguments
    if (args['config'] != null) {
      // Explicit JSON config file specified
      final configPath = args['config'] as String;
      if (!File(configPath).existsSync()) {
        stderr.writeln('Error: Configuration file not found: $configPath');
        exit(1);
      }
      await _processConfigFile(configPath, verbose: verbose);
    } else if (args['project'] != null) {
      // Project directory specified - look for config
      final projectPath = args['project'] as String;
      await _processProject(projectPath, verbose: verbose);
    } else if (args['scan'] != null) {
      // Scan specified directory
      final scanPath = args['scan'] as String;
      await _scanDirectory(scanPath, recursive: recursive, verbose: verbose);
    } else {
      // Default: process current directory as a project
      final currentDir = Directory.current.path;
      await _processProject(currentDir, verbose: verbose);
    }

    print('');
    print('Bridge generation complete.');
  } catch (e) {
    stderr.writeln('Fatal error: $e');
    exit(1);
  }
}

/// Process a single project directory.
///
/// Looks for config in this order:
/// 1. build.yaml (preferred)
/// 2. d4rt_bridging.json (fallback)
Future<void> _processProject(String projectPath,
    {required bool verbose}) async {
  if (verbose) {
    print('Processing project: $projectPath');
  }

  // Try loading from build.yaml first
  var config = BuildConfigLoader.loadFromBuildYaml(projectPath);

  if (config != null) {
    if (verbose) {
      print('  Using configuration from build.yaml');
    }
    await _generateBridges(config, projectPath, verbose: verbose);
    return;
  }

  // Fall back to d4rt_bridging.json
  final jsonConfigPath = p.join(projectPath, 'd4rt_bridging.json');
  if (File(jsonConfigPath).existsSync()) {
    if (verbose) {
      print('  Using configuration from d4rt_bridging.json');
    }
    await _processConfigFile(jsonConfigPath, verbose: verbose);
    return;
  }

  stderr.writeln('Error: No configuration found in $projectPath');
  stderr.writeln('  Expected: build.yaml with d4rt_bridge_builder options');
  stderr.writeln('  Or: d4rt_bridging.json');
  exit(1);
}

/// Scan a directory for config files and process them.
Future<void> _scanDirectory(String scanPath,
    {required bool recursive, required bool verbose}) async {
  final configFiles =
      BridgeConfig.findConfigFiles(scanPath, recursive: recursive);

  if (configFiles.isEmpty) {
    stderr.writeln('Error: No d4rt_bridging.json files found in $scanPath');
    exit(1);
  }

  if (verbose) {
    print('Found ${configFiles.length} configuration file(s):');
    for (final config in configFiles) {
      print('  - $config');
    }
    print('');
  }

  var successCount = 0;
  var failureCount = 0;

  for (final configFile in configFiles) {
    try {
      await _processConfigFile(configFile, verbose: verbose);
      successCount++;
    } catch (e) {
      stderr.writeln('Error processing $configFile: $e');
      failureCount++;
    }
  }

  print('');
  print('=' * 80);
  print('Bridge generation complete:');
  print('  Success: $successCount');
  if (failureCount > 0) {
    print('  Failed: $failureCount');
  }
  print('=' * 80);

  if (failureCount > 0) exit(1);
}

/// Generate bridges from a BridgeConfig object.
Future<void> _generateBridges(BridgeConfig config, String projectDir,
    {required bool verbose}) async {
  if (verbose) {
    print('  Project: ${config.name}');
    print('  Modules: ${config.modules.length}');
  }

  // Generate bridges for each module
  for (final module in config.modules) {
    if (verbose) {
      print('  Generating module: ${module.name}');
    }

    // Determine sourceImport: use barrelImport if provided, otherwise first barrel file
    final sourceImport = module.barrelImport ?? module.barrelFiles.first;

    final generator = BridgeGenerator(
      workspacePath: projectDir,
      packageName: config.name,
      sourceImport: sourceImport,
      helpersImport: config.helpersImport ?? 'package:tom_d4rt/tom_d4rt.dart',
      verbose: verbose,
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

    if (verbose) {
      print('    Generated ${result.classesGenerated} classes');
    }
  }

  // Generate barrel file if requested
  if (config.generateBarrel && config.barrelPath != null) {
    final barrelPath = p.join(projectDir, config.barrelPath!);
    await _generateBarrelFile(barrelPath, config, verbose: verbose);
  }

  // Generate dartscript file if requested
  if (config.generateDartscript && config.dartscriptPath != null) {
    final dartscriptPath = p.join(projectDir, config.dartscriptPath!);
    await _generateDartscriptFile(dartscriptPath, config, verbose: verbose);
  }

  if (verbose) {
    print('  ✓ Complete');
    print('');
  }
}

/// Process a single configuration file.
Future<void> _processConfigFile(String configPath,
    {required bool verbose}) async {
  if (verbose) {
    print('Processing: $configPath');
  }

  // Load configuration
  final config = BridgeConfig.fromFile(configPath);
  final projectDir = p.dirname(configPath);

  await _generateBridges(config, projectDir, verbose: verbose);
}

/// Generate barrel file that exports all bridge modules.
Future<void> _generateBarrelFile(String barrelPath, BridgeConfig config,
    {required bool verbose}) async {
  if (verbose) {
    print('  Generating barrel: $barrelPath');
  }

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
Future<void> _generateDartscriptFile(String dartscriptPath, BridgeConfig config,
    {required bool verbose}) async {
  if (verbose) {
    print('  Generating dartscript: $dartscriptPath');
  }

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
    // Capitalize module name for class name (e.g., "all" -> "All")
    final capitalizedName = module.name.isEmpty 
        ? module.name 
        : '${module.name[0].toUpperCase()}${module.name.substring(1)}';
    // Use barrelImport if provided, otherwise fall back to package name convention
    final registrationImport = module.barrelImport ?? 'package:${config.name}/${config.name}.dart';
    buffer.writeln('    ${module.name}_bridges.${capitalizedName}Bridge.registerBridges(');
    buffer.writeln('      d4rt,');
    buffer.writeln('      \'$registrationImport\',');
    buffer.writeln('    );');
  }

  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  /// Legacy method for backward compatibility.');
  buffer.writeln('  /// The [importPath] parameter is ignored (kept for backward compatibility).');
  buffer.writeln('  @Deprecated(\'Use register() instead\')');
  buffer.writeln('  static void registerAllBridges(D4rt interpreter, [String? importPath]) {');
  buffer.writeln('    register(interpreter);');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  /// Get all bridge classes.');
  buffer.writeln('  static List<BridgedClass> bridgeClasses() {');
  buffer.writeln('    return [');

  for (final module in config.modules) {
    final capitalizedName = module.name.isEmpty 
        ? module.name 
        : '${module.name[0].toUpperCase()}${module.name.substring(1)}';
    buffer.writeln('      ...${module.name}_bridges.${capitalizedName}Bridge.bridgeClasses(),');
  }

  buffer.writeln('    ];');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  /// Get import block for all modules.');
  buffer.writeln('  static String getImportBlock() {');
  buffer.writeln('    final buffer = StringBuffer();');

  for (final module in config.modules) {
    final capitalizedName = module.name.isEmpty 
        ? module.name 
        : '${module.name[0].toUpperCase()}${module.name.substring(1)}';
    buffer.writeln(
        '    buffer.writeln(${module.name}_bridges.${capitalizedName}Bridge.getImportBlock());');
  }

  buffer.writeln('    return buffer.toString();');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  /// Get global initialization script.');
  buffer.writeln('  static String getGlobalInitializationScript() {');
  buffer.writeln('    return \'\';');
  buffer.writeln('  }');
  buffer.writeln('}');

  await File(dartscriptPath).writeAsString(buffer.toString());
}

void _printUsage(ArgParser parser) {
  print('D4rt Bridge Generator');
  print('');
  print('Generates D4rt bridges from d4rt_bridging.json configuration files.');
  print('');
  print('Usage:');
  print('  dart run tom_d4rt_generator:d4rt_generator [options]');
  print('');
  print('Options:');
  print(parser.usage);
  print('');
  print('Examples:');
  print('  # Scan current directory for config files');
  print('  dart run tom_d4rt_generator:d4rt_generator');
  print('');
  print('  # Generate for specific project');
  print('  dart run tom_d4rt_generator:d4rt_generator --project=tom_build');
  print('');
  print('  # Use explicit config file');
  print(
      '  dart run tom_d4rt_generator:d4rt_generator --config=path/to/d4rt_bridging.json');
  print('');
  print('  # Recursively scan workspace');
  print('  dart run tom_d4rt_generator:d4rt_generator --scan=. --recursive');
}
