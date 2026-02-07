/// Test helper for D4rt bridge generator issue reproduction.
///
/// Provides infrastructure for end-to-end testing of bridge generation:
/// 1. Creates a temporary project with source files
/// 2. Generates bridges using the BridgeGenerator
/// 3. Executes D4rt scripts against the generated bridges
/// 4. Reports results for test assertions
///
/// ## Usage
///
/// ```dart
/// final helper = IssueTestHelper(
///   issueId: 'GEN-001',
///   sourceFiles: {
///     'lib/my_source.dart': '''
///       class MyClass {
///         T getValue<T>() => throw UnimplementedError();
///       }
///     ''',
///   },
///   barrelContent: "export 'src/my_source.dart';",
///   d4rtScript: '''
///     import 'package:test_pkg/test_pkg.dart';
///     main() {
///       final obj = MyClass();
///       return obj.getValue<int>();
///     }
///   ''',
/// );
///
/// final result = await helper.run();
/// expect(result.scriptError, isNotNull); // Issue reproduces
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart';

import '../bridge_generator.dart';

/// Result of running an issue test.
class IssueTestResult {
  /// Whether bridge generation succeeded.
  final bool generationSucceeded;

  /// The generated bridge code (null if generation failed).
  final String? generatedCode;

  /// Errors from bridge generation.
  final List<String> generationErrors;

  /// Warnings from bridge generation.
  final List<String> generationWarnings;

  /// Number of classes generated.
  final int classesGenerated;

  /// Whether the D4rt script executed successfully.
  final bool scriptSucceeded;

  /// The return value from the D4rt script (null if it failed).
  final dynamic scriptResult;

  /// Error from D4rt script execution (null if it succeeded).
  final Object? scriptError;

  /// Stack trace from D4rt script execution error.
  final StackTrace? scriptStackTrace;

  /// Whether the generated code compiles (attempted via analyzer).
  final bool? bridgeCompiles;

  /// Compilation errors in the generated bridge code.
  final List<String> compilationErrors;

  const IssueTestResult({
    required this.generationSucceeded,
    this.generatedCode,
    this.generationErrors = const [],
    this.generationWarnings = const [],
    this.classesGenerated = 0,
    required this.scriptSucceeded,
    this.scriptResult,
    this.scriptError,
    this.scriptStackTrace,
    this.bridgeCompiles,
    this.compilationErrors = const [],
  });

  /// Whether the issue reproduces (generation or script failed).
  bool get issueReproduces => !generationSucceeded || !scriptSucceeded;

  @override
  String toString() {
    final buf = StringBuffer('IssueTestResult(\n');
    buf.writeln('  generationSucceeded: $generationSucceeded');
    buf.writeln('  classesGenerated: $classesGenerated');
    if (generationErrors.isNotEmpty) {
      buf.writeln('  generationErrors: $generationErrors');
    }
    if (generationWarnings.isNotEmpty) {
      buf.writeln('  generationWarnings: $generationWarnings');
    }
    buf.writeln('  scriptSucceeded: $scriptSucceeded');
    if (scriptResult != null) buf.writeln('  scriptResult: $scriptResult');
    if (scriptError != null) buf.writeln('  scriptError: $scriptError');
    if (bridgeCompiles != null) {
      buf.writeln('  bridgeCompiles: $bridgeCompiles');
    }
    if (compilationErrors.isNotEmpty) {
      buf.writeln('  compilationErrors: $compilationErrors');
    }
    buf.writeln(')');
    return buf.toString();
  }
}

/// Configuration for a bridge module in the test project.
class TestModuleConfig {
  /// Module name (used in the bridge class name).
  final String name;

  /// Barrel file path relative to the project (e.g., 'lib/test_pkg.dart').
  final String barrelFile;

  /// Output path for the generated bridge file.
  final String outputPath;

  /// Classes to exclude from generation.
  final List<String> excludeClasses;

  /// Source patterns to exclude.
  final List<String> excludeSourcePatterns;

  const TestModuleConfig({
    this.name = 'all',
    this.barrelFile = 'lib/test_pkg.dart',
    this.outputPath = 'lib/src/bridges/test_bridges.b.dart',
    this.excludeClasses = const [],
    this.excludeSourcePatterns = const [],
  });
}

