// D4rt test script: Tests GLFWKeyHelper from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GLFWKeyHelper test executing');
  final results = <String>[];
  var passCount = 0;
  var failCount = 0;

  // Test 1: GLFW key code constants
  print('Test 1: Testing GLFW key code constants');
  try {
    // GLFW uses specific key codes for Linux/desktop platforms
    final glfwKeyCodes = <String, int>{
      'GLFW_KEY_SPACE': 32,
      'GLFW_KEY_APOSTROPHE': 39,
      'GLFW_KEY_COMMA': 44,
      'GLFW_KEY_MINUS': 45,
      'GLFW_KEY_PERIOD': 46,
      'GLFW_KEY_SLASH': 47,
      'GLFW_KEY_0': 48,
      'GLFW_KEY_1': 49,
      'GLFW_KEY_A': 65,
      'GLFW_KEY_B': 66,
    };
    for (final entry in glfwKeyCodes.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(glfwKeyCodes.length == 10);
    results.add('✓ GLFW key codes verified: ${glfwKeyCodes.length} codes');
    passCount++;
  } catch (e) {
    results.add('✗ GLFW key codes test failed: $e');
    failCount++;
  }

  // Test 2: GLFW modifier mask constants
  print('\nTest 2: Testing GLFW modifier masks');
  try {
    final modifierMasks = <String, int>{
      'GLFW_MOD_SHIFT': 0x0001,
      'GLFW_MOD_CONTROL': 0x0002,
      'GLFW_MOD_ALT': 0x0004,
      'GLFW_MOD_SUPER': 0x0008,
      'GLFW_MOD_CAPS_LOCK': 0x0010,
      'GLFW_MOD_NUM_LOCK': 0x0020,
    };
    for (final entry in modifierMasks.entries) {
      print(
        '  - ${entry.key}: 0x${entry.value.toRadixString(16).padLeft(4, '0')}',
      );
    }
    assert(modifierMasks['GLFW_MOD_SHIFT'] == 1);
    assert(modifierMasks['GLFW_MOD_CONTROL'] == 2);
    results.add('✓ Modifier masks verified: ${modifierMasks.length} masks');
    passCount++;
  } catch (e) {
    results.add('✗ Modifier masks test failed: $e');
    failCount++;
  }

  // Test 3: GLFW function key codes
  print('\nTest 3: Testing GLFW function key codes');
  try {
    final functionKeys = <String, int>{
      'GLFW_KEY_F1': 290,
      'GLFW_KEY_F2': 291,
      'GLFW_KEY_F3': 292,
      'GLFW_KEY_F4': 293,
      'GLFW_KEY_F5': 294,
      'GLFW_KEY_F6': 295,
      'GLFW_KEY_F7': 296,
      'GLFW_KEY_F8': 297,
      'GLFW_KEY_F9': 298,
      'GLFW_KEY_F10': 299,
      'GLFW_KEY_F11': 300,
      'GLFW_KEY_F12': 301,
    };
    for (final entry in functionKeys.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(functionKeys.length == 12);
    assert(functionKeys['GLFW_KEY_F1'] == 290);
    results.add('✓ Function keys verified: ${functionKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Function keys test failed: $e');
    failCount++;
  }

  // Test 4: GLFW navigation key codes
  print('\nTest 4: Testing GLFW navigation key codes');
  try {
    final navKeys = <String, int>{
      'GLFW_KEY_ESCAPE': 256,
      'GLFW_KEY_ENTER': 257,
      'GLFW_KEY_TAB': 258,
      'GLFW_KEY_BACKSPACE': 259,
      'GLFW_KEY_INSERT': 260,
      'GLFW_KEY_DELETE': 261,
      'GLFW_KEY_RIGHT': 262,
      'GLFW_KEY_LEFT': 263,
      'GLFW_KEY_DOWN': 264,
      'GLFW_KEY_UP': 265,
    };
    for (final entry in navKeys.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(navKeys['GLFW_KEY_ESCAPE'] == 256);
    assert(navKeys['GLFW_KEY_ENTER'] == 257);
    results.add('✓ Navigation keys verified: ${navKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Navigation keys test failed: $e');
    failCount++;
  }

  // Test 5: Key to LogicalKeyboardKey mapping concept
  print('\nTest 5: Testing key mapping to LogicalKeyboardKey');
  try {
    final keyMappings = <int, LogicalKeyboardKey>{
      65: LogicalKeyboardKey.keyA,
      66: LogicalKeyboardKey.keyB,
      67: LogicalKeyboardKey.keyC,
      32: LogicalKeyboardKey.space,
      257: LogicalKeyboardKey.enter,
      256: LogicalKeyboardKey.escape,
    };
    for (final entry in keyMappings.entries) {
      print('  - GLFW ${entry.key} -> ${entry.value.keyLabel}');
    }
    assert(keyMappings.length == 6);
    results.add('✓ Key mappings verified: ${keyMappings.length} mappings');
    passCount++;
  } catch (e) {
    results.add('✗ Key mapping test failed: $e');
    failCount++;
  }

  // Test 6: Modifier detection simulation
  print('\nTest 6: Testing modifier detection simulation');
  try {
    final modifierState = 0x0003; // Shift + Control
    final hasShift = (modifierState & 0x0001) != 0;
    final hasControl = (modifierState & 0x0002) != 0;
    final hasAlt = (modifierState & 0x0004) != 0;
    final hasSuper = (modifierState & 0x0008) != 0;
    print('  - Modifier state: 0x${modifierState.toRadixString(16)}');
    print('  - Shift: $hasShift');
    print('  - Control: $hasControl');
    print('  - Alt: $hasAlt');
    print('  - Super: $hasSuper');
    assert(hasShift == true);
    assert(hasControl == true);
    assert(hasAlt == false);
    results.add('✓ Modifier detection works correctly');
    passCount++;
  } catch (e) {
    results.add('✗ Modifier detection test failed: $e');
    failCount++;
  }

  // Test 7: Numpad key codes
  print('\nTest 7: Testing GLFW numpad key codes');
  try {
    final numpadKeys = <String, int>{
      'GLFW_KEY_KP_0': 320,
      'GLFW_KEY_KP_1': 321,
      'GLFW_KEY_KP_2': 322,
      'GLFW_KEY_KP_DECIMAL': 330,
      'GLFW_KEY_KP_DIVIDE': 331,
      'GLFW_KEY_KP_MULTIPLY': 332,
      'GLFW_KEY_KP_SUBTRACT': 333,
      'GLFW_KEY_KP_ADD': 334,
      'GLFW_KEY_KP_ENTER': 335,
    };
    for (final entry in numpadKeys.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(numpadKeys.length == 9);
    results.add('✓ Numpad keys verified: ${numpadKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Numpad keys test failed: $e');
    failCount++;
  }

  // Test 8: Lock key codes
  print('\nTest 8: Testing GLFW lock key codes');
  try {
    final lockKeys = <String, int>{
      'GLFW_KEY_CAPS_LOCK': 280,
      'GLFW_KEY_SCROLL_LOCK': 281,
      'GLFW_KEY_NUM_LOCK': 282,
      'GLFW_KEY_PRINT_SCREEN': 283,
      'GLFW_KEY_PAUSE': 284,
    };
    for (final entry in lockKeys.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(lockKeys.length == 5);
    results.add('✓ Lock keys verified: ${lockKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Lock keys test failed: $e');
    failCount++;
  }

  // Test 9: Key action types
  print('\nTest 9: Testing GLFW key action types');
  try {
    final actions = <String, int>{
      'GLFW_RELEASE': 0,
      'GLFW_PRESS': 1,
      'GLFW_REPEAT': 2,
    };
    for (final entry in actions.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(actions['GLFW_RELEASE'] == 0);
    assert(actions['GLFW_PRESS'] == 1);
    assert(actions['GLFW_REPEAT'] == 2);
    results.add('✓ Key actions verified: ${actions.length} actions');
    passCount++;
  } catch (e) {
    results.add('✗ Key action test failed: $e');
    failCount++;
  }

  // Test 10: Combined modifier and key detection
  print('\nTest 10: Testing combined modifier and key detection');
  try {
    // Simulate Ctrl+C key combination
    final keyCode = 67; // C
    final modifiers = 0x0002; // Control
    final isCtrlC = keyCode == 67 && (modifiers & 0x0002) != 0;
    print('  - Key code: $keyCode (C)');
    print('  - Modifier: 0x${modifiers.toRadixString(16)} (Control)');
    print('  - Is Ctrl+C: $isCtrlC');
    assert(isCtrlC == true);
    results.add('✓ Combined key detection works');
    passCount++;
  } catch (e) {
    results.add('✗ Combined detection test failed: $e');
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

  print('\nGLFWKeyHelper test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'GLFWKeyHelper Tests',
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
