/// Test setup helper for tom_ast_generator generator tests.
///
/// This helper implements the astgen test pipeline:
/// 1. Generate bridges (via [generateBridges] API)
/// 2. Post-process: safety-net replace `package:tom_d4rt/` → `package:tom_d4rt_exec/`
/// 3. Compile the d4 binary
///
/// The d4 binary depends on `tom_d4rt_exec` which internally handles
/// source parsing via `AstConverter` (analyzer → SAstNode mirror AST).
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

/// Helper class for preparing bridges in the tom_ast_generator context.
///
/// The key difference from ExecTestSetup: the d4 binary does NOT have
/// analyzer as a dependency. Instead, source parsing is delegated to
/// the ast_convert binary (compiled from tom_ast_generator/bin/ast_convert.dart).
class AstgenTestSetup {
  AstgenTestSetup._();

  /// Prepare bridges for the d4 project: generate, post-process, compile d4.
  ///
  /// Returns `true` if all steps succeed, `false` otherwise.
  /// On failure, error details are printed to stderr.
  static Future<bool> prepareBridges(
    D4rtTester tester,
    BridgeConfig config,
  ) async {
    final projectPath = tester.projectPath;

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

    // Step 4: Compile the d4 binary
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
}
