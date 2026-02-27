/// Shared file generation utilities for D4rt Bridge Generator.
///
/// This library provides the content generation functions used by all entry points:
/// - bin/d4rtgen.dart (standalone CLI)
/// - lib/src/bridge_api.dart (programmatic API)
/// - lib/builder.dart (build_runner integration)
library;

import 'package:path/path.dart' as p;

import 'bridge_config.dart';
import 'bridge_generator.dart'; // for toPascalCase

/// Ensures a file path ends with the `.b.dart` extension.
///
/// This normalizes output paths so that all generated files use the `.b.dart`
/// convention, regardless of what the user specified in their configuration.
///
/// Rules:
/// - If path already ends with `.b.dart`, return as-is (no double suffix).
/// - If path ends with `.dart`, replace `.dart` with `.b.dart`.
/// - Otherwise, append `.b.dart`.
///
/// Examples:
/// ```dart
/// ensureBDartExtension('lib/bridges.dart')      // => 'lib/bridges.b.dart'
/// ensureBDartExtension('lib/bridges.b.dart')     // => 'lib/bridges.b.dart'
/// ensureBDartExtension('lib/bridges')             // => 'lib/bridges.b.dart'
/// ```
String ensureBDartExtension(String path) {
  if (path.endsWith('.b.dart')) return path;
  if (path.endsWith('.dart')) {
    return '${path.substring(0, path.length - 5)}.b.dart';
  }
  return '$path.b.dart';
}

/// Computes the import path for a module's output file relative to the
/// importing file's directory.
///
/// When the output is under `lib/` and the importing file is outside `lib/`,
/// returns a `package:` import to avoid `avoid_relative_lib_imports` lint.
/// Otherwise returns a relative path.
String _moduleImportPath(
  String outputPath,
  String fromDir,
  String packageName,
) {
  final normalizedOutput = ensureBDartExtension(outputPath);
  if (normalizedOutput.startsWith('lib/') && !fromDir.startsWith('lib')) {
    // Use package: import to avoid relative lib imports lint
    final libRelative = normalizedOutput.substring(4); // strip 'lib/'
    return 'package:$packageName/$libRelative';
  }
  return p.relative(normalizedOutput, from: fromDir);
}

