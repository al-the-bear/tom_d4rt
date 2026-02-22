/// Test setup helper for tom_d4rt_astgen generator tests.
///
/// This helper implements the astgen test pipeline:
/// 1. Compile the `ast_convert` binary (from tom_d4rt_astgen)
/// 2. Generate bridges (via [generateBridges] API)
/// 3. Post-process: safety-net replace `package:tom_d4rt/` → `package:tom_d4rt_exec/`
/// 4. Inject `parseSourceCallback` into generated d4rtrun.b.dart that
///    shells out to the compiled `ast_convert` binary for source → AST JSON
///    conversion, then loads the JSON via `SCompilationUnit.fromJson()`
/// 5. Compile the d4 binary (which has NO analyzer dependency)
///
/// The d4 binary depends only on `tom_d4rt_exec` and `tom_d4rt_ast`.
/// Source parsing is delegated to the external `ast_convert` binary,
/// testing the full serialization round-trip:
///   source → analyzer → AstConverter → toJson → JSON file → fromJson → D4rt
///
/// Usage in tests:
/// ```dart
/// setUpAll(() async {
///   config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
///   tester = D4rtTester(projectPath: projectPath);
///   final ok = await AstgenTestSetup.prepareBridges(tester, config);
///   expect(ok, isTrue);
/// });
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt_generator/src/bridge_api.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/testing/d4rt_tester.dart';

/// Helper class for preparing bridges in the tom_d4rt_astgen context.
///
/// The key difference from ExecTestSetup: the d4 binary does NOT have
/// analyzer as a dependency. Instead, source parsing is delegated to
/// the ast_convert binary (compiled from tom_d4rt_astgen/bin/ast_convert.dart).
class AstgenTestSetup {
  AstgenTestSetup._();

  /// Path to the compiled ast_convert binary.
  /// Set during [prepareBridges] after compilation.
  static String? _astConvertBinaryPath;

  /// Prepare bridges for the d4 project: compile ast_convert, generate,
  /// post-process, inject, compile d4.
  ///
  /// Returns `true` if all steps succeed, `false` otherwise.
  /// On failure, error details are printed to stderr.
  static Future<bool> prepareBridges(
    D4rtTester tester,
    BridgeConfig config,
  ) async {
    final projectPath = tester.projectPath;

    // Step 0: Compile ast_convert binary from tom_d4rt_astgen
    final astgenRoot = _findAstgenRoot(projectPath);
    if (astgenRoot == null) {
      stderr.writeln('ERROR: Could not find tom_d4rt_astgen root');
      return false;
    }

    final astConvertBinary = p.join(astgenRoot, 'bin', 'ast_convert');
    if (!File(astConvertBinary).existsSync()) {
      stderr.writeln('Compiling ast_convert binary...');
      final compileAstConvert = await Process.run('dart', [
        'compile',
        'exe',
        p.join('bin', 'ast_convert.dart'),
        '-o',
        astConvertBinary,
      ], workingDirectory: astgenRoot);
      if (compileAstConvert.exitCode != 0) {
        stderr.writeln('AST_CONVERT COMPILATION FAILED:');
        stderr.writeln(compileAstConvert.stdout);
        stderr.writeln(compileAstConvert.stderr);
        return false;
      }
    }
    _astConvertBinaryPath = astConvertBinary;

    // Step 1: Delete existing d4 binary
    final binaryPath = p.join(projectPath, 'bin', tester.compiledBinaryName);
    final binary = File(binaryPath);
    if (binary.existsSync()) binary.deleteSync();

    // Step 2: Generate bridges
    final effectiveConfig = config.copyWith(
      generateTestRunner: true,
      testRunnerPath: 'bin/${tester.runnerExecutable}.dart',
    );
    final result = await generateBridges(
      config: effectiveConfig,
      projectPath: projectPath,
    );

    if (!result.isSuccess) {
      stderr.writeln('BRIDGE GENERATION ERRORS: ${result.errors}');
      return false;
    }

    // Step 3: Post-process generated files — replace hardcoded tom_d4rt imports
    final bridgeDir = Directory(p.join(projectPath, 'lib'));
    await _postProcessDirectory(bridgeDir);

    final binDir = Directory(p.join(projectPath, 'bin'));
    await _postProcessDirectory(binDir);

    // Step 4: Inject parseSourceCallback into generated d4rtrun.b.dart
    // This callback shells out to ast_convert for source → AST JSON conversion
    final runnerFile = File(
      p.join(projectPath, 'bin', '${tester.runnerExecutable}.dart'),
    );
    if (runnerFile.existsSync()) {
      await _injectAstConvertCallback(runnerFile, astConvertBinary);
    }

    // Step 5: Compile the d4 binary
    final runnerPath = p.join('bin', '${tester.runnerExecutable}.dart');
    final compileResult = await Process.run('dart', [
      'compile',
      'exe',
      runnerPath,
      '-o',
      binaryPath,
    ], workingDirectory: projectPath);

    if (compileResult.exitCode != 0) {
      stderr.writeln('D4 COMPILATION FAILED:');
      stderr.writeln(compileResult.stdout);
      stderr.writeln(compileResult.stderr);
      return false;
    }

    return true;
  }

