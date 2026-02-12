/// End-to-end tests using D4rtTester to generate bridges for the unified
/// d4 example project and execute D4rt test scripts.
///
/// All tests share a single D4rtTester instance pointing at the d4 project
/// which contains all bridged classes. Test scripts are in d4_test_scripts/bin/
/// organized by original source project (example_project, user_guide, etc.).
///
/// Test flow:
/// 1. In setUpAll: Load BridgeConfig from d4/buildkit.yaml, generate bridges once
/// 2. Each test: Execute a script from d4_test_scripts/bin/{category}/xxx.dart
/// 3. Assert on success (no exceptions, no timeout, exit 0)
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
final String _generatorRoot = Directory.current.path;

/// Path to the example projects folder.
final String _exampleRoot = p.join(_generatorRoot, 'example');

/// Path to the d4 project (bridge host).
final String _d4Project = p.join(_exampleRoot, 'd4');

void main() {
  late D4rtTester tester;
  late BridgeConfig config;

  setUpAll(() async {
    // Load config from d4 project
    config = BuildConfigLoader.loadFromTomBuildYaml(_d4Project)!;
    tester = D4rtTester(
      projectPath: _d4Project,
      defaultTimeout: const Duration(seconds: 30),
    );

    // Generate bridges once for all tests
    final ok = await tester.prepareBridges(config);
    expect(ok, isTrue, reason: 'Bridge generation failed for d4');
  });

  group('D4rtTester end-to-end', () {
    // ── example_project ──────────────────────────────────────────────

    group('example_project', () {
      test('G-TST-13: Basic classes, constructors, enums. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/example_project/d4rt_test_basics.dart',
        );
        _expectSuccess(result, 'example_project');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });

      test('G-TST-14: Enhanced enum fields. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/example_project/d4rt_test_enum_fields.dart',
        );
        _expectSuccess(result, 'example_project/enum_fields');
        expect(result.processOutput, contains('ALL_ENUM_FIELD_TESTS_PASSED'));
      });
    });

    // ── user_guide ───────────────────────────────────────────────────

    group('user_guide', () {
      test('G-TST-15: Calculator and Greeter classes. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/user_guide/d4rt_test_guide.dart',
        );
        _expectSuccess(result, 'user_guide');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });
    });

    // ── user_reference ───────────────────────────────────────────────

    group('user_reference', () {
      test('G-TST-1: User, Product, Order models. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/user_reference/d4rt_test_models.dart',
        );
        _expectSuccess(result, 'user_reference');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });
    });

    // ── userbridge_override ──────────────────────────────────────────

    group('userbridge_override', () {
      test('G-TST-2: MyList, globals, top-level functions. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/userbridge_override/d4rt_test_overrides.dart',
        );
        _expectSuccess(result, 'userbridge_override');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });

      test('G-TST-3: UBR02: user bridge method override. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/userbridge_override/ubr02_method_override.dart',
        );
        _expectSuccess(result, 'UBR02');
        expect(result.processOutput, contains('UBR02_PASSED'));
      });

      test('G-TST-4: UBR03: user bridge field/variable override. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/userbridge_override/ubr03_field_override.dart',
        );
        _expectSuccess(result, 'UBR03');
        expect(result.processOutput, contains('UBR03_PASSED'));
      });
    });

    // ── dart_overview ────────────────────────────────────────────────

    group('dart_overview', () {
      test('G-TST-5: Declarations, enums, generic classes. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/d4rt_test_overview.dart',
        );
        _expectSuccess(result, 'dart_overview');
        expect(result.processOutput, contains('ALL_TESTS_PASSED'));
      });

      test('G-TST-6: Implicit default constructors. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/d4rt_test_implicit_ctors.dart',
        );
        _expectSuccess(result, 'dart_overview/implicit_ctors');
        expect(
          result.processOutput,
          contains('ALL_IMPLICIT_CTOR_TESTS_PASSED'),
        );
      });

      test('G-TST-7: Enhanced enum fields (dart_overview). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/d4rt_test_enhanced_enums.dart',
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
      test('G-TST-8: Vector2D and Matrix2x2 via user bridges. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/userbridge_user_guide/d4rt_test_user_bridges.dart',
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

      test('G-TST-9: UBR01: user bridge class (basic). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/userbridge_user_guide/ubr01_basic_class.dart',
        );
        _expectSuccess(result, 'UBR01');
        expect(result.processOutput, contains('UBR01_PASSED'));
      });

      test('G-TST-10: UBR04: user bridge operator overrides. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/userbridge_user_guide/ubr04_operator.dart',
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

      test('G-TST-11: UBR05: user bridge constructor. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/userbridge_user_guide/ubr05_constructor.dart',
        );
        _expectSuccess(result, 'UBR05');
        expect(result.processOutput, contains('UBR05_PASSED'));
      });

      test('G-TST-12: UBR06: user bridge import prefix (GEN-043). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/userbridge_user_guide/ubr06_import_prefix.dart',
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
