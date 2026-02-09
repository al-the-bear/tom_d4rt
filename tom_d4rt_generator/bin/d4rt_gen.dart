#!/usr/bin/env dart
/// D4rt Bridge Generator CLI (d4rtgen)
///
/// Command-line interface for generating D4rt bridges from configuration files.
///
/// ## Configuration Sources (in order of precedence)
///
/// 1. Command-line arguments
/// 2. `buildkit.yaml` (d4rtgen: section) in project directory
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
/// # Process from workspace root
/// d4rtgen -R
///
/// # Show help
/// d4rtgen --help
/// ```
///
/// ## Tool Options
///   -c, --config           Path to specific buildkit.yaml file
///   -v, --verbose          Show detailed output
///   -l, --list             List projects that would be processed
///   --show                 With --list, show buildkit.yaml d4rtgen configuration
///   -h, --help             Show usage help
///
/// ## Navigation Options (common to all Tom build tools)
///   -s, --scan             Scan directory for projects
///   -r, --recursive        Scan directories recursively
///   -b, --build-order      Sort projects in dependency build order
///   -p, --project          Project(s) to run (comma-separated, globs supported)
///   -R, --root             Workspace root (bare: detected, path: specified)
///   -w, --workspace-recursion  Shell out to sub-workspaces
///   -i, --inner-first-git  Scan git repos, process innermost first
///   -o, --outer-first-git  Scan git repos, process outermost first
///   -x, --exclude          Exclude patterns (path-based globs)
///   --exclude-projects     Exclude projects by name or path
///   --recursion-exclude    Exclude patterns during recursive scan
library;

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/src/version.g.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';
import 'package:yaml/yaml.dart';

