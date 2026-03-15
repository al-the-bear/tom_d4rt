// D4rt test script: Tests GravitySimulation from physics
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GravitySimulation test executing');
  final results = <String>[];

  // Test 1: Constructor with positive acceleration (falling down)
  final gravity1 = GravitySimulation(9.8, 0.0, 100.0, 0.0);
  results.add('Test 1: Constructor with acceleration=9.8, distance=0, endDistance=100, velocity=0');
  print('Created GravitySimulation: acceleration=9.8, distance=0, endDistance=100, velocity=0');

  // Test 2: x(time) - position at time
  final posAtZero = gravity1.x(0.0);
  results.add('Position at t=0: $posAtZero');
  print('Position at t=0: $posAtZero');
  assert(posAtZero == 0.0, 'Position at t=0 should be initial distance (0)');

  // Test 3: x(time) at later time
  final posAtOne = gravity1.x(1.0);
  results.add('Position at t=1: $posAtOne');
  print('Position at t=1: $posAtOne');
  // With v0=0 and a=9.8, x(1) = 0 + 0*1 + 0.5*9.8*1^2 = 4.9
  assert(posAtOne > 0.0, 'Position should increase with positive acceleration');

  // Test 4: dx(time) - velocity at time
  final velAtZero = gravity1.dx(0.0);
  results.add('Velocity at t=0: $velAtZero');
  print('Velocity at t=0: $velAtZero');
  assert(velAtZero == 0.0, 'Initial velocity should be 0');

  // Test 5: dx(time) at later time
  final velAtOne = gravity1.dx(1.0);
  results.add('Velocity at t=1: $velAtOne');
  print('Velocity at t=1: $velAtOne');
  // v(1) = v0 + a*t = 0 + 9.8*1 = 9.8
  assert(velAtOne > 0.0, 'Velocity should increase with positive acceleration');

  // Test 6: isDone(time) - check if simulation completed
  final doneAtZero = gravity1.isDone(0.0);
  results.add('isDone at t=0: $doneAtZero');
  print('isDone at t=0: $doneAtZero');
  assert(doneAtZero == false, 'Simulation should not be done at t=0');

  // Test 7: Constructor with initial velocity
  final gravity2 = GravitySimulation(9.8, 0.0, 100.0, 5.0);
  results.add('Test 7: Constructor with initial velocity=5');
  print('Created GravitySimulation with initial velocity=5');

  // Test 8: Verify initial velocity is used
  final velWithInitial = gravity2.dx(0.0);
  results.add('Initial velocity from constructor: $velWithInitial');
  print('Initial velocity: $velWithInitial');
  assert(velWithInitial == 5.0, 'Initial velocity should be 5.0');

  // Test 9: Position with initial velocity
  final posWithVel = gravity2.x(1.0);
  results.add('Position at t=1 with v0=5: $posWithVel');
  print('Position at t=1 with initial velocity: $posWithVel');
  // x(1) = 0 + 5*1 + 0.5*9.8*1^2 = 5 + 4.9 = 9.9
  assert(posWithVel > posAtOne, 'Position should be greater with initial velocity');

  // Test 10: Negative acceleration (deceleration)
  final gravity3 = GravitySimulation(-9.8, 100.0, 0.0, 0.0);
  results.add('Test 10: Negative acceleration');
  print('Created GravitySimulation with negative acceleration');

  // Test 11: Verify negative acceleration behavior
  final negVelAtOne = gravity3.dx(1.0);
  results.add('Velocity at t=1 with negative accel: $negVelAtOne');
  print('Velocity with negative acceleration at t=1: $negVelAtOne');
  assert(negVelAtOne < 0.0, 'Velocity should be negative with negative acceleration');

  // Test 12: Position changes with negative acceleration
  final negPosAtOne = gravity3.x(1.0);
  results.add('Position at t=1 with negative accel: $negPosAtOne');
  print('Position with negative acceleration at t=1: $negPosAtOne');

  // Test 13: Large time value
  final posAtTen = gravity1.x(10.0);
  results.add('Position at t=10: $posAtTen');
  print('Position at t=10: $posAtTen');
  assert(posAtTen > posAtOne, 'Position should continue increasing');

  // Test 14: Velocity at large time
  final velAtTen = gravity1.dx(10.0);
  results.add('Velocity at t=10: $velAtTen');
  print('Velocity at t=10: $velAtTen');

  // Test 15: Small time value
  final posAtSmall = gravity1.x(0.1);
  results.add('Position at t=0.1: $posAtSmall');
  print('Position at t=0.1: $posAtSmall');
  assert(posAtSmall >= 0.0, 'Position should be non-negative');

  // Test 16: Check isDone at large time (should be done when past endDistance)
  final doneCheck = gravity1.isDone(10.0);
  results.add('isDone at t=10: $doneCheck');
  print('isDone at t=10: $doneCheck');

  // Test 17: Zero acceleration
  final gravity4 = GravitySimulation(0.0, 0.0, 100.0, 10.0);
  results.add('Test 17: Zero acceleration, v0=10');

  // Test 18: Constant velocity with zero acceleration
  final constVel = gravity4.dx(5.0);
  results.add('Velocity at t=5 with a=0: $constVel');
  print('Velocity with zero acceleration: $constVel');

  print('GravitySimulation test completed - ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('GravitySimulation Tests (${results.length} tests)', 
           style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 12)),
      )),
    ],
  );
}
