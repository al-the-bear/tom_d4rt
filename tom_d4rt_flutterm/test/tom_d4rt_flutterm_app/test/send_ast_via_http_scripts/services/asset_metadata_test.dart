// D4rt test script: Tests AssetMetadata from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetMetadata comprehensive test executing');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Helper to record test results
  void recordTest(String name, bool passed) {
    if (passed) {
      passCount++;
      results.add('✓ $name');
      print('PASS: $name');
    } else {
      failCount++;
      results.add('✗ $name');
      print('FAIL: $name');
    }
  }

  // Test 1: AssetMetadata basic creation
  print('\n--- Test 1: AssetMetadata basic creation ---');
  try {
    final metadata = AssetMetadata(
      key: 'assets/images/logo.png',
      targetDevicePixelRatio: 2.0,
      main: true,
    );
    assert(metadata.key == 'assets/images/logo.png');
    assert(metadata.targetDevicePixelRatio == 2.0);
    assert(metadata.main == true);
    print('Key: ${metadata.key}');
    print('Target DPR: ${metadata.targetDevicePixelRatio}');
    print('Is main: ${metadata.main}');
    recordTest('AssetMetadata basic creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('AssetMetadata basic creation', false);
  }

  // Test 2: Non-main asset variant
  print('\n--- Test 2: Non-main asset variant ---');
  try {
    final variant = AssetMetadata(
      key: 'assets/images/2.0x/logo.png',
      targetDevicePixelRatio: 2.0,
      main: false,
    );
    assert(variant.main == false);
    assert(variant.key.contains('2.0x'));
    print('Variant key: ${variant.key}');
    print('Is main: ${variant.main}');
    recordTest('Non-main asset variant', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Non-main asset variant', false);
  }

  // Test 3: Various pixel ratios
  print('\n--- Test 3: Various pixel ratios ---');
  try {
    final ratios = [1.0, 1.5, 2.0, 2.5, 3.0, 4.0];
    for (final ratio in ratios) {
      final metadata = AssetMetadata(
        key: 'assets/test.png',
        targetDevicePixelRatio: ratio,
        main: ratio == 1.0,
      );
      print('DPR: ${metadata.targetDevicePixelRatio}');
      assert(metadata.targetDevicePixelRatio == ratio);
    }
    recordTest('Various pixel ratios', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Various pixel ratios', false);
  }

  // Test 4: Null pixel ratio
  print('\n--- Test 4: Null pixel ratio ---');
  try {
    final metadata = AssetMetadata(
      key: 'assets/data.json',
      targetDevicePixelRatio: null,
      main: true,
    );
    assert(metadata.targetDevicePixelRatio == null);
    print('Key: ${metadata.key}');
    print('Target DPR: ${metadata.targetDevicePixelRatio}');
    recordTest('Null pixel ratio', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Null pixel ratio', false);
  }

  // Test 5: Different asset paths
  print('\n--- Test 5: Different asset paths ---');
  try {
    final paths = [
      'assets/images/icon.png',
      'assets/fonts/Roboto.ttf',
      'assets/data/config.json',
      'packages/my_pkg/assets/logo.svg',
      'assets/animations/loading.json',
    ];
    for (final path in paths) {
      final metadata = AssetMetadata(
        key: path,
        targetDevicePixelRatio: null,
        main: true,
      );
      print('Path: ${metadata.key}');
      assert(metadata.key == path);
    }
    recordTest('Different asset paths', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Different asset paths', false);
  }

  // Test 6: Asset family with variants
  print('\n--- Test 6: Asset family with variants ---');
  try {
    final family = [
      AssetMetadata(
        key: 'assets/images/logo.png',
        targetDevicePixelRatio: 1.0,
        main: true,
      ),
      AssetMetadata(
        key: 'assets/images/1.5x/logo.png',
        targetDevicePixelRatio: 1.5,
        main: false,
      ),
      AssetMetadata(
        key: 'assets/images/2.0x/logo.png',
        targetDevicePixelRatio: 2.0,
        main: false,
      ),
      AssetMetadata(
        key: 'assets/images/3.0x/logo.png',
        targetDevicePixelRatio: 3.0,
        main: false,
      ),
    ];
    final mainCount = family.where((m) => m.main).length;
    assert(mainCount == 1);
    print('Asset family has ${family.length} variants');
    print('Main asset count: $mainCount');
    for (final m in family) {
      print('  ${m.key} (${m.targetDevicePixelRatio}x) main:${m.main}');
    }
    recordTest('Asset family with variants', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Asset family with variants', false);
  }

  // Test 7: Key with special characters
  print('\n--- Test 7: Key with special characters ---');
  try {
    final specialKeys = [
      'assets/my-image.png',
      'assets/my_image.png',
      'assets/my.image.png',
      'assets/my image.png',
    ];
    for (final key in specialKeys) {
      final metadata = AssetMetadata(
        key: key,
        targetDevicePixelRatio: 1.0,
        main: true,
      );
      print('Special key: ${metadata.key}');
      assert(metadata.key == key);
    }
    recordTest('Key with special characters', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Key with special characters', false);
  }

  // Test 8: Unicode in asset keys
  print('\n--- Test 8: Unicode in asset keys ---');
  try {
    final unicodeKeys = ['assets/日本語.png', 'assets/中文.png', 'assets/한국어.png'];
    for (final key in unicodeKeys) {
      final metadata = AssetMetadata(
        key: key,
        targetDevicePixelRatio: 1.0,
        main: true,
      );
      print('Unicode key: ${metadata.key}');
    }
    recordTest('Unicode in asset keys', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Unicode in asset keys', false);
  }

  // Test 9: Empty key handling
  print('\n--- Test 9: Empty key handling ---');
  try {
    final metadata = AssetMetadata(
      key: '',
      targetDevicePixelRatio: 1.0,
      main: true,
    );
    print('Empty key: "${metadata.key}"');
    assert(metadata.key == '');
    recordTest('Empty key handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Empty key handling', false);
  }

  // Test 10: High DPI values
  print('\n--- Test 10: High DPI values ---');
  try {
    final highDpis = [4.0, 5.0, 6.0];
    for (final dpi in highDpis) {
      final metadata = AssetMetadata(
        key: 'assets/hd.png',
        targetDevicePixelRatio: dpi,
        main: false,
      );
      print('High DPI: ${metadata.targetDevicePixelRatio}');
      assert(metadata.targetDevicePixelRatio == dpi);
    }
    recordTest('High DPI values', true);
  } catch (e) {
    print('Error: $e');
    recordTest('High DPI values', false);
  }

  // Print summary
  print('\n========================================');
  print('AssetMetadata Test Summary');
  print('========================================');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('Total:  ${passCount + failCount}');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'AssetMetadata Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount | Failed: $failCount',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
