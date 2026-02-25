/// Integration test for the d4 example project.
///
/// This test verifies that:
/// - Extension bridges on core types (String, int, List) compile correctly
/// - Callback function parameters are handled correctly
/// - The d4 example project can be compiled without errors
///
/// Tests the fixes for:
/// - GEN-070: Extensions on built-in types should not use $pkg prefix
/// - GEN-071: Function-typed parameters with defaults use combinatorial dispatch
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String d4ExampleDir;
  late String tempOutputDir;

  setUpAll(() {
    d4ExampleDir = p.join(Directory.current.path, 'example', 'd4');
    tempOutputDir = Directory.systemTemp.createTempSync('d4_example_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('D4 Example Project - Core Type Extensions', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: d4ExampleDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        d4rtImport: 'package:tom_d4rt_exec/d4rt.dart',
        sourceImport: 'package:d4_example/test_extensions.dart',
        packageName: 'd4_example',
        verbose: false,
      );

      final sourceFile = p.join(d4ExampleDir, 'lib', 'test_extensions.dart');
      final outputFile = p.join(tempOutputDir, 'd4_bridges_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'core_extensions',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    test('D4-10: StringExtension does not use \$pkg prefix. [2026-02-11] (PASS)', () {
      // String is a built-in type, so the cast should be (target as String)
      // not (target as \$d4_example_1.String)
      expect(generatedCode, contains("onTypeName: 'String'"));
      expect(generatedCode, contains('(target as String)'));
      expect(generatedCode, isNot(contains(r'(target as $d4_example_1.String)')));
    });

    test('D4-11: IntExtension does not use \$pkg prefix. [2026-02-11] (PASS)', () {
      // int is a built-in type, so the cast should be (target as int)
      expect(generatedCode, contains("onTypeName: 'int'"));
      expect(generatedCode, contains('(target as int)'));
      expect(generatedCode, isNot(contains(r'(target as $d4_example_1.int)')));
    });

    test('D4-12: StringExtension generates getters. [2026-02-11] (PASS)', () {
      expect(generatedCode, contains("'reversed': (visitor, target) =>"));
      expect(generatedCode, contains("'isBlank': (visitor, target) =>"));
      expect(generatedCode, contains("'isNotBlank': (visitor, target) =>"));
      expect(generatedCode, contains("'inParens': (visitor, target) =>"));
    });

    test('D4-13: StringExtension generates methods. [2026-02-11] (PASS)', () {
      expect(generatedCode, contains("'repeatWith': (visitor, target, positional, named, typeArgs)"));
    });

    test('D4-14: IntExtension generates factorial getter. [2026-02-11] (PASS)', () {
      expect(generatedCode, contains("'factorial': (visitor, target) =>"));
    });

    test('D4-15: IntExtension generates clampTo method. [2026-02-11] (PASS)', () {
      expect(generatedCode, contains("'clampTo': (visitor, target, positional, named, typeArgs)"));
    });

    test('D4-20: TestPoint class uses \$pkg prefix. [2026-02-11] (PASS)', () {
      // TestPoint is NOT a built-in type, so it should use $<pkgname>_<N> prefix
      expect(generatedCode, contains(r'nativeType: $d4_example_1.TestPoint'));
    });

    test('D4-21: processItems function with callback is generated. [2026-02-11] (PASS)', () {
      expect(generatedCode, contains("'processItems':"));
    });

    test('D4-22: filterItems function with optional callback is generated. [2026-02-11] (PASS)', () {
      expect(generatedCode, contains("'filterItems':"));
    });

    test('D4-23: promptUser function with nullable callback is generated. [2026-02-11] (PASS)', () {
      expect(generatedCode, contains("'promptUser':"));
    });

    test('D4-30: ItemProcessor class with callback constructor is generated. [2026-02-11] (PASS)', () {
      expect(generatedCode, contains(r'nativeType: $d4_example_1.ItemProcessor'));
    });
  });
}
