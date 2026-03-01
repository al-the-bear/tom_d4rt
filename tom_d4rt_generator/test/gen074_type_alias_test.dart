// GEN-074: Test type alias (typedef) bridging
// These tests verify that type aliases pointing to classes are properly bridged

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String generatedCode;
  late BridgeGenerator generator;
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() async {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir = Directory.systemTemp
        .createTempSync('gen074_type_alias_test_')
        .path;

    // Create a generator for the test fixture
    generator = BridgeGenerator(
      workspacePath: testFixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: 'type_alias_source.dart',
      packageName: 'test_package',
      verbose: false,
    );

    final sourceFile = p.join(testFixturesDir, 'type_alias_source.dart');
    final outputFile = p.join(tempOutputDir, 'type_alias_bridges_test.dart');

    final result = await generator.generateBridges(
      sourceFiles: [sourceFile],
      outputPath: outputFile,
      moduleName: 'test_type_alias',
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

  group('GEN-074: Type alias bridging', () {
    test(
      'G-ISS-20: should include classAliases() method in generated code [2026-03-01] (FAIL)',
      () {
        // The generator should produce a classAliases() method that maps
        // alias names to their target class names
        expect(
          generatedCode.contains('classAliases()'),
          isTrue,
          reason:
              'Generated code should include classAliases() method for type alias registration',
        );
      },
    );

    test(
      'G-ISS-21: MaterialStateProperty should be aliased to WidgetStateProperty [2026-03-01] (FAIL)',
      () {
        // The classAliases() method should include MaterialStateProperty -> WidgetStateProperty
        expect(
          generatedCode.contains("'MaterialStateProperty'"),
          isTrue,
          reason: 'MaterialStateProperty should be registered as a type alias',
        );
      },
    );

    test(
      'G-ISS-22: ButtonStateProperty should be aliased to WidgetStateProperty [2026-03-01] (FAIL)',
      () {
        // The classAliases() method should include ButtonStateProperty -> WidgetStateProperty
        expect(
          generatedCode.contains("'ButtonStateProperty'"),
          isTrue,
          reason: 'ButtonStateProperty should be registered as a type alias',
        );
      },
    );

    test(
      'G-ISS-23: Box should be aliased to SimpleContainer [2026-03-01] (FAIL)',
      () {
        // Non-generic type aliases should also be bridged
        expect(
          generatedCode.contains("'Box'"),
          isTrue,
          reason:
              'Box should be registered as a type alias for SimpleContainer',
        );
      },
    );

    test(
      'G-ISS-24: Container should be aliased to SimpleContainer [2026-03-01] (FAIL)',
      () {
        // Non-generic type aliases should also be bridged
        expect(
          generatedCode.contains("'Container'"),
          isTrue,
          reason:
              'Container should be registered as a type alias for SimpleContainer',
        );
      },
    );

    test(
      'G-ISS-25: WidgetStateProperty base class should be bridged [2026-03-01] (OK)',
      () {
        // The base class should have a bridge
        expect(
          generatedCode.contains('_createWidgetStatePropertyBridge'),
          isTrue,
          reason:
              'WidgetStateProperty base class should have a bridge function',
        );
      },
    );

    test(
      'G-ISS-26: SimpleContainer base class should be bridged [2026-03-01] (OK)',
      () {
        // The base class should have a bridge
        expect(
          generatedCode.contains('_createSimpleContainerBridge'),
          isTrue,
          reason: 'SimpleContainer base class should have a bridge function',
        );
      },
    );

    test(
      'G-ISS-27: registerBridges should call registerClassAlias for aliases [2026-03-01] (FAIL)',
      () {
        // The registerBridges method should register class aliases
        expect(
          generatedCode.contains('interpreter.registerClassAlias'),
          isTrue,
          reason:
              'registerBridges should call registerClassAlias for type aliases',
        );
      },
    );
  });
}
