/// D4rt Bridge Generator CLI entry point.
library;

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import '../build_config_loader.dart';
import '../../tom_d4rt_generator.dart';

/// Main entry point for d4rt_generator CLI.
Future<void> d4rtGeneratorMain(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('project',
        abbr: 'p',
        help:
            'Path to project directory (reads build.yaml or d4rt_bridging.json)')
    ..addOption('config',
        abbr: 'c', help: 'Path to specific d4rt_bridging.json file')
    ..addOption('scan', abbr: 's', help: 'Scan directory for all config files')
    ..addFlag('recursive',
        abbr: 'r',
        defaultsTo: false,
        help: 'Recursively scan for config files')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage help')
    ..addFlag('verbose', abbr: 'v', negatable: false, help: 'Verbose output');

  final args = parser.parse(arguments);

  if (args['help'] as bool) {
    printD4rtGeneratorUsage(parser);
    return;
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
Future<void> _processProject(String projectPath,
    {required bool verbose}) async {
  if (verbose) {
    print('Processing project: $projectPath');
  }

  // Try loading from build.yaml first
  final config = BuildConfigLoader.loadFromBuildYaml(projectPath);

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

    // Resolve barrel files
    final barrelFiles = module.barrelFiles.map((f) {
      if (f.startsWith('package:')) {
        return f;
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
      excludeSourcePatterns: module.excludeSourcePatterns,
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
  await File(barrelPath).writeAsString(generateBarrelFileContent(config));
}

/// Generate dartscript file with combined bridge registration.
Future<void> _generateDartscriptFile(String dartscriptPath, BridgeConfig config,
    {required bool verbose}) async {
  if (verbose) {
    print('  Generating dartscript: $dartscriptPath');
  }
  await File(dartscriptPath).writeAsString(generateDartscriptFileContent(config));
}

/// Prints usage information.
void printD4rtGeneratorUsage(ArgParser parser) {
  print('D4rt Bridge Generator');
  print('');
  print('Generates D4rt bridges from d4rt_bridging.json configuration files.');
  print('');
  print('Usage:');
  print('  d4rt_gen [options]');
  print('');
  print('Options:');
  print(parser.usage);
  print('');
  print('Examples:');
  print('  # Scan current directory for config files');
  print('  d4rt_gen');
  print('');
  print('  # Generate for specific project');
  print('  d4rt_gen --project=tom_build');
  print('');
  print('  # Use explicit config file');
  print('  d4rt_gen --config=path/to/d4rt_bridging.json');
  print('');
  print('  # Recursively scan workspace');
  print('  d4rt_gen --scan=. --recursive');
}