  /// Find the tom_d4rt_astgen root directory.
  ///
  /// The d4 project is at tom_d4rt_astgen/example/d4,
  /// so astgen root is ../../ from the project path.
  static String? _findAstgenRoot(String projectPath) {
    // Navigate up from example/d4 to tom_d4rt_astgen
    final candidate = p.normalize(p.join(projectPath, '..', '..'));
    if (File(p.join(candidate, 'bin', 'ast_convert.dart')).existsSync()) {
      return candidate;
    }
    // Also try if projectPath IS the astgen root
    if (File(p.join(projectPath, 'bin', 'ast_convert.dart')).existsSync()) {
      return projectPath;
    }
    return null;
  }

  /// Recursively post-process all `.b.dart` files in a directory.
  static Future<void> _postProcessDirectory(Directory dir) async {
    if (!dir.existsSync()) return;

    await for (final entity in dir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.b.dart')) {
        await _postProcessFile(entity);
      }
    }
  }

  /// Replace `package:tom_d4rt/` imports with `package:tom_d4rt_exec/` in a file.
  static Future<void> _postProcessFile(File file) async {
    var content = await file.readAsString();
    final updated = content.replaceAll(
      "package:tom_d4rt/",
      "package:tom_d4rt_exec/",
    );
    if (updated != content) {
      await file.writeAsString(updated);
    }
  }

  /// Inject the parseSourceCallback that shells out to ast_convert.
  ///
  /// The injected callback:
  /// 1. Writes the source code to a temp .dart file
  /// 2. Runs the compiled ast_convert binary to produce .ast.json
  /// 3. Reads the JSON, creates SCompilationUnit.fromJson()
  /// 4. Cleans up temp files
  ///
  /// This keeps the d4 binary free of analyzer — only dart:convert and
  /// dart:io are needed for the callback, plus tom_d4rt_ast for fromJson.
  static Future<void> _injectAstConvertCallback(
    File runnerFile,
    String astConvertBinaryPath,
  ) async {
    var content = await runnerFile.readAsString();

    // Skip if already injected (idempotent)
    if (content.contains('_astgenParseSource')) return;

    // Add imports after the existing d4rt import line
    const d4rtImport = "import 'package:tom_d4rt_exec/d4rt.dart';";
    const extraImports = '''
import 'package:tom_d4rt_exec/d4rt.dart';
import 'dart:convert';''';
    content = content.replaceFirst(d4rtImport, extraImports);

    // Replace all D4rt() constructor calls with parseSourceCallback
    content = content.replaceAll(
      'D4rt()',
      'D4rt(parseSourceCallback: _astgenParseSource)',
    );

    // Embed the ast_convert binary path as a constant
    // Use the absolute path so the d4 binary can find it regardless of cwd
    final escapedPath = astConvertBinaryPath.replaceAll(r'\', r'\\');

    // Append the parse source function at the end
    content +=
        '''

/// Path to the compiled ast_convert binary.
/// Injected by AstgenTestSetup for tom_d4rt_astgen compatibility.
const _astConvertBinary = '$escapedPath';

/// Parse source code by shelling out to ast_convert binary.
///
/// Pipeline: source → temp.dart → ast_convert → temp.ast.json → fromJson
/// This tests the full AST serialization round-trip without requiring
/// analyzer as a dependency of this binary.
SCompilationUnit _astgenParseSource(String sourceCode, {String? path}) {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final tempDir = Directory.systemTemp.path;
  final tempDart = File('\$tempDir/d4rt_astgen_\$timestamp.dart');
  final tempJson = File('\$tempDir/d4rt_astgen_\$timestamp.ast.json');

  try {
    tempDart.writeAsStringSync(sourceCode);

    final result = Process.runSync(
      _astConvertBinary,
      [tempDart.path, tempJson.path],
    );

    if (result.exitCode != 0) {
      throw Exception(
        'ast_convert failed (exit \${result.exitCode}): \${result.stderr}',
      );
    }

    final jsonStr = tempJson.readAsStringSync();
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    return SCompilationUnit.fromJson(json);
  } finally {
    if (tempDart.existsSync()) tempDart.deleteSync();
    if (tempJson.existsSync()) tempJson.deleteSync();
  }
}
''';

    await runnerFile.writeAsString(content);
  }
}
