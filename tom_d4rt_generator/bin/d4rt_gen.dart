#!/usr/bin/env dart
/// D4rt Bridge Generator CLI (d4rtgen)
///
/// Command-line interface for generating D4rt bridges from configuration files.
///
/// ## Configuration Sources (in order of precedence)
///
/// 1. Command-line arguments
/// 2. `tom_build.yaml` (dartgen: section) in project directory
/// 3. `build.yaml` in project directory
/// 4. `d4rt_bridging.json` in project directory
///
/// ## Usage
///
/// ```bash
/// # Generate bridges for current project
/// d4rtgen
///
/// # Process project and all subprojects recursively
/// d4rtgen --project=my_app --recursive
///
/// # Process projects matching glob, with recursion exclusions
/// d4rtgen --projects="./**/tom_*" --recursive --recursion-exclude="**/node_modules/**"
///
/// # Show help
/// d4rtgen --help
/// ```
library;

import 'dart:io';

import 'package:args/args.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/src/version.g.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';
import 'package:yaml/yaml.dart';

/// The tool key for dartgen in tom_build.yaml
const _toolKey = 'dartgen';

/// Validates path containment using tom_build_base's validatePathContainment.
String? _validatePathContainment(TomBuildConfig config, String basePath) {
  return validatePathContainment(
    project: config.project,
    projects: config.projects,
    scan: config.scan,
    config: config.config,
    basePath: basePath,
  );
}

Future<void> main(List<String> arguments) async {
  // Check for version command first (before parsing)
  if (arguments.isNotEmpty &&
      (arguments[0] == 'version' ||
          arguments[0] == '-version' ||
          arguments[0] == '--version')) {
    _printVersion();
    exit(0);
  }

  final parser = ArgParser()
    ..addOption('project',
        abbr: 'p',
        help: 'Project(s) to process (comma-separated, globs: tom_*_builder, ./*)')
    ..addOption('config',
        abbr: 'c',
        help: 'Path to specific d4rt_bridging.json file')
    ..addOption('scan',
        abbr: 's',
        help: 'Scan directory for all D4rt projects')
    ..addFlag('recursive',
        abbr: 'r',
        defaultsTo: false,
        help: 'Recursively process subprojects within each project')
    ..addMultiOption('exclude',
        abbr: 'x',
        help: 'Glob patterns for projects to exclude')
    ..addMultiOption('recursion-exclude',
        abbr: 'R',
        help: 'Glob patterns to exclude from recursion (e.g., "**/node_modules/**")')
    ..addFlag('verbose',
        abbr: 'v',
        negatable: false,
        help: 'Show detailed output')
    ..addFlag('list',
        abbr: 'l',
        negatable: false,
        help: 'List projects that would be processed (no action)')
    ..addFlag('show',
        help: 'With --list, show build.yaml configuration for each project',
        negatable: false)
    ..addFlag('help',
        abbr: 'h',
        negatable: false,
        help: 'Show usage help');

  final ArgResults args;
  try {
    args = parser.parse(arguments);

    // Check for unexpected arguments (rest)
    if (args.rest.isNotEmpty) {
      stderr.writeln('Error: Unknown arguments: ${args.rest.join(' ')}');
      stderr.writeln('');
      _printUsage(parser);
      exit(1);
    }
  } catch (e) {
    stderr.writeln('Error: $e');
    stderr.writeln('');
    _printUsage(parser);
    exit(1);
  }

  if (args['help'] as bool) {
    _printUsage(parser);
    exit(0);
  }

  // Build config from CLI args (using TomBuildConfig from tom_build_base)
  final cliConfig = TomBuildConfig(
    project: args['project'] as String?,
    projects: const [], // --projects not exposed as CLI arg; only via tom_build.yaml
    config: args['config'] as String?,
    scan: args['scan'] as String?,
    recursive: args['recursive'] as bool,
    exclude: args['exclude'] as List<String>,
    recursionExclude: args['recursion-exclude'] as List<String>,
    verbose: args['verbose'] as bool,
  );

  // Check if any meaningful option was provided
  TomBuildConfig config;
  if (!cliConfig.hasProjectOptions) {
    // Try loading from tom_build.yaml in current directory
    final yamlConfig = TomBuildConfig.load(
      dir: Directory.current.path,
      toolKey: _toolKey,
    );
    if (yamlConfig != null) {
      print('Using configuration from tom_build.yaml (dartgen: section)');
      // Merge CLI flags (like --verbose) with yaml config
      config = yamlConfig.merge(cliConfig);
    } else {
      // Default: process current directory
      config = TomBuildConfig(
        project: Directory.current.path,
        recursive: cliConfig.recursive,
        exclude: cliConfig.exclude,
        recursionExclude: cliConfig.recursionExclude,
        verbose: cliConfig.verbose,
      );
    }
  } else {
    config = cliConfig;
  }

  // Validate that all paths are contained within current working directory
  final validationError = _validatePathContainment(config, Directory.current.path);
  if (validationError != null) {
    stderr.writeln('Error: $validationError');
    stderr.writeln('All paths must be within the current working directory.');
    stderr.writeln('Run from the workspace root to access all folders.');
    exit(1);
  }

  // Handle --list mode: just list projects without processing
  final listOnly = args['list'] as bool;
  final showConfig = args['show'] as bool;
  if (listOnly) {
    final projects = await _collectProjects(config);
    final workspaceRoot = ProjectDiscovery.findWorkspaceRoot(Directory.current.path);
    if (projects.isEmpty) {
      print('No d4rtgen projects found.');
    } else {
      print('D4rtgen projects (${projects.length}):');
      for (final project in projects) {
        final relativePath = p.relative(project, from: workspaceRoot);
        print('  $relativePath');
        
        if (showConfig) {
          _printBuildYamlSection(project, workspaceRoot);
        }
      }
    }
    exit(0);
  }

  try {
    final result = await _runWithConfig(config, basePath: Directory.current.path);

    print('');
    print('=' * 70);
    print('Bridge generation complete:');
    print('  Success: ${result.successCount}');
    if (result.failureCount > 0) {
      print('  Failed: ${result.failureCount}');
    }
    print('=' * 70);

    if (result.failureCount > 0) exit(1);
  } catch (e) {
    stderr.writeln('Fatal error: $e');
    exit(1);
  }
}

