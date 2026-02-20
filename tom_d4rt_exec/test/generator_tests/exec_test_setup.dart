/// Test setup helper for tom_d4rt_exec generator tests.
///
/// When a `BridgeConfig` specifies `d4rtImport: package:tom_d4rt_exec/d4rt.dart`,
/// the generator already produces the correct import. This helper still performs
/// a safety-net post-process and injects the `parseSourceCallback` that
/// `tom_d4rt_exec`'s `D4rt` constructor requires (since the analyzer is not
/// bundled in the runtime).
///
/// This helper wraps the standard [D4rtTester] flow:
/// 1. Generate bridges (via [generateBridges] API)
/// 2. Post-process: safety-net replace `package:tom_d4rt/` → `package:tom_d4rt_exec/`
/// 3. Inject `parseSourceCallback` into generated d4rtrun.b.dart
/// 4. Compile the d4 binary
///
/// Usage in tests:
/// ```dart
/// setUpAll(() async {
///   config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
///   tester = D4rtTester(projectPath: projectPath);
///   final ok = await ExecTestSetup.prepareBridges(tester, config);
///   expect(ok, isTrue);
/// });
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt_generator/src/bridge_api.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/testing/d4rt_tester.dart';

/// Helper class for preparing bridges in the tom_d4rt_exec context.
///
/// Works around the generator's hardcoded `package:tom_d4rt/d4rt.dart` import
/// by performing sed-like post-processing after bridge generation.
class ExecTestSetup {
  ExecTestSetup._();

  /// Prepare bridges for the d4 project: generate, post-process, compile.
  ///
  /// Returns `true` if all steps succeed, `false` otherwise.
  /// On failure, error details are printed to stderr.
  static Future<bool> prepareBridges(
    D4rtTester tester,
    BridgeConfig config,
  ) async {
    final projectPath = tester.projectPath;

    // Step 1: Delete existing binary (same as D4rtTester.prepareBridges)
    final binaryPath =
        p.join(projectPath, 'bin', tester.compiledBinaryName);
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

    // Also post-process the generated runner in bin/
    final binDir = Directory(p.join(projectPath, 'bin'));
    await _postProcessDirectory(binDir);

    // Step 3b: Inject parseSourceCallback into generated d4rtrun.b.dart
    final runnerFile =
        File(p.join(projectPath, 'bin', '${tester.runnerExecutable}.dart'));
    if (runnerFile.existsSync()) {
      await _injectParseSourceCallback(runnerFile);
    }

    // Step 4: Compile the binary
    final runnerPath = p.join('bin', '${tester.runnerExecutable}.dart');
    final compileResult = await Process.run(
      'dart',
      ['compile', 'exe', runnerPath, '-o', binaryPath],
      workingDirectory: projectPath,
    );

    if (compileResult.exitCode != 0) {
      stderr.writeln('COMPILATION FAILED:');
      stderr.writeln(compileResult.stdout);
      stderr.writeln(compileResult.stderr);
      return false;
    }

    return true;
  }

  /// Recursively post-process all `.b.dart` files in a directory.
  ///
  /// Replaces `package:tom_d4rt/` with `package:tom_d4rt_exec/` in import
  /// statements. Only modifies `.b.dart` files (generated code).
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

  /// Inject the parseSourceCallback into the generated d4rtrun.b.dart.
  ///
  /// The generator creates `D4rt()` calls without a parseSourceCallback.
  /// In tom_d4rt_exec, the D4rt constructor requires this callback for
  /// source code parsing (since the analyzer is not bundled).
  ///
  /// This method:
  /// 1. Adds imports for analyzer and tom_d4rt_astgen
  /// 2. Replaces all `D4rt()` calls with `D4rt(parseSourceCallback: _execParseSource)`
  /// 3. Appends the _execParseSource function
  static Future<void> _injectParseSourceCallback(File runnerFile) async {
    var content = await runnerFile.readAsString();

    // Skip if already injected (idempotent)
    if (content.contains('_execParseSource')) return;

    // Add imports after the existing d4rt import line
    const d4rtImport = "import 'package:tom_d4rt_exec/d4rt.dart';";
    const extraImports = '''
import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:analyzer/dart/analysis/utilities.dart' as analyzer;
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:tom_d4rt_astgen/tom_d4rt_astgen.dart';''';
    content = content.replaceFirst(d4rtImport, extraImports);

    // Replace all D4rt() constructor calls with parseSourceCallback
    content = content.replaceAll(
      'D4rt()',
      'D4rt(parseSourceCallback: _execParseSource)',
    );

    // Append the parse source function at the end
    content += '''

/// Parse source code using analyzer + AstConverter.
/// Injected by ExecTestSetup for tom_d4rt_exec compatibility.
SCompilationUnit _execParseSource(String sourceCode, {String? path}) {
  final result = analyzer.parseString(
    content: sourceCode,
    path: path,
    throwIfDiagnostics: false,
  );
  final cu = AstConverter().convertCompilationUnit(result.unit);
  final hasErrors = result.errors
      .any((e) => e.errorCode.errorSeverity == ErrorSeverity.ERROR);
  if (hasErrors) {
    return SCompilationUnit(
      offset: cu.offset,
      length: cu.length,
      scriptTag: cu.scriptTag,
      directives: cu.directives,
      declarations: cu.declarations,
      hasParseErrors: true,
    );
  }
  return cu;
}
''';

    await runnerFile.writeAsString(content);
  }
}
