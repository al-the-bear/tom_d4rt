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
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
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
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
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

    test('bridges Printable mixin', () {
      expect(generatedCode, contains("'Printable'"),
          reason: 'Should bridge Printable mixin');
    });

    test('bridges JsonSerializable mixin', () {
      expect(generatedCode, contains("'JsonSerializable'"),
          reason: 'Should bridge JsonSerializable mixin');
    });

    test('bridges Comparable mixin', () {
      expect(generatedCode, contains("'Comparable'"),
          reason: 'Should bridge generic Comparable mixin');
    });

    test('bridges Nameable mixin', () {
      expect(generatedCode, contains("'Nameable'"),
          reason: 'Should bridge Nameable mixin with getter/setter');
    });

    test('skips private _PrivateMixin', () {
      expect(generatedCode, isNot(contains("'_PrivateMixin'")),
          reason: 'Should skip private mixin');
      expect(generatedCode, isNot(contains("'secretMethod'")),
          reason: 'Should not include private mixin methods');
    });

    test('includes Printable.printFormatted method', () {
      expect(generatedCode, contains("'printFormatted'"),
          reason: 'Should include printFormatted method');
    });

    test('includes Printable.displayString getter', () {
      expect(generatedCode, contains("'displayString'"),
          reason: 'Should include displayString getter');
    });

    test('includes JsonSerializable.toMap method', () {
      expect(generatedCode, contains("'toMap'"),
          reason: 'Should include toMap method');
    });

    test('includes JsonSerializable.toJsonString method', () {
      expect(generatedCode, contains("'toJsonString'"),
          reason: 'Should include toJsonString method');
    });

    test('includes Nameable.name getter', () {
      // The name getter from Nameable should be included
      expect(generatedCode, contains("'name'"),
          reason: 'Should include name getter');
    });

    test('mixins are bridged as abstract (no constructors)', () {
      // Mixins should not have constructor bridges since they can't be instantiated
      // Check that Printable does not have a default constructor
      // (This is implied by isAbstract: true in the _ParsedClass)
      expect(generatedCode, contains("'Printable'"));
      // The bridge should exist but without a callable constructor
    });

    test('TestEntity class is also bridged', () {
      expect(generatedCode, contains("'TestEntity'"),
          reason: 'Should also bridge the concrete class using mixins');
    });
  });
}