/// Collect all projects that would be processed (for --list mode).
Future<List<String>> _collectProjects(TomBuildConfig config) async {
  final verbose = config.verbose;
  final discovery = ProjectDiscovery(verbose: verbose);

  if (config.config != null) {
    // Single config file - return the directory containing it
    final configPath = config.config!;
    if (File(configPath).existsSync()) {
      return [p.dirname(configPath)];
    }
    return [];
  }
  
  // Handle --project with patterns (comma-separated, globs, etc.)
  if (config.project != null) {
    return discovery.resolveProjectPatterns(
      config.project!,
      basePath: Directory.current.path,
      projectFilter: _isD4rtProject,
    );
  }
  
  // Legacy --projects support (for backward compatibility)
  if (config.projects.isNotEmpty) {
    return await _findProjectsByGlob(
      config.projects,
      exclude: config.exclude,
      verbose: verbose,
    );
  } 
  
  if (config.scan != null) {
    return await _scanForProjects(
      config.scan!,
      recursive: config.recursive,
      exclude: config.exclude,
      recursionExclude: config.recursionExclude,
      verbose: verbose,
    );
  }
  
  return [];
}

/// Run the generator with the given configuration.
/// This is the main entry point that can be called recursively.
/// [basePath] is the directory that constrains all paths in config.
Future<ProcessingResult> _runWithConfig(TomBuildConfig config, {required String basePath}) async {
  final result = ProcessingResult();
  final verbose = config.verbose;

  if (config.config != null) {
    // Explicit JSON config file specified
    final configPath = config.config!;
    if (!File(configPath).existsSync()) {
      stderr.writeln('Error: Configuration file not found: $configPath');
      result.addFailure();
      return result;
    }
    try {
      await _processConfigFile(configPath, verbose: verbose);
      result.addSuccess();
    } catch (e) {
      stderr.writeln('Error processing $configPath: $e');
      result.addFailure();
    }
  } else if (config.projects.isNotEmpty) {
    // Process projects matching glob patterns
    final projects = await _findProjectsByGlob(
      config.projects,
      exclude: config.exclude,
      verbose: verbose,
    );

    if (projects.isEmpty) {
      stderr.writeln('No projects found matching patterns: ${config.projects.join(", ")}');
      return result;
    }

    for (final projectPath in projects) {
      final subResult = await _processProjectWithRecursion(
        projectPath,
        recursive: config.recursive,
        recursionExclude: config.recursionExclude,
        exclude: config.exclude,
        verbose: verbose,
      );
      result.merge(subResult);
    }
  } else if (config.scan != null) {
    // Scan directory for projects (finds all D4rt projects in directory)
    final projects = await _scanForProjects(
      config.scan!,
      recursive: config.recursive,
      exclude: config.exclude,
      recursionExclude: config.recursionExclude,
      verbose: verbose,
    );

    if (projects.isEmpty) {
      stderr.writeln('No D4rt projects found in ${config.scan}');
      return result;
    }

    for (final projectPath in projects) {
      // Check for project-local tom_build.yaml (takes precedence)
      final projectConfig = TomBuildConfig.load(
        dir: projectPath,
        toolKey: _toolKey,
      );
      if (projectConfig != null) {
        if (verbose) {
          print('Found tom_build.yaml in $projectPath');
        }
        // Validate project config paths are contained within project
        final projectValidationError = _validatePathContainment(projectConfig, projectPath);
        if (projectValidationError != null) {
          stderr.writeln('Error in $projectPath/tom_build.yaml: $projectValidationError');
          result.addFailure();
          continue;
        }
        // Run with project's own configuration
        final subResult = await _runWithConfig(
          projectConfig,
          basePath: projectPath,
        );
        result.merge(subResult);
      } else {
        // No project-local config, process directly
        try {
          await _processProjectDirect(projectPath, verbose: verbose);
          result.addSuccess();
        } catch (e) {
          stderr.writeln('Error processing $projectPath: $e');
          result.addFailure();
        }
      }
    }
  } else if (config.project != null) {
    // Single project with optional recursion
    final subResult = await _processProjectWithRecursion(
      config.project!,
      recursive: config.recursive,
      recursionExclude: config.recursionExclude,
      exclude: config.exclude,
      verbose: verbose,
    );
    result.merge(subResult);
  }

  return result;
}

