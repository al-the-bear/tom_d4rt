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

      test('TOP02: abstract class', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top02_abstract_class.dart',
        );
        _expectSuccess(result, 'TOP02');
        expect(result.processOutput, contains('TOP02_PASSED'));
      });

      test('TOP03: sealed class', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top03_sealed_class.dart',
        );
        _expectSuccess(result, 'TOP03');
        expect(result.processOutput, contains('TOP03_PASSED'));
      });

      test('TOP04: base class', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top04_base_class.dart',
        );
        _expectSuccess(result, 'TOP04');
        expect(result.processOutput, contains('TOP04_PASSED'));
      });

      test('TOP05: interface class', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top05_interface_class.dart',
        );
        _expectSuccess(result, 'TOP05');
        expect(result.processOutput, contains('TOP05_PASSED'));
      });

      test('TOP06: final class', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top06_final_class.dart',
        );
        _expectSuccess(result, 'TOP06');
        expect(result.processOutput, contains('TOP06_PASSED'));
      });

      test('TOP07: mixin class', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top07_mixin_class.dart',
        );
        _expectSuccess(result, 'TOP07');
        expect(result.processOutput, contains('TOP07_PASSED'));
      });

      test('TOP08: simple enum (GEN-044: .values not bridged)', () async {
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

      test('TOP14: mixin', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top14_mixin.dart',
        );
        _expectSuccess(result, 'TOP14');
        expect(result.processOutput, contains('TOP14_PASSED'));
      });

      test('TOP13: generic enum (N/A — Dart limitation)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top13_generic_enum.dart',
        );
        _expectSuccess(result, 'TOP13');
        expect(result.processOutput, contains('TOP13_PASSED'));
      });

      test('TOP15: base mixin', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top15_base_mixin.dart',
        );
        _expectSuccess(result, 'TOP15');
        expect(result.processOutput, contains('TOP15_PASSED'));
      });

      test('TOP16: named extension (not supported)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top16_named_extension.dart',
        );
        _expectSuccess(result, 'TOP16');
        expect(result.processOutput, contains('TOP16_PASSED'));
      });

      test('TOP17: anonymous extension (not supported)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top17_anonymous_extension.dart',
        );
        _expectSuccess(result, 'TOP17');
        expect(result.processOutput, contains('TOP17_PASSED'));
      });

      test('TOP18: extension type (not supported)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top18_extension_type.dart',
        );
        _expectSuccess(result, 'TOP18');
        expect(result.processOutput, contains('TOP18_PASSED'));
      });

      test('TOP19: typedef (function, not needed)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top19_typedef_function.dart',
        );
        _expectSuccess(result, 'TOP19');
        expect(result.processOutput, contains('TOP19_PASSED'));
      });

      test('TOP20: typedef (type alias, not needed)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top20_typedef_type_alias.dart',
        );
        _expectSuccess(result, 'TOP20');
        expect(result.processOutput, contains('TOP20_PASSED'));
      });

      test('TOP21: typedef (generic, not needed)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top21_typedef_generic.dart',
        );
        _expectSuccess(result, 'TOP21');
        expect(result.processOutput, contains('TOP21_PASSED'));
      });

      test('TOP22: top-level function', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top22_toplevel_function.dart',
        );
        _expectSuccess(result, 'TOP22');
        expect(result.processOutput, contains('TOP22_PASSED'));
      });

      test('TOP25: top-level variable', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top25_toplevel_variable.dart',
        );
        _expectSuccess(result, 'TOP25');
        expect(result.processOutput, contains('TOP25_PASSED'));
      });

      test('TOP26: top-level const', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top26_toplevel_const.dart',
        );
        _expectSuccess(result, 'TOP26');
        expect(result.processOutput, contains('TOP26_PASSED'));
      });

      test('TOP27: top-level getter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top27_toplevel_getter.dart',
        );
        _expectSuccess(result, 'TOP27');
        expect(result.processOutput, contains('TOP27_PASSED'));
      });

      test('TOP23: top-level generic function', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top23_toplevel_generic_function.dart',
        );
        _expectSuccess(result, 'TOP23');
        expect(result.processOutput, contains('TOP23_PASSED'));
      });

      test('TOP24: top-level async function', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top24_async_function.dart',
        );
        _expectSuccess(result, 'TOP24');
        expect(result.processOutput, contains('TOP24_PASSED'));
      });

      test('TOP28: top-level setter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top28_toplevel_setter.dart',
        );
        _expectSuccess(result, 'TOP28');
        expect(result.processOutput, contains('TOP28_PASSED'));
      });

      test('TOP29: mixin application (class = with)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/top29_mixin_application.dart',
        );
        _expectSuccess(result, 'TOP29');
        expect(result.processOutput, contains('TOP29_PASSED'));
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

      test('CLS07: static field (mutable)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls07_static_field.dart',
        );
        _expectSuccess(result, 'CLS07');
        expect(result.processOutput, contains('CLS07_PASSED'));
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

      test('CLS11: static method', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls11_static_method.dart',
        );
        _expectSuccess(result, 'CLS11');
        expect(result.processOutput, contains('CLS11_PASSED'));
      });

      test('CLS14: instance method', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls14_instance_method.dart',
        );
        _expectSuccess(result, 'CLS14');
        expect(result.processOutput, contains('CLS14_PASSED'));
      });

      test('CLS15: abstract method', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls15_abstract_method.dart',
        );
        _expectSuccess(result, 'CLS15');
        expect(result.processOutput, contains('CLS15_PASSED'));
      });

      test('CLS16: toString override', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls16_tostring.dart',
        );
        _expectSuccess(result, 'CLS16');
        expect(result.processOutput, contains('CLS16_PASSED'));
      });

      test('CLS05: nullable instance field', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls05_nullable_field.dart',
        );
        _expectSuccess(result, 'CLS05');
        expect(result.processOutput, contains('CLS05_PASSED'));
      });

      test('CLS06: late field', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls06_late_field.dart',
        );
        _expectSuccess(result, 'CLS06');
        expect(result.processOutput, contains('CLS06_PASSED'));
      });

      test('CLS12: static getter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls12_static_getter.dart',
        );
        _expectSuccess(result, 'CLS12');
        expect(result.processOutput, contains('CLS12_PASSED'));
      });

      test('CLS13: static setter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls13_static_setter.dart',
        );
        _expectSuccess(result, 'CLS13');
        expect(result.processOutput, contains('CLS13_PASSED'));
      });

      test('CLS17: call() method (callable class)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/cls17_call_method.dart',
        );
        _expectSuccess(result, 'CLS17');
        expect(result.processOutput, contains('CLS17_PASSED'));
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

      test('CTOR05: const constructor', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/ctor05_const.dart',
        );
        _expectSuccess(result, 'CTOR05');
        expect(result.processOutput, contains('CTOR05_PASSED'));
      });

      test('CTOR06: redirecting constructor', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/ctor06_redirecting.dart',
        );
        _expectSuccess(result, 'CTOR06');
        expect(result.processOutput, contains('CTOR06_PASSED'));
      });

      test('CTOR07: private constructor + factory', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/ctor07_private.dart',
        );
        _expectSuccess(result, 'CTOR07');
        expect(result.processOutput, contains('CTOR07_PASSED'));
      });

      test('CTOR08: super parameters', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/ctor08_super_params.dart',
        );
        _expectSuccess(result, 'CTOR08');
        expect(result.processOutput, contains('CTOR08_PASSED'));
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

      test('PAR06: function-typed parameter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/par06_function_typed_param.dart',
        );
        _expectSuccess(result, 'PAR06');
        expect(result.processOutput, contains('PAR06_PASSED'));
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

      test('GNRC03: upper bound constraint', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/gnrc03_upper_bound.dart',
        );
        _expectSuccess(result, 'GNRC03');
        expect(result.processOutput, contains('GNRC03_PASSED'));
      });

      test('GNRC05: generic static factory', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/gnrc05_generic_static_factory.dart',
        );
        _expectSuccess(result, 'GNRC05');
        expect(result.processOutput, contains('GNRC05_PASSED'));
      });

      test('GNRC07: F-bounded polymorphism', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/gnrc07_fbounded_polymorphism.dart',
        );
        _expectSuccess(result, 'GNRC07');
        expect(result.processOutput, contains('GNRC07_PASSED'));
      });
    });

    // ── Inheritance ────────────────────────────────────────────────

    group('INH: Inheritance', () {
      test('INH01: single-level extends', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/inh01_single_extends.dart',
        );
        _expectSuccess(result, 'INH01');
        expect(result.processOutput, contains('INH01_PASSED'));
      });

      test('INH02: multi-level extends', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/inh02_multi_extends.dart',
        );
        _expectSuccess(result, 'INH02');
        expect(result.processOutput, contains('INH02_PASSED'));
      });

      test('INH03: implements (interface)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/inh03_implements.dart',
        );
        _expectSuccess(result, 'INH03');
        expect(result.processOutput, contains('INH03_PASSED'));
      });

      test('INH04: mixin with', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/inh04_mixin_with.dart',
        );
        _expectSuccess(result, 'INH04');
        expect(result.processOutput, contains('INH04_PASSED'));
      });

      test('INH05: super constructor call', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/inh05_super_ctor.dart',
        );
        _expectSuccess(result, 'INH05');
        expect(result.processOutput, contains('INH05_PASSED'));
      });

      test('INH06: method override', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/inh06_method_override.dart',
        );
        _expectSuccess(result, 'INH06');
        expect(result.processOutput, contains('INH06_PASSED'));
      });

      test(
        'GEN-045: barrel name collision (constrained mixin blocked)',
        () async {
          final result = await tester.runScriptOnly(
            config,
            'test/gen045_barrel_name_collision.dart',
          );
          _expectSuccess(result, 'GEN-045');
          expect(result.processOutput, contains('TOP15_PASSED'));
        },
        skip: 'GEN-045: Bird/Eagle/Penguin excluded from barrel due to '
            'Animal name collision between mixins/basics and '
            'classes/inheritance. The generator needs name-collision '
            'detection or import aliasing support.',
      );
    });

    // ── Operators ──────────────────────────────────────────────────

    group('OP: Operators', () {
      test('OP05: operator / (divide)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/op05_operator_divide.dart',
        );
        _expectSuccess(result, 'OP05');
        expect(result.processOutput, contains('OP05_PASSED'));
      });

      test('OP06: operator ~/ (integer divide)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/op06_operator_integer_divide.dart',
        );
        _expectSuccess(result, 'OP06');
        expect(result.processOutput, contains('OP06_PASSED'));
      });

      test('OP07: operator % (modulo)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/op07_operator_modulo.dart',
        );
        _expectSuccess(result, 'OP07');
        expect(result.processOutput, contains('OP07_PASSED'));
      });

      test('OP08: operator == (equality)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/op08_operator_equals.dart',
        );
        _expectSuccess(result, 'OP08');
        expect(result.processOutput, contains('OP08_PASSED'));
      });

      test('OP09: comparison operators (compareTo)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/op09_comparison_operators.dart',
        );
        _expectSuccess(result, 'OP09');
        expect(result.processOutput, contains('OP09_PASSED'));
      });

      test('OP12: bitwise operators', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/op12_bitwise_operators.dart',
        );
        _expectSuccess(result, 'OP12');
        expect(result.processOutput, contains('OP12_PASSED'));
      });
    });

    // ── Async ──────────────────────────────────────────────────────

    group('ASYNC: Async Features', () {
      test('ASYNC01: async function (Future)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/async01_async_function.dart',
        );
        _expectSuccess(result, 'ASYNC01');
        expect(result.processOutput, contains('ASYNC01_PASSED'));
      });

      test('ASYNC02: async* generator (Stream)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/async02_async_generator.dart',
        );
        _expectSuccess(result, 'ASYNC02');
        expect(result.processOutput, contains('ASYNC02_PASSED'));
      });

      test('ASYNC03: sync* generator (Iterable)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/async03_sync_generator.dart',
        );
        _expectSuccess(result, 'ASYNC03');
        expect(result.processOutput, contains('ASYNC03_PASSED'));
      });

      test('ASYNC04: callback parameter (Function)', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/async04_callback_param.dart',
        );
        _expectSuccess(result, 'ASYNC04');
        expect(result.processOutput, contains('ASYNC04_PASSED'));
      });
    });

    // ── Types ──────────────────────────────────────────────────────

    group('TYPE: Type Features', () {
      test('TYPE01: record parameter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/type01_record_param.dart',
        );
        _expectSuccess(result, 'TYPE01');
        expect(result.processOutput, contains('TYPE01_PASSED'));
      });

      test('TYPE02: record return type', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/type02_record_return.dart',
        );
        _expectSuccess(result, 'TYPE02');
        expect(result.processOutput, contains('TYPE02_PASSED'));
      });

      test('TYPE03: nullable parameter', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/type03_nullable_param.dart',
        );
        _expectSuccess(result, 'TYPE03');
        expect(result.processOutput, contains('TYPE03_PASSED'));
      });

      test('TYPE04: nullable return type', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/type04_nullable_return.dart',
        );
        _expectSuccess(result, 'TYPE04');
        expect(result.processOutput, contains('TYPE04_PASSED'));
      });

      test('TYPE05: dynamic type', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/type05_dynamic.dart',
        );
        _expectSuccess(result, 'TYPE05');
        expect(result.processOutput, contains('TYPE05_PASSED'));
      });
    });

    // ── Visibility ─────────────────────────────────────────────────

    group('VIS: Visibility', () {
      test('VIS03: show/hide combinators', () async {
        final result = await tester.runScriptOnly(
          config,
          'test/vis03_show_hide.dart',
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
