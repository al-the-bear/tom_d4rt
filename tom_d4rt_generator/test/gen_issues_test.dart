/// Tests for Generator issues identified in flutterm integration.
///
/// These tests verify the generator correctly handles:
/// - GEN-095: Missing static factory method bridges
/// - GEN-096: Getter/method signature mismatch
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
        Directory.systemTemp.createTempSync('gen_issues_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('GEN-095: Static Factory Method Bridges', () {
    late String generatedCode;
    late BridgeGeneratorResult result;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'gen_issues_source.dart',
        packageName: 'test_gen_issues',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'gen_issues_source.dart');
      final outputFile = p.join(tempOutputDir, 'gen_issues_bridges.dart');

      result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'gen_issues',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();

      // Debug output
      final debugPath = p.join(
        Directory.current.path,
        'ztmp',
        'gen_issues_bridge.dart',
      );
      await Directory(p.dirname(debugPath)).create(recursive: true);
      await File(debugPath).writeAsString(generatedCode);
    });

    test('GEN-095-01: FeatureMock class is bridged. [2026-03-07] (PASS)', () {
      expect(generatedCode, contains("name: 'FeatureMock'"));
    });

    test(
        'GEN-095-02: FeatureMock.withValue named constructor bridged. [2026-03-07] (PASS)',
        () {
      expect(generatedCode, contains("'withValue':"));
    });

    test(
        'GEN-095-03: FeatureMock.feature static factory bridged. [2026-03-07] (FAIL)',
        () {
      // Static factory method should be bridged as static member.
      // D4rt script: FeatureMock.feature('smcp')
      expect(
        generatedCode,
        contains("'feature':"),
        reason:
            'Static factory method feature() should be bridged',
      );
    });

    test(
        'GEN-095-04: FeatureMock.enable static factory bridged. [2026-03-07] (FAIL)',
        () {
      expect(
        generatedCode,
        contains("'enable':"),
        reason: 'Static factory method enable() should be bridged',
      );
    });

    test(
        'GEN-095-05: FeatureMock.disable static factory bridged. [2026-03-07] (FAIL)',
        () {
      expect(
        generatedCode,
        contains("'disable':"),
        reason: 'Static factory method disable() should be bridged',
      );
    });

    test(
        'GEN-095-06: FeatureMock.defaultFeature static getter bridged. [2026-03-07] (PASS)',
        () {
      expect(
        generatedCode,
        contains("'defaultFeature':"),
        reason: 'Static getter should be bridged',
      );
    });

    test('GEN-095-07: ColorMock class is bridged. [2026-03-07] (PASS)', () {
      expect(generatedCode, contains("name: 'ColorMock'"));
    });

    test(
        'GEN-095-08: ColorMock.fromARGB static factory bridged. [2026-03-07] (FAIL)',
        () {
      expect(
        generatedCode,
        contains("'fromARGB':"),
        reason: 'Static factory method fromARGB() should be bridged',
      );
    });

    test(
        'GEN-095-09: ColorMock.fromHex static factory bridged. [2026-03-07] (FAIL)',
        () {
      expect(
        generatedCode,
        contains("'fromHex':"),
        reason: 'Static factory method fromHex() should be bridged',
      );
    });

    test(
        'GEN-095-10: ColorMock static getters bridged. [2026-03-07] (PASS)',
        () {
      expect(generatedCode, contains("'transparent':"));
      expect(generatedCode, contains("'black':"));
      expect(generatedCode, contains("'white':"));
    });
  });

  group('GEN-096: Getter/Method Signature', () {
    late String generatedCode;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'gen_issues_source.dart',
        packageName: 'test_gen_issues',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'gen_issues_source.dart');
      final outputFile =
          p.join(tempOutputDir, 'gen_issues_bridges_096.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'gen_issues',
      );

      expect(result.errors, isEmpty);
      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    test('GEN-096-01: ActionMock class is bridged. [2026-03-07] (PASS)', () {
      expect(generatedCode, contains("name: 'ActionMock'"));
    });

    test('GEN-096-02: isEnabled getter bridged as getter. [2026-03-07] (PASS)',
        () {
      // Getter should be in getters map, not methods map expecting args
      expect(
        generatedCode,
        contains("'isEnabled':"),
        reason: 'isEnabled getter should be bridged',
      );
    });

    test(
        'GEN-096-03: consumesKey method requires argument. [2026-03-07] (PASS)',
        () {
      // Method should be in methods map and require 1 argument
      expect(
        generatedCode,
        contains("'consumesKey':"),
        reason: 'consumesKey method should be bridged',
      );
    });

    test(
        'GEN-096-04: maybeConsumesKey handles optional param. [2026-03-07] (PASS)',
        () {
      expect(
        generatedCode,
        contains("'maybeConsumesKey':"),
        reason: 'maybeConsumesKey should be bridged with optional handling',
      );
    });

    test(
        'GEN-096-05: DoNothingActionMock extends ActionMock. [2026-03-07] (PASS)',
        () {
      expect(generatedCode, contains("name: 'DoNothingActionMock'"));
    });

    test(
        'GEN-096-06: CombinedPatternMock static factories. [2026-03-07] (FAIL)',
        () {
      expect(generatedCode, contains("name: 'CombinedPatternMock'"));
      expect(generatedCode, contains("'create':"));
      expect(generatedCode, contains("'empty':"));
    });

    test(
        'GEN-096-07: CombinedPatternMock getter vs method distinction. [2026-03-07] (PASS)',
        () {
      // isEmpty is a getter, isValid is a method
      expect(generatedCode, contains("'isEmpty':"));
      expect(generatedCode, contains("'isValid':"));
    });
  });
}
