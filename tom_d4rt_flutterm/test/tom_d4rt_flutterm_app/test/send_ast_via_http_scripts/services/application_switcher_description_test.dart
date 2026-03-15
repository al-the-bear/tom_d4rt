// D4rt test script: Tests ApplicationSwitcherDescription from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('ApplicationSwitcherDescription comprehensive test executing');
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

  // Test 1: Basic ApplicationSwitcherDescription creation
  print('\n--- Test 1: Basic ApplicationSwitcherDescription creation ---');
  try {
    final desc = ApplicationSwitcherDescription(
      label: 'My App',
      primaryColor: 0xFF2196F3,
    );
    assert(desc.label == 'My App');
    assert(desc.primaryColor == 0xFF2196F3);
    print('Label: ${desc.label}');
    print(
      'Primary color: 0x${desc.primaryColor?.toRadixString(16).toUpperCase()}',
    );
    recordTest('Basic ApplicationSwitcherDescription creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Basic ApplicationSwitcherDescription creation', false);
  }

  // Test 2: Description with null label
  print('\n--- Test 2: Description with null label ---');
  try {
    final desc = ApplicationSwitcherDescription(primaryColor: 0xFF4CAF50);
    assert(desc.label == null);
    assert(desc.primaryColor == 0xFF4CAF50);
    print('Label: ${desc.label}');
    print(
      'Primary color: 0x${desc.primaryColor?.toRadixString(16).toUpperCase()}',
    );
    recordTest('Description with null label', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Description with null label', false);
  }

  // Test 3: Description with null primaryColor
  print('\n--- Test 3: Description with null primaryColor ---');
  try {
    final desc = ApplicationSwitcherDescription(label: 'Test App');
    assert(desc.label == 'Test App');
    assert(desc.primaryColor == null);
    print('Label: ${desc.label}');
    print('Primary color: ${desc.primaryColor}');
    recordTest('Description with null primaryColor', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Description with null primaryColor', false);
  }

  // Test 4: Various color values
  print('\n--- Test 4: Various color values ---');
  try {
    final colors = [
      0xFFFF0000, // Red
      0xFF00FF00, // Green
      0xFF0000FF, // Blue
      0xFFFFFFFF, // White
      0xFF000000, // Black
    ];
    for (final color in colors) {
      final desc = ApplicationSwitcherDescription(
        label: 'Color Test',
        primaryColor: color,
      );
      print('Color: 0x${color.toRadixString(16).toUpperCase()}');
      assert(desc.primaryColor == color);
    }
    recordTest('Various color values', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Various color values', false);
  }

  // Test 5: Long label strings
  print('\n--- Test 5: Long label strings ---');
  try {
    final longLabel = 'A' * 100;
    final desc = ApplicationSwitcherDescription(
      label: longLabel,
      primaryColor: 0xFF9C27B0,
    );
    assert(desc.label == longLabel);
    assert(desc.label!.length == 100);
    print('Long label length: ${desc.label!.length}');
    recordTest('Long label strings', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Long label strings', false);
  }

  // Test 6: Empty label string
  print('\n--- Test 6: Empty label string ---');
  try {
    final desc = ApplicationSwitcherDescription(
      label: '',
      primaryColor: 0xFFE91E63,
    );
    assert(desc.label == '');
    print('Empty label: "${desc.label}"');
    recordTest('Empty label string', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Empty label string', false);
  }

  // Test 7: Unicode label support
  print('\n--- Test 7: Unicode label support ---');
  try {
    final unicodeLabels = [
      '日本語 App', // Japanese
      '中文 App', // Chinese
      '한국어 App', // Korean
      'Русский App', // Russian
      'App 🚀', // Emoji
    ];
    for (final label in unicodeLabels) {
      final desc = ApplicationSwitcherDescription(
        label: label,
        primaryColor: 0xFF3F51B5,
      );
      print('Unicode label: ${desc.label}');
      assert(desc.label == label);
    }
    recordTest('Unicode label support', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Unicode label support', false);
  }

  // Test 8: Material Design colors
  print('\n--- Test 8: Material Design colors ---');
  try {
    final materialColors = {
      'Red': 0xFFF44336,
      'Pink': 0xFFE91E63,
      'Purple': 0xFF9C27B0,
      'DeepPurple': 0xFF673AB7,
      'Indigo': 0xFF3F51B5,
      'Blue': 0xFF2196F3,
      'Teal': 0xFF009688,
      'Green': 0xFF4CAF50,
    };
    materialColors.forEach((name, color) {
      final desc = ApplicationSwitcherDescription(
        label: '$name App',
        primaryColor: color,
      );
      print('$name: 0x${color.toRadixString(16).toUpperCase()}');
      assert(desc.primaryColor == color);
    });
    recordTest('Material Design colors', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Material Design colors', false);
  }

  // Test 9: All null parameters
  print('\n--- Test 9: All null parameters ---');
  try {
    final desc = ApplicationSwitcherDescription();
    assert(desc.label == null);
    assert(desc.primaryColor == null);
    print('Label: ${desc.label}');
    print('Primary color: ${desc.primaryColor}');
    recordTest('All null parameters', true);
  } catch (e) {
    print('Error: $e');
    recordTest('All null parameters', false);
  }

  // Test 10: Transparency in primary color
  print('\n--- Test 10: Transparency in primary color ---');
  try {
    final transparentColors = [
      0x80FF0000, // 50% transparent red
      0x40FF0000, // 25% transparent red
      0x00FF0000, // Fully transparent red
    ];
    for (final color in transparentColors) {
      final desc = ApplicationSwitcherDescription(
        label: 'Transparent',
        primaryColor: color,
      );
      final alpha = (color >> 24) & 0xFF;
      print('Alpha: $alpha, Color: 0x${color.toRadixString(16).toUpperCase()}');
      assert(desc.primaryColor == color);
    }
    recordTest('Transparency in primary color', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Transparency in primary color', false);
  }

  // Print summary
  print('\n========================================');
  print('ApplicationSwitcherDescription Test Summary');
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
        'ApplicationSwitcherDescription Test Results',
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
