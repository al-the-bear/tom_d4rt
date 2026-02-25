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

import 'exec_test_setup.dart';

/// Root path of the tom_d4rt_exec package (test host).
final String _packageRoot = Directory.current.path;

/// Path to the example projects folder.
final String _exampleRoot = p.join(_packageRoot, 'example');

void main() {
  // ── dart_overview: feature coverage ──────────────────────────────

  group('dart_overview coverage', () {
    late D4rtTester tester;
    late BridgeConfig config;

    setUpAll(() async {
      final projectPath = p.join(_exampleRoot, 'd4');
      config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
      tester = D4rtTester(
        projectPath: projectPath,
        defaultTimeout: const Duration(seconds: 30),
      );

      // Generate bridges, post-process imports, and compile.
      // Uses ExecTestSetup to replace hardcoded package:tom_d4rt/ imports
      // with package:tom_d4rt_exec/ before compilation.
      final ok = await ExecTestSetup.prepareBridges(tester, config);
      expect(ok, isTrue, reason: 'Bridge generation/compilation failed for dart_overview');
    });

    // ── Top-Level Exportables ──────────────────────────────────────

    group('TOP: Top-Level Exportables', () {
      test('G-COV-42: TOP01: concrete class. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top01_concrete_class.dart',
        );
        _expectSuccess(result, 'TOP01');
        expect(result.processOutput, contains('TOP01_PASSED'));
      });

      test('G-COV-51: TOP02: abstract class. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top02_abstract_class.dart',
        );
        _expectSuccess(result, 'TOP02');
        expect(result.processOutput, contains('TOP02_PASSED'));
      });

      test('G-COV-60: TOP03: sealed class. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top03_sealed_class.dart',
        );
        _expectSuccess(result, 'TOP03');
        expect(result.processOutput, contains('TOP03_PASSED'));
      });

      test('G-COV-68: TOP04: base class. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top04_base_class.dart',
        );
        _expectSuccess(result, 'TOP04');
        expect(result.processOutput, contains('TOP04_PASSED'));
      });

      test('G-COV-69: TOP05: interface class. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top05_interface_class.dart',
        );
        _expectSuccess(result, 'TOP05');
        expect(result.processOutput, contains('TOP05_PASSED'));
      });

      test('G-COV-74: TOP06: final class. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top06_final_class.dart',
        );
        _expectSuccess(result, 'TOP06');
        expect(result.processOutput, contains('TOP06_PASSED'));
      });

      test('G-COV-1: TOP07: mixin class. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top07_mixin_class.dart',
        );
        _expectSuccess(result, 'TOP07');
        expect(result.processOutput, contains('TOP07_PASSED'));
      });

      test('G-COV-2: TOP08: simple enum (GEN-044: .values not bridged). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top08_simple_enum.dart',
        );
        _expectSuccess(result, 'TOP08');
        expect(result.processOutput, contains('TOP08_PASSED'));
      });

      test('G-COV-3: TOP09: enhanced enum fields. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top09_enhanced_enum_fields.dart',
        );
        _expectSuccess(result, 'TOP09');
        expect(result.processOutput, contains('TOP09_PASSED'));
      });

      test('G-COV-4: TOP10: enhanced enum methods. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top10_enhanced_enum_methods.dart',
        );
        _expectSuccess(result, 'TOP10');
        expect(result.processOutput, contains('TOP10_PASSED'));
      });

      test('G-COV-5: TOP11: enhanced enum implements. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top11_enhanced_enum_implements.dart',
        );
        _expectSuccess(result, 'TOP11');
        expect(result.processOutput, contains('TOP11_PASSED'));
      });

      test('G-TOP-12: Enhanced enum with mixin. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top12_enhanced_enum_mixin.dart',
        );
        _expectSuccess(result, 'TOP12');
        expect(result.processOutput, contains('TOP12_PASSED'));
      });

      test('G-COV-6: TOP14: mixin. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top14_mixin.dart',
        );
        _expectSuccess(result, 'TOP14');
        expect(result.processOutput, contains('TOP14_PASSED'));
      });

      test('G-TOP-13: Generic enum N/A Dart limit. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top13_generic_enum.dart',
        );
        _expectSuccess(result, 'TOP13');
        expect(result.processOutput, contains('TOP13_PASSED'));
      });

      test('G-COV-7: TOP15: base mixin. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top15_base_mixin.dart',
        );
        _expectSuccess(result, 'TOP15');
        expect(result.processOutput, contains('TOP15_PASSED'));
      });

      test('G-COV-8: TOP16: named extension (not supported). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top16_named_extension.dart',
        );
        _expectSuccess(result, 'TOP16');
        expect(result.processOutput, contains('TOP16_PASSED'));
      });

      test('G-COV-9: TOP17: anonymous extension (not supported). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top17_anonymous_extension.dart',
        );
        _expectSuccess(result, 'TOP17');
        expect(result.processOutput, contains('TOP17_PASSED'));
      });

      test('G-COV-10: TOP18: extension type (not supported). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top18_extension_type.dart',
        );
        _expectSuccess(result, 'TOP18');
        expect(result.processOutput, contains('TOP18_PASSED'));
      });

      test('G-TOP-19: Typedef function not needed. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top19_typedef_function.dart',
        );
        _expectSuccess(result, 'TOP19');
        expect(result.processOutput, contains('TOP19_PASSED'));
      });

      test('G-COV-11: TOP20: typedef (type alias, not needed). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top20_typedef_type_alias.dart',
        );
        _expectSuccess(result, 'TOP20');
        expect(result.processOutput, contains('TOP20_PASSED'));
      });

      test('G-COV-12: TOP21: typedef (generic, not needed). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top21_typedef_generic.dart',
        );
        _expectSuccess(result, 'TOP21');
        expect(result.processOutput, contains('TOP21_PASSED'));
      });

      test('G-COV-13: TOP22: top-level function. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top22_toplevel_function.dart',
        );
        _expectSuccess(result, 'TOP22');
        expect(result.processOutput, contains('TOP22_PASSED'));
      });

      test('G-COV-14: TOP25: top-level variable. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top25_toplevel_variable.dart',
        );
        _expectSuccess(result, 'TOP25');
        expect(result.processOutput, contains('TOP25_PASSED'));
      });

      test('G-COV-15: TOP26: top-level const. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top26_toplevel_const.dart',
        );
        _expectSuccess(result, 'TOP26');
        expect(result.processOutput, contains('TOP26_PASSED'));
      });

      test('G-COV-16: TOP27: top-level getter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top27_toplevel_getter.dart',
        );
        _expectSuccess(result, 'TOP27');
        expect(result.processOutput, contains('TOP27_PASSED'));
      });

      test('G-COV-17: TOP23: top-level generic function. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top23_toplevel_generic_function.dart',
        );
        _expectSuccess(result, 'TOP23');
        expect(result.processOutput, contains('TOP23_PASSED'));
      });

      test('G-TOP-24: Top-level async function. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top24_async_function.dart',
        );
        _expectSuccess(result, 'TOP24');
        expect(result.processOutput, contains('TOP24_PASSED'));
      });

      test('G-TOP-28: Top-level setter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top28_toplevel_setter.dart',
        );
        _expectSuccess(result, 'TOP28');
        expect(result.processOutput, contains('TOP28_PASSED'));
      });

      test('G-COV-18: TOP29: mixin application (class = with). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/top29_mixin_application.dart',
        );
        _expectSuccess(result, 'TOP29');
        expect(result.processOutput, contains('TOP29_PASSED'));
      });
    });

    // ── Class Members ──────────────────────────────────────────────

    group('CLS: Class Members', () {
      test('G-COV-19: CLS01: instance field getter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls01_field_getter.dart',
        );
        _expectSuccess(result, 'CLS01');
        expect(result.processOutput, contains('CLS01_PASSED'));
      });

      test('G-COV-20: CLS02: instance field setter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls02_field_setter.dart',
        );
        _expectSuccess(result, 'CLS02');
        expect(result.processOutput, contains('CLS02_PASSED'));
      });

      test('G-COV-21: CLS03: final field. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls03_final_field.dart',
        );
        _expectSuccess(result, 'CLS03');
        expect(result.processOutput, contains('CLS03_PASSED'));
      });

      test('G-COV-22: CLS04: private field with public getter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls04_private_field_getter.dart',
        );
        _expectSuccess(result, 'CLS04');
        expect(result.processOutput, contains('CLS04_PASSED'));
      });

      test('G-COV-23: CLS07: static field (mutable). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls07_static_field.dart',
        );
        _expectSuccess(result, 'CLS07');
        expect(result.processOutput, contains('CLS07_PASSED'));
      });

      test('G-COV-24: CLS08: static const field (not in barrel). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls08_static_const.dart',
        );
        _expectSuccess(result, 'CLS08');
        expect(result.processOutput, contains('CLS08_PASSED'));
      });

      test('G-COV-25: CLS09: computed getter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls09_computed_getter.dart',
        );
        _expectSuccess(result, 'CLS09');
        expect(result.processOutput, contains('CLS09_PASSED'));
      });

      test('G-COV-26: CLS10: explicit setter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls10_explicit_setter.dart',
        );
        _expectSuccess(result, 'CLS10');
        expect(result.processOutput, contains('CLS10_PASSED'));
      });

      test('G-COV-27: CLS11: static method. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls11_static_method.dart',
        );
        _expectSuccess(result, 'CLS11');
        expect(result.processOutput, contains('CLS11_PASSED'));
      });

      test('G-COV-28: CLS14: instance method. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls14_instance_method.dart',
        );
        _expectSuccess(result, 'CLS14');
        expect(result.processOutput, contains('CLS14_PASSED'));
      });

      test('G-COV-29: CLS15: abstract method. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls15_abstract_method.dart',
        );
        _expectSuccess(result, 'CLS15');
        expect(result.processOutput, contains('CLS15_PASSED'));
      });

      test('G-COV-30: CLS16: toString override. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls16_tostring.dart',
        );
        _expectSuccess(result, 'CLS16');
        expect(result.processOutput, contains('CLS16_PASSED'));
      });

      test('G-COV-31: CLS05: nullable instance field. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls05_nullable_field.dart',
        );
        _expectSuccess(result, 'CLS05');
        expect(result.processOutput, contains('CLS05_PASSED'));
      });

      test('G-CLS-6b: Late field. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls06_late_field.dart',
        );
        _expectSuccess(result, 'CLS06');
        expect(result.processOutput, contains('CLS06_PASSED'));
      });

      test('G-COV-32: CLS12: static getter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls12_static_getter.dart',
        );
        _expectSuccess(result, 'CLS12');
        expect(result.processOutput, contains('CLS12_PASSED'));
      });

      test('G-COV-33: CLS13: static setter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls13_static_setter.dart',
        );
        _expectSuccess(result, 'CLS13');
        expect(result.processOutput, contains('CLS13_PASSED'));
      });

      test('G-COV-34: CLS17: call() method (callable class). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/cls17_call_method.dart',
        );
        _expectSuccess(result, 'CLS17');
        expect(result.processOutput, contains('CLS17_PASSED'));
      });
    });

    // ── Constructors ───────────────────────────────────────────────

    group('CTOR: Constructors', () {
      test('G-COV-35: CTOR01: unnamed constructor. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/ctor01_unnamed.dart',
        );
        _expectSuccess(result, 'CTOR01');
        expect(result.processOutput, contains('CTOR01_PASSED'));
      });

      test('G-COV-36: CTOR02: implicit default constructor (GEN-042). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/ctor02_implicit_default.dart',
        );
        _expectSuccess(result, 'CTOR02');
        expect(result.processOutput, contains('CTOR02_PASSED'));
      });

      test('G-COV-37: CTOR03: named constructor. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/ctor03_named.dart',
        );
        _expectSuccess(result, 'CTOR03');
        expect(result.processOutput, contains('CTOR03_PASSED'));
      });

      test('G-COV-38: CTOR04: factory-like constructor (fromMap). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/ctor04_factory.dart',
        );
        _expectSuccess(result, 'CTOR04');
        expect(result.processOutput, contains('CTOR04_PASSED'));
      });

      test('G-COV-39: CTOR05: const constructor. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/ctor05_const.dart',
        );
        _expectSuccess(result, 'CTOR05');
        expect(result.processOutput, contains('CTOR05_PASSED'));
      });

      test('G-COV-40: CTOR06: redirecting constructor. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/ctor06_redirecting.dart',
        );
        _expectSuccess(result, 'CTOR06');
        expect(result.processOutput, contains('CTOR06_PASSED'));
      });

      test('G-COV-41: CTOR07: private constructor + factory. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/ctor07_private.dart',
        );
        _expectSuccess(result, 'CTOR07');
        expect(result.processOutput, contains('CTOR07_PASSED'));
      });

      test('G-COV-43: CTOR08: super parameters. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/ctor08_super_params.dart',
        );
        _expectSuccess(result, 'CTOR08');
        expect(result.processOutput, contains('CTOR08_PASSED'));
      });
    });

    // ── Parameters ─────────────────────────────────────────────────

    group('PAR: Parameters', () {
      test('G-COV-44: PAR01: required positional. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/par01_required_positional.dart',
        );
        _expectSuccess(result, 'PAR01');
        expect(result.processOutput, contains('PAR01_PASSED'));
      });

      test('G-COV-45: PAR02: optional positional. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/par02_optional_positional.dart',
        );
        _expectSuccess(result, 'PAR02');
        expect(result.processOutput, contains('PAR02_PASSED'));
      });

      test('G-COV-46: PAR03: named parameters (not in barrel). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/par03_named_params.dart',
        );
        _expectSuccess(result, 'PAR03');
        expect(result.processOutput, contains('PAR03_PASSED'));
      });

      test('G-COV-47: PAR04: required named. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/par04_required_named.dart',
        );
        _expectSuccess(result, 'PAR04');
        expect(result.processOutput, contains('PAR04_PASSED'));
      });

      test('G-COV-48: PAR05: default values. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/par05_default_values.dart',
        );
        _expectSuccess(result, 'PAR05');
        expect(result.processOutput, contains('PAR05_PASSED'));
      });

      test('G-PAR-6: Function-typed parameter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/par06_function_typed_param.dart',
        );
        _expectSuccess(result, 'PAR06');
        expect(result.processOutput, contains('PAR06_PASSED'));
      });
    });

    // ── Generics ───────────────────────────────────────────────────

    group('GNRC: Generics', () {
      test('G-COV-49: GNRC01: single type parameter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/gnrc01_single_type_param.dart',
        );
        _expectSuccess(result, 'GNRC01');
        expect(result.processOutput, contains('GNRC01_PASSED'));
      });

      test('G-COV-50: GNRC02: two type parameters. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/gnrc02_two_type_params.dart',
        );
        _expectSuccess(result, 'GNRC02');
        expect(result.processOutput, contains('GNRC02_PASSED'));
      });

      test('G-COV-52: GNRC04: generic method. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/gnrc04_generic_method.dart',
        );
        _expectSuccess(result, 'GNRC04');
        expect(result.processOutput, contains('GNRC04_PASSED'));
      });

      test('G-COV-53: GNRC06: generic collection (Stack/Queue, GEN-042). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/gnrc06_generic_collection.dart',
        );
        _expectSuccess(result, 'GNRC06');
        expect(result.processOutput, contains('GNRC06_PASSED'));
      });

      test('G-COV-54: GNRC03: upper bound constraint. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/gnrc03_upper_bound.dart',
        );
        _expectSuccess(result, 'GNRC03');
        expect(result.processOutput, contains('GNRC03_PASSED'));
      });

      test('G-COV-55: GNRC05: generic static factory. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/gnrc05_generic_static_factory.dart',
        );
        _expectSuccess(result, 'GNRC05');
        expect(result.processOutput, contains('GNRC05_PASSED'));
      });

      test('G-GNRC-7: F-bounded polymorphism. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/gnrc07_fbounded_polymorphism.dart',
        );
        _expectSuccess(result, 'GNRC07');
        expect(result.processOutput, contains('GNRC07_PASSED'));
      });
    });

    // ── Inheritance ────────────────────────────────────────────────

    group('INH: Inheritance', () {
      test('G-COV-56: INH01: single-level extends. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/inh01_single_extends.dart',
        );
        _expectSuccess(result, 'INH01');
        expect(result.processOutput, contains('INH01_PASSED'));
      });

      test('G-COV-57: INH02: multi-level extends. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/inh02_multi_extends.dart',
        );
        _expectSuccess(result, 'INH02');
        expect(result.processOutput, contains('INH02_PASSED'));
      });

      test('G-COV-58: INH03: implements (interface). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/inh03_implements.dart',
        );
        _expectSuccess(result, 'INH03');
        expect(result.processOutput, contains('INH03_PASSED'));
      });

      test('G-COV-59: INH04: mixin with. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/inh04_mixin_with.dart',
        );
        _expectSuccess(result, 'INH04');
        expect(result.processOutput, contains('INH04_PASSED'));
      });

      test('G-COV-61: INH05: super constructor call. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/inh05_super_ctor.dart',
        );
        _expectSuccess(result, 'INH05');
        expect(result.processOutput, contains('INH05_PASSED'));
      });

      test('G-COV-62: INH06: method override. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/inh06_method_override.dart',
        );
        _expectSuccess(result, 'INH06');
        expect(result.processOutput, contains('INH06_PASSED'));
      });

      test(
        'GEN-045: barrel name collision (constrained mixin blocked). [2026-02-10] (FAIL)',
        () async {
          // GEN-045: Bird/Eagle/Penguin excluded from barrel due to
          // Animal name collision between mixins/basics and classes/inheritance.
          // The generator needs name-collision detection or import aliasing support.
          // This test confirms the issue still exists.
          final result = await tester.runScriptOnly(
            config,
            '../d4_test_scripts/bin/dart_overview/gen045_barrel_name_collision.dart',
          );
          // The test script currently outputs BLOCKED because the types aren't in barrel.
          // When import aliasing is implemented and types are bridged, it should output PASSED.
          expect(
            result.processOutput.contains('GEN045_BLOCKED'),
            isTrue,
            reason: 'GEN-045: Expected BLOCKED message due to barrel name collision. '
                'If this test starts failing (no BLOCKED message), '
                'implement the actual test with Bird/Eagle/Penguin.',
          );
        },
      );
    });

    // ── Operators ──────────────────────────────────────────────────

    group('OP: Operators', () {
      test('G-COV-63: OP05: operator / (divide). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/op05_operator_divide.dart',
        );
        _expectSuccess(result, 'OP05');
        expect(result.processOutput, contains('OP05_PASSED'));
      });

      test('G-COV-64: OP06: operator ~/ (integer divide). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/op06_operator_integer_divide.dart',
        );
        _expectSuccess(result, 'OP06');
        expect(result.processOutput, contains('OP06_PASSED'));
      });

      test('G-COV-65: OP07: operator % (modulo). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/op07_operator_modulo.dart',
        );
        _expectSuccess(result, 'OP07');
        expect(result.processOutput, contains('OP07_PASSED'));
      });

      test('G-OP-8: Operator == equality. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/op08_operator_equals.dart',
        );
        _expectSuccess(result, 'OP08');
        expect(result.processOutput, contains('OP08_PASSED'));
      });

      test('G-COV-66: OP09: comparison operators (compareTo). [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/op09_comparison_operators.dart',
        );
        _expectSuccess(result, 'OP09');
        expect(result.processOutput, contains('OP09_PASSED'));
      });

      test('G-COV-67: OP12: bitwise operators. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/op12_bitwise_operators.dart',
        );
        _expectSuccess(result, 'OP12');
        expect(result.processOutput, contains('OP12_PASSED'));
      });
    });

    // ── Async ──────────────────────────────────────────────────────

    group('ASYNC: Async Features', () {
      test('G-ASYNC-1: Async function Future. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/async01_async_function.dart',
        );
        _expectSuccess(result, 'ASYNC01');
        expect(result.processOutput, contains('ASYNC01_PASSED'));
      });

      test('G-ASYNC-2: Async* generator Stream. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/async02_async_generator.dart',
        );
        _expectSuccess(result, 'ASYNC02');
        expect(result.processOutput, contains('ASYNC02_PASSED'));
      });

      test('G-ASYNC-3: Sync* generator Iterable. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/async03_sync_generator.dart',
        );
        _expectSuccess(result, 'ASYNC03');
        expect(result.processOutput, contains('ASYNC03_PASSED'));
      });

      test('G-ASYNC-4: Callback parameter Function. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/async04_callback_param.dart',
        );
        _expectSuccess(result, 'ASYNC04');
        expect(result.processOutput, contains('ASYNC04_PASSED'));
      });

      test('G-ASYNC-5: Instance async method Future. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/async05_instance_async_method.dart',
        );
        _expectSuccess(result, 'ASYNC05');
        expect(result.processOutput, contains('ASYNC05_PASSED'));
      });

      test('G-ASYNC-6: Instance sync* method Iterable. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/async06_instance_sync_generator.dart',
        );
        _expectSuccess(result, 'ASYNC06');
        expect(result.processOutput, contains('ASYNC06_PASSED'));
      });

      test('G-ASYNC-7: Instance async* method Stream. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/async07_instance_async_generator.dart',
        );
        _expectSuccess(result, 'ASYNC07');
        expect(result.processOutput, contains('ASYNC07_PASSED'));
      });

      test('G-ASYNC-8: Static sync*/async* method. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/async08_static_generators.dart',
        );
        _expectSuccess(result, 'ASYNC08');
        expect(result.processOutput, contains('ASYNC08_PASSED'));
      });
    });

    // ── Types ──────────────────────────────────────────────────────

    group('TYPE: Type Features', () {
      test('G-TYPE-1: Record parameter. [2026-02-10 06:37] (FAIL)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/type01_record_param.dart',
        );
        _expectSuccess(result, 'TYPE01');
        expect(result.processOutput, contains('TYPE01_PASSED'));
      });

      test('G-TYPE-2: Record return type. [2026-02-10 06:37] (FAIL)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/type02_record_return.dart',
        );
        _expectSuccess(result, 'TYPE02');
        expect(result.processOutput, contains('TYPE02_PASSED'));
      });

      test('G-COV-70: TYPE03: nullable parameter. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/type03_nullable_param.dart',
        );
        _expectSuccess(result, 'TYPE03');
        expect(result.processOutput, contains('TYPE03_PASSED'));
      });

      test('G-COV-71: TYPE04: nullable return type. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/type04_nullable_return.dart',
        );
        _expectSuccess(result, 'TYPE04');
        expect(result.processOutput, contains('TYPE04_PASSED'));
      });

      test('G-COV-72: TYPE05: dynamic type. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/type05_dynamic.dart',
        );
        _expectSuccess(result, 'TYPE05');
        expect(result.processOutput, contains('TYPE05_PASSED'));
      });
    });

    // ── Visibility ─────────────────────────────────────────────────

    group('VIS: Visibility', () {
      test('G-COV-73: VIS03: show/hide combinators. [2026-02-10 06:37] (PASS)', () async {
        final result = await tester.runScriptOnly(
          config,
          '../d4_test_scripts/bin/dart_overview/vis03_show_hide.dart',
        );
        _expectSuccess(result, 'VIS03');
        expect(result.processOutput, contains('VIS03_PASSED'));
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
