/// Builder for build_runner to generate D4rt bridges automatically.
///
/// This builder reads configuration from build.yaml options and generates
/// D4rt bridge files for the project.
library;

import 'dart:async';

import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'src/bridge_config.dart';
import 'src/bridge_generator.dart';
import 'src/build_runner_file_writer.dart';
import 'src/file_writer.dart';

/// Builder that generates D4rt bridges from build.yaml configuration.
///
/// Configuration is specified in build.yaml under targets.$default.builders:
///
/// ```yaml
/// targets:
///   $default:
///     builders:
///       tom_d4rt_generator:d4rt_bridge_builder:
///         enabled: true
///         options:
///           name: my_package
///           modules:
///             - name: all
///               barrelFiles: [lib/my_package.dart]
///               outputPath: lib/src/d4rt_bridges/my_package_bridges.dart
///           generateBarrel: true
///           barrelPath: lib/d4rt_bridges.dart
///           generateDartscript: true
///           dartscriptPath: lib/dartscript.dart
/// ```
///
/// The builder triggers on any .dart file change and regenerates all bridges.
class D4rtBridgeBuilder implements Builder {
  /// The configuration for this builder.
  final BridgeConfig? config;

  /// Creates a new D4rtBridgeBuilder with the given config.
  const D4rtBridgeBuilder(this.config);

  @override
  Map<String, List<String>> get buildExtensions {
    // We trigger on .dart files and generate our outputs
    // The actual outputs depend on config, but we use a marker extension
    // to indicate this builder was run
    return const {
      r'$lib$': ['d4rt_bridges.g.info'],
    };
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    if (config == null) {
      log.warning('D4rt bridge builder: no configuration found in build.yaml');
      return;
    }

    final packageName = buildStep.inputId.package;
    log.info('Generating D4rt bridges for $packageName...');

    final fileWriter = BuildRunnerFileWriter(buildStep, packageName);

    try {
      var totalClasses = 0;
      final outputFiles = <String>[];

      // Generate bridges for each module
      for (final module in config!.modules) {
        // For build_runner, we need to resolve paths relative to package
        final projectRoot = p.current; // build_runner runs from package root

        final generator = BridgeGenerator(
          workspacePath: projectRoot,
          packageName: config!.name,
          sourceImport: module.barrelImport ?? module.barrelFiles.first,
          helpersImport:
              config!.helpersImport ?? 'package:tom_d4rt/tom_d4rt.dart',
        );

        final result = await generator.generateBridgesFromExportsWithWriter(
          barrelFiles:
              module.barrelFiles.map((f) => p.join(projectRoot, f)).toList(),
          outputFileId: FileId(packageName, module.outputPath),
          moduleName: module.name,
          excludePatterns: module.excludePatterns,
          excludeClasses: module.excludeClasses,
          followReExports: module.followReExports,
          fileWriter: fileWriter,
        );

        totalClasses += result.classesGenerated;
        outputFiles.add(module.outputPath);

        if (result.errors.isNotEmpty) {
          for (final error in result.errors) {
            log.warning('  $error');
          }
        }
      }

      // Generate barrel file if requested
      if (config!.generateBarrel && config!.barrelPath != null) {
        final barrelContent = _generateBarrelFileContent(config!);
        await fileWriter.writeFile(
          FileId(packageName, config!.barrelPath!),
          barrelContent,
        );
        outputFiles.add(config!.barrelPath!);
      }

      // Generate dartscript file if requested
      if (config!.generateDartscript && config!.dartscriptPath != null) {
        final dartscriptContent = _generateDartscriptFileContent(config!);
        await fileWriter.writeFile(
          FileId(packageName, config!.dartscriptPath!),
          dartscriptContent,
        );
        outputFiles.add(config!.dartscriptPath!);
      }

      // Write a marker file to track that generation completed
      final markerContent = '''
// D4rt bridge generation marker
// Generated: ${DateTime.now().toIso8601String()}
// Classes: $totalClasses
// Modules: ${config!.modules.length}
// Outputs: ${outputFiles.join(', ')}
''';
      await buildStep.writeAsString(
        AssetId(packageName, 'lib/d4rt_bridges.g.info'),
        markerContent,
      );

      log.info(
          '✓ Generated $totalClasses classes across ${config!.modules.length} modules');
    } catch (e, stackTrace) {
      log.severe('Error generating D4rt bridges', e, stackTrace);
      rethrow;
    }
  }