/// The tool key for d4rtgen in buildkit.yaml
const _toolKey = 'd4rtgen';

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
  // Check for help command first (before parsing)
  if (isHelpCommand(arguments)) {
    _printUsage(null);
    exit(0);
  }

  // Check for version command first (before parsing)
  if (isVersionCommand(arguments)) {
    _printVersion();
    exit(0);
  }

  // Preprocess args for bare -R detection
  final (processedArgs, bareRoot) = preprocessRootFlag(arguments);

  final parser = ArgParser()
    // Tool-specific options
    ..addOption('config',
        abbr: 'c',
        help: 'Path to specific buildkit.yaml file')
    ..addFlag('verbose',
        abbr: 'v',
        negatable: false,
        help: 'Show detailed output')
    ..addFlag('list',
        abbr: 'l',
        negatable: false,
        help: 'List projects that would be processed (no action)')
    ..addFlag('show',
        help: 'With --list, show buildkit.yaml d4rtgen configuration for each project',
        negatable: false)
    ..addFlag('dump-config',
        help: 'Print effective merged configuration as JSON (no action)',
        negatable: false)
    ..addFlag('help',
        abbr: 'h',
        negatable: false,
        help: 'Show usage help');
  
  // Add standard navigation options
  addNavigationOptions(parser);

  final ArgResults args;
  try {
    args = parser.parse(processedArgs);

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

  // Parse navigation options
  final navArgs = parseNavigationArgs(args, bareRoot: bareRoot);
  final currentDir = Directory.current.path;
  
  // Resolve execution root based on navigation mode
  String executionRoot;
  try {
    executionRoot = resolveExecutionRoot(navArgs, currentDir: currentDir);
  } on ArgumentError catch (e) {
    stderr.writeln('Error: ${e.message}');
    exit(1);
  }

  final verbose = args['verbose'] as bool;
  
  // Apply defaults (--scan . --recursive --build-order) if no explicit navigation
  final effectiveNavArgs = navArgs.withDefaults();

  // Handle --list mode: just list projects without processing
  final listOnly = args['list'] as bool;
  final showConfig = args['show'] as bool;
  if (listOnly) {
    final projects = await _collectProjectsFromNavArgs(effectiveNavArgs, executionRoot, verbose);
    final workspaceRoot = ProjectDiscovery.findWorkspaceRoot(executionRoot);
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

  // Handle --dump-config mode: print effective merged configuration as JSON (GEN-024)
  final dumpConfig = args['dump-config'] as bool;
  if (dumpConfig) {
    final projects = await _collectProjectsFromNavArgs(effectiveNavArgs, executionRoot, verbose);
    final workspaceRoot = ProjectDiscovery.findWorkspaceRoot(executionRoot);
    if (projects.isEmpty) {
      print('No d4rtgen projects found.');
    } else {
      for (final project in projects) {
        final relativePath = p.relative(project, from: workspaceRoot);
        print('# $relativePath');
        _printEffectiveConfig(project);
        print('');
      }
    }
    exit(0);
  }

  try {
    final result = await _runWithNavArgs(effectiveNavArgs, executionRoot, verbose);

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

/// Collect all projects that would be processed using navigation args.
Future<List<String>> _collectProjectsFromNavArgs(
  WorkspaceNavigationArgs navArgs,
  String basePath,
  bool verbose,
) async {
  final discovery = ProjectDiscovery(verbose: verbose);

  // Handle --project with patterns (comma-separated, globs, etc.)
  if (navArgs.project != null) {
    return discovery.resolveProjectPatterns(
      navArgs.project!,
      basePath: basePath,
      projectFilter: _isD4rtProject,
    );
  }

  // Scan directory for projects
  if (navArgs.scan != null) {
    final scanPath = p.isAbsolute(navArgs.scan!)
        ? navArgs.scan!
        : p.join(basePath, navArgs.scan!);

    final projects = await discovery.scanForProjects(
      scanPath,
      recursive: navArgs.recursive,
      toolKey: _toolKey,
      recursionExclude: navArgs.recursionExclude,
    );
    return _filterD4rtProjects(projects, navArgs.exclude);
  }

  // Default: process current directory if it's a D4rt project
  if (_isD4rtProject(basePath)) {
    return [basePath];
  }

  return [];
}

/// Run the generator using navigation args.
Future<ProcessingResult> _runWithNavArgs(
  WorkspaceNavigationArgs navArgs,
  String basePath,
  bool verbose,
) async {
  final result = ProcessingResult();
  final projects = await _collectProjectsFromNavArgs(navArgs, basePath, verbose);

  if (projects.isEmpty) {
    stderr.writeln('No D4rt projects found.');
    return result;
  }

  for (final projectPath in projects) {
    final subResult = await _processProjectWithRecursion(
      projectPath,
      recursive: navArgs.recursive,
      recursionExclude: navArgs.recursionExclude,
      exclude: navArgs.exclude,
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

  // Check if this project has its own buildkit.yaml
  final projectConfig = TomBuildConfig.load(
    dir: normalizedPath,
    toolKey: _toolKey,
  );
  if (projectConfig != null) {
    if (verbose) {
      print('Found buildkit.yaml in $normalizedPath');
    }
    // Validate project config paths are contained within project
    final validationError = _validatePathContainment(projectConfig, normalizedPath);
    if (validationError != null) {
      stderr.writeln('Error in $normalizedPath/buildkit.yaml: $validationError');
      result.addFailure();
      return result;
    }
    // Process project directly using its buildkit.yaml configuration.
    // Note: We call _processProjectDirect instead of _runWithConfig to avoid
    // infinite recursion. The project-level config contains toolOptions (modules,
    // excludeClasses, etc.) which _processProjectDirect reads via
    // BuildConfigLoader. Calling _runWithConfig with project: set would loop
    // back into _processProjectWithRecursion endlessly.
    try {
      await _processProjectDirect(normalizedPath, verbose: verbose);
      result.addSuccess();
    } catch (e) {
      stderr.writeln('Error processing $normalizedPath: $e');
      result.addFailure();
    }
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
      // Each subproject might have its own buildkit.yaml
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

/// Find subprojects within a project directory using ProjectDiscovery.
Future<List<String>> _findSubprojects(
  String projectPath, {
  required List<String> recursionExclude,
  required List<String> exclude,
  required bool verbose,
}) async {
  final discovery = ProjectDiscovery(verbose: verbose);
  final allProjects = await discovery.scanForProjects(
    projectPath,
    recursive: true,
    toolKey: _toolKey,
    recursionExclude: recursionExclude,
  );

  // Remove the root project itself — we only want subprojects
  final normalizedRoot = p.normalize(p.absolute(projectPath));
  final subprojects = allProjects
      .where((path) => p.normalize(p.absolute(path)) != normalizedRoot)
      .toList();

  final filtered = _filterD4rtProjects(subprojects, exclude);

  if (verbose && filtered.isNotEmpty) {
    print('Found ${filtered.length} subproject(s) in $projectPath:');
    for (final sub in filtered) {
      print('  - ${p.relative(sub, from: projectPath)}');
    }
  }

  return filtered;
}

/// Check if a directory is a D4rt project.
/// A D4rt project has pubspec.yaml AND buildkit.yaml with a d4rtgen: section.
bool _isD4rtProject(String dirPath) {
  final pubspecFile = File(p.join(dirPath, 'pubspec.yaml'));
  if (!pubspecFile.existsSync()) return false;

  // Check for buildkit.yaml with d4rtgen: section
  return hasTomBuildConfig(dirPath, _toolKey);
}

/// Filter a project list to only D4rt projects and apply exclusion patterns.
List<String> _filterD4rtProjects(List<String> projects, List<String> exclude) {
  var filtered = projects.where(_isD4rtProject).toList();
  if (exclude.isEmpty) return filtered;

  final globs = exclude.map((pattern) => Glob(pattern)).toList();
  return filtered.where((project) {
    final dirName = p.basename(project);
    for (final glob in globs) {
      if (glob.matches(project) || glob.matches(dirName)) return false;
    }
    return true;
  }).toList();
}

/// Process a single project directory directly (no recursion).
Future<void> _processProjectDirect(String projectPath, {required bool verbose}) async {
  if (verbose) {
    print('Processing project: $projectPath');
  }

  // Load from buildkit.yaml d4rtgen: section
  final config = BuildConfigLoader.loadFromTomBuildYaml(projectPath);

  if (config != null) {
    if (verbose) {
      print('  Using configuration from buildkit.yaml');
    }
    await _generateBridges(config, projectPath, verbose: verbose);
    return;
  }

  throw Exception('No d4rtgen configuration found in $projectPath/buildkit.yaml');
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

/// Print the effective merged configuration as JSON (--dump-config option).
/// GEN-024: Provides transparency into the merged configuration.
void _printEffectiveConfig(String projectPath) {
  final config = BuildConfigLoader.loadFromTomBuildYaml(projectPath);
  
  if (config == null) {
    print('  (no d4rtgen configuration found)');
    return;
  }
  
  // Convert to JSON and pretty-print
  final jsonEncoder = JsonEncoder.withIndent('  ');
  final jsonString = jsonEncoder.convert(config.toJson());
  
  // Print with proper indentation
  for (final line in jsonString.split('\n')) {
    print(line);
  }
}

/// Print the buildkit.yaml d4rtgen section for a project (--show option).
void _printBuildYamlSection(String projectPath, String workspaceRoot) {
  final buildkitYamlPath = p.join(projectPath, TomBuildConfig.projectFilename);
  final buildkitYamlFile = File(buildkitYamlPath);
  
  if (!buildkitYamlFile.existsSync()) {
    print('    (no buildkit.yaml)');
    return;
  }
  
  try {
    final content = buildkitYamlFile.readAsStringSync();
    final rootYaml = loadYaml(content) as YamlMap?;
    if (rootYaml == null) {
      print('    (empty buildkit.yaml)');
      return;
    }
    
    final d4rtgenSection = rootYaml['d4rtgen'] as YamlMap?;
    if (d4rtgenSection == null) {
      print('    (no d4rtgen section in buildkit.yaml)');
      return;
    }
    
    // Print the d4rtgen section as YAML
    print('    d4rtgen:');
    _printYamlNode(d4rtgenSection, indent: 6);
  } catch (e) {
    print('    (error reading buildkit.yaml: $e)');
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

void _printUsage(ArgParser? parser) {
  // Print header
  for (final line in getToolHelpHeader(
    toolName: 'D4rtgen',
    toolDescription: 'Generates D4rt bridges from configuration files',
    usagePatterns: [
      'd4rtgen [options]',
      'dart run tom_d4rt_generator:d4rtgen [options]',
      'd4rtgen help',
      'd4rtgen version',
    ],
  )) {
    print(line);
  }

  print('Tool Options:');
  print('  -c, --config=<path>  Path to specific buildkit.yaml file');
  print('  -v, --verbose        Show detailed output');
  print('  -l, --list           List projects that would be processed (no action)');
  print('      --show           With --list, show buildkit.yaml d4rtgen configuration');
  print('  -h, --help           Show usage help');
  print('');

  // Print navigation options
  printNavigationOptionsHelp();
  print('');

  print('Configuration File (buildkit.yaml):');
  print('  Each project must have a buildkit.yaml file with a d4rtgen: section.');
  print('  When recursing into subprojects, the tool uses each project\'s config.');
  print('');
  print('    # buildkit.yaml');
  print('    d4rtgen:');
  print('      name: my_project');
  print('      helpersImport: package:tom_d4rt/tom_d4rt.dart');
  print('      generateBarrel: true');
  print('      barrelPath: lib/d4rt_bridges.b.dart');
  print('      modules:');
  print('        - name: my_module');
  print('          barrelFiles:');
  print('            - package:my_project/my_module.dart');
  print('          outputPath: lib/src/bridges/my_module_bridges.b.dart');
  print('');
  print('Project Detection:');
  print('  A D4rt project is a directory with:');
  print('    - pubspec.yaml, AND');
  print('    - buildkit.yaml with a d4rtgen: section');
  print('');

  // Print footer with examples
  for (final line in getToolHelpFooter(toolName: 'd4rtgen')) {
    print(line);
  }
}

void _printVersion() {
  print('D4rt Bridge Generator ${D4rtGenVersionInfo.versionShort}');
  print('Git: ${D4rtGenVersionInfo.gitCommit}');
  print('Built: ${D4rtGenVersionInfo.buildTime}');
}
