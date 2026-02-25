/// Tests for cross-file type resolution in bridge generation (GEN-055).
///
/// When a class in file A references a type defined in file B as a method
/// parameter, the generator must use file B's import prefix for the type,
/// not file A's prefix.
///
/// Bug scenario:
///   - BridgeRegistry (in cross_file_reference_source.dart) has
///     `static void register([Interpreter? interpreter])`
///   - Interpreter is defined in cross_file_type.dart
///   - Generator should emit `$cross_file_type_1.Interpreter?`
///   - Bug: generator emits `$cross_file_reference_source_1.Interpreter?`
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir =
        Directory.systemTemp.createTempSync('bridge_cross_file_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Cross-file type resolution (GEN-055)', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'cross_file_reference_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      // Generate from the file that imports cross-file types
      final sourceFile =
          p.join(testFixturesDir, 'cross_file_reference_source.dart');
      final outputFile =
          p.join(tempOutputDir, 'cross_file_bridges_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    test('GEN-055a: Detects BridgeRegistry class. [2026-02-14] (PASS)', () {
      expect(generatedCode, contains("name: 'BridgeRegistry'"));
    });

    test('GEN-055b: Detects Worker class. [2026-02-14] (PASS)', () {
      expect(generatedCode, contains("name: 'Worker'"));
    });

    test(
        'GEN-055c: BridgeRegistry.register uses correct prefix for Interpreter. [2026-02-14] (FAIL)',
        () {
      // The Interpreter type is defined in cross_file_type.dart, not in
      // cross_file_reference_source.dart. The generated code must NOT use
      // the source file's prefix for the Interpreter type.
      //
      // WRONG: $cross_file_reference_source_1.Interpreter
      // WRONG: $test_package_1.Interpreter (if source file prefix is test_package_1)
      //
      // The correct code should reference Interpreter through whatever prefix
      // maps to cross_file_type.dart (e.g., $test_package_2 or $cross_file_type_1)

      // First verify that Interpreter appears in the generated code
      expect(generatedCode, contains('Interpreter'),
          reason: 'Interpreter type should appear in generated code');

      // The import for cross_file_type.dart should exist
      expect(generatedCode, contains('cross_file_type.dart'),
          reason:
              'cross_file_type.dart should be imported since Interpreter is defined there');

      // Find the prefix used for cross_file_type.dart
      final crossFileImportMatch = RegExp(
              r"import '.*cross_file_type\.dart' as (\$\w+);")
          .firstMatch(generatedCode);
      expect(crossFileImportMatch, isNotNull,
          reason: 'Should have a prefixed import for cross_file_type.dart');

      final correctPrefix = crossFileImportMatch!.group(1)!;

      // The generated code for BridgeRegistry.register should use the
      // correct prefix for the Interpreter type parameter
      expect(generatedCode, contains('$correctPrefix.Interpreter'),
          reason:
              'Interpreter parameter type should use the cross_file_type.dart prefix ($correctPrefix), not the source file prefix');
    });

    test(
        'GEN-055d: Worker.initialize uses correct prefix for cross-file params. [2026-02-14] (FAIL)',
        () {
      // Worker.initialize(Interpreter interpreter, {RuntimeConfig? config})
      // Both Interpreter and RuntimeConfig are from cross_file_type.dart

      final crossFileImportMatch = RegExp(
              r"import '.*cross_file_type\.dart' as (\$\w+);")
          .firstMatch(generatedCode);
      expect(crossFileImportMatch, isNotNull);

      final correctPrefix = crossFileImportMatch!.group(1)!;

      // RuntimeConfig should also use the cross_file_type prefix
      expect(generatedCode, contains('$correctPrefix.RuntimeConfig'),
          reason:
              'RuntimeConfig type should use the cross_file_type.dart prefix');
    });
  });
}
