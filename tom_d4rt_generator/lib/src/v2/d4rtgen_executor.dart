/// D4rtgen v2 — Command executor.
///
/// Wraps the existing bridge generation logic to work with the v2
/// ToolRunner framework.
library;

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart'
    show TomBuildConfig, hasTomBuildConfig, findWorkspaceRoot;
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/src/user_bridge_scanner.dart';
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
      final workspaceRoot = findWorkspaceRoot(context.executionRoot);
      final relativePath = p.relative(context.path, from: workspaceRoot);
      print('  $relativePath');

      if (args.extraOptions['show'] == true) {
        _printBuildYamlSection(context.path, workspaceRoot);
      }
      return ItemResult.success(path: context.path, name: context.name);
    }

    // Handle --dump-config mode
    if (args.dumpConfig) {
      final workspaceRoot = findWorkspaceRoot(context.executionRoot);
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
Future<void> _processProjectDirect(
  String projectPath, {
  required bool verbose,
}) async {
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
    'No d4rtgen configuration found in $projectPath/buildkit.yaml',
  );
}

/// Scan user bridge files in d4rt_user_bridges directories.
///
/// User bridge files should be placed in:
/// - `lib/src/d4rt_user_bridges/` for package projects
/// - `lib/d4rt_user_bridges/` for console projects
Future<UserBridgeScanner> _scanUserBridges(
  String projectDir, {
  required bool verbose,
}) async {
  final scanner = UserBridgeScanner();

  final userBridgeDirs = [
    p.join(projectDir, 'lib', 'src', 'd4rt_user_bridges'),
    p.join(projectDir, 'lib', 'd4rt_user_bridges'),
  ];

  for (final dirPath in userBridgeDirs) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) continue;

    if (verbose) {
      print('  Scanning user bridges in $dirPath');
    }

    await for (final entity in dir.list(recursive: true)) {
      if (entity is! File) continue;
      if (!entity.path.endsWith('.dart')) continue;

      try {
        final content = await entity.readAsString();
        final parseResult = parseString(
          content: content,
          featureSet: FeatureSet.latestLanguageVersion(),
        );
        scanner.scanUnit(parseResult.unit, entity.path);
      } catch (e) {
        if (verbose) {
          stderr.writeln('Warning: Failed to parse user bridge ${entity.path}: $e');
        }
      }
    }
  }

  // Report what was found
  final classCount = scanner.userBridges.length;
  final globalsCount = scanner.globalsUserBridges.length;
  if (classCount > 0 || globalsCount > 0) {
    print(
      '  USER-BRIDGE: Found $classCount class user bridges and $globalsCount globals user bridges',
    );
  }

  return scanner;
}

