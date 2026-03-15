// D4rt test script: Tests RawFloatingCursorPoint from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('RawFloatingCursorPoint test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawFloatingCursorPoint with start state
  print('\n--- Test 1: Create RawFloatingCursorPoint with Start state ---');
  try {
    final point1 = RawFloatingCursorPoint(
      state: FloatingCursorDragState.Start,
      startLocation: const Offset(100.0, 200.0),
      currentLocation: const Offset(100.0, 200.0),
    );
    assert(point1.state == FloatingCursorDragState.Start);
    assert(point1.startLocation == Offset(100.0, 200.0));
    assert(point1.currentLocation == Offset(100.0, 200.0));
    print('Created RawFloatingCursorPoint with Start state');
    print('State: ${point1.state}');
    print('Start location: ${point1.startLocation}');
    print('Current location: ${point1.currentLocation}');
    results.add('Test 1 PASSED: Start state creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Create RawFloatingCursorPoint with Update state
  print('\n--- Test 2: Create RawFloatingCursorPoint with Update state ---');
  try {
    final point2 = RawFloatingCursorPoint(
      state: FloatingCursorDragState.Update,
      startLocation: const Offset(100.0, 200.0),
      currentLocation: const Offset(150.0, 250.0),
    );
    assert(point2.state == FloatingCursorDragState.Update);
    assert(point2.startLocation == Offset(100.0, 200.0));
    assert(point2.currentLocation == Offset(150.0, 250.0));
    print('Created RawFloatingCursorPoint with Update state');
    print('State: ${point2.state}');
    print('Current location moved to: ${point2.currentLocation}');
    results.add('Test 2 PASSED: Update state creation');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Create RawFloatingCursorPoint with End state
  print('\n--- Test 3: Create RawFloatingCursorPoint with End state ---');
  try {
    final point3 = RawFloatingCursorPoint(state: FloatingCursorDragState.End);
    assert(point3.state == FloatingCursorDragState.End);
    print('Created RawFloatingCursorPoint with End state');
    print('State: ${point3.state}');
    print('Start location (null expected): ${point3.startLocation}');
    print('Current location (null expected): ${point3.currentLocation}');
    results.add('Test 3 PASSED: End state creation');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test with different offset values
  print('\n--- Test 4: Test with various offset values ---');
  try {
    final offsets = [
      const Offset(0.0, 0.0),
      const Offset(500.0, 500.0),
      const Offset(-50.0, -50.0),
      const Offset(1000.0, 2000.0),
    ];
    for (int i = 0; i < offsets.length; i++) {
      final point = RawFloatingCursorPoint(
        state: FloatingCursorDragState.Update,
        startLocation: const Offset(0, 0),
        currentLocation: offsets[i],
      );
      assert(point.currentLocation == offsets[i]);
      print('Offset $i: ${offsets[i]} - verified');
    }
    results.add('Test 4 PASSED: Various offset values');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Verify FloatingCursorDragState enum values
  print('\n--- Test 5: Verify FloatingCursorDragState enum values ---');
  try {
    final states = FloatingCursorDragState.values;
    assert(states.contains(FloatingCursorDragState.Start));
    assert(states.contains(FloatingCursorDragState.Update));
    assert(states.contains(FloatingCursorDragState.End));
    assert(states.length == 3);
    print('FloatingCursorDragState values: $states');
    print('Total enum values: ${states.length}');
    results.add('Test 5 PASSED: Enum values verification');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Simulate floating cursor movement sequence
  print('\n--- Test 6: Simulate floating cursor movement sequence ---');
  try {
    final sequence = <RawFloatingCursorPoint>[];
    sequence.add(
      RawFloatingCursorPoint(
        state: FloatingCursorDragState.Start,
        startLocation: const Offset(100, 100),
        currentLocation: const Offset(100, 100),
      ),
    );
    for (int i = 1; i <= 5; i++) {
      sequence.add(
        RawFloatingCursorPoint(
          state: FloatingCursorDragState.Update,
          startLocation: const Offset(100, 100),
          currentLocation: Offset(100.0 + i * 10, 100.0 + i * 5),
        ),
      );
    }
    sequence.add(RawFloatingCursorPoint(state: FloatingCursorDragState.End));
    assert(sequence.length == 7);
    assert(sequence.first.state == FloatingCursorDragState.Start);
    assert(sequence.last.state == FloatingCursorDragState.End);
    print('Simulated ${sequence.length} cursor points');
    for (var p in sequence) {
      print('  State: ${p.state}, Location: ${p.currentLocation}');
    }
    results.add('Test 6 PASSED: Movement sequence simulation');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawFloatingCursorPoint test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RawFloatingCursorPoint Tests',
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
