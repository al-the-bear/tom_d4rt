/// Astgen v2 — Command executor.
///
/// Wraps the existing AST conversion logic to work with the v2
/// ToolRunner framework.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart'
    show TomBuildConfig, hasTomBuildConfig, findWorkspaceRoot;
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:yaml/yaml.dart';

import 'package:tom_ast_generator/tom_ast_generator.dart';

const _toolKey = 'astgen';

// =============================================================================
// Astgen Executor
// =============================================================================

/// Default executor for the astgen tool (single-command).
class AstgenExecutor extends CommandExecutor {
  @override
  Future<ItemResult> execute(CommandContext context, CliArgs args) async {
    // Skip projects without astgen config
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

    // Show project being processed
    final displayPath = p.relative(context.path, from: context.executionRoot);
    print('  $displayPath');

    if (args.verbose) {
      print('=' * 60);
    }

    try {
      final success = await _processProject(
        context.path,
        TomBuildConfig.projectFilename,
        args.verbose,
        args.dryRun,
      );

      return success
          ? ItemResult.success(path: context.path, name: context.name)
          : ItemResult.failure(
              path: context.path,
              name: context.name,
              error: 'AST generation failed',
            );
    } catch (e, stack) {
      stderr.writeln('Error processing ${context.path}: $e');
      if (args.verbose) stderr.writeln(stack);
      return ItemResult.failure(
        path: context.path,
        name: context.name,
        error: '$e',
      );
    }
  }
}

// =============================================================================
// Processing Logic (moved from bin/astgen.dart)
// =============================================================================

class _ConversionConfig {
  final String entrypoints;
  final List<String> exclude;
  final String output;
  final String root;
  final bool preserveStructure;
  final bool includeSourcemap;
  final bool includeImports;
  final int importDepth;
  final bool includeRelativeImports;

  _ConversionConfig({
    required this.entrypoints,
    required this.exclude,
    required this.output,
    required this.root,
    required this.preserveStructure,
    required this.includeSourcemap,
    required this.includeImports,
    required this.importDepth,
    required this.includeRelativeImports,
  });
}

/// Process a single project.
Future<bool> _processProject(
  String projectPath,
  String configFileName,
  bool verbose,
  bool dryRun,
) async {
  // Load conversion configurations from buildkit.yaml
  final configPath = p.join(projectPath, configFileName);
  final configs = _loadConfig(configPath, verbose);
  if (configs == null) {
    return false;
  }

  // Change to project directory for processing
  final originalDir = Directory.current.path;
  Directory.current = projectPath;

  try {
    // Process conversions
    final converter = AstConverter();
    var totalFiles = 0;
    var successCount = 0;
    var errorCount = 0;

    for (final conversionConfig in configs) {
      if (verbose) {
        print('\nProcessing conversion:');
        print('  Root: ${conversionConfig.root}');
        print('  Entrypoints: ${conversionConfig.entrypoints}');
        if (conversionConfig.exclude.isNotEmpty) {
          print('  Exclude: ${conversionConfig.exclude}');
        }
        print('  Output: ${conversionConfig.output}');
        print('  Preserve structure: ${conversionConfig.preserveStructure}');
        print('  Include sourcemap: ${conversionConfig.includeSourcemap}');
        print('  Include imports: ${conversionConfig.includeImports}');
        if (conversionConfig.includeImports) {
          print('  Import depth: ${conversionConfig.importDepth}');
          print(
            '  Include relative imports: ${conversionConfig.includeRelativeImports}',
          );
        }
      }

      // Resolve output directory
      final resolvedOutput = _resolveOutputPath(
        conversionConfig.output,
        verbose,
      );
      if (resolvedOutput == null) {
        print(
          'Error: Failed to resolve output path: ${conversionConfig.output}',
        );
        errorCount++;
        continue;
      }

      // Resolve entrypoint files
      final files = _findFiles(
        conversionConfig.entrypoints,
        conversionConfig.exclude,
        conversionConfig.root,
        verbose,
      );

      if (files.isEmpty) {
        print(
          'Warning: No files matched pattern: ${conversionConfig.entrypoints}',
        );
        continue;
      }

      totalFiles += files.length;

      // Process each file
      for (final file in files) {
        final relativePath = p.relative(file, from: conversionConfig.root);
        final outputPath = _getOutputPath(
          file,
          conversionConfig.root,
          resolvedOutput,
          conversionConfig.preserveStructure,
        );

        if (verbose || dryRun) {
          print('  ${dryRun ? '[DRY RUN] ' : ''}$relativePath -> $outputPath');
        }

        if (!dryRun) {
          _convertFile(file, outputPath, converter, conversionConfig, verbose);
          successCount++;
        }
      }
    }

    // Summary for this project
    if (verbose) {
      print('\n${dryRun ? 'Would convert' : 'Converted'} $totalFiles file(s)');
      if (!dryRun) {
        print('  Success: $successCount');
        if (errorCount > 0) {
          print('  Errors: $errorCount');
          return false;
        }
      }
    }

    return true;
  } finally {
    // Restore original directory
    Directory.current = originalDir;
  }
}