/// Process a project and optionally recurse into subprojects.
Future<ProcessingResult> _processProjectWithRecursion(
  String projectPath, {
  required bool recursive,
  required List<String> recursionExclude,
  required List<String> exclude,
  required bool verbose,
}) async {
  final result = ProcessingResult();
  final normalizedPath = p.normalize(p.absolute(projectPath));

  // Check if this project has its own tom_build.yaml
  final projectConfig = TomBuildConfig.load(
    dir: normalizedPath,
    toolKey: _toolKey,
  );
  if (projectConfig != null) {
    if (verbose) {
      print('Found tom_build.yaml in $normalizedPath');
    }
    // Validate project config paths are contained within project
    final validationError = _validatePathContainment(projectConfig, normalizedPath);
    if (validationError != null) {
      stderr.writeln('Error in $normalizedPath/tom_build.yaml: $validationError');
      result.addFailure();
      return result;
    }
    // Run with the project's own configuration (project config takes precedence)
    final mergedConfig = TomBuildConfig(
      project: normalizedPath,
      recursive: projectConfig.recursive || recursive,
      exclude: projectConfig.exclude.isNotEmpty ? projectConfig.exclude : exclude,
      recursionExclude: projectConfig.recursionExclude.isNotEmpty 
          ? projectConfig.recursionExclude 
          : recursionExclude,
      verbose: projectConfig.verbose || verbose,
    ).merge(projectConfig);
    final subResult = await _runWithConfig(mergedConfig, basePath: normalizedPath);
    result.merge(subResult);
    return result;
  }

  // Process this project if it's a D4rt project
  if (_isD4rtProject(normalizedPath)) {
    try {
      await _processProjectDirect(normalizedPath, verbose: verbose);
      result.addSuccess();
    } catch (e) {
      stderr.writeln('Error processing $normalizedPath: $e');
      result.addFailure();
    }
  }

  // If recursive, find and process subprojects
  if (recursive) {
    final subprojects = await _findSubprojects(
      normalizedPath,
      recursionExclude: recursionExclude,
      exclude: exclude,
      verbose: verbose,
    );

    for (final subproject in subprojects) {
      // Each subproject might have its own tom_build.yaml
      final subResult = await _processProjectWithRecursion(
        subproject,
        recursive: true, // Continue recursion
        recursionExclude: recursionExclude,
        exclude: exclude,
        verbose: verbose,
      );
      result.merge(subResult);
    }
  }

  return result;
}