/// Generates the content for a barrel file that exports all bridge modules.
///
/// Returns the file content as a string.
String generateBarrelFileContent(BridgeConfig config) {
  final buffer = StringBuffer();
  buffer.writeln('/// D4rt Bridges for ${config.name}');
  buffer.writeln('library;');
  buffer.writeln();

  final barrelPath = config.barrelPath != null
      ? ensureBDartExtension(config.barrelPath!)
      : null;
  final barrelDir = barrelPath != null ? p.dirname(barrelPath) : 'lib';

  for (final module in config.modules) {
    final normalizedOutput = ensureBDartExtension(module.outputPath);
    final relativePath = p.relative(normalizedOutput, from: barrelDir);
    final dartPath = p.posix.normalize(relativePath.replaceAll('\\', '/'));
    buffer.writeln("export '$dartPath';");
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
String generateDartscriptFileContent(
  BridgeConfig config, {
  String? dartscriptPath,
  String? packageName,
}) {
  final registrationClass = config.registrationClass ?? '${config.name}Bridges';
  final effectivePackageName = packageName ?? config.name;
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
  buffer.writeln(
    "import '${config.d4rtImport ?? 'package:tom_d4rt/d4rt.dart'}';",
  );

  // Import external bridge packages
  for (var i = 0; i < config.importedBridges.length; i++) {
    final imported = config.importedBridges[i];
    buffer.writeln("import '${imported.import}' as imported_$i;");
  }

  // Import local module bridges with correct relative paths
  for (final module in config.modules) {
    // Calculate relative path from dartscript directory to module output
    final importPath = _moduleImportPath(
      module.outputPath,
      dartscriptDir,
      effectivePackageName,
    );
    buffer.writeln("import '$importPath' as ${module.name}_bridges;");
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
      '    ${module.name}_bridges.${capitalizedModuleName}Bridge.registerBridges(',
    );
    buffer.writeln('      d4rt,');
    buffer.writeln("      '$sourceImport',");
    buffer.writeln('    );');

    // When a module has multiple barrel files, also register under each
    // additional barrel import so that D4rt scripts can import from any of them.
    for (final barrelFile in module.barrelFiles) {
      if (barrelFile != sourceImport) {
        buffer.writeln(
          '    ${module.name}_bridges.${capitalizedModuleName}Bridge.registerBridges(',
        );
        buffer.writeln('      d4rt,');
        buffer.writeln("      '$barrelFile',");
        buffer.writeln('    );');
      }
    }

    // GEN-030: Also register under sub-package barrel URIs discovered through
    // followAllReExports. When a module re-exports sub-packages (e.g., dcli
    // re-exports dcli_core), D4rt scripts may import those sub-packages directly.
    // The bridge's subPackageBarrels() method returns these discovered URIs.
    final prefix = '${module.name}_bridges';
    final bridgeClass = '${capitalizedModuleName}Bridge';
    buffer.writeln(
      '    // Register under sub-package barrels for direct imports',
    );
    buffer.writeln(
      '    for (final barrel in $prefix.$bridgeClass.subPackageBarrels()) {',
    );
    buffer.writeln('      $prefix.$bridgeClass.registerBridges(d4rt, barrel);');
    buffer.writeln('    }');
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
      '    buffer.writeln(imported_$i.${imported.className}.getImportBlock());',
    );
  }

  for (final module in config.modules) {
    // Use toPascalCase for consistent class naming with bridge generator
    final capitalizedModuleName = toPascalCase(module.name);
    buffer.writeln(
      '    buffer.writeln(${module.name}_bridges.${capitalizedModuleName}Bridge.getImportBlock());',
    );
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
/// - Test a script (structured output): `dart run d4rtrun.b.dart --test file`
/// - Test eval (structured output): `dart run d4rtrun.b.dart --test-eval init expr`
///
/// All bridges are pre-registered before script execution.
///
/// The [testRunnerPath] parameter is used to calculate correct relative imports.
String generateTestRunnerContent(
  BridgeConfig config, {
  String? testRunnerPath,
  String? packageName,
}) {
  final buffer = StringBuffer();
  final effectivePackageName = packageName ?? config.name;

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
  buffer.writeln(
    '//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} <script.dart|.d4rt>  Run a D4rt script file',
  );
  buffer.writeln(
    '//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} "<expression>"      Evaluate an expression',
  );
  buffer.writeln(
    '//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --eval-file <file>  Evaluate file content with eval()',
  );
  buffer.writeln(
    '//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --init-eval         Validate bridge registrations',
  );
  buffer.writeln(
    '//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --test <file>       Test script (structured JSON output)',
  );
  buffer.writeln(
    '//   dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --test-eval <init> <expr>  Test eval (structured JSON output)',
  );
  buffer.writeln();

  // Imports
  buffer.writeln("import 'dart:async';");
  buffer.writeln("import 'dart:convert';");
  buffer.writeln("import 'dart:io';");
  buffer.writeln();
  buffer.writeln(
    "import '${config.d4rtImport ?? 'package:tom_d4rt/d4rt.dart'}';",
  );

  // Import external bridge packages
  for (var i = 0; i < config.importedBridges.length; i++) {
    final imported = config.importedBridges[i];
    buffer.writeln("import '${imported.import}' as imported_$i;");
  }

  // Import local module bridges with correct relative paths
  for (final module in config.modules) {
    final importPath = _moduleImportPath(
      module.outputPath,
      testRunnerDir,
      effectivePackageName,
    );
    buffer.writeln("import '$importPath' as ${module.name}_bridges;");
  }

  buffer.writeln();

  // Build the init script source with all imports
  buffer.writeln('/// Init script source that imports all bridged modules.');
  buffer.writeln("const String _initSource = '''");
  // Add import for each module's barrel — only package: imports
  for (final module in config.modules) {
    final sourceImport = module.barrelImport ?? module.barrelFiles.first;
    if (sourceImport.startsWith('package:')) {
      buffer.writeln("import '$sourceImport';");
    }
    // Additional barrel files (only package: URIs)
    for (final barrelFile in module.barrelFiles) {
      if (barrelFile != sourceImport && barrelFile.startsWith('package:')) {
        buffer.writeln("import '$barrelFile';");
      }
    }
  }
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
      '  ${module.name}_bridges.${capitalizedModuleName}Bridge.registerBridges(',
    );
    buffer.writeln('    d4rt,');
    buffer.writeln("    '$sourceImport',");
    buffer.writeln('  );');

    // Register additional barrel files (only package: URIs to avoid duplicates)
    for (final barrelFile in module.barrelFiles) {
      if (barrelFile != sourceImport && barrelFile.startsWith('package:')) {
        buffer.writeln(
          '  ${module.name}_bridges.${capitalizedModuleName}Bridge.registerBridges(',
        );
        buffer.writeln('    d4rt,');
        buffer.writeln("    '$barrelFile',");
        buffer.writeln('  );');
      }
    }
  }

  buffer.writeln('}');
  buffer.writeln();

  // D4 invocation logging function
  buffer.writeln('/// Logs D4 invocations to a debug file.');
  buffer.writeln(
    "const String _d4InvocationsLogPath = '/Users/alexiskyaw/Desktop/Code/tom2/d4_invocations.log';",
  );
  buffer.writeln();
  buffer.writeln('void _logD4Invocation(String mode, String input) {');
  buffer.writeln('  final timestamp = DateTime.now().toIso8601String();');
  buffer.writeln("  final logLine = '\$timestamp | \$mode | \$input\\n';");
  buffer.writeln('  try {');
  buffer.writeln(
    "    File(_d4InvocationsLogPath).writeAsStringSync(logLine, mode: FileMode.append);",
  );
  buffer.writeln('  } catch (_) {');
  buffer.writeln('    // Ignore logging failures');
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln();

  // Main function
  buffer.writeln('Future<void> main(List<String> args) async {');
  buffer.writeln('  if (args.isEmpty) {');
  buffer.writeln("    stderr.writeln('Usage:');");
  buffer.writeln(
    "    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} <script.dart|.d4rt>  Run a D4rt script file');",
  );
  buffer.writeln(
    "    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} \"<expression>\"      Evaluate an expression');",
  );
  buffer.writeln(
    "    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --eval-file <file>  Evaluate file content with eval()');",
  );
  buffer.writeln(
    "    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --init-eval         Validate bridge registrations');",
  );
  buffer.writeln(
    "    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --test <file>       Test script (structured JSON output)');",
  );
  buffer.writeln(
    "    stderr.writeln('  dart run ${testRunnerPath ?? 'bin/d4rtrun.b.dart'} --test-eval <init> <expr>  Test eval (structured JSON)');",
  );
  buffer.writeln('    exit(1);');
  buffer.writeln('  }');
  buffer.writeln();

  // --test mode (structured output for D4rtTester)
  buffer.writeln("  if (args.first == '--test') {");
  buffer.writeln('    if (args.length < 2) {');
  buffer.writeln(
    "      stderr.writeln('Error: --test requires a script file path argument.');",
  );
  buffer.writeln('      exit(1);');
  buffer.writeln('    }');
  buffer.writeln('    await _runTestScript(args[1]);');
  buffer.writeln('    return;');
  buffer.writeln('  }');
  buffer.writeln();

  // --test-eval mode (structured output for D4rtTester)
  buffer.writeln("  if (args.first == '--test-eval') {");
  buffer.writeln('    if (args.length < 3) {');
  buffer.writeln(
    "      stderr.writeln('Error: --test-eval requires <init-file> and <expression-file> arguments.');",
  );
  buffer.writeln('      exit(1);');
  buffer.writeln('    }');
  buffer.writeln('    await _runTestEval(args[1], args[2]);');
  buffer.writeln('    return;');
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
  buffer.writeln(
    "      stderr.writeln('Error: --eval-file requires a file path argument.');",
  );
  buffer.writeln('      exit(1);');
  buffer.writeln('    }');
  buffer.writeln('    _runEvalFile(args[1]);');
  buffer.writeln('    return;');
  buffer.writeln('  }');
  buffer.writeln();

  // File or expression mode — detect by file extension or existence
  buffer.writeln('  final input = args.first;');
  buffer.writeln(
    "  if (input.endsWith('.dart') || input.endsWith('.d4rt') || File(input).existsSync()) {",
  );
  buffer.writeln('    _runFile(input);');
  buffer.writeln('  } else {');
  buffer.writeln('    _runExpression(input);');
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln();

  // _runFile — execute a script file
  buffer.writeln('/// Run a D4rt script file using execute().');
  buffer.writeln('void _runFile(String filePath) {');
  buffer.writeln("  _logD4Invocation('FILE', filePath);");
  buffer.writeln('  final file = File(filePath);');
  buffer.writeln('  if (!file.existsSync()) {');
  buffer.writeln("    stderr.writeln('Error: File not found: \$filePath');");
  buffer.writeln('    exit(1);');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  final source = file.readAsStringSync();');
  buffer.writeln('  final d4rt = D4rt();');
  buffer.writeln('  _registerBridges(d4rt);');
  buffer.writeln('  // Grant all permissions for full access');
  buffer.writeln('  d4rt.grant(FilesystemPermission.any);');
  buffer.writeln('  d4rt.grant(NetworkPermission.any);');
  buffer.writeln('  d4rt.grant(ProcessRunPermission.any);');
  buffer.writeln('  d4rt.grant(IsolatePermission.any);');
  buffer.writeln('  d4rt.grant(DangerousPermission.any);');
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
  buffer.writeln("  _logD4Invocation('EXPR', expression);");
  buffer.writeln('  final d4rt = D4rt();');
  buffer.writeln('  _registerBridges(d4rt);');
  buffer.writeln('  // Grant all permissions for full access');
  buffer.writeln('  d4rt.grant(FilesystemPermission.any);');
  buffer.writeln('  d4rt.grant(NetworkPermission.any);');
  buffer.writeln('  d4rt.grant(ProcessRunPermission.any);');
  buffer.writeln('  d4rt.grant(IsolatePermission.any);');
  buffer.writeln('  d4rt.grant(DangerousPermission.any);');
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
  buffer.writeln("  _logD4Invocation('EVAL-FILE', filePath);");
  buffer.writeln('  final file = File(filePath);');
  buffer.writeln('  if (!file.existsSync()) {');
  buffer.writeln("    stderr.writeln('Error: File not found: \$filePath');");
  buffer.writeln('    exit(1);');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  final source = file.readAsStringSync();');
  buffer.writeln('  final d4rt = D4rt();');
  buffer.writeln('  _registerBridges(d4rt);');
  buffer.writeln('  // Grant all permissions for full access');
  buffer.writeln('  d4rt.grant(FilesystemPermission.any);');
  buffer.writeln('  d4rt.grant(NetworkPermission.any);');
  buffer.writeln('  d4rt.grant(ProcessRunPermission.any);');
  buffer.writeln('  d4rt.grant(IsolatePermission.any);');
  buffer.writeln('  d4rt.grant(DangerousPermission.any);');
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
  buffer.writeln(
    '/// Validate bridge registrations by running the init script',
  );
  buffer.writeln('/// and collecting all duplicate element errors.');
  buffer.writeln('void _runInitEval() {');
  buffer.writeln(
    "  print('Validating bridge registrations for ${config.name}...');",
  );
  buffer.writeln("  print('');");
  buffer.writeln();
  buffer.writeln('  final d4rt = D4rt();');
  buffer.writeln('  _registerBridges(d4rt);');
  buffer.writeln();
  buffer.writeln(
    '  final errors = d4rt.validateRegistrations(source: _initSource);',
  );
  buffer.writeln();
  buffer.writeln('  if (errors.isEmpty) {');
  buffer.writeln("    print('✓ All bridge registrations are valid.');");
  buffer.writeln("    print('  No duplicate elements found.');");
  buffer.writeln('  } else {');
  buffer.writeln(
    "    stderr.writeln('✗ Found \${errors.length} registration error(s):');",
  );
  buffer.writeln("    stderr.writeln('');");
  buffer.writeln('    for (var i = 0; i < errors.length; i++) {');
  buffer.writeln("      stderr.writeln('  \${i + 1}. \${errors[i]}');");
  buffer.writeln('    }');
  buffer.writeln("    stderr.writeln('');");
  buffer.writeln(
    "    stderr.writeln('Fix these issues by using import show/hide clauses in your');",
  );
  buffer.writeln(
    "    stderr.writeln('module configuration or by removing duplicate exports.');",
  );
  buffer.writeln('    exit(2);');
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln();

  // _runTestScript — execute a script with structured output capture
  buffer.writeln(
    '/// Run a D4rt script in test mode with structured output capture.',
  );
  buffer.writeln(
    '/// Uses runZonedGuarded with ZoneSpecification to capture all print()',
  );
  buffer.writeln(
    '/// output and unhandled exceptions. Results are output as JSON.',
  );
  buffer.writeln('/// Properly awaits async main() functions.');
  buffer.writeln('Future<void> _runTestScript(String filePath) async {');
  buffer.writeln("  _logD4Invocation('TEST', filePath);");
  buffer.writeln('  final file = File(filePath);');
  buffer.writeln('  if (!file.existsSync()) {');
  buffer.writeln("    _emitTestResult('', ['File not found: \$filePath']);");
  buffer.writeln('    exit(2);');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  final source = file.readAsStringSync();');
  buffer.writeln('  final capturedOutput = StringBuffer();');
  buffer.writeln('  final capturedExceptions = <String>[];');
  buffer.writeln('  final completer = Completer<void>();');
  buffer.writeln();
  buffer.writeln('  runZonedGuarded(');
  buffer.writeln('    () async {');
  buffer.writeln('      try {');
  buffer.writeln('        final d4rt = D4rt();');
  buffer.writeln('        _registerBridges(d4rt);');
  buffer.writeln('        // Grant all permissions for full access');
  buffer.writeln('        d4rt.grant(FilesystemPermission.any);');
  buffer.writeln('        d4rt.grant(NetworkPermission.any);');
  buffer.writeln('        d4rt.grant(ProcessRunPermission.any);');
  buffer.writeln('        d4rt.grant(IsolatePermission.any);');
  buffer.writeln('        d4rt.grant(DangerousPermission.any);');
  buffer.writeln('        final result = d4rt.execute(');
  buffer.writeln('          source: source,');
  buffer.writeln('          basePath: File(filePath).parent.path,');
  buffer.writeln('          allowFileSystemImports: true,');
  buffer.writeln('        );');
  buffer.writeln('        // Await if result is a Future (async main)');
  buffer.writeln('        if (result is Future) {');
  buffer.writeln('          await result;');
  buffer.writeln('        }');
  buffer.writeln('        completer.complete();');
  buffer.writeln('      } catch (e, st) {');
  buffer.writeln("        capturedExceptions.add('\$e\\n\$st');");
  buffer.writeln('        completer.complete();');
  buffer.writeln('      }');
  buffer.writeln('    },');
  buffer.writeln('    (error, stackTrace) {');
  buffer.writeln("      capturedExceptions.add('\$error\\n\$stackTrace');");
  buffer.writeln('      if (!completer.isCompleted) completer.complete();');
  buffer.writeln('    },');
  buffer.writeln('    zoneSpecification: ZoneSpecification(');
  buffer.writeln('      print: (self, parent, zone, line) {');
  buffer.writeln('        capturedOutput.writeln(line);');
  buffer.writeln('      },');
  buffer.writeln('    ),');
  buffer.writeln('  );');
  buffer.writeln();
  buffer.writeln('  await completer.future;');
  buffer.writeln(
    '  _emitTestResult(capturedOutput.toString(), capturedExceptions);',
  );
  buffer.writeln('  if (capturedExceptions.isNotEmpty) exit(2);');
  buffer.writeln('}');
  buffer.writeln();

  // _runTestEval — eval with init script and structured output capture
  buffer.writeln(
    '/// Evaluate file content in test mode with structured output capture.',
  );
  buffer.writeln(
    '/// Initializes with [initFilePath], then evaluates [evalFilePath].',
  );
  buffer.writeln('/// Properly awaits async init scripts.');
  buffer.writeln(
    'Future<void> _runTestEval(String initFilePath, String evalFilePath) async {',
  );
  buffer.writeln(
    "  _logD4Invocation('TEST-EVAL', '\$initFilePath | \$evalFilePath');",
  );
  buffer.writeln('  final initFile = File(initFilePath);');
  buffer.writeln('  final evalFile = File(evalFilePath);');
  buffer.writeln('  if (!initFile.existsSync()) {');
  buffer.writeln(
    "    _emitTestResult('', ['Init file not found: \$initFilePath']);",
  );
  buffer.writeln('    exit(2);');
  buffer.writeln('  }');
  buffer.writeln('  if (!evalFile.existsSync()) {');
  buffer.writeln(
    "    _emitTestResult('', ['Eval file not found: \$evalFilePath']);",
  );
  buffer.writeln('    exit(2);');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  final initSource = initFile.readAsStringSync();');
  buffer.writeln('  final evalSource = evalFile.readAsStringSync();');
  buffer.writeln('  final capturedOutput = StringBuffer();');
  buffer.writeln('  final capturedExceptions = <String>[];');
  buffer.writeln('  final completer = Completer<void>();');
  buffer.writeln();
  buffer.writeln('  runZonedGuarded(');
  buffer.writeln('    () async {');
  buffer.writeln('      try {');
  buffer.writeln('        final d4rt = D4rt();');
  buffer.writeln('        _registerBridges(d4rt);');
  buffer.writeln('        // Grant all permissions for full access');
  buffer.writeln('        d4rt.grant(FilesystemPermission.any);');
  buffer.writeln('        d4rt.grant(NetworkPermission.any);');
  buffer.writeln('        d4rt.grant(ProcessRunPermission.any);');
  buffer.writeln('        d4rt.grant(IsolatePermission.any);');
  buffer.writeln('        d4rt.grant(DangerousPermission.any);');
  buffer.writeln('        // Initialize with the init script');
  buffer.writeln('        final initResult = d4rt.execute(');
  buffer.writeln('          source: initSource,');
  buffer.writeln('          basePath: File(initFilePath).parent.path,');
  buffer.writeln('          allowFileSystemImports: true,');
  buffer.writeln('        );');
  buffer.writeln('        // Await if init result is a Future (async main)');
  buffer.writeln('        if (initResult is Future) {');
  buffer.writeln('          await initResult;');
  buffer.writeln('        }');
  buffer.writeln('        // Evaluate the expression file');
  buffer.writeln('        d4rt.eval(evalSource);');
  buffer.writeln('        completer.complete();');
  buffer.writeln('      } catch (e, st) {');
  buffer.writeln("        capturedExceptions.add('\$e\\n\$st');");
  buffer.writeln('        completer.complete();');
  buffer.writeln('      }');
  buffer.writeln('    },');
  buffer.writeln('    (error, stackTrace) {');
  buffer.writeln("      capturedExceptions.add('\$error\\n\$stackTrace');");
  buffer.writeln('      if (!completer.isCompleted) completer.complete();');
  buffer.writeln('    },');
  buffer.writeln('    zoneSpecification: ZoneSpecification(');
  buffer.writeln('      print: (self, parent, zone, line) {');
  buffer.writeln('        capturedOutput.writeln(line);');
  buffer.writeln('      },');
  buffer.writeln('    ),');
  buffer.writeln('  );');
  buffer.writeln();
  buffer.writeln('  await completer.future;');
  buffer.writeln(
    '  _emitTestResult(capturedOutput.toString(), capturedExceptions);',
  );
  buffer.writeln('  if (capturedExceptions.isNotEmpty) exit(2);');
  buffer.writeln('}');
  buffer.writeln();

  // _emitTestResult — output structured JSON for D4rtTester
  buffer.writeln(
    '/// Emit structured test result as JSON for D4rtTester to parse.',
  );
  buffer.writeln(
    '/// Uses stdout.writeln directly to bypass any zone print overrides.',
  );
  buffer.writeln(
    'void _emitTestResult(String output, List<String> exceptions) {',
  );
  buffer.writeln('  final result = jsonEncode({');
  buffer.writeln("    'output': output,");
  buffer.writeln("    'exceptions': exceptions,");
  buffer.writeln('  });');
  buffer.writeln("  stdout.writeln('###D4RT_TEST_RESULT###\$result');");
  buffer.writeln('}');

  return buffer.toString();
}