List<_ConversionConfig>? _loadConfig(String configPath, bool verbose) {
  final configFile = File(configPath);

  if (!configFile.existsSync()) {
    print('Error: Configuration file not found: $configPath');
    return null;
  }

  try {
    final yamlString = configFile.readAsStringSync();
    final yaml = loadYaml(yamlString) as YamlMap;

    if (!yaml.containsKey('astgen')) {
      print('Error: No "astgen" section found in $configPath');
      return null;
    }

    final astgenConfig = yaml['astgen'] as YamlMap;

    if (!astgenConfig.containsKey('convert')) {
      print('Error: No "convert" section found in astgen configuration');
      return null;
    }

    final convertList = astgenConfig['convert'] as YamlList;
    final configs = <_ConversionConfig>[];

    for (final item in convertList) {
      final config = item as YamlMap;

      final entrypoints = config['entrypoints'] as String?;
      final output = config['output'] as String?;
      final root = config['root'] as String? ?? '.';

      // Parse exclude list
      final exclude = <String>[];
      if (config.containsKey('exclude')) {
        final excludeValue = config['exclude'];
        if (excludeValue is YamlList) {
          exclude.addAll(excludeValue.map((e) => e.toString()));
        } else if (excludeValue is String) {
          exclude.add(excludeValue);
        }
      }

      // Parse options with defaults
      final preserveStructure = config['preserve_structure'] as bool? ?? false;
      final includeSourcemap = config['include_sourcemap'] as bool? ?? false;
      final includeImports = config['include_imports'] as bool? ?? false;
      final importDepth = config['import_depth'] as int? ?? 1;
      final includeRelativeImports =
          config['include_relative_imports'] as bool? ?? true;

      if (entrypoints == null) {
        print('Error: Missing "entrypoints" in conversion configuration');
        return null;
      }

      if (output == null) {
        print('Error: Missing "output" in conversion configuration');
        return null;
      }

      configs.add(
        _ConversionConfig(
          entrypoints: entrypoints,
          exclude: exclude,
          output: output,
          root: root,
          preserveStructure: preserveStructure,
          includeSourcemap: includeSourcemap,
          includeImports: includeImports,
          importDepth: importDepth,
          includeRelativeImports: includeRelativeImports,
        ),
      );
    }

    if (verbose) {
      print(
        'Loaded ${configs.length} conversion configuration(s) from $configPath',
      );
    }

    return configs;
  } catch (e) {
    print('Error parsing configuration file: $e');
    return null;
  }
}

