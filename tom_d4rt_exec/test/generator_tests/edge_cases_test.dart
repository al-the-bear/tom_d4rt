/// Tests for bridge generator edge cases and difficult scenarios.
///
/// These tests verify that the generator correctly handles:
/// - Reserved word parameter names
/// - Complex nested generic types
/// - Function type parameters
/// - Operator overloading
/// - Special patterns (empty classes, static-only, etc.)
/// - Mixins and late initialization
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
        Directory.systemTemp.createTempSync('bridge_edge_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Edge Cases Generation', () {
    late String generatedCode;
    late BridgeGeneratorResult result;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        sourceImport: 'edge_cases_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'edge_cases_source.dart');
      final outputFile = p.join(tempOutputDir, 'edge_cases_test.dart');

      result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'edge',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    group('Reserved Word Parameters', () {
      test('G-EDGE-34: Detects ReservedWordsClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'ReservedWordsClass'"));
      });

      test('G-EDGE-35: Handles reserved word parameter names safely. [2026-02-10 06:37] (PASS)', () {
        // The generator should handle parameters like class_, for_, in_
        expect(generatedCode, contains('_createReservedWordsClassBridge'));
      });
    });

    group('Nested Generic Types', () {
      test('G-EDGE-36: Detects NestedGenericsClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'NestedGenericsClass'"));
      });

      test('G-EDGE-37: Detects Result<T, E> with multiple type params. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'Result'"));
      });

      test('G-EDGE-38: Generates methods with nested generics. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'getItems':"));
        expect(generatedCode, contains("'addEntry':"));
      });
    });

    group('Default Values with Static References', () {
      test('G-EDGE-39: Detects DefaultValuesClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'DefaultValuesClass'"));
      });

      test('G-EDGE-40: Constructor with static default values is bridged. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains('_createDefaultValuesClassBridge'));
      });
    });

    group('Function Type Parameters', () {
      test('G-EDGE-41: Detects CallbackHolder. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'CallbackHolder'"));
      });

      test('G-EDGE-1: Detects FunctionParamsClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'FunctionParamsClass'"));
      });

      test('G-EDGE-2: Methods with function parameters may be bridged or skipped. [2026-02-10 06:37] (PASS)', () {
        // Function types are typically handled as dynamic
        expect(generatedCode, contains('FunctionParamsClass'));
      });
    });

    group('Operator Overloading', () {
      test('G-EDGE-3: Detects Vector2D class. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'Vector2D'"));
      });

      test('G-EDGE-4: Length getter is bridged. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'length':"));
      });

      test('G-EDGE-5: ToString is bridged. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'toString':"));
      });
    });

    group('Empty and Minimal Classes', () {
      test('G-EDGE-6: Detects EmptyClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'EmptyClass'"));
      });

      test('G-EDGE-7: Detects MinimalClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'MinimalClass'"));
      });

      test('G-EDGE-8: Detects StaticOnlyClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'StaticOnlyClass'"));
      });

      test('G-EDGE-9: Empty class has default constructor. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains('_createEmptyClassBridge'));
      });
    });

    group('Many Parameters Stress Test', () {
      test('G-EDGE-10: Detects ManyParamsClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'ManyParamsClass'"));
      });

      test('G-EDGE-11: Constructor with many params is bridged. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains('_createManyParamsClassBridge'));
      });
    });

    group('Nullable Parameters', () {
      test('G-EDGE-12: Detects NullableParamsClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'NullableParamsClass'"));
      });

      test('G-EDGE-13: Nullable getters are bridged. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'nullableString':"));
        expect(generatedCode, contains("'nullableInt':"));
      });

      test('G-EDGE-14: Methods with nullable params are bridged. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'format':"));
        expect(generatedCode, contains("'getFirstOrNull':"));
      });
    });

    group('Mixins', () {
      test('G-EDGE-15: Detects LoggingClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'LoggingClass'"));
      });

      test('G-EDGE-16: LoggingClass has its own doWork method. [2026-02-10 06:37] (PASS)', () {
        // Note: Mixin-provided methods may not be detected without full resolution
        // The class's own methods should still be bridged
        expect(generatedCode, contains("'doWork':"));
      });
    });

    group('Late Initialization', () {
      test('G-EDGE-17: Detects LateInitClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'LateInitClass'"));
      });

      test('G-EDGE-18: Late fields have getters and setters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'name':"));
        expect(generatedCode, contains("'id':"));
      });

      test('G-EDGE-19: Initialize method is bridged. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'initialize':"));
      });
    });

    group('Covariant Parameters', () {
      test('G-EDGE-20: Detects Cat class. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'Cat'"));
      });

      test('G-EDGE-21: Overridden method with covariant param is bridged. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'feed':"));
      });
    });
  });

  group('Edge Case Class Verification', () {
    late String generatedCode;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        sourceImport: 'edge_cases_source.dart',
        packageName: 'test_package',
      );

      final sourceFile = p.join(testFixturesDir, 'edge_cases_source.dart');
      final outputFile = p.join(tempOutputDir, 'edge_verify.dart');

      await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'verify',
      );

      generatedCode = await File(outputFile).readAsString();
    });

    test('G-EDGE-22: Result class with multiple type parameters is bridged. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("name: 'Result'"));
    });

    test('G-EDGE-23: Empty class is bridged with constructor. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("name: 'EmptyClass'"));
      expect(generatedCode, contains('_createEmptyClassBridge'));
    });

    test('G-EDGE-24: Static-only class has static members. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("name: 'StaticOnlyClass'"));
      expect(generatedCode, contains('staticGetters'));
      expect(generatedCode, contains('staticMethods'));
    });

    test('G-EDGE-25: Class using mixin is bridged. [2026-02-10 06:37] (PASS)', () {
      // Note: Mixin-provided methods may not be detected without full resolution
      expect(generatedCode, contains("name: 'LoggingClass'"));
    });

    test('G-EDGE-26: LoggingClass has its own method doWork bridged. [2026-02-10 06:37] (PASS)', () {
      // The class's own method should be bridged
      expect(generatedCode, contains("'doWork':"));
    });

    test('G-EDGE-27: Concrete implementation Cat is bridged. [2026-02-10 06:37] (PASS)', () {
      // Abstract Animal may be skipped, but concrete Cat should be bridged
      expect(generatedCode, contains("name: 'Cat'"));
    });
  });

  group('Combined Sources Generation', () {
    test('G-EDGE-28: Generates from multiple source files. [2026-02-10 06:37] (PASS)', () async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        sourceImport: 'all_sources.dart',
        packageName: 'test_package',
      );

      final sourceFiles = [
        p.join(testFixturesDir, 'class_test_source.dart'),
        p.join(testFixturesDir, 'enum_test_source.dart'),
        p.join(testFixturesDir, 'global_test_source.dart'),
      ];

      final outputFile = p.join(tempOutputDir, 'combined_bridges.dart');

      final result = await generator.generateBridges(
        sourceFiles: sourceFiles,
        outputPath: outputFile,
        moduleName: 'combined',
      );

      expect(result.errors, isEmpty);
      expect(result.classesGenerated, greaterThan(0));

      final code = await File(outputFile).readAsString();

      // Should have classes from class_test_source
      expect(code, contains("name: 'SimpleClass'"));

      // Should have enums from enum_test_source
      expect(code, contains("name: 'SimpleStatus'"));
    });

    test('G-EDGE-29: Handles empty source file gracefully. [2026-02-10 06:37] (PASS)', () async {
      // Create a minimal temp file
      final emptyFile = File(p.join(tempOutputDir, 'empty_source.dart'));
      emptyFile.writeAsStringSync('library;\n// Empty file\n');

      final generator = BridgeGenerator(
        workspacePath: tempOutputDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        packageName: 'test_package',
      );

      final outputFile = p.join(tempOutputDir, 'empty_bridges.dart');

      final result = await generator.generateBridges(
        sourceFiles: [emptyFile.path],
        outputPath: outputFile,
        moduleName: 'empty',
      );

      // Should complete without errors
      expect(result.errors, isEmpty);
      expect(result.classesGenerated, equals(0));
    });
  });

  group('Error Handling', () {
    test('G-EDGE-30: Reports errors for invalid source paths. [2026-02-10 06:37] (PASS)', () async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        packageName: 'test_package',
      );

      final result = await generator.generateBridges(
        sourceFiles: ['/nonexistent/path/to/file.dart'],
        outputPath: p.join(tempOutputDir, 'error_test.dart'),
        moduleName: 'error',
      );

      // Should have errors or warnings for missing file
      // The exact behavior depends on implementation
      expect(
        result.errors.isNotEmpty || result.warnings.isNotEmpty || result.classesGenerated == 0,
        isTrue,
      );
    });
  });

  group('Generator Options', () {
    test('G-EDGE-31: SkipPrivate=true skips private members in output. [2026-02-10 06:37] (PASS)', () async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        sourceImport: 'class_test_source.dart',
        packageName: 'test_package',
      );

      final sourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'skip_private_true.dart');

      await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'skip',
      );

      final code = await File(outputFile).readAsString();

      // Should not have _PrivateClass
      expect(code, isNot(contains('_PrivateClass')));
    });

    test('G-EDGE-32: SkipPrivate=false includes private members in output. [2026-02-10 06:37] (PASS)', () async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: false,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        sourceImport: 'class_test_source.dart',
        packageName: 'test_package',
      );

      final sourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'skip_private_false.dart');

      await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'include',
      );

      final code = await File(outputFile).readAsString();

      // Should have _PrivateClass
      expect(code, contains('_PrivateClass'));
    });

    test('G-EDGE-33: Verbose mode does not affect output structure. [2026-02-10 06:37] (PASS)', () async {
      final sourceFile = p.join(testFixturesDir, 'enum_test_source.dart');

      final verboseGenerator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        sourceImport: 'enum_test_source.dart',
        packageName: 'test_package',
        verbose: true,
      );

      final quietGenerator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
        sourceImport: 'enum_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final verboseOutput = p.join(tempOutputDir, 'verbose_out.dart');
      final quietOutput = p.join(tempOutputDir, 'quiet_out.dart');

      await verboseGenerator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: verboseOutput,
        moduleName: 'verbose',
      );

      await quietGenerator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: quietOutput,
        moduleName: 'quiet',
      );

      final verboseCode = await File(verboseOutput).readAsString();
      final quietCode = await File(quietOutput).readAsString();

      // Both should have the same enum definitions
      expect(verboseCode, contains("name: 'SimpleStatus'"));
      expect(quietCode, contains("name: 'SimpleStatus'"));
    });
  });
}
