// D4rt test script: Tests AndroidPointerCoords from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidPointerCoords comprehensive test executing');
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

  // Test 1: Basic AndroidPointerCoords creation
  print('\n--- Test 1: Basic AndroidPointerCoords creation ---');
  try {
    final coords = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 1.0,
      size: 0.5,
      toolMajor: 10.0,
      toolMinor: 10.0,
      touchMajor: 15.0,
      touchMinor: 15.0,
      x: 100.0,
      y: 200.0,
    );
    assert(coords.x == 100.0);
    assert(coords.y == 200.0);
    assert(coords.pressure == 1.0);
    assert(coords.size == 0.5);
    print('Created coords at (${coords.x}, ${coords.y})');
    print('Pressure: ${coords.pressure}, Size: ${coords.size}');
    recordTest('Basic AndroidPointerCoords creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Basic AndroidPointerCoords creation', false);
  }

  // Test 2: Orientation property
  print('\n--- Test 2: Orientation property ---');
  try {
    final coords1 = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 1.0,
      size: 0.5,
      toolMajor: 10.0,
      toolMinor: 10.0,
      touchMajor: 15.0,
      touchMinor: 15.0,
      x: 0.0,
      y: 0.0,
    );
    assert(coords1.orientation == 0.0);
    print('Orientation at 0: ${coords1.orientation}');

    final coords2 = AndroidPointerCoords(
      orientation: 1.5708,
      pressure: 1.0,
      size: 0.5,
      toolMajor: 10.0,
      toolMinor: 10.0,
      touchMajor: 15.0,
      touchMinor: 15.0,
      x: 0.0,
      y: 0.0,
    );
    assert(coords2.orientation == 1.5708);
    print('Orientation at π/2: ${coords2.orientation}');

    final coords3 = AndroidPointerCoords(
      orientation: -1.5708,
      pressure: 1.0,
      size: 0.5,
      toolMajor: 10.0,
      toolMinor: 10.0,
      touchMajor: 15.0,
      touchMinor: 15.0,
      x: 0.0,
      y: 0.0,
    );
    assert(coords3.orientation == -1.5708);
    print('Orientation at -π/2: ${coords3.orientation}');
    recordTest('Orientation property handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Orientation property handling', false);
  }

  // Test 3: Pressure values
  print('\n--- Test 3: Pressure values ---');
  try {
    // Light pressure
    final lightCoords = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 0.1,
      size: 0.3,
      toolMajor: 5.0,
      toolMinor: 5.0,
      touchMajor: 8.0,
      touchMinor: 8.0,
      x: 50.0,
      y: 50.0,
    );
    assert(lightCoords.pressure == 0.1);
    print('Light pressure: ${lightCoords.pressure}');

    // Medium pressure
    final mediumCoords = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 0.5,
      size: 0.5,
      toolMajor: 10.0,
      toolMinor: 10.0,
      touchMajor: 15.0,
      touchMinor: 15.0,
      x: 100.0,
      y: 100.0,
    );
    assert(mediumCoords.pressure == 0.5);
    print('Medium pressure: ${mediumCoords.pressure}');

    // Full pressure
    final fullCoords = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 1.0,
      size: 0.8,
      toolMajor: 15.0,
      toolMinor: 15.0,
      touchMajor: 20.0,
      touchMinor: 20.0,
      x: 150.0,
      y: 150.0,
    );
    assert(fullCoords.pressure == 1.0);
    print('Full pressure: ${fullCoords.pressure}');
    recordTest('Pressure values handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Pressure values handling', false);
  }

  // Test 4: Tool dimensions
  print('\n--- Test 4: Tool dimensions ---');
  try {
    final coords = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 1.0,
      size: 0.5,
      toolMajor: 20.0,
      toolMinor: 15.0,
      touchMajor: 25.0,
      touchMinor: 20.0,
      x: 200.0,
      y: 200.0,
    );
    assert(coords.toolMajor == 20.0);
    assert(coords.toolMinor == 15.0);
    print('Tool major: ${coords.toolMajor}');
    print('Tool minor: ${coords.toolMinor}');
    assert(coords.toolMajor >= coords.toolMinor);
    recordTest('Tool dimensions handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Tool dimensions handling', false);
  }

  // Test 5: Touch dimensions
  print('\n--- Test 5: Touch dimensions ---');
  try {
    final coords = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 1.0,
      size: 0.6,
      toolMajor: 12.0,
      toolMinor: 10.0,
      touchMajor: 18.0,
      touchMinor: 14.0,
      x: 250.0,
      y: 250.0,
    );
    assert(coords.touchMajor == 18.0);
    assert(coords.touchMinor == 14.0);
    print('Touch major: ${coords.touchMajor}');
    print('Touch minor: ${coords.touchMinor}');
    assert(coords.touchMajor >= coords.touchMinor);
    recordTest('Touch dimensions handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Touch dimensions handling', false);
  }

  // Test 6: Size property
  print('\n--- Test 6: Size property ---');
  try {
    final smallTouch = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 0.5,
      size: 0.2,
      toolMajor: 5.0,
      toolMinor: 5.0,
      touchMajor: 8.0,
      touchMinor: 8.0,
      x: 300.0,
      y: 300.0,
    );
    assert(smallTouch.size == 0.2);
    print('Small touch size: ${smallTouch.size}');

    final largeTouch = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 1.0,
      size: 0.9,
      toolMajor: 25.0,
      toolMinor: 25.0,
      touchMajor: 30.0,
      touchMinor: 30.0,
      x: 350.0,
      y: 350.0,
    );
    assert(largeTouch.size == 0.9);
    print('Large touch size: ${largeTouch.size}');
    recordTest('Size property handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Size property handling', false);
  }

  // Test 7: Coordinate edge cases
  print('\n--- Test 7: Coordinate edge cases ---');
  try {
    // Zero coordinates
    final zeroCoords = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 1.0,
      size: 0.5,
      toolMajor: 10.0,
      toolMinor: 10.0,
      touchMajor: 15.0,
      touchMinor: 15.0,
      x: 0.0,
      y: 0.0,
    );
    assert(zeroCoords.x == 0.0);
    assert(zeroCoords.y == 0.0);
    print('Zero coords: (${zeroCoords.x}, ${zeroCoords.y})');

    // Large coordinates
    final largeCoords = AndroidPointerCoords(
      orientation: 0.0,
      pressure: 1.0,
      size: 0.5,
      toolMajor: 10.0,
      toolMinor: 10.0,
      touchMajor: 15.0,
      touchMinor: 15.0,
      x: 2560.0,
      y: 1440.0,
    );
    assert(largeCoords.x == 2560.0);
    assert(largeCoords.y == 1440.0);
    print('Large screen coords: (${largeCoords.x}, ${largeCoords.y})');
    recordTest('Coordinate edge cases', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Coordinate edge cases', false);
  }

  // Test 8: Multiple pointer scenarios
  print('\n--- Test 8: Multiple pointer scenarios ---');
  try {
    final coordsList = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 100.0,
        y: 100.0,
      ),
      AndroidPointerCoords(
        orientation: 0.5,
        pressure: 0.8,
        size: 0.4,
        toolMajor: 8.0,
        toolMinor: 8.0,
        touchMajor: 12.0,
        touchMinor: 12.0,
        x: 300.0,
        y: 300.0,
      ),
      AndroidPointerCoords(
        orientation: -0.5,
        pressure: 0.9,
        size: 0.45,
        toolMajor: 9.0,
        toolMinor: 9.0,
        touchMajor: 14.0,
        touchMinor: 14.0,
        x: 500.0,
        y: 200.0,
      ),
    ];
    assert(coordsList.length == 3);
    print('Created ${coordsList.length} pointer coords');
    for (int i = 0; i < coordsList.length; i++) {
      print('Pointer $i: (${coordsList[i].x}, ${coordsList[i].y})');
    }
    recordTest('Multiple pointer scenarios', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Multiple pointer scenarios', false);
  }

  // Print summary
  print('\n========================================');
  print('AndroidPointerCoords Test Summary');
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
        'AndroidPointerCoords Test Results',
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
