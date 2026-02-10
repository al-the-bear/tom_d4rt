/// Test for GEN-049: Extension methods on bridged classes from imports.
///
/// Verifies that the generator discovers extensions from imported libraries,
/// not just extensions defined in the source files being bridged.
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
        Directory.systemTemp.createTempSync('bridge_import_extension_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('GEN-049: Extension Discovery from Imports', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'imports_external_extensions.dart',
        packageName: 'test_package',
        verbose: true, // Enable verbose to see GEN-049 messages
      );

      // Process the file that imports extensions
      final sourceFile = p.join(testFixturesDir, 'imports_external_extensions.dart');
      final outputFile = p.join(tempOutputDir, 'import_extension_bridges_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
      
      // Debug: Print generated code for inspection
      // print('Generated code:\n$generatedCode');
    });

    test('discovers ImportedIntHelpers from import [2026-02-10 06:37]', () {
      expect(generatedCode, contains("name: 'ImportedIntHelpers'"),
          reason: 'Should discover ImportedIntHelpers from imported file');
    });

    test('discovers ImportedListHelpers from import [2026-02-10 06:37]', () {
      // Note: Generic extensions like List<T> may be skipped in initial implementation
      // This test documents the expected behavior
      expect(generatedCode, contains("name: 'ImportedListHelpers'"),
          reason: 'Should discover ImportedListHelpers from imported file');
    });

    test('discovers doubled getter from ImportedIntHelpers [2026-02-10 06:37]', () {
      expect(generatedCode, contains("'doubled'"),
          reason: 'Should include doubled getter from imported extension');
    });

    test('discovers plus method from ImportedIntHelpers [2026-02-10 06:37]', () {
      expect(generatedCode, contains("'plus'"),
          reason: 'Should include plus method from imported extension');
    });

    test('does not duplicate extensions defined in source file [2026-02-10 06:37]', () {
      // Count occurrences of ImportedIntHelpers
      final matches = RegExp(r"name:\s*'ImportedIntHelpers'").allMatches(generatedCode);
      expect(matches.length, equals(1),
          reason: 'Should not have duplicate extension definitions');
    });
  });
}