List<String> _findFiles(
  String pattern,
  List<String> excludePatterns,
  String root,
  bool verbose,
) {
  final glob = Glob(pattern);
  final excludeGlobs = excludePatterns.map((p) => Glob(p)).toList();
  final files = <String>[];

  // Change to root directory for glob matching
  final originalDir = Directory.current.path;
  Directory.current = root;

  try {
    for (final entity in glob.listSync()) {
      if (entity is File) {
        final filePath = entity.path;

        // Check if file matches any exclude pattern
        var excluded = false;
        for (final excludeGlob in excludeGlobs) {
          if (excludeGlob.matches(filePath)) {
            excluded = true;
            if (verbose) {
              print('  Excluding: $filePath');
            }
            break;
          }
        }

        if (!excluded) {
          files.add(p.join(root, filePath));
        }
      }
    }
  } finally {
    Directory.current = originalDir;
  }

  if (verbose && files.isNotEmpty) {
    print('  Found ${files.length} file(s) matching pattern: $pattern');
  }

  return files;
}

String? _resolveOutputPath(String outputTemplate, bool verbose) {
  // Handle project:name/path notation
  final projectPattern = RegExp(r'^project:([^/]+)(.*)$');
  final match = projectPattern.firstMatch(outputTemplate);

  if (match != null) {
    final projectName = match.group(1)!;
    var subPath = match.group(2) ?? '';

    // Remove leading slash from subPath if present
    if (subPath.startsWith('/')) {
      subPath = subPath.substring(1);
    }

    // Search for project in workspace
    final projectPath = _findProjectInWorkspace(projectName, verbose);
    if (projectPath == null) {
      print('Error: Project "$projectName" not found in workspace');
      return null;
    }

    return p.join(projectPath, subPath);
  }

  // Handle absolute and relative paths
  return outputTemplate;
}

String? _findProjectInWorkspace(String projectName, bool verbose) {
  // Start from current directory and search upwards for workspace root
  var currentDir = Directory.current;

  // First, try to find in sibling directories
  final parent = currentDir.parent;

  // Search in parent and sibling directories
  final searchDirs = [parent, ...parent.listSync().whereType<Directory>()];

  for (final dir in searchDirs) {
    // Check if this directory contains a project with the name
    final projectDir = Directory(p.join(dir.path, projectName));
    if (projectDir.existsSync()) {
      final pubspecFile = File(p.join(projectDir.path, 'pubspec.yaml'));
      if (pubspecFile.existsSync()) {
        // Verify the project name in pubspec.yaml
        final pubspecContent = pubspecFile.readAsStringSync();
        final pubspec = loadYaml(pubspecContent) as YamlMap;
        final name = pubspec['name'] as String?;

        if (name == projectName) {
          if (verbose) {
            print('  Found project "$projectName" at: ${projectDir.path}');
          }
          return projectDir.path;
        }
      }
    }

    // Also check subdirectories
    if (dir.path != parent.path) {
      for (final subDir in dir.listSync().whereType<Directory>()) {
        final projectDir = Directory(p.join(subDir.path, projectName));
        if (projectDir.existsSync()) {
          final pubspecFile = File(p.join(projectDir.path, 'pubspec.yaml'));
          if (pubspecFile.existsSync()) {
            final pubspecContent = pubspecFile.readAsStringSync();
            final pubspec = loadYaml(pubspecContent) as YamlMap;
            final name = pubspec['name'] as String?;

            if (name == projectName) {
              if (verbose) {
                print('  Found project "$projectName" at: ${projectDir.path}');
              }
              return projectDir.path;
            }
          }
        }
      }
    }
  }

  return null;
}

String _getOutputPath(
  String inputFile,
  String root,
  String outputDir,
  bool preserveStructure,
) {
  // Get basename and replace extension
  final basename = p.basenameWithoutExtension(inputFile);
  final outputFilename = '$basename.ast.yaml';

  if (preserveStructure) {
    // Preserve directory structure relative to root
    final relativePath = p.relative(inputFile, from: root);
    final relativeDir = p.dirname(relativePath);

    if (relativeDir == '.') {
      return p.join(outputDir, outputFilename);
    } else {
      return p.join(outputDir, relativeDir, outputFilename);
    }
  } else {
    // Flat output - all files in output directory
    return p.join(outputDir, outputFilename);
  }
}

