// D4rt test script: Tests BoundedFrictionSimulation from physics
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoundedFrictionSimulation test executing');
  final results = <String>[];

  // Test 1: Constructor with positive velocity (moving right)
  final bounded1 = BoundedFrictionSimulation(0.5, 50.0, 100.0, 0.0, 100.0);
  results.add('Test 1: BoundedFrictionSimulation(drag=0.5, pos=50, vel=100, minX=0, maxX=100)');
  print('Created BoundedFrictionSimulation with positive velocity');

  // Test 2: Position at time 0
  final posAtZero = bounded1.x(0.0);
  results.add('Position at t=0: $posAtZero');
  print('Initial position: $posAtZero');
  assert(posAtZero == 50.0, 'Initial position should be 50');

  // Test 3: Velocity at time 0
  final velAtZero = bounded1.dx(0.0);
  results.add('Velocity at t=0: $velAtZero');
  print('Initial velocity: $velAtZero');
  assert(velAtZero == 100.0, 'Initial velocity should be 100');

  // Test 4: Position at later time
  final posAtOne = bounded1.x(1.0);
  results.add('Position at t=1: $posAtOne');
  print('Position at t=1: $posAtOne');
  assert(posAtOne > 50.0, 'Position should increase with positive velocity');

  // Test 5: Velocity decreases due to friction
  final velAtOne = bounded1.dx(1.0);
  results.add('Velocity at t=1: $velAtOne');
  print('Velocity at t=1: $velAtOne');
  assert(velAtOne < 100.0, 'Velocity should decrease due to friction');

  // Test 6: isDone at time 0
  final doneAtZero = bounded1.isDone(0.0);
  results.add('isDone at t=0: $doneAtZero');
  print('isDone at t=0: $doneAtZero');
  assert(doneAtZero == false, 'Should not be done at t=0');

  // Test 7: Constructor with negative velocity (moving left)
  final bounded2 = BoundedFrictionSimulation(0.5, 50.0, -100.0, 0.0, 100.0);
  results.add('Test 7: BoundedFrictionSimulation with negative velocity=-100');
  print('Created BoundedFrictionSimulation with negative velocity');

  // Test 8: Negative velocity at time 0
  final negVelAtZero = bounded2.dx(0.0);
  results.add('Negative velocity at t=0: $negVelAtZero');
  print('Negative velocity: $negVelAtZero');
  assert(negVelAtZero == -100.0, 'Initial negative velocity should be -100');

  // Test 9: Position decreases with negative velocity
  final negPosAtOne = bounded2.x(1.0);
  results.add('Position at t=1 (negative vel): $negPosAtOne');
  print('Position with negative velocity: $negPosAtOne');
  assert(negPosAtOne < 50.0, 'Position should decrease with negative velocity');

  // Test 10: Position bounded by minX
  final negPosAtTen = bounded2.x(10.0);
  results.add('Position at t=10 (bounded by minX): $negPosAtTen');
  print('Position bounded by minX: $negPosAtTen');
  assert(negPosAtTen >= 0.0, 'Position should be bounded by minX=0');

  // Test 11: High drag coefficient
  final bounded3 = BoundedFrictionSimulation(2.0, 50.0, 100.0, 0.0, 100.0);
  results.add('Test 11: BoundedFrictionSimulation with high drag=2.0');
  print('Created BoundedFrictionSimulation with high drag');

  // Test 12: High drag slows down faster
  final highDragVel = bounded3.dx(0.5);
  final lowDragVel = bounded1.dx(0.5);
  results.add('Velocity comparison: highDrag=$highDragVel, lowDrag=$lowDragVel');
  print('High drag velocity vs low drag velocity');
  assert(highDragVel < lowDragVel, 'High drag should slow down faster');

  // Test 13: Low drag coefficient
  final bounded4 = BoundedFrictionSimulation(0.1, 50.0, 100.0, 0.0, 200.0);
  results.add('Test 13: BoundedFrictionSimulation with low drag=0.1');
  print('Created BoundedFrictionSimulation with low drag');

  // Test 14: Low drag maintains velocity longer
  final lowDrag1 = bounded4.dx(1.0);
  results.add('Low drag velocity at t=1: $lowDrag1');
  print('Low drag velocity: $lowDrag1');

  // Test 15: Position bounded by maxX
  final boundedMax = BoundedFrictionSimulation(0.1, 90.0, 100.0, 0.0, 100.0);
  final maxPosAtTen = boundedMax.x(10.0);
  results.add('Test 15: Position bounded by maxX: $maxPosAtTen');
  print('Position bounded by maxX: $maxPosAtTen');
  assert(maxPosAtTen <= 100.0, 'Position should be bounded by maxX=100');

  // Test 16: isDone when velocity approaches zero
  final doneAtFive = bounded3.isDone(5.0);
  results.add('isDone at t=5 (high drag): $doneAtFive');
  print('isDone at t=5 with high drag: $doneAtFive');

  // Test 17: Zero initial velocity
  final bounded5 = BoundedFrictionSimulation(0.5, 50.0, 0.0, 0.0, 100.0);
  results.add('Test 17: Zero initial velocity');
  final zeroVelDone = bounded5.isDone(0.0);
  results.add('isDone with zero velocity: $zeroVelDone');
  print('Zero velocity simulation');

  // Test 18: Position remains constant with zero velocity
  final zeroVelPos = bounded5.x(5.0);
  results.add('Position with zero velocity at t=5: $zeroVelPos');
  print('Position with zero velocity: $zeroVelPos');
  assert(zeroVelPos == 50.0, 'Position should remain constant with zero velocity');

  // Test 19: Very small time delta
  final smallTimePos = bounded1.x(0.001);
  results.add('Position at t=0.001: $smallTimePos');
  print('Position at very small time: $smallTimePos');

  // Test 20: Very small time velocity
  final smallTimeVel = bounded1.dx(0.001);
  results.add('Velocity at t=0.001: $smallTimeVel');
  print('Velocity at very small time: $smallTimeVel');

  print('BoundedFrictionSimulation test completed - ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('BoundedFrictionSimulation Tests (${results.length} tests)',
           style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 12)),
      )),
    ],
  );
}
