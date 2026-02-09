/// End-to-end tests using D4rtTester to generate bridges for example
/// projects and execute D4rt test scripts.
///
/// Each test group:
/// 1. Loads BridgeConfig from the example project's buildkit.yaml
/// 2. Uses D4rtTester to generate bridges and a test runner
/// 3. Executes a D4rt test script via the generated test runner
/// 4. Asserts on success (no exceptions, no timeout, exit 0)
///
/// These tests exercise the full pipeline: config loading → bridge
/// generation → test runner code generation → subprocess execution
/// → structured result parsing.
@TestOn('vm')
@Timeout(Duration(minutes: 2))
library d4rt_tester_test;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/src/testing/d4rt_test_result.dart';
import 'package:tom_d4rt_generator/src/testing/d4rt_tester.dart';

/// Root path of the tom_d4rt_generator package.
///
/// `dart test` sets the working directory to the package root, so
/// [Directory.current] is reliable here.
final String _generatorRoot = Directory.current.path;

/// Path to the example projects folder.
final String _exampleRoot = p.join(_generatorRoot, 'example');

void main() {
  group('D4rtTester end-to-end', () {
    // ── example_project ──────────────────────────────────────────────

    group('example_project', () {
      late D4rtTester tester;
      late BridgeConfig config;

      setUpAll(() {
        final projectPath = p.join(_exampleRoot, 'example_project');
        config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
        tester = D4rtTester(
          projectPath: projectPath,
          defaultTimeout: const Duration(seconds: 30),
        );
      });

      test('basic classes, constructors, enums', () async {
        final result = await tester.runScript(
          config,
          'test/d4rt_test_basics.dart',
        );
        _expectSuccess(result, 'example_project');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });

      test('GEN-041: enhanced enum fields', () async {
        final result = await tester.runScript(
          config,
          'test/d4rt_test_enum_fields.dart',
        );
        _expectSuccess(result, 'example_project/enum_fields');
        expect(result.processOutput, contains('ALL_ENUM_FIELD_TESTS_PASSED'));
      });
    });

    // ── user_guide ───────────────────────────────────────────────────

    group('user_guide', () {
      late D4rtTester tester;
      late BridgeConfig config;

      setUpAll(() {
        final projectPath = p.join(_exampleRoot, 'user_guide');
        config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
        tester = D4rtTester(
          projectPath: projectPath,
          defaultTimeout: const Duration(seconds: 30),
        );
      });

      test('Calculator and Greeter classes', () async {
        final result = await tester.runScript(
          config,
          'test/d4rt_test_guide.dart',
        );
        _expectSuccess(result, 'user_guide');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });
    });

    // ── user_reference ───────────────────────────────────────────────

    group('user_reference', () {
      late D4rtTester tester;
      late BridgeConfig config;

      setUpAll(() {
        final projectPath = p.join(_exampleRoot, 'user_reference');
        config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
        tester = D4rtTester(
          projectPath: projectPath,
          defaultTimeout: const Duration(seconds: 30),
        );
      });

      test('User, Product, Order models', () async {
        final result = await tester.runScript(
          config,
          'test/d4rt_test_models.dart',
        );
        _expectSuccess(result, 'user_reference');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });
    });

    // ── userbridge_override ──────────────────────────────────────────

    group('userbridge_override', () {
      late D4rtTester tester;
      late BridgeConfig config;

      setUpAll(() {
        final projectPath = p.join(_exampleRoot, 'userbridge_override');
        config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
        tester = D4rtTester(
          projectPath: projectPath,
          defaultTimeout: const Duration(seconds: 30),
        );
      });

      test('MyList, globals, top-level functions', () async {
        final result = await tester.runScript(
          config,
          'test/d4rt_test_overrides.dart',
        );
        _expectSuccess(result, 'userbridge_override');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });

      test('UBR02: user bridge method override', () async {
        final result = await tester.runScript(
          config,
          'test/ubr02_method_override.dart',
        );
        _expectSuccess(result, 'UBR02');
        expect(result.processOutput, contains('UBR02_PASSED'));
      });

      test('UBR03: user bridge field/variable override', () async {
        final result = await tester.runScript(
          config,
          'test/ubr03_field_override.dart',
        );
        _expectSuccess(result, 'UBR03');
        expect(result.processOutput, contains('UBR03_PASSED'));
      });
    });

    // ── dart_overview ────────────────────────────────────────────────

    group('dart_overview', () {
      late D4rtTester tester;
      late BridgeConfig config;

      setUpAll(() {
        final projectPath = p.join(_exampleRoot, 'dart_overview');
        config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
        tester = D4rtTester(
          projectPath: projectPath,
          defaultTimeout: const Duration(seconds: 30),
        );
      });

      test('declarations, enums, generic classes', () async {
        final result = await tester.runScript(
          config,
          'test/d4rt_test_overview.dart',
        );
        _expectSuccess(result, 'dart_overview');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });

      test('GEN-042: implicit default constructors', () async {
        final result = await tester.runScript(
          config,
          'test/d4rt_test_implicit_ctors.dart',
        );
        _expectSuccess(result, 'dart_overview/implicit_ctors');
        expect(
          result.processOutput,
          contains('ALL_IMPLICIT_CTOR_TESTS_PASSED'),
        );
      });

      test('GEN-041: enhanced enum fields (dart_overview)', () async {
        final result = await tester.runScript(
          config,
          'test/d4rt_test_enhanced_enums.dart',
        );
        _expectSuccess(result, 'dart_overview/enhanced_enums');
        expect(
          result.processOutput,
          contains('ALL_ENHANCED_ENUM_TESTS_PASSED'),
        );
      });
    });

    // ── userbridge_user_guide ────────────────────────────────────────

    group('userbridge_user_guide', () {
      late D4rtTester tester;
      late BridgeConfig config;

      setUpAll(() {
        final projectPath = p.join(_exampleRoot, 'userbridge_user_guide');
        config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
        tester = D4rtTester(
          projectPath: projectPath,
          defaultTimeout: const Duration(seconds: 30),
        );
      });

      test('Vector2D and Matrix2x2 via user bridges', () async {
        final result = await tester.runScript(
          config,
          'test/d4rt_test_user_bridges.dart',
        );
        _expectSuccess(result, 'userbridge_user_guide');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));

        // Verify user bridge print markers appear in output
        expect(
          result.processOutput,
          contains('[Vector2DUserBridge] operator+ called'),
          reason: 'Vector2D operator+ should use user bridge code',
        );
        expect(
          result.processOutput,
          contains('[Vector2DUserBridge] binary operator- called'),
          reason: 'Vector2D binary operator- should use user bridge code',
        );
        expect(
          result.processOutput,
          contains('[Vector2DUserBridge] unary operator- called'),
          reason: 'Vector2D unary operator- should use user bridge code',
        );
        expect(
          result.processOutput,
          contains('[Vector2DUserBridge] operator* called'),
          reason: 'Vector2D operator* should use user bridge code',
        );
        expect(
          result.processOutput,
          contains('[Vector2DUserBridge] dot() called'),
          reason: 'Vector2D dot() should use user bridge code',
        );
        expect(
          result.processOutput,
          contains('[Matrix2x2UserBridge] operator[] called'),
          reason: 'Matrix2x2 operator[] should use user bridge code',
        );
        expect(
          result.processOutput,
          contains('[Matrix2x2UserBridge] operator[]= called'),
          reason: 'Matrix2x2 operator[]= should use user bridge code',
        );
      });

      test('UBR01: user bridge class (basic)', () async {
        final result = await tester.runScript(
          config,
          'test/ubr01_basic_class.dart',
        );
        _expectSuccess(result, 'UBR01');
        expect(result.processOutput, contains('UBR01_PASSED'));
      });

      test('UBR04: user bridge operator overrides', () async {
        final result = await tester.runScript(
          config,
          'test/ubr04_operator.dart',
        );
        _expectSuccess(result, 'UBR04');
        expect(result.processOutput, contains('UBR04_PASSED'));

        // Verify user bridge print markers
        expect(
          result.processOutput,
          contains('[Vector2DUserBridge] operator+ called'),
          reason: 'UBR04: operator+ should use user bridge',
        );
        expect(
          result.processOutput,
          contains('[Matrix2x2UserBridge] operator[] called'),
          reason: 'UBR04: operator[] should use user bridge',
        );
      });

      test('UBR05: user bridge constructor', () async {
        final result = await tester.runScript(
          config,
          'test/ubr05_constructor.dart',
        );
        _expectSuccess(result, 'UBR05');
        expect(result.processOutput, contains('UBR05_PASSED'));
      });

      test('UBR06: user bridge import prefix (GEN-043)', () async {
        final result = await tester.runScript(
          config,
          'test/ubr06_import_prefix.dart',
        );
        _expectSuccess(result, 'UBR06');
        expect(result.processOutput, contains('UBR06_PASSED'));
      });
    });
  });
}

/// Assert that a [D4rtTestResult] represents a successful execution.
///
/// Provides detailed failure messages including the process output and
/// any captured exceptions, making it easy to diagnose failures.
void _expectSuccess(D4rtTestResult result, String projectName) {
  if (!result.success) {
    final buf = StringBuffer('$projectName test failed:\n');
    buf.writeln('  timedOut: ${result.timedOut}');
    buf.writeln('  exitCode: ${result.exitCode}');
    if (result.exceptions.isNotEmpty) {
      buf.writeln('  exceptions:');
      for (final e in result.exceptions) {
        buf.writeln('    - $e');
      }
    }
    if (result.processOutput.isNotEmpty) {
      buf.writeln('  processOutput:');
      buf.writeln('    ${result.processOutput.replaceAll('\n', '\n    ')}');
    }
    if (result.processError.isNotEmpty) {
      buf.writeln('  processError:');
      buf.writeln('    ${result.processError.replaceAll('\n', '\n    ')}');
    }
    fail(buf.toString());
  }
}
