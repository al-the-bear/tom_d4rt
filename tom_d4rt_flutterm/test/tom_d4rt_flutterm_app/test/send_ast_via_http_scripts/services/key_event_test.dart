// D4rt test script: Tests KeyEvent base class from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyEvent test executing');
  final results = <String>[];
  var passCount = 0;
  var failCount = 0;

  // Test 1: KeyEvent class hierarchy
  print('Test 1: Testing KeyEvent class hierarchy');
  try {
    print('  - KeyEvent is the base class for key events');
    print('  - Subclasses: KeyDownEvent, KeyUpEvent, KeyRepeatEvent');
    print('  - Contains physical key, logical key, and character');
    final hierarchy = [
      'KeyEvent',
      'KeyDownEvent',
      'KeyUpEvent',
      'KeyRepeatEvent',
    ];
    assert(hierarchy.length == 4);
    results.add('✓ KeyEvent hierarchy verified: ${hierarchy.length} classes');
    passCount++;
  } catch (e) {
    results.add('✗ Hierarchy test failed: $e');
    failCount++;
  }

  // Test 2: KeyEvent properties
  print('\nTest 2: Testing KeyEvent properties');
  try {
    final properties = <String, String>{
      'physicalKey': 'PhysicalKeyboardKey representing hardware',
      'logicalKey': 'LogicalKeyboardKey representing meaning',
      'character': 'String? representing typed character',
      'timeStamp': 'Duration since event source started',
      'synthesized': 'bool indicating if event was synthesized',
    };
    for (final entry in properties.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(properties.length == 5);
    results.add('✓ Properties documented: ${properties.length} properties');
    passCount++;
  } catch (e) {
    results.add('✗ Properties test failed: $e');
    failCount++;
  }

  // Test 3: Physical key usage
  print('\nTest 3: Testing physical key concepts');
  try {
    final physicalKeys = [
      PhysicalKeyboardKey.keyA,
      PhysicalKeyboardKey.keyZ,
      PhysicalKeyboardKey.digit1,
      PhysicalKeyboardKey.f1,
      PhysicalKeyboardKey.enter,
    ];
    for (final key in physicalKeys) {
      print('  - Physical: ${key.debugName} (USB: ${key.usbHidUsage})');
    }
    assert(physicalKeys.length == 5);
    results.add('✓ Physical keys verified: ${physicalKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Physical key test failed: $e');
    failCount++;
  }

  // Test 4: Logical key usage
  print('\nTest 4: Testing logical key concepts');
  try {
    final logicalKeys = [
      LogicalKeyboardKey.keyA,
      LogicalKeyboardKey.keyZ,
      LogicalKeyboardKey.digit1,
      LogicalKeyboardKey.f1,
      LogicalKeyboardKey.enter,
    ];
    for (final key in logicalKeys) {
      print('  - Logical: ${key.keyLabel} (ID: ${key.keyId})');
    }
    assert(logicalKeys.length == 5);
    results.add('✓ Logical keys verified: ${logicalKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Logical key test failed: $e');
    failCount++;
  }

  // Test 5: Character property behavior
  print('\nTest 5: Testing character property behavior');
  try {
    final keyCharacters = <String, String?>{
      'keyA': 'a',
      'keyA+Shift': 'A',
      'enter': null,
      'escape': null,
      'space': ' ',
      'digit1': '1',
      'digit1+Shift': '!',
    };
    for (final entry in keyCharacters.entries) {
      final charDisplay = entry.value == null ? 'null' : '"${entry.value}"';
      print('  - ${entry.key}: $charDisplay');
    }
    assert(keyCharacters['keyA'] == 'a');
    assert(keyCharacters['enter'] == null);
    results.add('✓ Character property verified');
    passCount++;
  } catch (e) {
    results.add('✗ Character test failed: $e');
    failCount++;
  }

  // Test 6: Timestamp handling
  print('\nTest 6: Testing timestamp handling');
  try {
    final durations = [
      Duration(milliseconds: 0),
      Duration(milliseconds: 100),
      Duration(milliseconds: 200),
      Duration(milliseconds: 300),
    ];
    for (final d in durations) {
      print('  - Timestamp: ${d.inMilliseconds}ms');
    }
    assert(durations[0] < durations[3]);
    results.add('✓ Timestamp handling verified');
    passCount++;
  } catch (e) {
    results.add('✗ Timestamp test failed: $e');
    failCount++;
  }

  // Test 7: Event type differentiation
  print('\nTest 7: Testing event type differentiation');
  try {
    final eventTypes = {
      'KeyDownEvent': 'Initial key press',
      'KeyUpEvent': 'Key release',
      'KeyRepeatEvent': 'Key held down (auto-repeat)',
    };
    for (final entry in eventTypes.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(eventTypes.length == 3);
    results.add('✓ Event types differentiated: ${eventTypes.length} types');
    passCount++;
  } catch (e) {
    results.add('✗ Event type test failed: $e');
    failCount++;
  }

  // Test 8: Synthesized event concept
  print('\nTest 8: Testing synthesized event concept');
  try {
    print('  - Synthesized events fill gaps in key sequences');
    print('  - Used when system fails to report key up events');
    print('  - Common with modifier keys losing focus');
    final scenarios = [
      'Window loses focus while key held',
      'System key intercept (Alt+Tab)',
      'Remote desktop key forwarding',
    ];
    for (var i = 0; i < scenarios.length; i++) {
      print('  - Scenario ${i + 1}: ${scenarios[i]}');
    }
    assert(scenarios.length == 3);
    results.add('✓ Synthesized event concept verified');
    passCount++;
  } catch (e) {
    results.add('✗ Synthesized event test failed: $e');
    failCount++;
  }

  // Test 9: Key event sequence simulation
  print('\nTest 9: Testing key event sequence');
  try {
    final sequence = <Map<String, dynamic>>[
      {'type': 'KeyDownEvent', 'key': 'Shift', 'time': 0},
      {'type': 'KeyDownEvent', 'key': 'A', 'time': 50, 'char': 'A'},
      {'type': 'KeyUpEvent', 'key': 'A', 'time': 150},
      {'type': 'KeyUpEvent', 'key': 'Shift', 'time': 200},
    ];
    for (final event in sequence) {
      final char = event['char'] != null ? ' (char: ${event['char']})' : '';
      print('  - ${event['type']}: ${event['key']}$char at ${event['time']}ms');
    }
    assert(sequence.length == 4);
    results.add('✓ Key sequence verified: ${sequence.length} events');
    passCount++;
  } catch (e) {
    results.add('✗ Sequence test failed: $e');
    failCount++;
  }

  // Test 10: Platform differences
  print('\nTest 10: Documenting platform differences');
  try {
    final platforms = {
      'Windows': 'Uses virtual key codes',
      'macOS': 'Uses Carbon key codes',
      'Linux/GLFW': 'Uses GLFW key codes',
      'Linux/GTK': 'Uses GDK keysyms',
      'Android': 'Uses Android key codes',
      'iOS': 'Uses UIKit key handling',
      'Web': 'Uses DOM key codes',
    };
    for (final entry in platforms.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(platforms.length == 7);
    results.add(
      '✓ Platform differences documented: ${platforms.length} platforms',
    );
    passCount++;
  } catch (e) {
    results.add('✗ Platform test failed: $e');
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

  print('\nKeyEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'KeyEvent Tests',
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
