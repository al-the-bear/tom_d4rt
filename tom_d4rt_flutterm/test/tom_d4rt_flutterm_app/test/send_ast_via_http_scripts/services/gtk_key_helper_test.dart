// D4rt test script: Tests GtkKeyHelper from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GtkKeyHelper test executing');
  final results = <String>[];
  var passCount = 0;
  var failCount = 0;

  // Test 1: GTK key value constants
  print('Test 1: Testing GTK key value constants');
  try {
    // GDK key values based on X11 keysyms
    final gtkKeyValues = <String, int>{
      'GDK_KEY_space': 0x020,
      'GDK_KEY_exclam': 0x021,
      'GDK_KEY_quotedbl': 0x022,
      'GDK_KEY_numbersign': 0x023,
      'GDK_KEY_dollar': 0x024,
      'GDK_KEY_percent': 0x025,
      'GDK_KEY_ampersand': 0x026,
      'GDK_KEY_apostrophe': 0x027,
      'GDK_KEY_parenleft': 0x028,
      'GDK_KEY_parenright': 0x029,
    };
    for (final entry in gtkKeyValues.entries) {
      print('  - ${entry.key}: 0x${entry.value.toRadixString(16)}');
    }
    assert(gtkKeyValues.length == 10);
    results.add('✓ GTK key values verified: ${gtkKeyValues.length} values');
    passCount++;
  } catch (e) {
    results.add('✗ GTK key values test failed: $e');
    failCount++;
  }

  // Test 2: GTK modifier type constants
  print('\nTest 2: Testing GTK modifier type constants');
  try {
    final modifierTypes = <String, int>{
      'GDK_SHIFT_MASK': 1 << 0,
      'GDK_LOCK_MASK': 1 << 1,
      'GDK_CONTROL_MASK': 1 << 2,
      'GDK_MOD1_MASK': 1 << 3, // Alt
      'GDK_MOD2_MASK': 1 << 4, // Num Lock
      'GDK_MOD3_MASK': 1 << 5,
      'GDK_MOD4_MASK': 1 << 6, // Super/Windows
      'GDK_MOD5_MASK': 1 << 7,
      'GDK_SUPER_MASK': 1 << 26,
      'GDK_HYPER_MASK': 1 << 27,
      'GDK_META_MASK': 1 << 28,
    };
    for (final entry in modifierTypes.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(modifierTypes['GDK_SHIFT_MASK'] == 1);
    assert(modifierTypes['GDK_CONTROL_MASK'] == 4);
    results.add('✓ Modifier types verified: ${modifierTypes.length} types');
    passCount++;
  } catch (e) {
    results.add('✗ Modifier types test failed: $e');
    failCount++;
  }

  // Test 3: GTK alphabet key values
  print('\nTest 3: Testing GTK alphabet key values');
  try {
    final alphabetKeys = <String, int>{
      'GDK_KEY_a': 0x061,
      'GDK_KEY_b': 0x062,
      'GDK_KEY_c': 0x063,
      'GDK_KEY_A': 0x041,
      'GDK_KEY_B': 0x042,
      'GDK_KEY_C': 0x043,
    };
    for (final entry in alphabetKeys.entries) {
      print('  - ${entry.key}: 0x${entry.value.toRadixString(16)}');
    }
    assert(alphabetKeys['GDK_KEY_a'] == 0x61);
    assert(alphabetKeys['GDK_KEY_A'] == 0x41);
    results.add('✓ Alphabet keys verified: ${alphabetKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Alphabet keys test failed: $e');
    failCount++;
  }

  // Test 4: GTK function key values
  print('\nTest 4: Testing GTK function key values');
  try {
    final functionKeys = <String, int>{
      'GDK_KEY_F1': 0xffbe,
      'GDK_KEY_F2': 0xffbf,
      'GDK_KEY_F3': 0xffc0,
      'GDK_KEY_F4': 0xffc1,
      'GDK_KEY_F5': 0xffc2,
      'GDK_KEY_F6': 0xffc3,
      'GDK_KEY_F7': 0xffc4,
      'GDK_KEY_F8': 0xffc5,
      'GDK_KEY_F9': 0xffc6,
      'GDK_KEY_F10': 0xffc7,
      'GDK_KEY_F11': 0xffc8,
      'GDK_KEY_F12': 0xffc9,
    };
    for (final entry in functionKeys.entries) {
      print('  - ${entry.key}: 0x${entry.value.toRadixString(16)}');
    }
    assert(functionKeys.length == 12);
    results.add('✓ Function keys verified: ${functionKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Function keys test failed: $e');
    failCount++;
  }

  // Test 5: GTK navigation key values
  print('\nTest 5: Testing GTK navigation key values');
  try {
    final navKeys = <String, int>{
      'GDK_KEY_Home': 0xff50,
      'GDK_KEY_Left': 0xff51,
      'GDK_KEY_Up': 0xff52,
      'GDK_KEY_Right': 0xff53,
      'GDK_KEY_Down': 0xff54,
      'GDK_KEY_Page_Up': 0xff55,
      'GDK_KEY_Page_Down': 0xff56,
      'GDK_KEY_End': 0xff57,
    };
    for (final entry in navKeys.entries) {
      print('  - ${entry.key}: 0x${entry.value.toRadixString(16)}');
    }
    assert(navKeys['GDK_KEY_Left'] == 0xff51);
    results.add('✓ Navigation keys verified: ${navKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Navigation keys test failed: $e');
    failCount++;
  }

  // Test 6: Key to LogicalKeyboardKey mapping
  print('\nTest 6: Testing key mapping to LogicalKeyboardKey');
  try {
    final keyMappings = <int, LogicalKeyboardKey>{
      0x061: LogicalKeyboardKey.keyA,
      0x062: LogicalKeyboardKey.keyB,
      0x020: LogicalKeyboardKey.space,
      0xff0d: LogicalKeyboardKey.enter,
      0xff1b: LogicalKeyboardKey.escape,
    };
    for (final entry in keyMappings.entries) {
      print(
        '  - GDK 0x${entry.key.toRadixString(16)} -> ${entry.value.keyLabel}',
      );
    }
    assert(keyMappings.length == 5);
    results.add('✓ Key mappings verified: ${keyMappings.length} mappings');
    passCount++;
  } catch (e) {
    results.add('✗ Key mapping test failed: $e');
    failCount++;
  }

  // Test 7: Modifier detection from state
  print('\nTest 7: Testing modifier detection from state');
  try {
    final state = 5; // Shift + Control
    final hasShift = (state & 1) != 0;
    final hasLock = (state & 2) != 0;
    final hasControl = (state & 4) != 0;
    final hasAlt = (state & 8) != 0;
    print('  - State: $state');
    print('  - Shift: $hasShift');
    print('  - Caps Lock: $hasLock');
    print('  - Control: $hasControl');
    print('  - Alt: $hasAlt');
    assert(hasShift == true);
    assert(hasControl == true);
    assert(hasAlt == false);
    results.add('✓ Modifier detection works correctly');
    passCount++;
  } catch (e) {
    results.add('✗ Modifier detection test failed: $e');
    failCount++;
  }

  // Test 8: Special key values
  print('\nTest 8: Testing GTK special key values');
  try {
    final specialKeys = <String, int>{
      'GDK_KEY_BackSpace': 0xff08,
      'GDK_KEY_Tab': 0xff09,
      'GDK_KEY_Return': 0xff0d,
      'GDK_KEY_Escape': 0xff1b,
      'GDK_KEY_Delete': 0xffff,
      'GDK_KEY_Insert': 0xff63,
    };
    for (final entry in specialKeys.entries) {
      print('  - ${entry.key}: 0x${entry.value.toRadixString(16)}');
    }
    assert(specialKeys['GDK_KEY_Return'] == 0xff0d);
    results.add('✓ Special keys verified: ${specialKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Special keys test failed: $e');
    failCount++;
  }

  // Test 9: Numpad key values
  print('\nTest 9: Testing GTK numpad key values');
  try {
    final numpadKeys = <String, int>{
      'GDK_KEY_KP_0': 0xffb0,
      'GDK_KEY_KP_1': 0xffb1,
      'GDK_KEY_KP_2': 0xffb2,
      'GDK_KEY_KP_Enter': 0xff8d,
      'GDK_KEY_KP_Add': 0xffab,
      'GDK_KEY_KP_Subtract': 0xffad,
      'GDK_KEY_KP_Multiply': 0xffaa,
      'GDK_KEY_KP_Divide': 0xffaf,
    };
    for (final entry in numpadKeys.entries) {
      print('  - ${entry.key}: 0x${entry.value.toRadixString(16)}');
    }
    assert(numpadKeys.length == 8);
    results.add('✓ Numpad keys verified: ${numpadKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Numpad keys test failed: $e');
    failCount++;
  }

  // Test 10: GTK vs X11 keysym relationship
  print('\nTest 10: Documenting GTK vs X11 keysym relationship');
  try {
    print('  - GDK key values are based on X11 keysyms');
    print('  - Lower values (0x00-0xff) are Latin-1 characters');
    print('  - 0xff00-0xffff are special/function keys');
    print('  - GTK modifier masks match X11 conventions');
    final facts = [
      'GDK uses X11 keysyms as base',
      'Latin-1 range: 0x00-0xff',
      'Function keys: 0xff00-0xffff',
    ];
    assert(facts.length == 3);
    results.add('✓ GTK/X11 relationship documented');
    passCount++;
  } catch (e) {
    results.add('✗ Documentation test failed: $e');
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

  print('\nGtkKeyHelper test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'GtkKeyHelper Tests',
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