void _convertFile(
  String inputPath,
  String outputPath,
  AstConverter converter,
  _ConversionConfig config,
  bool verbose,
) {
  // Read and parse the Dart file
  final content = File(inputPath).readAsStringSync();
  final parseResult = parseString(content: content, path: inputPath);

  // Check for parse errors - always fail on errors
  if (parseResult.errors.isNotEmpty) {
    print('Parse errors found in $inputPath:');
    for (final error in parseResult.errors) {
      print('  ${error.message} at line ${error.offset}');
    }
    throw Exception('Parse errors in $inputPath');
  }

  // Convert to serializable AST
  final ast = converter.convertCompilationUnit(parseResult.unit);

  // Convert to JSON first (since our AST model has toJson)
  var jsonData = ast.toJson();

  // Add sourcemap if requested
  if (config.includeSourcemap) {
    jsonData = {
      'sourcemap': {
        'source_file': p.absolute(inputPath),
        'generated_at': DateTime.now().toIso8601String(),
      },
      'ast': jsonData,
    };
  }

  // Handle include_imports if enabled
  if (config.includeImports) {
    if (verbose) {
      print('    Note: include_imports not yet implemented');
    }
  }

  // Convert JSON to YAML string
  final yamlString = _jsonToYaml(jsonData);

  // Ensure output directory exists
  final outputFile = File(outputPath);
  outputFile.parent.createSync(recursive: true);

  // Write YAML file
  outputFile.writeAsStringSync(yamlString);

  if (verbose) {
    print('    Generated: $outputPath (${outputFile.lengthSync()} bytes)');
  }
}

String _jsonToYaml(Map<String, dynamic> json, [int indent = 0]) {
  final buffer = StringBuffer();
  final indentStr = '  ' * indent;

  json.forEach((key, value) {
    if (value == null) {
      // Skip null values for cleaner output
      return;
    }

    buffer.write('$indentStr$key:');

    if (value is Map<String, dynamic>) {
      buffer.writeln();
      buffer.write(_jsonToYaml(value, indent + 1));
    } else if (value is List) {
      if (value.isEmpty) {
        buffer.writeln(' []');
      } else {
        buffer.writeln();
        for (final item in value) {
          if (item is Map<String, dynamic>) {
            buffer.writeln('$indentStr  -');
            buffer.write(_jsonToYaml(item, indent + 2));
          } else {
            buffer.writeln('$indentStr  - ${_formatValue(item)}');
          }
        }
      }
    } else {
      buffer.writeln(' ${_formatValue(value)}');
    }
  });

  return buffer.toString();
}

String _formatValue(dynamic value) {
  if (value is String) {
    // Escape special characters and quote if needed
    if (value.contains('\n') || value.contains(':') || value.contains('#')) {
      return '"${value.replaceAll('"', '\\"').replaceAll('\n', '\\n')}"';
    }
    return value;
  }
  return value.toString();
}

/// Print the buildkit.yaml section for a project (--show option).
void _printBuildYamlSection(String projectPath, String workspaceRoot) {
  final yamlPath = p.join(projectPath, TomBuildConfig.projectFilename);
  final yamlFile = File(yamlPath);

  if (!yamlFile.existsSync()) {
    print('    (no buildkit.yaml)');
    return;
  }

  try {
    final content = yamlFile.readAsStringSync();
    final rootYaml = loadYaml(content) as YamlMap?;
    if (rootYaml == null) {
      print('    (empty buildkit.yaml)');
      return;
    }

    // Navigate to astgen section
    final astgenSection = rootYaml['astgen'] as YamlMap?;
    if (astgenSection == null) {
      print('    (no astgen section in buildkit.yaml)');
      return;
    }

    // Print the astgen section as YAML
    print('    buildkit.yaml:');
    _printYamlNode(astgenSection, indent: 6);
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

// =============================================================================
// Factory
// =============================================================================

/// Create executor map for the astgen tool.
Map<String, CommandExecutor> createAstgenExecutors() {
  return {'default': AstgenExecutor()};
}
