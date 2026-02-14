/// D4rtgen v2 — Command executor.
///
/// Wraps the existing bridge generation logic to work with the v2
/// ToolRunner framework.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart'
    show TomBuildConfig, hasTomBuildConfig, ProjectDiscovery;
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';
import 'package:yaml/yaml.dart';

const _toolKey = 'd4rtgen';

// =============================================================================
// D4rtgen Executor
// =============================================================================

/// Default executor for the d4rtgen tool (single-command).
class D4rtgenExecutor extends CommandExecutor {
  @override
  Future<ItemResult> execute(CommandContext context, CliArgs args) async {
    // Skip projects without d4rtgen config
    if (!hasTomBuildConfig(context.path, _toolKey)) {
      return ItemResult.success(path: context.path, name: context.name);
    }

    // Handle --list mode
    if (args.listOnly) {
      final workspaceRoot =
          ProjectDiscovery.findWorkspaceRoot(context.executionRoot);
      final relativePath = p.relative(context.path, from: workspaceRoot);
      print('  $relativePath');

      if (args.extraOptions['show'] == true) {
        _printBuildYamlSection(context.path, workspaceRoot);
      }
      return ItemResult.success(path: context.path, name: context.name);
    }

    // Handle --dump-config mode
    if (args.dumpConfig) {
      final workspaceRoot =
          ProjectDiscovery.findWorkspaceRoot(context.executionRoot);
      final relativePath = p.relative(context.path, from: workspaceRoot);
      print('# $relativePath');
      _printEffectiveConfig(context.path);
      print('');
      return ItemResult.success(path: context.path, name: context.name);
    }

    try {
      await _processProjectDirect(context.path, verbose: args.verbose);
      return ItemResult.success(path: context.path, name: context.name);
    } catch (e, st) {
      stderr.writeln('Error processing ${context.path}: $e');
      if (args.verbose) stderr.writeln(st);
      return ItemResult.failure(
        path: context.path,
        name: context.name,
        error: '$e',
      );
    }
  }
}

// =============================================================================
// Processing Logic (moved from bin/d4rtgen.dart)
// =============================================================================

/// Process a single project directory directly.
Future<void> _processProjectDirect(String projectPath,
    {required bool verbose}) async {
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

  throw Exception(
      'No d4rtgen configuration found in $projectPath/buildkit.yaml');
}

/// Generate bridges from a BridgeConfig object.
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

    // Determine sourceImport(s)
    final List<String> sourceImports;
    final String? sourceImport;

    if (module.barrelFiles.length > 1) {
      sourceImports = module.barrelFiles;
      sourceImport = module.barrelImport;
    } else {
      sourceImport = module.barrelImport ?? module.barrelFiles.first;
      sourceImports = const [];
    }

    // Create a fresh generator instance for each module
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
    final barrelPath =
        p.join(projectDir, ensureBDartExtension(config.barrelPath!));
    await _generateBarrelFile(barrelPath, config, verbose: verbose);
  }

  // Generate dartscript file if requested
  if (config.generateDartscript && config.dartscriptPath != null) {
    final dartscriptPath =
        p.join(projectDir, ensureBDartExtension(config.dartscriptPath!));
    await _generateDartscriptFile(dartscriptPath, config, verbose: verbose);
  }

  // Generate test runner file if requested
  if (config.generateTestRunner && config.testRunnerPath != null) {
    final testRunnerPath =
        p.join(projectDir, ensureBDartExtension(config.testRunnerPath!));
    await _generateTestRunnerFile(testRunnerPath, config, verbose: verbose);
  }

  if (verbose) {
    print('  Complete');
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
    generateDartscriptFileContent(config,
        dartscriptPath: normalizedDartscriptPath),
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
    generateTestRunnerContent(config,
        testRunnerPath: normalizedTestRunnerPath),
  );
}

/// Print the effective merged configuration as JSON (--dump-config option).
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
  final buildkitYamlPath =
      p.join(projectPath, TomBuildConfig.projectFilename);
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
        final entries = item.entries.toList();
        if (entries.isNotEmpty) {
          final first = entries.first;
          if (first.value is YamlMap || first.value is YamlList) {
            print('$prefix- ${first.key}:');
            _printYamlNode(first.value, indent: indent + 4);
          } else {
            print('$prefix- ${first.key}: ${first.value}');
          }
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

// =============================================================================
// Factory
// =============================================================================

/// Create executor map for the d4rtgen tool.
Map<String, CommandExecutor> createD4rtgenExecutors() {
  return {
    'default': D4rtgenExecutor(),
  };
}
