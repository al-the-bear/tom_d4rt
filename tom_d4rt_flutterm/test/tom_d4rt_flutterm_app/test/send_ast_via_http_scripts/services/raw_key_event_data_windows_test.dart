// D4rt test script: Tests RawKeyEventDataWindows from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataWindows test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyEventDataWindows instance
  print('\n--- Test 1: Create RawKeyEventDataWindows instance ---');
  try {
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 97,
      modifiers: 0,
    );
    assert(data is RawKeyEventDataWindows);
    print('Created RawKeyEventDataWindows successfully');
    print('KeyCode: ${data.keyCode}');
    print('ScanCode: ${data.scanCode}');
    print('CharacterCodePoint: ${data.characterCodePoint}');
    results.add('Test 1 PASSED: Instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test Windows virtual key codes
  print('\n--- Test 2: Test Windows virtual key codes ---');
  try {
    final vkCodes = {
      'A': 65,
      'B': 66,
      'C': 67,
      '0': 48,
      '1': 49,
      'Enter': 13,
      'Escape': 27,
      'Space': 32,
      'Tab': 9,
    };
    for (final entry in vkCodes.entries) {
      final data = RawKeyEventDataWindows(
        keyCode: entry.value,
        scanCode: 0,
        characterCodePoint: 0,
        modifiers: 0,
      );
      print('Key ${entry.key}: VK_CODE=${data.keyCode}');
      assert(data.keyCode == entry.value);
    }
    results.add('Test 2 PASSED: Virtual key codes');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test scanCode values
  print('\n--- Test 3: Test scanCode values ---');
  try {
    final scanCodes = [30, 31, 32, 33, 34, 35, 36, 37, 38];
    for (int i = 0; i < scanCodes.length; i++) {
      final data = RawKeyEventDataWindows(
        keyCode: 65 + i,
        scanCode: scanCodes[i],
        characterCodePoint: 97 + i,
        modifiers: 0,
      );
      print('ScanCode: ${data.scanCode}');
      assert(data.scanCode == scanCodes[i]);
    }
    results.add('Test 3 PASSED: ScanCode values');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test characterCodePoint
  print('\n--- Test 4: Test characterCodePoint ---');
  try {
    final codePoints = [97, 65, 48, 64, 33, 35];
    for (final cp in codePoints) {
      final data = RawKeyEventDataWindows(
        keyCode: 65,
        scanCode: 30,
        characterCodePoint: cp,
        modifiers: 0,
      );
      final char = cp > 0 ? String.fromCharCode(cp) : '(none)';
      print('CodePoint $cp = "$char"');
      assert(data.characterCodePoint == cp);
    }
    results.add('Test 4 PASSED: CharacterCodePoint');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test Windows modifier flags
  print('\n--- Test 5: Test Windows modifier flags ---');
  try {
    final modShift = 1;
    final modControl = 4;
    final modAlt = 2;
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 65,
      modifiers: modShift | modControl,
    );
    print('Modifiers: ${data.modifiers}');
    print('Shift: ${(data.modifiers & modShift) != 0}');
    print('Control: ${(data.modifiers & modControl) != 0}');
    print('Alt: ${(data.modifiers & modAlt) != 0}');
    results.add('Test 5 PASSED: Modifier flags');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test logical key extraction
  print('\n--- Test 6: Test logical key extraction ---');
  try {
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 97,
      modifiers: 0,
    );
    final logicalKey = data.logicalKey;
    print('Logical key: ${logicalKey.debugName}');
    print('Key ID: ${logicalKey.keyId}');
    results.add('Test 6 PASSED: Logical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test physical key extraction
  print('\n--- Test 7: Test physical key extraction ---');
  try {
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 97,
      modifiers: 0,
    );
    final physicalKey = data.physicalKey;
    print('Physical key: ${physicalKey.debugName}');
    print('USB HID: ${physicalKey.usbHidUsage}');
    results.add('Test 7 PASSED: Physical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Verify inheritance from RawKeyEventData
  print('\n--- Test 8: Verify inheritance from RawKeyEventData ---');
  try {
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 97,
      modifiers: 0,
    );
    assert(data is RawKeyEventData);
    print('Inherits from RawKeyEventData: true');
    print('Runtime type: ${data.runtimeType}');
    results.add('Test 8 PASSED: Inheritance verified');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyEventDataWindows test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RawKeyEventDataWindows Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        'Passed: $testsPassed, Failed: $testsFailed',
        style: TextStyle(
          color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000),
        ),
      ),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
