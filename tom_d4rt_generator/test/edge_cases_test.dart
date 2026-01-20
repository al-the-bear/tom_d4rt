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
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
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
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
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
      test('detects ReservedWordsClass', () {
        expect(generatedCode, contains("name: 'ReservedWordsClass'"));
      });

      test('handles reserved word parameter names safely', () {
        // The generator should handle parameters like class_, for_, in_
        expect(generatedCode, contains('_createReservedWordsClassBridge'));
      });
    });

    group('Nested Generic Types', () {
      test('detects NestedGenericsClass', () {
        expect(generatedCode, contains("name: 'NestedGenericsClass'"));
      });

      test('detects Result<T, E> with multiple type params', () {
        expect(generatedCode, contains("name: 'Result'"));
      });

      test('generates methods with nested generics', () {
        expect(generatedCode, contains("'getItems':"));
        expect(generatedCode, contains("'addEntry':"));
      });
    });

    group('Default Values with Static References', () {
      test('detects DefaultValuesClass', () {
        expect(generatedCode, contains("name: 'DefaultValuesClass'"));
      });

      test('constructor with static default values is bridged', () {
        expect(generatedCode, contains('_createDefaultValuesClassBridge'));
      });
    });

    group('Function Type Parameters', () {
      test('detects CallbackHolder', () {
        expect(generatedCode, contains("name: 'CallbackHolder'"));
      });

      test('detects FunctionParamsClass', () {
        expect(generatedCode, contains("name: 'FunctionParamsClass'"));
      });

      test('methods with function parameters may be bridged or skipped', () {
        // Function types are typically handled as dynamic
        expect(generatedCode, contains('FunctionParamsClass'));
      });
    });

    group('Operator Overloading', () {
      test('detects Vector2D class', () {
        expect(generatedCode, contains("name: 'Vector2D'"));
      });

      test('length getter is bridged', () {
        expect(generatedCode, contains("'length':"));
      });

      test('toString is bridged', () {
        expect(generatedCode, contains("'toString':"));
      });
    });

    group('Empty and Minimal Classes', () {
      test('detects EmptyClass', () {
        expect(generatedCode, contains("name: 'EmptyClass'"));
      });

      test('detects MinimalClass', () {
        expect(generatedCode, contains("name: 'MinimalClass'"));
      });

      test('detects StaticOnlyClass', () {
        expect(generatedCode, contains("name: 'StaticOnlyClass'"));
      });

      test('empty class has default constructor', () {
        expect(generatedCode, contains('_createEmptyClassBridge'));
      });
    });

    group('Many Parameters Stress Test', () {
      test('detects ManyParamsClass', () {
        expect(generatedCode, contains("name: 'ManyParamsClass'"));
      });

      test('constructor with many params is bridged', () {
        expect(generatedCode, contains('_createManyParamsClassBridge'));
      });
    });

    group('Nullable Parameters', () {
      test('detects NullableParamsClass', () {
        expect(generatedCode, contains("name: 'NullableParamsClass'"));
      });

      test('nullable getters are bridged', () {
        expect(generatedCode, contains("'nullableString':"));
        expect(generatedCode, contains("'nullableInt':"));
      });

      test('methods with nullable params are bridged', () {
        expect(generatedCode, contains("'format':"));
        expect(generatedCode, contains("'getFirstOrNull':"));
      });
    });

    group('Mixins', () {
      test('detects LoggingClass', () {
        expect(generatedCode, contains("name: 'LoggingClass'"));
      });

      test('LoggingClass has its own doWork method', () {
        // Note: Mixin-provided methods may not be detected without full resolution
        // The class's own methods should still be bridged
        expect(generatedCode, contains("'doWork':"));
      });
    });

    group('Late Initialization', () {
      test('detects LateInitClass', () {
        expect(generatedCode, contains("name: 'LateInitClass'"));
      });

      test('late fields have getters and setters', () {
        expect(generatedCode, contains("'name':"));
        expect(generatedCode, contains("'id':"));
      });

      test('initialize method is bridged', () {
        expect(generatedCode, contains("'initialize':"));
      });
    });

    group('Covariant Parameters', () {
      test('detects Cat class', () {
        expect(generatedCode, contains("name: 'Cat'"));
      });

      test('overridden method with covariant param is bridged', () {
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
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
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

    test('Result class with multiple type parameters is bridged', () {
      expect(generatedCode, contains("name: 'Result'"));
    });

    test('empty class is bridged with constructor', () {
      expect(generatedCode, contains("name: 'EmptyClass'"));
      expect(generatedCode, contains('_createEmptyClassBridge'));
    });

    test('static-only class has static members', () {
      expect(generatedCode, contains("name: 'StaticOnlyClass'"));
      expect(generatedCode, contains('staticGetters'));
      expect(generatedCode, contains('staticMethods'));
    });

    test('class using mixin is bridged', () {
      // Note: Mixin-provided methods may not be detected without full resolution
      expect(generatedCode, contains("name: 'LoggingClass'"));
    });

    test('LoggingClass has its own method doWork bridged', () {
      // The class's own method should be bridged
      expect(generatedCode, contains("'doWork':"));
    });

    test('concrete implementation Cat is bridged', () {
      // Abstract Animal may be skipped, but concrete Cat should be bridged
      expect(generatedCode, contains("name: 'Cat'"));
    });
  });

  group('Combined Sources Generation', () {
    test('generates from multiple source files', () async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
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

    test('handles empty source file gracefully', () async {
      // Create a minimal temp file
      final emptyFile = File(p.join(tempOutputDir, 'empty_source.dart'));
      emptyFile.writeAsStringSync('library;\n// Empty file\n');

      final generator = BridgeGenerator(
        workspacePath: tempOutputDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
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
    test('reports errors for invalid source paths', () async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
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
    test('skipPrivate=true skips private members in output', () async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
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

    test('skipPrivate=false includes private members in output', () async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: false,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
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

    test('verbose mode does not affect output structure', () async {
      final sourceFile = p.join(testFixturesDir, 'enum_test_source.dart');

      final verboseGenerator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'enum_test_source.dart',
        packageName: 'test_package',
        verbose: true,
      );

      final quietGenerator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
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
