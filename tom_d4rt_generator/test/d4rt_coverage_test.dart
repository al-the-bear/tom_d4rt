/// Feature coverage tests for the D4rt bridge generator.
///
/// Uses [D4rtTester] with [prepareBridges] / [runScriptOnly] to generate
/// bridges once for the `dart_overview` example project, then runs
/// individual D4rt test scripts for each feature.
///
/// Test scripts are in `example/dart_overview/test/` and follow the naming
/// convention `<feature_id>_<short_description>.dart`.
///
/// See `doc/test_coverage.md` for the full feature inventory.
@TestOn('vm')
@Timeout(Duration(minutes: 5))
library d4rt_coverage_test;

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

void main() {
  // ── dart_overview: feature coverage ──────────────────────────────

  group('dart_overview coverage', () {
    late D4rtTester tester;
    late BridgeConfig config;

    setUpAll(() async {
      final projectPath = p.join(_exampleRoot, 'dart_overview');
      config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
      tester = D4rtTester(
        projectPath: projectPath,
        defaultTimeout: const Duration(seconds: 30),
      );

      // Generate bridges once for all tests in this group.
      final ok = await tester.prepareBridges(config);
      expect(ok, isTrue, reason: 'Bridge generation failed for dart_overview');
    });

    // ── Top-Level Exportables ──────────────────────────────────────

    group('TOP: Top-Level Exportables', () {
      test('TOP01: concrete class', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top01_concrete_class.dart',
        );
        _expectSuccess(result, 'TOP01');
        expect(result.processOutput, contains('TOP01_PASSED'));
      });

      test('TOP08: simple enum', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top08_simple_enum.dart',
        );
        _expectSuccess(result, 'TOP08');
        expect(result.processOutput, contains('TOP08_PASSED'));
      });

      test('TOP09: enhanced enum fields', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top09_enhanced_enum_fields.dart',
        );
        _expectSuccess(result, 'TOP09');
        expect(result.processOutput, contains('TOP09_PASSED'));
      });

      test('TOP10: enhanced enum methods', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top10_enhanced_enum_methods.dart',
        );
        _expectSuccess(result, 'TOP10');
        expect(result.processOutput, contains('TOP10_PASSED'));
      });

      test('TOP11: enhanced enum implements', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top11_enhanced_enum_implements.dart',
        );
        _expectSuccess(result, 'TOP11');
        expect(result.processOutput, contains('TOP11_PASSED'));
      });

      test('TOP12: enhanced enum with mixin', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top12_enhanced_enum_mixin.dart',
        );
        _expectSuccess(result, 'TOP12');
        expect(result.processOutput, contains('TOP12_PASSED'));
      });

      test('TOP22: top-level function (not in barrel)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top22_toplevel_function.dart',
        );
        _expectSuccess(result, 'TOP22');
        expect(result.processOutput, contains('TOP22_PASSED'));
      });
    });

    // ── Class Members ──────────────────────────────────────────────

    group('CLS: Class Members', () {
      test('CLS01: instance field getter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls01_field_getter.dart',
        );
        _expectSuccess(result, 'CLS01');
        expect(result.processOutput, contains('CLS01_PASSED'));
      });

      test('CLS02: instance field setter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls02_field_setter.dart',
        );
        _expectSuccess(result, 'CLS02');
        expect(result.processOutput, contains('CLS02_PASSED'));
      });

      test('CLS03: final field', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls03_final_field.dart',
        );
        _expectSuccess(result, 'CLS03');
        expect(result.processOutput, contains('CLS03_PASSED'));
      });

      test('CLS04: private field with public getter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls04_private_field_getter.dart',
        );
        _expectSuccess(result, 'CLS04');
        expect(result.processOutput, contains('CLS04_PASSED'));
      });

      test('CLS08: static const field (not in barrel)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls08_static_const.dart',
        );
        _expectSuccess(result, 'CLS08');
        expect(result.processOutput, contains('CLS08_PASSED'));
      });

      test('CLS09: computed getter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls09_computed_getter.dart',
        );
        _expectSuccess(result, 'CLS09');
        expect(result.processOutput, contains('CLS09_PASSED'));
      });

      test('CLS10: explicit setter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls10_explicit_setter.dart',
        );
        _expectSuccess(result, 'CLS10');
        expect(result.processOutput, contains('CLS10_PASSED'));
      });

      test('CLS14: instance method', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls14_instance_method.dart',
        );
        _expectSuccess(result, 'CLS14');
        expect(result.processOutput, contains('CLS14_PASSED'));
      });

      test('CLS16: toString override', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls16_tostring.dart',
        );
        _expectSuccess(result, 'CLS16');
        expect(result.processOutput, contains('CLS16_PASSED'));
      });
    });

    // ── Constructors ───────────────────────────────────────────────

    group('CTOR: Constructors', () {
      test('CTOR01: unnamed constructor', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/ctor01_unnamed.dart',
        );
        _expectSuccess(result, 'CTOR01');
        expect(result.processOutput, contains('CTOR01_PASSED'));
      });

      test('CTOR02: implicit default constructor (GEN-042)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/ctor02_implicit_default.dart',
        );
        _expectSuccess(result, 'CTOR02');
        expect(result.processOutput, contains('CTOR02_PASSED'));
      });

      test('CTOR03: named constructor', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/ctor03_named.dart',
        );
        _expectSuccess(result, 'CTOR03');
        expect(result.processOutput, contains('CTOR03_PASSED'));
      });

      test('CTOR04: factory-like constructor (fromMap)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/ctor04_factory.dart',
        );
        _expectSuccess(result, 'CTOR04');
        expect(result.processOutput, contains('CTOR04_PASSED'));
      });
    });

    // ── Parameters ─────────────────────────────────────────────────

    group('PAR: Parameters', () {
      test('PAR01: required positional', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/par01_required_positional.dart',
        );
        _expectSuccess(result, 'PAR01');
        expect(result.processOutput, contains('PAR01_PASSED'));
      });

      test('PAR03: named parameters (not in barrel)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/par03_named_params.dart',
        );
        _expectSuccess(result, 'PAR03');
        expect(result.processOutput, contains('PAR03_PASSED'));
      });
    });

    // ── Generics ───────────────────────────────────────────────────

    group('GNRC: Generics', () {
      test('GNRC01: single type parameter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/gnrc01_single_type_param.dart',
        );
        _expectSuccess(result, 'GNRC01');
        expect(result.processOutput, contains('GNRC01_PASSED'));
      });

      test('GNRC02: two type parameters', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/gnrc02_two_type_params.dart',
        );
        _expectSuccess(result, 'GNRC02');
        expect(result.processOutput, contains('GNRC02_PASSED'));
      });

      test('GNRC04: generic method', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/gnrc04_generic_method.dart',
        );
        _expectSuccess(result, 'GNRC04');
        expect(result.processOutput, contains('GNRC04_PASSED'));
      });

      test('GNRC06: generic collection (Stack/Queue, GEN-042)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/gnrc06_generic_collection.dart',
        );
        _expectSuccess(result, 'GNRC06');
        expect(result.processOutput, contains('GNRC06_PASSED'));
      });
    });
  });
}

/// Assert that a [D4rtTestResult] represents a successful execution.
///
/// Provides detailed failure messages including the process output and
/// any captured exceptions, making it easy to diagnose failures.
void _expectSuccess(D4rtTestResult result, String featureId) {
  if (!result.success) {
    final buf = StringBuffer('$featureId test failed:\n');
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
