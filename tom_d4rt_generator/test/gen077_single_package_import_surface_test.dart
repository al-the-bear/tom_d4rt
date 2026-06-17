// GEN-077: AllBridge import-surface methods must always be emitted.
//
// Regression guard for the single-package inline strategy. The generated
// dartscript helper (file_generators.dart) calls AllBridge.getImportBlock()
// and AllBridge.subPackageBarrels() UNCONDITIONALLY. Previously these two
// methods were emitted only when a primary barrel URI (importBlockUri) could
// be resolved — gated behind `if (importBlockUri != null)` — while
// sourceLibraries() was always emitted. When sourceImport was unset (the
// single-package inline case), AllBridge declared sourceLibraries() but not
// getImportBlock()/subPackageBarrels(), so dartscript.b.dart failed to
// compile downstream (tom_brain_procedure, tom_brain_run, Observatory).
//
// This test drives the generator with sourceImport: null to force
// importBlockUri == null and asserts all three methods are present.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String generatedCode;
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() async {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir = Directory.systemTemp
        .createTempSync('gen077_single_package_import_surface_test_')
        .path;

    // sourceImport: null (and packageName: null) forces importBlockUri == null
    // — the single-package inline strategy that previously dropped the import
    // surface methods.
    final generator = BridgeGenerator(
      workspacePath: testFixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: null,
      packageName: null,
      verbose: false,
    );

    final sourceFile = p.join(testFixturesDir, 'class_test_source.dart');
    final outputFile =
        p.join(tempOutputDir, 'single_package_import_surface_test.dart');

    final result = await generator.generateBridges(
      sourceFiles: [sourceFile],
      outputPath: outputFile,
      moduleName: 'test_single_package',
    );

    expect(result.errors, isEmpty, reason: 'Should generate without errors');
    expect(result.outputFiles, isNotEmpty);

    generatedCode = await File(result.outputFiles.first).readAsString();
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('GEN-077: AllBridge import surface (single-package inline)', () {
    test(
      'G-ISS-37: sourceLibraries() is emitted [2026-06-17] (PASS)',
      () {
        expect(
          generatedCode,
          contains('static List<String> sourceLibraries()'),
          reason: 'sourceLibraries() must always be emitted',
        );
      },
    );

    test(
      'G-ISS-38: getImportBlock() is emitted even without a barrel URI [2026-06-17] (PASS)',
      () {
        expect(
          generatedCode,
          contains('static String getImportBlock()'),
          reason:
              'getImportBlock() must be emitted unconditionally — the '
              'dartscript helper calls it regardless of strategy',
        );
      },
    );

    test(
      'G-ISS-39: subPackageBarrels() is emitted even without a barrel URI [2026-06-17] (PASS)',
      () {
        expect(
          generatedCode,
          contains('static List<String> subPackageBarrels()'),
          reason:
              'subPackageBarrels() must be emitted unconditionally — the '
              'dartscript helper calls it regardless of strategy',
        );
      },
    );
  });
}
