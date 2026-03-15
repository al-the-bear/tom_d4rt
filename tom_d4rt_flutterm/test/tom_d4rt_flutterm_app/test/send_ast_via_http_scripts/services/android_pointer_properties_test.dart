// D4rt test script: Tests AndroidPointerProperties from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidPointerProperties comprehensive test executing');
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

  // Test 1: Basic AndroidPointerProperties creation
  print('\n--- Test 1: Basic AndroidPointerProperties creation ---');
  try {
    final props = AndroidPointerProperties(id: 0, toolType: 1);
    assert(props.id == 0);
    assert(props.toolType == 1);
    print(
      'Created properties with id: ${props.id}, toolType: ${props.toolType}',
    );
    recordTest('Basic AndroidPointerProperties creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Basic AndroidPointerProperties creation', false);
  }

  // Test 2: Different pointer IDs
  print('\n--- Test 2: Different pointer IDs ---');
  try {
    final props0 = AndroidPointerProperties(id: 0, toolType: 1);
    final props1 = AndroidPointerProperties(id: 1, toolType: 1);
    final props2 = AndroidPointerProperties(id: 2, toolType: 1);

    assert(props0.id == 0);
    assert(props1.id == 1);
    assert(props2.id == 2);
    print('Pointer 0 id: ${props0.id}');
    print('Pointer 1 id: ${props1.id}');
    print('Pointer 2 id: ${props2.id}');
    recordTest('Different pointer IDs', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Different pointer IDs', false);
  }

  // Test 3: Tool type FINGER (1)
  print('\n--- Test 3: Tool type FINGER ---');
  try {
    final fingerProps = AndroidPointerProperties(id: 0, toolType: 1);
    assert(fingerProps.toolType == 1);
    print('FINGER tool type: ${fingerProps.toolType}');
    recordTest('Tool type FINGER', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type FINGER', false);
  }

  // Test 4: Tool type STYLUS (2)
  print('\n--- Test 4: Tool type STYLUS ---');
  try {
    final stylusProps = AndroidPointerProperties(id: 0, toolType: 2);
    assert(stylusProps.toolType == 2);
    print('STYLUS tool type: ${stylusProps.toolType}');
    recordTest('Tool type STYLUS', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type STYLUS', false);
  }

  // Test 5: Tool type MOUSE (3)
  print('\n--- Test 5: Tool type MOUSE ---');
  try {
    final mouseProps = AndroidPointerProperties(id: 0, toolType: 3);
    assert(mouseProps.toolType == 3);
    print('MOUSE tool type: ${mouseProps.toolType}');
    recordTest('Tool type MOUSE', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type MOUSE', false);
  }

  // Test 6: Tool type ERASER (4)
  print('\n--- Test 6: Tool type ERASER ---');
  try {
    final eraserProps = AndroidPointerProperties(id: 0, toolType: 4);
    assert(eraserProps.toolType == 4);
    print('ERASER tool type: ${eraserProps.toolType}');
    recordTest('Tool type ERASER', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type ERASER', false);
  }

  // Test 7: Tool type UNKNOWN (0)
  print('\n--- Test 7: Tool type UNKNOWN ---');
  try {
    final unknownProps = AndroidPointerProperties(id: 0, toolType: 0);
    assert(unknownProps.toolType == 0);
    print('UNKNOWN tool type: ${unknownProps.toolType}');
    recordTest('Tool type UNKNOWN', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool type UNKNOWN', false);
  }

  // Test 8: Multiple pointers with different tools
  print('\n--- Test 8: Multiple pointers with different tools ---');
  try {
    final propsList = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1), // Finger
      AndroidPointerProperties(id: 1, toolType: 1), // Finger
      AndroidPointerProperties(id: 2, toolType: 2), // Stylus
    ];
    assert(propsList.length == 3);
    assert(propsList[0].toolType == 1);
    assert(propsList[1].toolType == 1);
    assert(propsList[2].toolType == 2);
    print('Created ${propsList.length} pointer properties');
    for (int i = 0; i < propsList.length; i++) {
      print('Pointer ${propsList[i].id}: toolType ${propsList[i].toolType}');
    }
    recordTest('Multiple pointers with different tools', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Multiple pointers with different tools', false);
  }

  // Test 9: High pointer ID values
  print('\n--- Test 9: High pointer ID values ---');
  try {
    final highIdProps = AndroidPointerProperties(id: 99, toolType: 1);
    assert(highIdProps.id == 99);
    print('High ID pointer: ${highIdProps.id}');

    final maxIdProps = AndroidPointerProperties(id: 255, toolType: 1);
    assert(maxIdProps.id == 255);
    print('Max ID pointer: ${maxIdProps.id}');
    recordTest('High pointer ID values', true);
  } catch (e) {
    print('Error: $e');
    recordTest('High pointer ID values', false);
  }

  // Test 10: Properties for multi-touch gesture
  print('\n--- Test 10: Properties for multi-touch gesture ---');
  try {
    // Simulating a pinch gesture with two fingers
    final pinchProps = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
      AndroidPointerProperties(id: 1, toolType: 1),
    ];
    assert(pinchProps.length == 2);
    assert(pinchProps[0].id != pinchProps[1].id);
    print(
      'Pinch gesture with pointers: ${pinchProps[0].id} and ${pinchProps[1].id}',
    );
    recordTest('Properties for multi-touch gesture', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Properties for multi-touch gesture', false);
  }

  // Test 11: Stylus with eraser end
  print('\n--- Test 11: Stylus tool transitions ---');
  try {
    // Regular stylus tip
    final stylusTip = AndroidPointerProperties(id: 0, toolType: 2);
    assert(stylusTip.toolType == 2);
    print('Stylus tip: toolType ${stylusTip.toolType}');

    // Stylus eraser end
    final stylusEraser = AndroidPointerProperties(id: 0, toolType: 4);
    assert(stylusEraser.toolType == 4);
    print('Stylus eraser: toolType ${stylusEraser.toolType}');
    recordTest('Stylus tool transitions', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Stylus tool transitions', false);
  }

  // Print summary
  print('\n========================================');
  print('AndroidPointerProperties Test Summary');
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
        'AndroidPointerProperties Test Results',
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