/// Generate bridges from a BridgeConfig object.
Future<void> _generateBridges(
  BridgeConfig config,
  String projectDir, {
  required bool verbose,
}) async {
  final effectivePackageName =
      BuildConfigLoader.getPackageName(projectDir) ?? config.name;

  if (verbose) {
    print('  Project: ${config.name}');
    print('  Modules: ${config.modules.length}');
  }

  // Scan for user bridges before processing modules
  final userBridgeScanner = await _scanUserBridges(projectDir, verbose: verbose);

  // GEN-079: Collect class lookup across modules for relaxer generation.
  final globalClassLookup = <String, ClassInfo>{};

  // GEN-079: Collect generic extraction sites and GEN-075 classes
  // across all modules for relaxer generation.
  final allExtractionSites = <GenericExtractionSite>[];
  final allGen075Classes = <String>{};

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
    // Pass the shared UserBridgeScanner to enable constructor overrides
    final generator = BridgeGenerator(
      workspacePath: projectDir,
      packageName: config.name,
      sourceImport: sourceImport,
      sourceImports: sourceImports,
      helpersImport: config.helpersImport ?? 'package:tom_d4rt/tom_d4rt.dart',
      d4rtImport: config.d4rtImport ?? 'package:tom_d4rt/d4rt.dart',
      verbose: verbose,
      userBridgeScanner: userBridgeScanner,
    );

    // Resolve barrel files
    final barrelFiles = module.barrelFiles.map((f) {
      if (f.startsWith('package:') || f.startsWith('dart:')) {
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
    // GEN-079: Accumulate class lookup for relaxer generation
    globalClassLookup.addAll(generator.classLookup);
    // GEN-079: Accumulate generic extraction sites and GEN-075 classes
    allExtractionSites.addAll(generator.genericExtractionSites);
    allGen075Classes.addAll(generator.gen075Classes);
  }

  // Generate barrel file if requested
  if (config.generateBarrel && config.barrelPath != null) {
    final barrelPath = p.join(
      projectDir,
      ensureBDartExtension(config.barrelPath!),
    );
    await _generateBarrelFile(barrelPath, config, verbose: verbose);
  }

  // Generate dartscript file if requested
  if (config.generateDartscript && config.dartscriptPath != null) {
    final dartscriptPath = p.join(
      projectDir,
      ensureBDartExtension(config.dartscriptPath!),
    );
    await _generateDartscriptFile(
      dartscriptPath,
      config,
      packageName: effectivePackageName,
      verbose: verbose,
    );
  }

  // Generate test runner file if requested
  if (config.generateTestRunner && config.testRunnerPath != null) {
    final testRunnerPath = p.join(
      projectDir,
      ensureBDartExtension(config.testRunnerPath!),
    );
    await _generateTestRunnerFile(
      testRunnerPath,
      config,
      packageName: effectivePackageName,
      verbose: verbose,
    );
  }

  // Generate proxy classes if requested (GEN-083)
  if (config.generateProxies && config.proxyClasses.isNotEmpty) {
    final proxyResult = await generateProxies(
      config: config,
      projectPath: projectDir,
    );

    if (proxyResult.errors.isNotEmpty) {
      for (final error in proxyResult.errors) {
        print('  PROXY ERROR: $error');
      }
    }

    if (proxyResult.proxies.isNotEmpty) {
      print(
        '  GEN-083: Generated ${proxyResult.proxies.length} proxy classes'
        ' → ${proxyResult.outputFile}',
      );
    }
  }

  // Generate relaxer wrappers (GEN-079) — always runs, output path
  // auto-derived from first module when not explicitly configured.
  {
    final relaxerResult = await generateRelaxers(
      config: config,
      projectPath: projectDir,
      globalClassLookup: globalClassLookup,
      genericExtractionSites: allExtractionSites,
      gen075Classes: allGen075Classes,
    );
    if (relaxerResult.errors.isNotEmpty) {
      for (final error in relaxerResult.errors) {
        print('  RELAXER ERROR: $error');
      }
    }
    if (relaxerResult.wrapperClassesGenerated > 0) {
      print(
        '  GEN-079: Generated ${relaxerResult.wrapperClassesGenerated} relaxer wrappers'
        ' (${relaxerResult.factoryFunctionsGenerated} factories)'
        ' → ${relaxerResult.outputFile}',
      );
    }
    for (final warning in relaxerResult.warnings) {
      print('  GEN-079 WARNING: $warning');
    }
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
  required String packageName,
  required bool verbose,
}) async {
  if (verbose) {
    print('  Generating dartscript: $dartscriptPath');
  }
  final normalizedDartscriptPath = config.dartscriptPath != null
      ? ensureBDartExtension(config.dartscriptPath!)
      : null;
  await File(dartscriptPath).writeAsString(
    generateDartscriptFileContent(
      config,
      dartscriptPath: normalizedDartscriptPath,
      packageName: packageName,
    ),
  );
}

/// Generate test runner file for testing bridges.
Future<void> _generateTestRunnerFile(
  String testRunnerPath,
  BridgeConfig config, {
  required String packageName,
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
    generateTestRunnerContent(
      config,
      testRunnerPath: normalizedTestRunnerPath,
      packageName: packageName,
    ),
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
  return {'default': D4rtgenExecutor()};
}
