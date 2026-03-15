// D4rt test script: Tests RawKeyboard from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyboard test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Access RawKeyboard singleton instance
  print('\n--- Test 1: Access RawKeyboard singleton instance ---');
  try {
    final keyboard = RawKeyboard.instance;
    assert(keyboard != null);
    print('RawKeyboard instance obtained');
    print('Instance type: ${keyboard.runtimeType}');
    results.add('Test 1 PASSED: Singleton instance access');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Check initial keyboard state
  print('\n--- Test 2: Check initial keyboard state ---');
  try {
    final keyboard = RawKeyboard.instance;
    final keysPressed = keyboard.keysPressed;
    print('Keys currently pressed: ${keysPressed.length}');
    print('Keys pressed set: $keysPressed');
    results.add('Test 2 PASSED: Initial state check');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Check physical keys pressed
  print('\n--- Test 3: Check physical keys pressed ---');
  try {
    final keyboard = RawKeyboard.instance;
    final physicalKeys = keyboard.physicalKeysPressed;
    print('Physical keys pressed count: ${physicalKeys.length}');
    print('Physical keys: $physicalKeys');
    results.add('Test 3 PASSED: Physical keys check');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test key listener registration
  print('\n--- Test 4: Test key listener registration ---');
  try {
    final keyboard = RawKeyboard.instance;
    bool listenerCalled = false;
    void testListener(RawKeyEvent event) {
      listenerCalled = true;
    }

    keyboard.addListener(testListener);
    print('Listener added successfully');
    keyboard.removeListener(testListener);
    print('Listener removed successfully');
    results.add('Test 4 PASSED: Listener registration/removal');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Verify LogicalKeyboardKey constants
  print('\n--- Test 5: Verify LogicalKeyboardKey constants ---');
  try {
    final testKeys = [
      LogicalKeyboardKey.keyA,
      LogicalKeyboardKey.keyB,
      LogicalKeyboardKey.enter,
      LogicalKeyboardKey.space,
      LogicalKeyboardKey.escape,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.alt,
    ];
    for (final key in testKeys) {
      print('Key: ${key.debugName}, ID: ${key.keyId}');
      assert(key.keyId > 0);
    }
    results.add('Test 5 PASSED: LogicalKeyboardKey constants');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Verify PhysicalKeyboardKey constants
  print('\n--- Test 6: Verify PhysicalKeyboardKey constants ---');
  try {
    final physicalKeys = [
      PhysicalKeyboardKey.keyA,
      PhysicalKeyboardKey.keyB,
      PhysicalKeyboardKey.enter,
      PhysicalKeyboardKey.space,
      PhysicalKeyboardKey.shiftLeft,
      PhysicalKeyboardKey.shiftRight,
    ];
    for (final key in physicalKeys) {
      print('Physical key: ${key.debugName}, USB HID: ${key.usbHidUsage}');
      assert(key.usbHidUsage > 0);
    }
    results.add('Test 6 PASSED: PhysicalKeyboardKey constants');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test keyboard state consistency
  print('\n--- Test 7: Test keyboard state consistency ---');
  try {
    final keyboard = RawKeyboard.instance;
    final logical = keyboard.keysPressed;
    final physical = keyboard.physicalKeysPressed;
    print('Logical keys count: ${logical.length}');
    print('Physical keys count: ${physical.length}');
    assert(logical.length == physical.length);
    results.add('Test 7 PASSED: State consistency check');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Multiple listener management
  print('\n--- Test 8: Multiple listener management ---');
  try {
    final keyboard = RawKeyboard.instance;
    final listeners = <void Function(RawKeyEvent)>[];
    for (int i = 0; i < 5; i++) {
      final listener = (RawKeyEvent event) => print('Listener $i');
      listeners.add(listener);
      keyboard.addListener(listener);
      print('Added listener $i');
    }
    for (final listener in listeners) {
      keyboard.removeListener(listener);
    }
    print('Removed all ${listeners.length} listeners');
    results.add('Test 8 PASSED: Multiple listeners');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyboard test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RawKeyboard Tests',
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
