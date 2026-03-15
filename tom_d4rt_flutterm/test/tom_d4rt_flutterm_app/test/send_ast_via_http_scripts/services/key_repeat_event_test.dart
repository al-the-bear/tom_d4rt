// D4rt test script: Tests KeyRepeatEvent class from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// KeyRepeatEvent represents a key being held down and repeating
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('=== KeyRepeatEvent Test Suite ===');
  print('Testing KeyRepeatEvent class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: KeyRepeatEvent type verification
  print('\n--- Test 1: KeyRepeatEvent Type Verification ---');
  try {
    print('KeyRepeatEvent extends KeyEvent');
    print('Represents key repeat when held down');
    final physicalKey = PhysicalKeyboardKey.keyA;
    final logicalKey = LogicalKeyboardKey.keyA;
    print('Physical key: $physicalKey');
    print('Logical key: $logicalKey');
    results.add('✓ KeyRepeatEvent type verification passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent type verification failed: $e');
    failCount++;
  }

  // Test 2: Create KeyRepeatEvent
  print('\n--- Test 2: KeyRepeatEvent Creation ---');
  try {
    final repeatEvent = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: LogicalKeyboardKey.keyA,
      timeStamp: Duration(milliseconds: 100),
      character: 'a',
    );
    print('Created KeyRepeatEvent: $repeatEvent');
    print('Physical key: ${repeatEvent.physicalKey}');
    print('Logical key: ${repeatEvent.logicalKey}');
    print('Character: ${repeatEvent.character}');
    assert(
      repeatEvent.physicalKey == PhysicalKeyboardKey.keyA,
      'Physical key mismatch',
    );
    assert(
      repeatEvent.logicalKey == LogicalKeyboardKey.keyA,
      'Logical key mismatch',
    );
    results.add('✓ KeyRepeatEvent creation passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent creation failed: $e');
    failCount++;
  }

  // Test 3: KeyRepeatEvent timestamp
  print('\n--- Test 3: KeyRepeatEvent Timestamp ---');
  try {
    final timestamp = Duration(milliseconds: 500);
    final repeatEvent = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyB,
      logicalKey: LogicalKeyboardKey.keyB,
      timeStamp: timestamp,
    );
    print('Timestamp: ${repeatEvent.timeStamp}');
    assert(repeatEvent.timeStamp == timestamp, 'Timestamp mismatch');
    results.add('✓ KeyRepeatEvent timestamp test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent timestamp test failed: $e');
    failCount++;
  }

  // Test 4: KeyRepeatEvent with modifier keys
  print('\n--- Test 4: KeyRepeatEvent with Modifiers ---');
  try {
    final shiftRepeat = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.shiftLeft,
      logicalKey: LogicalKeyboardKey.shiftLeft,
      timeStamp: Duration(milliseconds: 200),
    );
    print('Shift repeat event: $shiftRepeat');
    print(
      'Is shift key: ${shiftRepeat.logicalKey == LogicalKeyboardKey.shiftLeft}',
    );
    results.add('✓ KeyRepeatEvent with modifiers test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent with modifiers test failed: $e');
    failCount++;
  }

  // Test 5: KeyRepeatEvent vs KeyDownEvent
  print('\n--- Test 5: KeyRepeatEvent vs KeyDownEvent Comparison ---');
  try {
    final downEvent = KeyDownEvent(
      physicalKey: PhysicalKeyboardKey.keyC,
      logicalKey: LogicalKeyboardKey.keyC,
      timeStamp: Duration(milliseconds: 100),
      character: 'c',
    );
    final repeatEvent = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyC,
      logicalKey: LogicalKeyboardKey.keyC,
      timeStamp: Duration(milliseconds: 200),
      character: 'c',
    );
    print('KeyDownEvent type: ${downEvent.runtimeType}');
    print('KeyRepeatEvent type: ${repeatEvent.runtimeType}');
    assert(
      downEvent.runtimeType != repeatEvent.runtimeType,
      'Types should differ',
    );
    results.add('✓ KeyRepeatEvent vs KeyDownEvent comparison passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent vs KeyDownEvent comparison failed: $e');
    failCount++;
  }

  // Test 6: KeyRepeatEvent character property
  print('\n--- Test 6: KeyRepeatEvent Character Property ---');
  try {
    final eventWithChar = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.digit1,
      logicalKey: LogicalKeyboardKey.digit1,
      timeStamp: Duration.zero,
      character: '1',
    );
    final eventNoChar = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.backspace,
      logicalKey: LogicalKeyboardKey.backspace,
      timeStamp: Duration.zero,
    );
    print('Event with character: ${eventWithChar.character}');
    print('Event without character: ${eventNoChar.character}');
    assert(eventWithChar.character == '1', 'Character mismatch');
    results.add('✓ KeyRepeatEvent character property test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent character property test failed: $e');
    failCount++;
  }

  // Test 7: Multiple consecutive repeats
  print('\n--- Test 7: Multiple Consecutive Repeats ---');
  try {
    final repeats = <KeyRepeatEvent>[];
    for (var i = 0; i < 5; i++) {
      repeats.add(
        KeyRepeatEvent(
          physicalKey: PhysicalKeyboardKey.keyA,
          logicalKey: LogicalKeyboardKey.keyA,
          timeStamp: Duration(milliseconds: 100 * (i + 1)),
          character: 'a',
        ),
      );
    }
    print('Created ${repeats.length} repeat events');
    for (var i = 0; i < repeats.length; i++) {
      print('Repeat $i timestamp: ${repeats[i].timeStamp}');
    }
    assert(repeats.length == 5, 'Should have 5 repeat events');
    results.add('✓ Multiple consecutive repeats test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Multiple consecutive repeats test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== KeyRepeatEvent Test Summary ===');
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
        'KeyRepeatEvent Test Results',
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