  /// Generates the content for the barrel file.
  String _generateBarrelFileContent(BridgeConfig cfg) {
    final buffer = StringBuffer();
    buffer.writeln('/// D4rt Bridges for ${cfg.name}');
    buffer.writeln('library;');
    buffer.writeln();

    for (final module in cfg.modules) {
      final relativePath = module.outputPath.startsWith('lib/')
          ? module.outputPath.substring(4)
          : module.outputPath;
      buffer.writeln("export '$relativePath';");
    }

    return buffer.toString();
  }

  /// Generates the content for the dartscript registration file.
  String _generateDartscriptFileContent(BridgeConfig cfg) {
    final registrationClass = cfg.registrationClass ?? '${cfg.name}Bridges';
    final buffer = StringBuffer();

    buffer.writeln('/// D4rt Bridge Registration for ${cfg.name}');
    buffer.writeln('library;');
    buffer.writeln();
    buffer.writeln("import 'package:tom_d4rt/d4rt.dart';");

    for (final module in cfg.modules) {
      final relativePath = module.outputPath.startsWith('lib/')
          ? module.outputPath.substring(4)
          : module.outputPath;
      buffer.writeln("import '$relativePath' as ${module.name}_bridges;");
    }

    buffer.writeln();
    buffer.writeln('/// Combined bridge registration for ${cfg.name}.');
    buffer.writeln('class $registrationClass {');
    buffer.writeln('  /// Register all bridges with D4rt interpreter.');
    buffer.writeln('  static void register([D4rt? interpreter]) {');
    buffer.writeln('    final d4rt = interpreter ?? D4rt();');

    for (final module in cfg.modules) {
      final capitalizedModuleName =
          module.name.substring(0, 1).toUpperCase() + module.name.substring(1);
      buffer.writeln(
          '    ${module.name}_bridges.${capitalizedModuleName}Bridge.registerBridges(');
      buffer.writeln('      d4rt,');
      buffer.writeln("      'package:${cfg.name}/${cfg.name}.dart',");
      buffer.writeln('    );');
    }

    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  /// Get import block for all modules.');
    buffer.writeln('  static String getImportBlock() {');
    buffer.writeln('    final buffer = StringBuffer();');

    for (final module in cfg.modules) {
      final capitalizedModuleName =
          module.name.substring(0, 1).toUpperCase() + module.name.substring(1);
      buffer.writeln(
          '    buffer.writeln(${module.name}_bridges.${capitalizedModuleName}Bridge.getImportBlock());');
    }

    buffer.writeln('    return buffer.toString();');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  /// Get global initialization script.');
    buffer.writeln('  static String getGlobalInitializationScript() {');
    buffer.writeln("    return '';");
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }
}

/// Creates the D4rt bridge builder for build_runner.
///
/// Reads configuration from BuilderOptions.config which comes from build.yaml.
Builder d4rtBridgeBuilder(BuilderOptions options) {
  BridgeConfig? config;

  if (options.config.isNotEmpty) {
    try {
      // Convert config map to BridgeConfig, handling nested YamlMaps
      config = BridgeConfig.fromJson(
        _deepConvertMap(options.config),
      );
    } catch (e) {
      log.warning('Failed to parse D4rt bridge config: $e');
    }
  }

  return D4rtBridgeBuilder(config);
}

/// Recursively converts a map containing YamlMaps and YamlLists to regular
/// Dart Maps and Lists.
Map<String, dynamic> _deepConvertMap(Map<dynamic, dynamic> input) {
  final result = <String, dynamic>{};
  for (final entry in input.entries) {
    final key = entry.key.toString();
    result[key] = _deepConvertValue(entry.value);
  }
  return result;
}

/// Recursively converts a value, handling YamlMap and YamlList.
dynamic _deepConvertValue(dynamic value) {
  if (value is YamlMap) {
    return _deepConvertMap(value);
  } else if (value is Map) {
    return _deepConvertMap(value);
  } else if (value is YamlList) {
    return value.map((item) => _deepConvertValue(item)).toList();
  } else if (value is List) {
    return value.map((item) => _deepConvertValue(item)).toList();
  } else {
    return value;
  }
}
