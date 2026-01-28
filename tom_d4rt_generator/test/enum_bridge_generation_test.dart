/// Integration tests for bridge generator enum support.
///
/// These tests verify that the generator correctly:
/// - Detects enums from source files
/// - Generates BridgedEnumDefinition code
/// - Generates registerBridgedEnum calls
/// - Handles complex enum cases
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    // Get the test fixtures directory relative to the package root
    // When running tests, we're in the package root
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    
    // Create a temporary output directory
    tempOutputDir = Directory.systemTemp.createTempSync('bridge_gen_test_').path;
  });

  tearDownAll(() {
    // Clean up temp directory
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {
      // Ignore cleanup errors
    }
  });

  group('Enum Bridge Generation', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'enum_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'enum_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'enum_bridge_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    test('detects simple enums', () {
      expect(generatedCode, contains("name: 'SimpleStatus'"));
      expect(generatedCode, contains("name: 'Color'"));
      expect(generatedCode, contains("name: 'Singleton'"));
    });

    test('detects enums with members', () {
      expect(generatedCode, contains("name: 'Priority'"));
      expect(generatedCode, contains("name: 'HttpMethod'"));
      expect(generatedCode, contains("name: 'Planet'"));
    });

    test('skips private enums', () {
      expect(generatedCode, isNot(contains('_InternalState')));
    });

    test('generates bridgedEnums method', () {
      expect(generatedCode, contains('static List<BridgedEnumDefinition> bridgedEnums()'));
    });

    test('generates BridgedEnumDefinition with correct type parameter', () {
      // Types are prefixed with $pkg since source imports use that prefix
      expect(generatedCode, contains(r'BridgedEnumDefinition<$pkg.SimpleStatus>'));
      expect(generatedCode, contains(r'BridgedEnumDefinition<$pkg.Color>'));
      expect(generatedCode, contains(r'BridgedEnumDefinition<$pkg.Priority>'));
    });

    test('generates enum values reference', () {
      // Types are prefixed with $pkg since source imports use that prefix
      expect(generatedCode, contains(r'values: $pkg.SimpleStatus.values'));
      expect(generatedCode, contains(r'values: $pkg.Color.values'));
      expect(generatedCode, contains(r'values: $pkg.Priority.values'));
    });

    test('generates registerBridgedEnum calls in registerBridges', () {
      expect(generatedCode, contains('interpreter.registerBridgedEnum(enumDef, importPath)'));
    });

    test('generates enumNames property', () {
      expect(generatedCode, contains("static List<String> get enumNames"));
      expect(generatedCode, contains("'SimpleStatus'"));
      expect(generatedCode, contains("'Color'"));
      expect(generatedCode, contains("'Priority'"));
    });

    test('generates class bridges that reference enums', () {
      expect(generatedCode, contains('_createTaskBridge'));
      expect(generatedCode, contains('_createTaskManagerBridge'));
    });
  });

  group('Enum Bridge Generation - Edge Cases', () {
    test('handles file with no enums', () async {
      // Create a temp file with no enums
      final noEnumFile = File(p.join(tempOutputDir, 'no_enums.dart'));
      await noEnumFile.writeAsString('''
class SimpleClass {
  final String name;
  SimpleClass(this.name);
}
''');

      final generator = BridgeGenerator(
        workspacePath: tempOutputDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final result = await generator.generateBridges(
        sourceFiles: [noEnumFile.path],
        outputPath: p.join(tempOutputDir, 'no_enums_bridge.dart'),
        moduleName: 'test',
      );

      expect(result.errors, isEmpty);
      final code = await File(result.outputFiles.first).readAsString();
      
      // Should not have bridgedEnums method when no enums
      expect(code, isNot(contains('bridgedEnums()')));
      expect(code, isNot(contains('registerBridgedEnum')));
    });

    test('handles file with only private enums', () async {
      // Create a temp file with only private enums
      final privateEnumFile = File(p.join(tempOutputDir, 'private_enums.dart'));
      await privateEnumFile.writeAsString('''
// ignore: unused_element
enum _PrivateEnum { a, b, c }

class PublicClass {
  final String name;
  PublicClass(this.name);
}
''');

      final generator = BridgeGenerator(
        workspacePath: tempOutputDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final result = await generator.generateBridges(
        sourceFiles: [privateEnumFile.path],
        outputPath: p.join(tempOutputDir, 'private_enums_bridge.dart'),
        moduleName: 'test',
      );

      expect(result.errors, isEmpty);
      final code = await File(result.outputFiles.first).readAsString();
      
      // Should not include private enum
      expect(code, isNot(contains('_PrivateEnum')));
    });

    test('handles single-value enum', () async {
      final singleValueFile = File(p.join(tempOutputDir, 'single_value.dart'));
      await singleValueFile.writeAsString('''
enum SingletonEnum { instance }

class DummyClass {
  final String name;
  DummyClass(this.name);
}
''');

      final generator = BridgeGenerator(
        workspacePath: tempOutputDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final result = await generator.generateBridges(
        sourceFiles: [singleValueFile.path],
        outputPath: p.join(tempOutputDir, 'single_value_bridge.dart'),
        moduleName: 'test',
      );

      expect(result.errors, isEmpty);
      expect(result.outputFiles, isNotEmpty, 
        reason: 'Should generate output file');
      final code = await File(result.outputFiles.first).readAsString();
      
      expect(code, contains("name: 'SingletonEnum'"));
      // Types are prefixed with $pkg since source imports use that prefix
      expect(code, contains(r'values: $pkg.SingletonEnum.values'));
    });
  });
}