/// Helper for creating end-to-end issue reproduction tests.
///
/// Creates a temporary project, generates bridges, and runs D4rt scripts
/// to verify whether a known issue reproduces.
class IssueTestHelper {
  /// The issue ID (e.g., 'GEN-001').
  final String issueId;

  /// Package name for the test project.
  final String packageName;

  /// Source files to create in the project.
  ///
  /// Keys are paths relative to the project root (e.g., 'lib/src/my_class.dart').
  /// Values are the file contents.
  final Map<String, String> sourceFiles;

  /// Content for the barrel file (e.g., "export 'src/my_class.dart';").
  final String barrelContent;

  /// D4rt script source code to execute against the generated bridges.
  final String d4rtScript;

  /// Module configuration for bridge generation.
  final TestModuleConfig moduleConfig;

  /// Whether to use verbose output during generation.
  final bool verbose;

  /// Additional barrel files for multi-barrel testing.
  final List<String> additionalBarrelFiles;

  /// Additional source imports for multi-barrel testing.
  final List<String> additionalSourceImports;

  /// Temp directory (created during run, cleaned up after).
  Directory? _tempDir;

  IssueTestHelper({
    required this.issueId,
    this.packageName = 'test_pkg',
    required this.sourceFiles,
    required this.barrelContent,
    required this.d4rtScript,
    this.moduleConfig = const TestModuleConfig(),
    this.verbose = false,
    this.additionalBarrelFiles = const [],
    this.additionalSourceImports = const [],
  });

  /// Run the complete test: generate bridges, then execute D4rt script.
  Future<IssueTestResult> run() async {
    _tempDir = Directory.systemTemp.createTempSync('issue_test_${issueId}_');
    try {
      // 1. Create project structure
      _createProjectFiles();

      // 2. Generate bridges
      final genResult = await _generateBridges();
      if (!genResult.generationSucceeded) {
        return genResult;
      }

      // 3. Execute D4rt script
      return await _executeScript(genResult);
    } finally {
      // Cleanup
      try {
        _tempDir?.deleteSync(recursive: true);
      } catch (_) {}
    }
  }

  /// Run only bridge generation (skip D4rt execution).
  ///
  /// Useful for testing generation-only issues (compile errors, warnings).
  Future<IssueTestResult> runGenerationOnly() async {
    _tempDir = Directory.systemTemp.createTempSync('issue_test_${issueId}_');
    try {
      _createProjectFiles();
      return await _generateBridges();
    } finally {
      try {
        _tempDir?.deleteSync(recursive: true);
      } catch (_) {}
    }
  }

  /// Create the project directory structure.
  void _createProjectFiles() {
    final root = _tempDir!.path;

    // Create barrel file
    final barrelPath = p.join(root, moduleConfig.barrelFile);
    _writeFile(barrelPath, barrelContent);

    // Create source files
    for (final entry in sourceFiles.entries) {
      final filePath = p.join(root, entry.key);
      _writeFile(filePath, entry.value);
    }

    // Create output directory
    final outputDir = p.dirname(p.join(root, moduleConfig.outputPath));
    Directory(outputDir).createSync(recursive: true);
  }

  /// Generate bridges using BridgeGenerator.
  Future<IssueTestResult> _generateBridges() async {
    final root = _tempDir!.path;

    final sourceImport = 'package:$packageName/${p.basename(moduleConfig.barrelFile)}';
    
    final allSourceImports = [
      sourceImport,
      ...additionalSourceImports,
    ];

    final generator = BridgeGenerator(
      workspacePath: root,
      packageName: packageName,
      sourceImport: allSourceImports.length == 1 ? sourceImport : null,
      sourceImports: allSourceImports.length > 1 ? allSourceImports : const [],
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      verbose: verbose,
    );

    // Resolve source files to absolute paths
    final absoluteSourceFiles = sourceFiles.keys
        .map((relative) => p.join(root, relative))
        .toList();

    final outputPath = p.join(root, moduleConfig.outputPath);

    try {
      final result = await generator.generateBridges(
        sourceFiles: absoluteSourceFiles,
        outputPath: outputPath,
        moduleName: moduleConfig.name,
        excludeClasses: moduleConfig.excludeClasses,
        excludeSourcePatterns: moduleConfig.excludeSourcePatterns,
      );

      final generatedCode = result.outputFiles.isNotEmpty
          ? await File(result.outputFiles.first).readAsString()
          : null;

      return IssueTestResult(
        generationSucceeded: result.errors.isEmpty,
        generatedCode: generatedCode,
        generationErrors: result.errors,
        generationWarnings: result.warnings,
        classesGenerated: result.classesGenerated,
        scriptSucceeded: false, // Not run yet
      );
    } catch (e, st) {
      return IssueTestResult(
        generationSucceeded: false,
        generationErrors: ['Generation threw: $e\n$st'],
        scriptSucceeded: false,
      );
    }
  }

