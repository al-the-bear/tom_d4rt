// D4rt test script: Tests KeyboardKey from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyboardKey test executing');
  final results = <String>[];
  var passCount = 0;
  var failCount = 0;

  // Test 1: LogicalKeyboardKey basic access
  print('Test 1: Testing LogicalKeyboardKey basic access');
  try {
    final keyA = LogicalKeyboardKey.keyA;
    final keyB = LogicalKeyboardKey.keyB;
    print('  - Key A: ${keyA.keyLabel}');
    print('  - Key B: ${keyB.keyLabel}');
    print('  - Key A ID: ${keyA.keyId}');
    assert(keyA != keyB);
    assert(keyA.keyId != keyB.keyId);
    results.add('✓ LogicalKeyboardKey basic access works');
    passCount++;
  } catch (e) {
    results.add('✗ LogicalKeyboardKey test failed: $e');
    failCount++;
  }

  // Test 2: PhysicalKeyboardKey access
  print('\nTest 2: Testing PhysicalKeyboardKey access');
  try {
    final physKeyA = PhysicalKeyboardKey.keyA;
    final physKeyB = PhysicalKeyboardKey.keyB;
    print('  - Physical Key A: ${physKeyA.debugName}');
    print('  - Physical Key B: ${physKeyB.debugName}');
    print('  - USB HID code A: ${physKeyA.usbHidUsage}');
    assert(physKeyA.usbHidUsage != physKeyB.usbHidUsage);
    results.add('✓ PhysicalKeyboardKey access works');
    passCount++;
  } catch (e) {
    results.add('✗ PhysicalKeyboardKey test failed: $e');
    failCount++;
  }

  // Test 3: Alphabet keys
  print('\nTest 3: Testing alphabet keys');
  try {
    final alphabetKeys = [
      LogicalKeyboardKey.keyA,
      LogicalKeyboardKey.keyB,
      LogicalKeyboardKey.keyC,
      LogicalKeyboardKey.keyD,
      LogicalKeyboardKey.keyE,
      LogicalKeyboardKey.keyF,
    ];
    for (final key in alphabetKeys) {
      print('  - ${key.keyLabel}: ${key.keyId}');
    }
    assert(alphabetKeys.length == 6);
    results.add('✓ Alphabet keys verified: ${alphabetKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Alphabet keys test failed: $e');
    failCount++;
  }

  // Test 4: Number keys
  print('\nTest 4: Testing number keys');
  try {
    final numberKeys = [
      LogicalKeyboardKey.digit0,
      LogicalKeyboardKey.digit1,
      LogicalKeyboardKey.digit2,
      LogicalKeyboardKey.digit3,
      LogicalKeyboardKey.digit4,
      LogicalKeyboardKey.digit5,
      LogicalKeyboardKey.digit6,
      LogicalKeyboardKey.digit7,
      LogicalKeyboardKey.digit8,
      LogicalKeyboardKey.digit9,
    ];
    print('  - Number keys count: ${numberKeys.length}');
    for (var i = 0; i < 5; i++) {
      print('  - Digit $i: ${numberKeys[i].keyLabel}');
    }
    assert(numberKeys.length == 10);
    results.add('✓ Number keys verified: ${numberKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Number keys test failed: $e');
    failCount++;
  }

  // Test 5: Function keys
  print('\nTest 5: Testing function keys');
  try {
    final functionKeys = [
      LogicalKeyboardKey.f1,
      LogicalKeyboardKey.f2,
      LogicalKeyboardKey.f3,
      LogicalKeyboardKey.f4,
      LogicalKeyboardKey.f5,
      LogicalKeyboardKey.f6,
    ];
    for (final key in functionKeys) {
      print('  - Function key: ${key.keyLabel}');
    }
    assert(functionKeys.length == 6);
    results.add('✓ Function keys verified: ${functionKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Function keys test failed: $e');
    failCount++;
  }

  // Test 6: Modifier keys
  print('\nTest 6: Testing modifier keys');
  try {
    final modifiers = {
      'Shift Left': LogicalKeyboardKey.shiftLeft,
      'Shift Right': LogicalKeyboardKey.shiftRight,
      'Control Left': LogicalKeyboardKey.controlLeft,
      'Control Right': LogicalKeyboardKey.controlRight,
      'Alt Left': LogicalKeyboardKey.altLeft,
      'Alt Right': LogicalKeyboardKey.altRight,
      'Meta Left': LogicalKeyboardKey.metaLeft,
      'Meta Right': LogicalKeyboardKey.metaRight,
    };
    for (final entry in modifiers.entries) {
      print('  - ${entry.key}: ${entry.value.keyLabel}');
    }
    assert(modifiers.length == 8);
    results.add('✓ Modifier keys verified: ${modifiers.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Modifier keys test failed: $e');
    failCount++;
  }

  // Test 7: Navigation keys
  print('\nTest 7: Testing navigation keys');
  try {
    final navKeys = {
      'Arrow Up': LogicalKeyboardKey.arrowUp,
      'Arrow Down': LogicalKeyboardKey.arrowDown,
      'Arrow Left': LogicalKeyboardKey.arrowLeft,
      'Arrow Right': LogicalKeyboardKey.arrowRight,
      'Home': LogicalKeyboardKey.home,
      'End': LogicalKeyboardKey.end,
      'Page Up': LogicalKeyboardKey.pageUp,
      'Page Down': LogicalKeyboardKey.pageDown,
    };
    for (final entry in navKeys.entries) {
      print('  - ${entry.key}: ${entry.value.keyId}');
    }
    assert(navKeys.length == 8);
    results.add('✓ Navigation keys verified: ${navKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Navigation keys test failed: $e');
    failCount++;
  }

  // Test 8: Special keys
  print('\nTest 8: Testing special keys');
  try {
    final specialKeys = {
      'Enter': LogicalKeyboardKey.enter,
      'Escape': LogicalKeyboardKey.escape,
      'Backspace': LogicalKeyboardKey.backspace,
      'Tab': LogicalKeyboardKey.tab,
      'Space': LogicalKeyboardKey.space,
      'Delete': LogicalKeyboardKey.delete,
    };
    for (final entry in specialKeys.entries) {
      print('  - ${entry.key}: ${entry.value.keyLabel}');
    }
    assert(specialKeys.length == 6);
    results.add('✓ Special keys verified: ${specialKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Special keys test failed: $e');
    failCount++;
  }

  // Test 9: Key comparison
  print('\nTest 9: Testing key comparison');
  try {
    final keyA1 = LogicalKeyboardKey.keyA;
    final keyA2 = LogicalKeyboardKey.keyA;
    final keyB = LogicalKeyboardKey.keyB;
    assert(keyA1 == keyA2);
    assert(keyA1 != keyB);
    assert(keyA1.keyId == keyA2.keyId);
    print('  - keyA == keyA: ${keyA1 == keyA2}');
    print('  - keyA != keyB: ${keyA1 != keyB}');
    print('  - Key IDs match: ${keyA1.keyId == keyA2.keyId}');
    results.add('✓ Key comparison works correctly');
    passCount++;
  } catch (e) {
    results.add('✗ Key comparison test failed: $e');
    failCount++;
  }

  // Test 10: Numpad keys
  print('\nTest 10: Testing numpad keys');
  try {
    final numpadKeys = [
      LogicalKeyboardKey.numpad0,
      LogicalKeyboardKey.numpad1,
      LogicalKeyboardKey.numpad2,
      LogicalKeyboardKey.numpad3,
      LogicalKeyboardKey.numpad4,
      LogicalKeyboardKey.numpad5,
    ];
    for (final key in numpadKeys) {
      print('  - Numpad: ${key.keyLabel}');
    }
    assert(numpadKeys.length == 6);
    results.add('✓ Numpad keys verified: ${numpadKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Numpad keys test failed: $e');
    failCount++;
  }

  // Test 11: Key synonyms
  print('\nTest 11: Testing key synonyms concepts');
  try {
    final returnKey = LogicalKeyboardKey.enter;
    final numEnter = LogicalKeyboardKey.numpadEnter;
    print('  - Enter key: ${returnKey.keyLabel}');
    print('  - Numpad Enter: ${numEnter.keyLabel}');
    print('  - Both represent "enter" action but are different keys');
    assert(returnKey != numEnter);
    results.add('✓ Key synonyms concept verified');
    passCount++;
  } catch (e) {
    results.add('✗ Key synonyms test failed: $e');
    failCount++;
  }

  // Print summary
  print('\n========== Test Summary ==========');
  print('Total tests: ${passCount + failCount}');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('===================================');

  for (final result in results) {
    print(result);
  }

  print('\nKeyboardKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'KeyboardKey Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount / ${passCount + failCount}',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 12)),
        ),
      ),
    ],
  );
}