/// Find subprojects within a project directory.
Future<List<String>> _findSubprojects(
  String projectPath, {
  required List<String> recursionExclude,
  required List<String> exclude,
  required bool verbose,
}) async {
  final subprojects = <String>[];
  final projectDir = Directory(projectPath);

  if (!projectDir.existsSync()) return subprojects;

  await _findSubprojectsRecursive(
    projectDir,
    projectPath,
    subprojects,
    recursionExclude: recursionExclude,
  );

  // Apply project exclusions
  final filtered = _applyExclusions(subprojects, exclude);

  if (verbose && filtered.isNotEmpty) {
    print('Found ${filtered.length} subproject(s) in $projectPath:');
    for (final sub in filtered) {
      print('  - ${p.relative(sub, from: projectPath)}');
    }
  }

  return filtered;
}

/// Recursively find subprojects, respecting recursion exclusions.
Future<void> _findSubprojectsRecursive(
  Directory dir,
  String rootPath,
  List<String> subprojects, {
  required List<String> recursionExclude,
}) async {
  final recursionGlobs = recursionExclude.map((pattern) => Glob(pattern)).toList();

  try {
    for (final entity in dir.listSync()) {
      if (entity is! Directory) continue;

      final dirPath = entity.path;
      final dirName = p.basename(dirPath);
      final relativePath = p.relative(dirPath, from: rootPath);

      // Skip hidden directories and common non-project directories
      if (dirName.startsWith('.') ||
          dirName == 'build' ||
          dirName == '.dart_tool' ||
          dirName == 'node_modules') {
        continue;
      }

      // Check recursion exclusions
      bool excluded = false;
      for (final glob in recursionGlobs) {
        if (glob.matches(relativePath) || glob.matches(dirPath)) {
          excluded = true;
          break;
        }
      }
      if (excluded) continue;

      // Check if this is a D4rt project (has config)
      if (_isD4rtProject(dirPath) || _hasTomBuildYaml(dirPath)) {
        subprojects.add(p.normalize(dirPath));
      }

      // Continue recursion into subdirectories
      await _findSubprojectsRecursive(
        entity,
        rootPath,
        subprojects,
        recursionExclude: recursionExclude,
      );
    }
  } catch (e) {
    // Ignore permission errors, etc.
  }
}

/// Check if directory has tom_build.yaml with dartgen: section.
/// Uses hasTomBuildConfig from tom_build_base.
bool _hasTomBuildYaml(String dirPath) {
  return hasTomBuildConfig(dirPath, _toolKey);
}

/// Find projects matching glob patterns.
Future<List<String>> _findProjectsByGlob(
  List<String> patterns, {
  List<String> exclude = const [],
  required bool verbose,
}) async {
  final projects = <String>{};

  for (final pattern in patterns) {
    final glob = Glob(pattern);

    await for (final entity in glob.list()) {
      if (entity is Directory) {
        final dirPath = entity.path;
        if (_isD4rtProject(dirPath) || _hasTomBuildYaml(dirPath)) {
          projects.add(p.normalize(dirPath));
        }
      }
    }
  }

  // Apply exclusions
  final filtered = _applyExclusions(projects.toList(), exclude);

  if (verbose && filtered.isNotEmpty) {
    print('Found ${filtered.length} project(s) matching patterns:');
    for (final project in filtered) {
      print('  - $project');
    }
    print('');
  }

  return filtered;
}

