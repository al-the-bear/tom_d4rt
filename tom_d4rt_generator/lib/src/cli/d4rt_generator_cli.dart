/// D4rt Bridge Generator CLI entry point.
library;

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart';
import '../build_config_loader.dart';
import '../../tom_d4rt_generator.dart';

/// Main entry point for d4rt_generator CLI.
Future<void> d4rtGeneratorMain(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('project',
        abbr: 'p',
        help:
            'Path to project directory (reads tom_build.yaml d4rtgen: section)')
    ..addOption('config',
        abbr: 'c', help: 'Path to specific tom_build.yaml file')
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
      // Explicit tom_build.yaml config file specified
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

  // Load from tom_build.yaml d4rtgen: section
  final config = BuildConfigLoader.loadFromTomBuildYaml(projectPath);

  if (config != null) {
    if (verbose) {
      print('  Using configuration from tom_build.yaml');
    }
    await _generateBridges(config, projectPath, verbose: verbose);
    return;
  }

  stderr.writeln('Error: No d4rtgen configuration found in $projectPath');
  stderr.writeln('  Expected: tom_build.yaml with d4rtgen: section');
  exit(1);
}

/// Scan a directory for D4rt projects and process them.
Future<void> _scanDirectory(String scanPath,
    {required bool recursive, required bool verbose}) async {
  final dir = Directory(scanPath);
  if (!dir.existsSync()) {
    stderr.writeln('Error: Directory not found: $scanPath');
    exit(1);
  }

  // Find all directories with tom_build.yaml containing d4rtgen: section
  final projectDirs = <String>[];
  _findD4rtgenProjects(dir, projectDirs, recursive: recursive);

  if (projectDirs.isEmpty) {
    stderr.writeln('Error: No D4rt projects found in $scanPath');
    exit(1);
  }

  if (verbose) {
    print('Found ${projectDirs.length} D4rt project(s):');
    for (final projDir in projectDirs) {
      print('  - $projDir');
    }
    print('');
  }

  var successCount = 0;
  var failureCount = 0;

  for (final projectDir in projectDirs) {
    try {
      await _processProject(projectDir, verbose: verbose);
      successCount++;
    } catch (e) {
      stderr.writeln('Error processing $projectDir: $e');
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

/// Recursively find directories containing tom_build.yaml with d4rtgen: section.
void _findD4rtgenProjects(Directory dir, List<String> results,
    {required bool recursive}) {
  if (hasTomBuildConfig(dir.path, 'd4rtgen')) {
    results.add(dir.path);
  }

  if (recursive) {
    for (final entity in dir.listSync(followLinks: false)) {
      if (entity is Directory) {
        final name = p.basename(entity.path);
        // Skip hidden directories and common non-project directories
        if (!name.startsWith('.') && name != 'node_modules') {
          _findD4rtgenProjects(entity, results, recursive: true);
        }
      }
    }
  }
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
    );

    if (verbose) {
      print('    Generated ${result.classesGenerated} classes');
    }
  }

  // Generate barrel file if requested
  if (config.generateBarrel && config.barrelPath != null) {
    final barrelPath = p.join(projectDir, ensureBDartExtension(config.barrelPath!));
    await _generateBarrelFile(barrelPath, config, verbose: verbose);
  }

  // Generate dartscript file if requested
  if (config.generateDartscript && config.dartscriptPath != null) {
    final dartscriptPath = p.join(projectDir, ensureBDartExtension(config.dartscriptPath!));
    await _generateDartscriptFile(dartscriptPath, config, verbose: verbose);
  }

  // Generate test runner file if requested
  if (config.generateTestRunner && config.testRunnerPath != null) {
    final testRunnerPath = p.join(projectDir, ensureBDartExtension(config.testRunnerPath!));
    await _generateTestRunnerFile(testRunnerPath, config, verbose: verbose);
  }

  if (verbose) {
    print('  ✓ Complete');
    print('');
  }
}

/// Process a single tom_build.yaml configuration file.
Future<void> _processConfigFile(String configPath,
    {required bool verbose}) async {
  if (verbose) {
    print('Processing: $configPath');
  }

  // Derive project directory from config file path
  final projectDir = p.dirname(configPath);

  // Load from tom_build.yaml d4rtgen: section
  final config = BuildConfigLoader.loadFromTomBuildYaml(projectDir);
  if (config == null) {
    stderr.writeln('Error: No d4rtgen configuration found in $configPath');
    exit(1);
  }

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
  final normalizedDartscriptPath = config.dartscriptPath != null
      ? ensureBDartExtension(config.dartscriptPath!)
      : null;
  await File(dartscriptPath).writeAsString(
    generateDartscriptFileContent(config, dartscriptPath: normalizedDartscriptPath),
  );
}

/// Generate test runner file for testing bridges.
Future<void> _generateTestRunnerFile(String testRunnerPath, BridgeConfig config,
    {required bool verbose}) async {
  if (verbose) {
    print('  Generating test runner: $testRunnerPath');
  }
  // Ensure directory exists (test runner may be in bin/)
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

/// Prints usage information.
void printD4rtGeneratorUsage(ArgParser parser) {
  print('D4rt Bridge Generator');
  print('');
  print('Generates D4rt bridges from tom_build.yaml configuration.');
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
  print('  d4rt_gen --config=path/to/tom_build.yaml');
  print('');
  print('  # Recursively scan workspace');
  print('  d4rt_gen --scan=. --recursive');
}
