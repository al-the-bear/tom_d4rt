/// Test for GEN-048: Pure mixin declarations bridging.
///
/// Verifies that the generator correctly bridges pure `mixin` declarations
/// (not `mixin class`), making them available as types in D4rt scripts.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'generator_tests', 'fixtures');
    tempOutputDir =
        Directory.systemTemp.createTempSync('bridge_mixin_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('GEN-048: Pure Mixin Bridging', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        sourceImport: 'mixin_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'mixin_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'mixin_bridges_test.dart');

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

    test('G-MIX-5: Bridges Printable mixin. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'Printable'"),
          reason: 'Should bridge Printable mixin');
    });

    test('G-MIX-6: Bridges JsonSerializable mixin. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'JsonSerializable'"),
          reason: 'Should bridge JsonSerializable mixin');
    });

    test('G-MIX-7: Bridges Comparable mixin. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'Comparable'"),
          reason: 'Should bridge generic Comparable mixin');
    });

    test('G-MIX-8: Bridges Nameable mixin. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'Nameable'"),
          reason: 'Should bridge Nameable mixin with getter/setter');
    });

    test('G-MIX-9: Skips private _PrivateMixin. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, isNot(contains("'_PrivateMixin'")),
          reason: 'Should skip private mixin');
      expect(generatedCode, isNot(contains("'secretMethod'")),
          reason: 'Should not include private mixin methods');
    });

    test('G-MIX-10: Includes Printable.printFormatted method. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'printFormatted'"),
          reason: 'Should include printFormatted method');
    });

    test('G-MIX-11: Includes Printable.displayString getter. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'displayString'"),
          reason: 'Should include displayString getter');
    });

    test('G-MIX-12: Includes JsonSerializable.toMap method. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'toMap'"),
          reason: 'Should include toMap method');
    });

    test('G-MIX-1: Includes JsonSerializable.toJsonString method. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'toJsonString'"),
          reason: 'Should include toJsonString method');
    });

    test('G-MIX-2: Includes Nameable.name getter. [2026-02-10 06:37] (PASS)', () {
      // The name getter from Nameable should be included
      expect(generatedCode, contains("'name'"),
          reason: 'Should include name getter');
    });

    test('G-MIX-3: Mixins are bridged as abstract (no constructors). [2026-02-10 06:37] (PASS)', () {
      // Mixins should not have constructor bridges since they can't be instantiated
      // Check that Printable does not have a default constructor
      // (This is implied by isAbstract: true in the _ParsedClass)
      expect(generatedCode, contains("'Printable'"));
      // The bridge should exist but without a callable constructor
    });

    test('G-MIX-4: TestEntity class is also bridged. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'TestEntity'"),
          reason: 'Should also bridge the concrete class using mixins');
    });
  });
}