/// Scan directory for D4rt projects.
Future<List<String>> _scanForProjects(
  String scanPath, {
  required bool recursive,
  List<String> exclude = const [],
  List<String> recursionExclude = const [],
  required bool verbose,
}) async {
  final projects = <String>[];
  final scanDir = Directory(scanPath);

  if (!scanDir.existsSync()) {
    throw Exception('Scan directory not found: $scanPath');
  }

  // Check if the scan directory itself is a project
  if (_isD4rtProject(scanPath)) {
    projects.add(p.normalize(scanPath));
  }

  if (recursive) {
    // Recursively find all projects
    await _findProjectsInDirRecursive(scanDir, projects, recursionExclude: recursionExclude);
  } else {
    // Only immediate subdirectories
    for (final entity in scanDir.listSync()) {
      if (entity is Directory && _isD4rtProject(entity.path)) {
        projects.add(p.normalize(entity.path));
      }
    }
  }

  // Apply exclusions
  final filtered = _applyExclusions(projects, exclude);

  if (verbose && filtered.isNotEmpty) {
    print('Found ${filtered.length} D4rt project(s):');
    for (final project in filtered) {
      print('  - $project');
    }
    print('');
  }

  return filtered;
}

/// Recursively find all D4rt projects in a directory.
Future<void> _findProjectsInDirRecursive(
  Directory dir,
  List<String> projects, {
  required List<String> recursionExclude,
}) async {
  final recursionGlobs = recursionExclude.map((pattern) => Glob(pattern)).toList();

  try {
    for (final entity in dir.listSync()) {
      if (entity is! Directory) continue;

      final dirPath = entity.path;
      final dirName = p.basename(dirPath);

      // Skip hidden directories and common non-project directories
      if (dirName.startsWith('.') ||
          dirName == 'build' ||
          dirName == '.dart_tool' ||
          dirName == 'node_modules') {
        continue;
      }

      // Check recursion exclusions
      bool excluded = false;
      for (final glob in recursionGlobs) {
        if (glob.matches(dirPath)) {
          excluded = true;
          break;
        }
      }
      if (excluded) continue;

      // Check if this is a D4rt project
      if (_isD4rtProject(dirPath)) {
        projects.add(p.normalize(dirPath));
      }

      // Always recurse to find subprojects
      await _findProjectsInDirRecursive(entity, projects, recursionExclude: recursionExclude);
    }
  } catch (e) {
    // Ignore permission errors, etc.
  }
}

/// Check if a directory is a D4rt project.
/// A D4rt project has pubspec.yaml AND (build.yaml with d4rt config OR d4rt_bridging.json).
bool _isD4rtProject(String dirPath) {
  final pubspecFile = File(p.join(dirPath, 'pubspec.yaml'));
  if (!pubspecFile.existsSync()) return false;

  // Skip packages that DEFINE builders (they're not consumers)
  if (isBuildYamlBuilderDefinition(dirPath)) return false;

  // Check for d4rt_bridging.json
  final jsonConfig = File(p.join(dirPath, 'd4rt_bridging.json'));
  if (jsonConfig.existsSync()) return true;

  // Check for build.yaml with D4rt consumer config (not builder definition)
  // Use BuildConfigLoader to properly parse YAML and check for consumer config
  final buildConfig = BuildConfigLoader.loadFromBuildYaml(dirPath);
  if (buildConfig != null) return true;

  return false;
}

/// Apply exclusion patterns to a list of projects.
List<String> _applyExclusions(List<String> projects, List<String> exclude) {
  if (exclude.isEmpty) return projects;

  final globs = exclude.map((pattern) => Glob(pattern)).toList();

  return projects.where((project) {
    for (final glob in globs) {
      if (glob.matches(project)) {
        return false;
      }
    }
    return true;
  }).toList();
}

/// Process a single project directory directly (no recursion).
Future<void> _processProjectDirect(String projectPath, {required bool verbose}) async {
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

  throw Exception('No D4rt configuration found in $projectPath');
}

