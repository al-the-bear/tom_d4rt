/// Shared file generation utilities for D4rt Bridge Generator.
///
/// This library provides the content generation functions used by all entry points:
/// - bin/d4rt_generator.dart (standalone CLI)
/// - lib/src/cli/d4rt_generator_cli.dart (library CLI)
/// - lib/src/bridge_api.dart (programmatic API)
/// - lib/builder.dart (build_runner integration)
library;

import 'package:path/path.dart' as p;

import 'bridge_config.dart';
import 'bridge_generator.dart'; // for toPascalCase

/// Generates the content for a barrel file that exports all bridge modules.
///
/// Returns the file content as a string.
String generateBarrelFileContent(BridgeConfig config) {
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

  return buffer.toString();
}

/// Generates the content for the dartscript registration file.
///
/// This file provides a unified registration class that registers all bridges
/// from all modules with a D4rt interpreter.
///
/// The [dartscriptPath] parameter is used to calculate correct relative imports
/// from the dartscript file location to the module bridge files.
///
/// Returns the file content as a string.
String generateDartscriptFileContent(BridgeConfig config, {String? dartscriptPath}) {
  final registrationClass = config.registrationClass ?? '${config.name}Bridges';
  final buffer = StringBuffer();
  
  // Determine the directory containing the dartscript file
  // Used for calculating relative imports to module bridge files
  final dartscriptDir = dartscriptPath != null 
      ? p.dirname(dartscriptPath)
      : 'lib';

  // Header
  buffer.writeln('// D4rt Bridge - Generated file, do not edit');
  buffer.writeln('// Dartscript registration for ${config.name}');
  buffer.writeln('// Generated: ${DateTime.now().toIso8601String()}');
  buffer.writeln();
  buffer.writeln('/// D4rt Bridge Registration for ${config.name}');
  buffer.writeln('library;');
  buffer.writeln();
  buffer.writeln("import 'package:tom_d4rt/d4rt.dart';");

  // Import external bridge packages
  for (var i = 0; i < config.importedBridges.length; i++) {
    final imported = config.importedBridges[i];
    buffer.writeln("import '${imported.import}' as imported_$i;");
  }

  // Import local module bridges with correct relative paths
  for (final module in config.modules) {
    // Calculate relative path from dartscript directory to module output
    final relativePath = p.relative(module.outputPath, from: dartscriptDir);
    buffer.writeln("import '$relativePath' as ${module.name}_bridges;");
  }

  buffer.writeln();
  buffer.writeln('/// Combined bridge registration for ${config.name}.');
  buffer.writeln('class $registrationClass {');

  // register() method
  buffer.writeln('  /// Register all bridges with D4rt interpreter.');
  buffer.writeln('  static void register([D4rt? interpreter]) {');
  buffer.writeln('    final d4rt = interpreter ?? D4rt();');
  buffer.writeln();

  // Register imported bridges first
  if (config.importedBridges.isNotEmpty) {
    buffer.writeln('    // Register imported bridges');
    for (var i = 0; i < config.importedBridges.length; i++) {
      final imported = config.importedBridges[i];
      buffer.writeln('    imported_$i.${imported.className}.register(d4rt);');
    }
    buffer.writeln();
    buffer.writeln('    // Register local bridges');
  }

  for (final module in config.modules) {
    // Use toPascalCase for consistent class naming with bridge generator
    final capitalizedModuleName = toPascalCase(module.name);
    // Use the source barrel import the classes were generated from
    final sourceImport = module.barrelImport ?? module.barrelFiles.first;
    buffer.writeln(
        '    ${module.name}_bridges.${capitalizedModuleName}Bridge.registerBridges(');
    buffer.writeln('      d4rt,');
    buffer.writeln("      '$sourceImport',");
    buffer.writeln('    );');
    
    // When a module has multiple barrel files, also register under each
    // additional barrel import so that D4rt scripts can import from any of them.
    for (final barrelFile in module.barrelFiles) {
      if (barrelFile != sourceImport) {
        buffer.writeln(
            '    ${module.name}_bridges.${capitalizedModuleName}Bridge.registerBridges(');
        buffer.writeln('      d4rt,');
        buffer.writeln("      '$barrelFile',");
        buffer.writeln('    );');
      }
    }
  }

  buffer.writeln('  }');
  buffer.writeln();

  // getImportBlock() method
  buffer.writeln('  /// Get import block for all modules.');
  buffer.writeln('  static String getImportBlock() {');
  buffer.writeln('    final buffer = StringBuffer();');

  // Get import blocks from imported bridges first
  for (var i = 0; i < config.importedBridges.length; i++) {
    final imported = config.importedBridges[i];
    buffer.writeln(
        '    buffer.writeln(imported_$i.${imported.className}.getImportBlock());');
  }

  for (final module in config.modules) {
    // Use toPascalCase for consistent class naming with bridge generator
    final capitalizedModuleName = toPascalCase(module.name);
    buffer.writeln(
        '    buffer.writeln(${module.name}_bridges.${capitalizedModuleName}Bridge.getImportBlock());');
  }

  buffer.writeln('    return buffer.toString();');
  buffer.writeln('  }');
  buffer.writeln('}');

  return buffer.toString();
}
