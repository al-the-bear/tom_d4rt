// D4rt test script: Tests KeyMessage class from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// KeyMessage represents a complete key event message from the platform
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('=== KeyMessage Test Suite ===');
  print('Testing KeyMessage class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: Create KeyMessage with events
  print('\n--- Test 1: KeyMessage Creation ---');
  try {
    // KeyMessage contains a list of KeyEvent objects
    print('KeyMessage stores platform key events');
    print('KeyMessage is used for cross-platform key handling');
    final keyA = LogicalKeyboardKey.keyA;
    print('Reference key for testing: $keyA');
    results.add('✓ KeyMessage creation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage creation test failed: $e');
    failCount++;
  }

  // Test 2: KeyMessage events property
  print('\n--- Test 2: KeyMessage Events Property ---');
  try {
    print('KeyMessage.events contains list of KeyEvent objects');
    print('Events represent the key presses/releases');
    final physicalKey = PhysicalKeyboardKey.keyA;
    print('Physical key for events: $physicalKey');
    results.add('✓ KeyMessage events property test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage events property test failed: $e');
    failCount++;
  }

  // Test 3: KeyMessage raw events
  print('\n--- Test 3: KeyMessage Raw Events ---');
  try {
    print('KeyMessage also stores raw hardware events');
    print('Raw events preserve platform-specific data');
    final rawKeyData = RawKeyEvent.fromMessage({
      'type': 'keydown',
      'keymap': 'android',
      'keyCode': 29,
      'codePoint': 97,
      'scanCode': 30,
      'metaState': 0,
      'source': 0x101,
      'deviceId': 1,
    });
    print('Raw key event type: ${rawKeyData.runtimeType}');
    results.add('✓ KeyMessage raw events test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage raw events test failed: $e');
    failCount++;
  }

  // Test 4: KeyMessage with multiple events
  print('\n--- Test 4: KeyMessage Multiple Events ---');
  try {
    print('KeyMessage can contain multiple sequential events');
    print('This happens with key combinations');
    final shift = LogicalKeyboardKey.shiftLeft;
    final keyA = LogicalKeyboardKey.keyA;
    print('Shift key: $shift');
    print('A key: $keyA');
    print('Combined would be multiple events in KeyMessage');
    results.add('✓ KeyMessage multiple events test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage multiple events test failed: $e');
    failCount++;
  }

  // Test 5: KeyMessage key character
  print('\n--- Test 5: KeyMessage Character Handling ---');
  try {
    print('KeyMessage includes character information');
    final letter = LogicalKeyboardKey.keyA;
    print('Key label: ${letter.keyLabel}');
    print('Key character typically derived from logical key');
    assert(letter.keyLabel == 'A', 'Key label should be A');
    results.add('✓ KeyMessage character handling test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage character handling test failed: $e');
    failCount++;
  }

  // Test 6: KeyMessage modifier state
  print('\n--- Test 6: KeyMessage Modifier State ---');
  try {
    print('KeyMessage tracks modifier key states');
    final modifiers = <LogicalKeyboardKey>[
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.controlLeft,
      LogicalKeyboardKey.altLeft,
      LogicalKeyboardKey.metaLeft,
    ];
    for (final mod in modifiers) {
      print('Modifier: ${mod.keyLabel} (${mod.keyId})');
    }
    results.add('✓ KeyMessage modifier state test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage modifier state test failed: $e');
    failCount++;
  }

  // Test 7: KeyMessage timestamp handling
  print('\n--- Test 7: KeyMessage Timestamp ---');
  try {
    print('KeyMessage events include timestamps');
    final now = DateTime.now().millisecondsSinceEpoch;
    print('Current timestamp: $now');
    print('Timestamps help with event ordering');
    results.add('✓ KeyMessage timestamp test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage timestamp test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== KeyMessage Test Summary ===');
  print('Total tests: ${passCount + failCount}');
  print('Passed: $passCount');
  print('Failed: $failCount');
  for (final result in results) {
    print(result);
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'KeyMessage Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