/// Generate bridges from a BridgeConfig object.
/// This is stateless - all state is passed in as parameters.
Future<void> _generateBridges(
  BridgeConfig config,
  String projectDir, {
  required bool verbose,
}) async {
  if (verbose) {
    print('  Project: ${config.name}');
    print('  Modules: ${config.modules.length}');
  }

  // Generate bridges for each module
  for (final module in config.modules) {
    if (verbose) {
      print('  Generating module: ${module.name}');
    }

    // Determine sourceImport(s): use barrelImport if provided, otherwise barrel files
    // When there are multiple barrel files, use sourceImports for proper prefix handling
    final List<String> sourceImports;
    final String? sourceImport;
    
    if (module.barrelFiles.length > 1) {
      // Multiple barrel files - use sourceImports for multiple prefix support
      sourceImports = module.barrelFiles;
      sourceImport = module.barrelImport; // May be null, used as primary import
    } else {
      // Single barrel file - use legacy sourceImport
      sourceImport = module.barrelImport ?? module.barrelFiles.first;
      sourceImports = const [];
    }

    // Create a fresh generator instance for each module - no shared state
    final generator = BridgeGenerator(
      workspacePath: projectDir,
      packageName: config.name,
      sourceImport: sourceImport,
      sourceImports: sourceImports,
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
      followAllReExports: module.followAllReExports,
      skipReExports: module.skipReExports,
      followReExports: module.followReExports,
      importShowClause: module.importShowClause,
      importHideClause: module.importHideClause,
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

/// Process a single configuration file.
Future<void> _processConfigFile(String configPath, {required bool verbose}) async {
  if (verbose) {
    print('Processing: $configPath');
  }

  final config = BridgeConfig.fromFile(configPath);
  final projectDir = p.dirname(configPath);

  await _generateBridges(config, projectDir, verbose: verbose);
}

/// Generate barrel file that exports all bridge modules.
Future<void> _generateBarrelFile(
  String barrelPath,
  BridgeConfig config, {
  required bool verbose,
}) async {
  if (verbose) {
    print('  Generating barrel: $barrelPath');
  }
  await File(barrelPath).writeAsString(generateBarrelFileContent(config));
}

/// Generate dartscript file with combined bridge registration.
Future<void> _generateDartscriptFile(
  String dartscriptPath,
  BridgeConfig config, {
  required bool verbose,
}) async {
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
Future<void> _generateTestRunnerFile(
  String testRunnerPath,
  BridgeConfig config, {
  required bool verbose,
}) async {
  if (verbose) {
    print('  Generating test runner: $testRunnerPath');
  }
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

/// Print the build.yaml section for a project (--show option).
void _printBuildYamlSection(String projectPath, String workspaceRoot) {
  final buildYamlPath = p.join(projectPath, 'build.yaml');
  final buildYamlFile = File(buildYamlPath);
  
  if (!buildYamlFile.existsSync()) {
    print('    (no build.yaml)');
    return;
  }
  
  try {
    final content = buildYamlFile.readAsStringSync();
    final rootYaml = loadYaml(content) as YamlMap?;
    if (rootYaml == null) {
      print('    (empty build.yaml)');
      return;
    }
    
    // Navigate to tom_d4rt_generator:d4rt_bridge_builder section
    final targets = rootYaml['targets'] as YamlMap?;
    if (targets == null) {
      print('    (no targets section in build.yaml)');
      return;
    }
    
    final defaultTarget = targets[r'$default'] as YamlMap?;
    if (defaultTarget == null) {
      print('    (no \$default target in build.yaml)');
      return;
    }
    
    final builders = defaultTarget['builders'] as YamlMap?;
    if (builders == null) {
      print('    (no builders in build.yaml)');
      return;
    }
    
    final d4rtBuilder = builders['tom_d4rt_generator:d4rt_bridge_builder'] as YamlMap?;
    if (d4rtBuilder == null) {
      print('    (no tom_d4rt_generator:d4rt_bridge_builder section)');
      return;
    }
    
    // Print the d4rt_bridge_builder section as YAML
    print('    build.yaml:');
    _printYamlNode(d4rtBuilder, indent: 6);
  } catch (e) {
    print('    (error reading build.yaml: $e)');
  }
}

/// Print a YAML node with proper indentation.
void _printYamlNode(dynamic node, {int indent = 0}) {
  final prefix = ' ' * indent;
  
  if (node is YamlMap) {
    for (final entry in node.entries) {
      final key = entry.key;
      final value = entry.value;
      
      if (value is YamlMap || value is YamlList) {
        print('$prefix$key:');
        _printYamlNode(value, indent: indent + 2);
      } else {
        print('$prefix$key: $value');
      }
    }
  } else if (node is YamlList) {
    for (final item in node) {
      if (item is YamlMap) {
        // Print first key on same line as dash
        final entries = item.entries.toList();
        if (entries.isNotEmpty) {
          final first = entries.first;
          if (first.value is YamlMap || first.value is YamlList) {
            print('$prefix- ${first.key}:');
            _printYamlNode(first.value, indent: indent + 4);
          } else {
            print('$prefix- ${first.key}: ${first.value}');
          }
          // Print remaining keys indented
          for (var i = 1; i < entries.length; i++) {
            final entry = entries[i];
            if (entry.value is YamlMap || entry.value is YamlList) {
              print('$prefix  ${entry.key}:');
              _printYamlNode(entry.value, indent: indent + 4);
            } else {
              print('$prefix  ${entry.key}: ${entry.value}');
            }
          }
        }
      } else if (item is YamlList) {
        print('$prefix-');
        _printYamlNode(item, indent: indent + 2);
      } else {
        print('$prefix- $item');
      }
    }
  } else {
    print('$prefix$node');
  }
}

void _printUsage(ArgParser parser) {
  print('D4rt Bridge Generator (d4rtgen)');
  print('');
  print('Generates D4rt bridges from build.yaml or d4rt_bridging.json configuration.');
  print('');
  print('Usage:');
  print('  d4rtgen [options]');
  print('  dart run tom_d4rt_generator:d4rtgen [options]');
  print('');
  print('Options:');
  print(parser.usage);
  print('');
  print('Configuration File (tom_build.yaml):');
  print('  Each project can have a tom_build.yaml file with a dartgen: section.');
  print('  When recursing into subprojects, the tool uses each project\'s config.');
  print('');
  print('    # tom_build.yaml');
  print('    dartgen:');
  print('      recursive: true');
  print('      recursion-exclude:');
  print('        - "**/node_modules/**"');
  print('        - "**/build/**"');
  print('      exclude:');
  print('        - "**/test_*"');
  print('      verbose: true');
  print('');
  print('Project Detection:');
  print('  A D4rt project is a directory with:');
  print('    - pubspec.yaml, AND');
  print('    - Either build.yaml (with d4rt_bridge_builder config)');
  print('    - Or d4rt_bridging.json');
  print('    - Or tom_build.yaml with dartgen: section');
  print('');
  print('Recursion Behavior:');
  print('  With --recursive, the tool:');
  print('  1. Processes the specified project(s)');
  print('  2. Finds subprojects in subdirectories');
  print('  3. For each subproject with tom_build.yaml, uses that config');
  print('  4. Otherwise, processes directly');
  print('');
  print('Examples:');
  print('  # Process current directory');
  print('  d4rtgen');
  print('');
  print('  # Process project and all subprojects');
  print('  d4rtgen --project=my_app --recursive');
  print('');
  print('  # Process with recursion exclusions');
  print('  d4rtgen -p my_app -r --recursion-exclude="**/generated/**"');
  print('');
  print('  # Scan workspace for all D4rt projects');
  print('  d4rtgen --scan=. --recursive');
  print('');
  print('  # Multiple exclusion patterns');
  print('  d4rtgen -s . -r -x "**/test_*" -R "**/node_modules/**"');
}

void _printVersion() {
  print('D4rt Bridge Generator ${TomVersionInfo.versionShort}');
  print('Git: ${TomVersionInfo.gitCommit}');
  print('Built: ${TomVersionInfo.buildTime}');
}