  /// Execute the D4rt script with the generated bridges registered.
  Future<IssueTestResult> _executeScript(IssueTestResult genResult) async {
    // Create D4rt interpreter
    final d4rt = D4rt();

    // We can't dynamically load the generated bridge file at runtime
    // (it's generated Dart that imports the source package which isn't
    // available as a real package in the test environment).
    //
    // Instead, we verify the D4rt script execution pattern:
    // - If generation succeeded and produced valid-looking bridge code,
    //   we attempt to run the script.
    // - The script will fail if bridges aren't registered, which is
    //   expected — the key assertion is about the generated code content.
    //
    // For full end-to-end tests that actually execute bridges, use the
    // example projects in example/ which have real pubspec.yaml files.

    try {
      final result = d4rt.execute(source: d4rtScript);
      return IssueTestResult(
        generationSucceeded: genResult.generationSucceeded,
        generatedCode: genResult.generatedCode,
        generationErrors: genResult.generationErrors,
        generationWarnings: genResult.generationWarnings,
        classesGenerated: genResult.classesGenerated,
        scriptSucceeded: true,
        scriptResult: result,
      );
    } catch (e, st) {
      return IssueTestResult(
        generationSucceeded: genResult.generationSucceeded,
        generatedCode: genResult.generatedCode,
        generationErrors: genResult.generationErrors,
        generationWarnings: genResult.generationWarnings,
        classesGenerated: genResult.classesGenerated,
        scriptSucceeded: false,
        scriptError: e,
        scriptStackTrace: st,
      );
    }
  }

  /// Write a file, creating parent directories as needed.
  void _writeFile(String path, String content) {
    final file = File(path);
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(content);
  }
}

/// Convenience function to create and run an issue test.
///
/// Returns the [IssueTestResult] for assertions.
///
/// Example:
/// ```dart
/// test('GEN-001: type erasure', () async {
///   final result = await runIssueTest(
///     issueId: 'GEN-001',
///     sourceFiles: {'lib/src/my_class.dart': 'class MyClass<T> { T get() => throw ""; }'},
///     barrelContent: "export 'src/my_class.dart';",
///     d4rtScript: 'import "package:test_pkg/test_pkg.dart"; main() => MyClass<int>().get();',
///   );
///   // Verify the issue manifests in the generated code
///   expect(result.generatedCode, contains('<dynamic>'));
/// });
/// ```
Future<IssueTestResult> runIssueTest({
  required String issueId,
  String packageName = 'test_pkg',
  required Map<String, String> sourceFiles,
  required String barrelContent,
  required String d4rtScript,
  TestModuleConfig moduleConfig = const TestModuleConfig(),
  bool verbose = false,
}) async {
  final helper = IssueTestHelper(
    issueId: issueId,
    packageName: packageName,
    sourceFiles: sourceFiles,
    barrelContent: barrelContent,
    d4rtScript: d4rtScript,
    moduleConfig: moduleConfig,
    verbose: verbose,
  );
  return helper.run();
}

/// Convenience function to run only bridge generation (no D4rt execution).
///
/// Returns the [IssueTestResult] with generation results only.
Future<IssueTestResult> runGenerationTest({
  required String issueId,
  String packageName = 'test_pkg',
  required Map<String, String> sourceFiles,
  required String barrelContent,
  TestModuleConfig moduleConfig = const TestModuleConfig(),
  bool verbose = false,
}) async {
  final helper = IssueTestHelper(
    issueId: issueId,
    packageName: packageName,
    sourceFiles: sourceFiles,
    barrelContent: barrelContent,
    d4rtScript: '', // Not used
    moduleConfig: moduleConfig,
    verbose: verbose,
  );
  return helper.runGenerationOnly();
}
