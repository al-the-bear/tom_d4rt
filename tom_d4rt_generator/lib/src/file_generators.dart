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

/// Generates the content for a test runner script (d4rtrun.b.dart).
///
/// This generates an executable Dart script that can:
/// - Run a D4rt script file: `dart run d4rtrun.b.dart script.dart`
/// - Evaluate an expression: `dart run d4rtrun.b.dart "expression"`
/// - Evaluate a file via eval: `dart run d4rtrun.b.dart --eval-file file`
/// - Validate registrations: `dart run d4rtrun.b.dart --init-eval`
///
/// All bridges are pre-registered before script execution.
///
/// The [testRunnerPath] parameter is used to calculate correct relative imports.
String generateTestRunnerContent(BridgeConfig config, {String? testRunnerPath}) {
  final buffer = StringBuffer();

  // Determine the directory containing the test runner
  final testRunnerDir = testRunnerPath != null
      ? p.dirname(testRunnerPath)
      : 'bin';

  // Header
  buffer.writeln('// D4rt Bridge - Generated file, do not edit');
  buffer.writeln('// Test runner for ${config.name}');
  buffer.writeln('// Generated: ${DateTime.now().toIso8601String()}');
  buffer.writeln('//');
  buffer.writeln('// Usage:');
  buffer.writeln('//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} <script.dart>       Run a D4rt script file');
  buffer.writeln('//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} "<expression>"      Evaluate an expression');
  buffer.writeln('//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --eval-file <file>  Evaluate file content with eval()');
  buffer.writeln('//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --init-eval         Validate bridge registrations');
  buffer.writeln();

  // Imports
  buffer.writeln("import 'dart:io';");
  buffer.writeln();
  buffer.writeln("import 'package:tom_d4rt/d4rt.dart';");

  // Import external bridge packages
  for (var i = 0; i < config.importedBridges.length; i++) {
    final imported = config.importedBridges[i];
    buffer.writeln("import '${imported.import}' as imported_$i;");
  }

  // Import local module bridges with correct relative paths
  for (final module in config.modules) {
    final relativePath = p.relative(module.outputPath, from: testRunnerDir);
    buffer.writeln("import '$relativePath' as ${module.name}_bridges;");
  }

  buffer.writeln();

  // Build the init script source with all imports
  buffer.writeln('/// Init script source that imports all bridged modules.');
  buffer.writeln("const String _initSource = '''");
  // Add import for each module's barrel
  for (final module in config.modules) {
    final sourceImport = module.barrelImport ?? module.barrelFiles.first;
    buffer.writeln("import '$sourceImport';");
    // Additional barrel files
    for (final barrelFile in module.barrelFiles) {
      if (barrelFile != sourceImport) {
        buffer.writeln("import '$barrelFile';");
      }
    }
  }
  // Add imports from imported bridges — need to collect their import blocks
  // at runtime, so add a placeholder comment
  buffer.writeln();
  buffer.writeln('void main() {}');
  buffer.writeln("''';");
  buffer.writeln();

  // Register bridges function
  buffer.writeln('/// Registers all bridges with the given D4rt interpreter.');
  buffer.writeln('void _registerBridges(D4rt d4rt) {');

  // Register imported bridges first
  if (config.importedBridges.isNotEmpty) {
    for (var i = 0; i < config.importedBridges.length; i++) {
      final imported = config.importedBridges[i];
      buffer.writeln('  imported_$i.${imported.className}.register(d4rt);');
    }
  }

  for (final module in config.modules) {
    final capitalizedModuleName = toPascalCase(module.name);
    final sourceImport = module.barrelImport ?? module.barrelFiles.first;
    buffer.writeln(
        '  ${module.name}_bridges.${capitalizedModuleName}Bridge.registerBridges(');
    buffer.writeln('    d4rt,');
    buffer.writeln("    '$sourceImport',");
    buffer.writeln('  );');

    for (final barrelFile in module.barrelFiles) {
      if (barrelFile != sourceImport) {
        buffer.writeln(
            '  ${module.name}_bridges.${capitalizedModuleName}Bridge.registerBridges(');
        buffer.writeln('    d4rt,');
        buffer.writeln("    '$barrelFile',");
        buffer.writeln('  );');
      }
    }
  }

  buffer.writeln('}');
  buffer.writeln();

  // Main function
  buffer.writeln('void main(List<String> args) {');
  buffer.writeln('  if (args.isEmpty) {');
  buffer.writeln("    stderr.writeln('Usage:');");
  buffer.writeln("    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} <script.dart>       Run a D4rt script file');");
  buffer.writeln("    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} \"<expression>\"      Evaluate an expression');");
  buffer.writeln("    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --eval-file <file>  Evaluate file content with eval()');");
  buffer.writeln("    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --init-eval         Validate bridge registrations');");
  buffer.writeln('    exit(1);');
  buffer.writeln('  }');
  buffer.writeln();

  // --init-eval mode
  buffer.writeln("  if (args.first == '--init-eval') {");
  buffer.writeln('    _runInitEval();');
  buffer.writeln('    return;');
  buffer.writeln('  }');
  buffer.writeln();

  // --eval-file mode
  buffer.writeln("  if (args.first == '--eval-file') {");
  buffer.writeln('    if (args.length < 2) {');
  buffer.writeln("      stderr.writeln('Error: --eval-file requires a file path argument.');");
  buffer.writeln('      exit(1);');
  buffer.writeln('    }');
  buffer.writeln('    _runEvalFile(args[1]);');
  buffer.writeln('    return;');
  buffer.writeln('  }');
  buffer.writeln();

  // File or expression mode
  buffer.writeln('  final input = args.first;');
  buffer.writeln("  if (input.endsWith('.dart')) {");
  buffer.writeln('    _runFile(input);');
  buffer.writeln('  } else {');
  buffer.writeln('    _runExpression(input);');
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln();

  // _runFile — execute a script file
  buffer.writeln('/// Run a D4rt script file using execute().');
  buffer.writeln('void _runFile(String filePath) {');
  buffer.writeln('  final file = File(filePath);');
  buffer.writeln('  if (!file.existsSync()) {');
  buffer.writeln("    stderr.writeln('Error: File not found: \$filePath');");
  buffer.writeln('    exit(1);');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  final source = file.readAsStringSync();');
  buffer.writeln('  final d4rt = D4rt();');
  buffer.writeln('  _registerBridges(d4rt);');
  buffer.writeln('  d4rt.grant(FilesystemPermission.any);');
  buffer.writeln();
  buffer.writeln('  try {');
  buffer.writeln('    final result = d4rt.execute(');
  buffer.writeln('      source: source,');
  buffer.writeln("      basePath: File(filePath).parent.path,");
  buffer.writeln('      allowFileSystemImports: true,');
  buffer.writeln('    );');
  buffer.writeln('    if (result != null) {');
  buffer.writeln("      print('Result: \$result');");
  buffer.writeln('    }');
  buffer.writeln('  } catch (e, st) {');
  buffer.writeln("    stderr.writeln('Error executing \$filePath:');");
  buffer.writeln("    stderr.writeln('  \$e');");
  buffer.writeln("    stderr.writeln(st);");
  buffer.writeln('    exit(2);');
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln();

  // _runExpression — eval an expression
  buffer.writeln('/// Evaluate an expression using eval().');
  buffer.writeln('void _runExpression(String expression) {');
  buffer.writeln('  final d4rt = D4rt();');
  buffer.writeln('  _registerBridges(d4rt);');
  buffer.writeln('  d4rt.grant(FilesystemPermission.any);');
  buffer.writeln();
  buffer.writeln('  // Initialize the interpreter with the import script');
  buffer.writeln('  d4rt.execute(source: _initSource);');
  buffer.writeln();
  buffer.writeln('  try {');
  buffer.writeln('    final result = d4rt.eval(expression);');
  buffer.writeln('    if (result != null) {');
  buffer.writeln("      print('Result: \$result');");
  buffer.writeln('    }');
  buffer.writeln('  } catch (e, st) {');
  buffer.writeln("    stderr.writeln('Error evaluating expression:');");
  buffer.writeln("    stderr.writeln('  \$e');");
  buffer.writeln("    stderr.writeln(st);");
  buffer.writeln('    exit(2);');
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln();

  // _runEvalFile — eval a file's content
  buffer.writeln('/// Evaluate file content using eval().');
  buffer.writeln('void _runEvalFile(String filePath) {');
  buffer.writeln('  final file = File(filePath);');
  buffer.writeln('  if (!file.existsSync()) {');
  buffer.writeln("    stderr.writeln('Error: File not found: \$filePath');");
  buffer.writeln('    exit(1);');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  final source = file.readAsStringSync();');
  buffer.writeln('  final d4rt = D4rt();');
  buffer.writeln('  _registerBridges(d4rt);');
  buffer.writeln('  d4rt.grant(FilesystemPermission.any);');
  buffer.writeln();
  buffer.writeln('  // Initialize the interpreter with the import script');
  buffer.writeln('  d4rt.execute(source: _initSource);');
  buffer.writeln();
  buffer.writeln('  try {');
  buffer.writeln('    final result = d4rt.eval(source);');
  buffer.writeln('    if (result != null) {');
  buffer.writeln("      print('Result: \$result');");
  buffer.writeln('    }');
  buffer.writeln('  } catch (e, st) {');
  buffer.writeln("    stderr.writeln('Error evaluating \$filePath:');");
  buffer.writeln("    stderr.writeln('  \$e');");
  buffer.writeln("    stderr.writeln(st);");
  buffer.writeln('    exit(2);');
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln();

  // _runInitEval — validate bridge registrations
  buffer.writeln('/// Validate bridge registrations by running the init script');
  buffer.writeln('/// and collecting all duplicate element errors.');
  buffer.writeln('void _runInitEval() {');
  buffer.writeln("  print('Validating bridge registrations for ${config.name}...');");
  buffer.writeln("  print('');");
  buffer.writeln();
  buffer.writeln('  final d4rt = D4rt();');
  buffer.writeln('  _registerBridges(d4rt);');
  buffer.writeln();
  buffer.writeln('  final errors = d4rt.validateRegistrations(source: _initSource);');
  buffer.writeln();
  buffer.writeln('  if (errors.isEmpty) {');
  buffer.writeln("    print('✓ All bridge registrations are valid.');");
  buffer.writeln("    print('  No duplicate elements found.');");
  buffer.writeln('  } else {');
  buffer.writeln("    stderr.writeln('✗ Found \${errors.length} registration error(s):');");
  buffer.writeln("    stderr.writeln('');");
  buffer.writeln('    for (var i = 0; i < errors.length; i++) {');
  buffer.writeln("      stderr.writeln('  \${i + 1}. \${errors[i]}');");
  buffer.writeln('    }');
  buffer.writeln("    stderr.writeln('');");
  buffer.writeln("    stderr.writeln('Fix these issues by using import show/hide clauses in your');");
  buffer.writeln("    stderr.writeln('module configuration or by removing duplicate exports.');");
  buffer.writeln('    exit(2);');
  buffer.writeln('  }');
  buffer.writeln('}');

  return buffer.toString();
}
