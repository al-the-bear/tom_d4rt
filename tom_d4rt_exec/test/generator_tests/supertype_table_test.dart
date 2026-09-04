/// Tests for the generated supertype table.
///
/// Verifies that `BridgeGenerator` emits a `classSupertypes()` method whose
/// entries match the analyzer's flattened (transitive) `allSupertypes` set for
/// each bridged class, and that the per-package `registerBridges` wires it into
/// `BridgedClass.registerSupertypes`.
///
/// The table is flattened (each class lists ALL transitive bridged ancestors)
/// because `BridgedClass.isSubtypeOf` only walks two levels. See
/// `fixtures/supertype_table_source.dart` for the hierarchy under test.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;
  late String generatedCode;

  setUpAll(() async {
    testFixturesDir = p.join(
      Directory.current.path,
      'test',
      'generator_tests',
      'fixtures',
    );
    tempOutputDir = Directory.systemTemp
        .createTempSync('supertype_table_test_')
        .path;

    final generator = BridgeGenerator(
      workspacePath: testFixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
      sourceImport: 'supertype_table_source.dart',
      packageName: 'test_package',
      verbose: false,
    );

    final sourceFile = p.join(testFixturesDir, 'supertype_table_source.dart');
    final outputFile = p.join(tempOutputDir, 'supertype_table_bridges.dart');

    final result = await generator.generateBridges(
      sourceFiles: [sourceFile],
      outputPath: outputFile,
      moduleName: 'test',
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

  /// Extracts the flattened supertype list emitted for [className] in the
  /// generated `classSupertypes()` table. Returns null when the class has no
  /// entry (i.e. an empty / root class is omitted from the table).
  Set<String>? supertypesOf(String className) {
    // Match `      'Dog': ['Animal', 'Walks'],`
    final pattern = RegExp("'${RegExp.escape(className)}': \\[([^\\]]*)\\]");
    final match = pattern.firstMatch(generatedCode);
    if (match == null) return null;
    final inner = match.group(1)!.trim();
    if (inner.isEmpty) return <String>{};
    return inner
        .split(',')
        .map((s) => s.trim().replaceAll("'", ''))
        .where((s) => s.isNotEmpty)
        .toSet();
  }

  group('Generated supertype table', () {
    test('GEN-A1-1: emits a classSupertypes() method', () {
      expect(generatedCode, contains('classSupertypes()'));
      expect(
        generatedCode,
        contains('Map<String, List<String>> classSupertypes()'),
      );
    });

    test('GEN-A1-2: registerBridges wires registerSupertypes', () {
      expect(
        generatedCode,
        contains('BridgedClass.registerSupertypes(classSupertypes())'),
      );
    });

    test('GEN-A1-3: direct extends + implements is flattened', () {
      // Dog extends Animal implements Walks
      expect(supertypesOf('Dog'), {'Animal', 'Walks'});
    });

    test('GEN-A1-4: transitive extends chain is flattened', () {
      // Puppy extends Dog (-> Animal, Walks). isSubtypeOf walks only two
      // levels, so the table must list ALL transitive ancestors.
      final supers = supertypesOf('Puppy');
      expect(supers, isNotNull);
      expect(supers, containsAll(<String>['Dog', 'Animal', 'Walks']));
    });

    test('GEN-A1-5: applied mixin is captured', () {
      // Fish with Swims
      expect(supertypesOf('Fish'), {'Swims'});
    });

    test('GEN-A1-6: extends + with + implements combined', () {
      // Amphibian extends Animal with Swims implements Walks
      final supers = supertypesOf('Amphibian');
      expect(supers, isNotNull);
      expect(supers, containsAll(<String>['Animal', 'Swims', 'Walks']));
    });

    test('GEN-A1-7: root class with no bridged supertype is omitted', () {
      // Animal extends Object only -> no entry in the table.
      expect(supertypesOf('Animal'), isNull);
    });
  });
}
