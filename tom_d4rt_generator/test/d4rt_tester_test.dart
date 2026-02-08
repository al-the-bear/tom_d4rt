/// End-to-end tests using D4rtTester to generate bridges for example
/// projects and execute D4rt test scripts.
///
/// Each test group:
/// 1. Loads BridgeConfig from the example project's tom_build.yaml
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
