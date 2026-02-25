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
    testFixturesDir = p.join(Directory.current.path, 'test', 'generator_tests', 'fixtures');
    
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
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
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

    test('G-ENM-10: Detects simple enums. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("name: 'SimpleStatus'"));
      expect(generatedCode, contains("name: 'Color'"));
      expect(generatedCode, contains("name: 'Singleton'"));
    });

    test('G-ENM-11: Detects enums with members. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("name: 'Priority'"));
      expect(generatedCode, contains("name: 'HttpMethod'"));
      expect(generatedCode, contains("name: 'Planet'"));
    });

    test('G-ENM-12: Skips private enums. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, isNot(contains('_InternalState')));
    });

    test('G-ENM-13: Generates bridgedEnums method. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains('static List<BridgedEnumDefinition> bridgedEnums()'));
    });

    test('G-ENM-14: Generates BridgedEnumDefinition with correct type parameter. [2026-02-10 06:37] (PASS)', () {
      // Types are prefixed with $<pkgname>_<N> since source imports use direct import aliases
      expect(generatedCode, contains(r'BridgedEnumDefinition<$test_package_1.SimpleStatus>'));
      expect(generatedCode, contains(r'BridgedEnumDefinition<$test_package_1.Color>'));
      expect(generatedCode, contains(r'BridgedEnumDefinition<$test_package_1.Priority>'));
    });

    test('G-ENM-15: Generates enum values reference. [2026-02-10 06:37] (PASS)', () {
      // Types are prefixed with $<pkgname>_<N> since source imports use direct import aliases
      expect(generatedCode, contains(r'values: $test_package_1.SimpleStatus.values'));
      expect(generatedCode, contains(r'values: $test_package_1.Color.values'));
      expect(generatedCode, contains(r'values: $test_package_1.Priority.values'));
    });

    test('G-ENM-16: Generates registerBridgedEnum calls in registerBridges. [2026-02-10 06:37] (PASS)', () {
      // The call includes sourceUri for deduplication support
      expect(generatedCode, contains('interpreter.registerBridgedEnum(enumDef, importPath, sourceUri:'));
    });

    test('G-ENM-1: Generates enumNames property. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("static List<String> get enumNames"));
      expect(generatedCode, contains("'SimpleStatus'"));
      expect(generatedCode, contains("'Color'"));
      expect(generatedCode, contains("'Priority'"));
    });

    test('G-ENM-2: Generates class bridges that reference enums. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains('_createTaskBridge'));
      expect(generatedCode, contains('_createTaskManagerBridge'));
    });

    test('G-ENM-3: Generates getter adapters for enhanced enum fields. [2026-02-10 06:37] (PASS)', () {
      // Priority has computed getters: 'level' and 'isHighPriority'
      expect(generatedCode, contains("'level': (visitor, target) =>"));
      expect(generatedCode, contains(r'(target as $test_package_1.Priority).level'));
      expect(generatedCode, contains("'isHighPriority': (visitor, target) =>"));
      expect(generatedCode, contains(r'(target as $test_package_1.Priority).isHighPriority'));
    });

    test('G-ENM-4: Generates getter adapters for Planet fields. [2026-02-10 06:37] (PASS)', () {
      // Planet has 'mass' and 'radius' final fields, plus 'surfaceGravity' computed getter
      expect(generatedCode, contains("'mass': (visitor, target) =>"));
      expect(generatedCode, contains("'radius': (visitor, target) =>"));
      expect(generatedCode, contains(r'(target as $test_package_1.Planet).mass'));
      expect(generatedCode, contains(r'(target as $test_package_1.Planet).radius'));
      expect(generatedCode, contains("'surfaceGravity': (visitor, target) =>"));
    });

    test('G-ENM-5: Generates method adapters for enhanced enum methods. [2026-02-10 06:37] (PASS)', () {
      // HttpMethod has 'canHaveBody()' and 'toUpperCase()'
      expect(generatedCode, contains("'canHaveBody':"));
      expect(generatedCode, contains("'toUpperCase':"));
    });

    test('G-ENM-6: Does NOT generate getters for simple enums. [2026-02-10 06:37] (PASS)', () {
      // SimpleStatus has no custom fields — should have no getters: block
      // We need to check that there's no getters block right after SimpleStatus
      final simpleIdx = generatedCode.indexOf("name: 'SimpleStatus'");
      expect(simpleIdx, greaterThan(0));
      // Find the closing '),\n' of this BridgedEnumDefinition
      final nextDef = generatedCode.indexOf('BridgedEnumDefinition', simpleIdx + 1);
      final section = nextDef > 0
          ? generatedCode.substring(simpleIdx, nextDef)
          : generatedCode.substring(simpleIdx, simpleIdx + 200);
      expect(section, isNot(contains("getters:")),
          reason: 'Simple enum should not have getters');
    });
  });

  group('Enum Bridge Generation - Edge Cases', () {
    test('G-ENM-7: Handles file with no enums. [2026-02-10 06:37] (PASS)', () async {
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
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
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
      
      // bridgedEnums() is always generated for API consistency,
      // but returns empty list when no enums exist
      expect(code, contains('bridgedEnums()'));
      // The method signature List<BridgedEnumDefinition> is present,
      // but no BridgedEnumDefinition( constructor calls (with opening paren)
      expect(code, isNot(contains('BridgedEnumDefinition(')));
    });

    test('G-ENM-8: Handles file with only private enums. [2026-02-10 06:37] (PASS)', () async {
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
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
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

    test('G-ENM-9: Handles single-value enum. [2026-02-10 06:37] (PASS)', () async {
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
        helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
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
      // Edge case: temp dir source files don't generate package imports, so no prefix
      expect(code, contains('values: SingletonEnum.values'));
    });
  });
}
