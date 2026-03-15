// D4rt test script: Tests ClampedSimulation from physics
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClampedSimulation test executing');
  final results = <String>[];

  // Test 1: Create inner simulation (GravitySimulation)
  final innerSim = GravitySimulation(9.8, 0.0, 100.0, 0.0);
  results.add('Test 1: Created inner GravitySimulation');
  print('Created inner GravitySimulation for clamping');

  // Test 2: Create ClampedSimulation with position bounds
  final clamped1 = ClampedSimulation(innerSim, xMin: 0.0, xMax: 50.0);
  results.add('Test 2: ClampedSimulation with xMin=0, xMax=50');
  print('Created ClampedSimulation with position bounds');

  // Test 3: Position at time 0
  final posAtZero = clamped1.x(0.0);
  results.add('Position at t=0: $posAtZero');
  print('Clamped position at t=0: $posAtZero');
  assert(posAtZero >= 0.0, 'Position should be at or above minimum');

  // Test 4: Position clamped to maximum
  final posAtFive = clamped1.x(5.0);
  results.add('Position at t=5 (clamped): $posAtFive');
  print('Clamped position at t=5: $posAtFive');
  assert(posAtFive <= 50.0, 'Position should be clamped to xMax=50');

  // Test 5: Velocity at time 0
  final velAtZero = clamped1.dx(0.0);
  results.add('Velocity at t=0: $velAtZero');
  print('Clamped velocity at t=0: $velAtZero');

  // Test 6: Create with velocity bounds
  final clamped2 = ClampedSimulation(innerSim, dxMin: 0.0, dxMax: 20.0);
  results.add('Test 6: ClampedSimulation with dxMin=0, dxMax=20');
  print('Created ClampedSimulation with velocity bounds');

  // Test 7: Velocity clamped to maximum
  final velClamped = clamped2.dx(10.0);
  results.add('Velocity at t=10 (clamped): $velClamped');
  print('Clamped velocity at t=10: $velClamped');
  assert(velClamped <= 20.0, 'Velocity should be clamped to dxMax=20');

  // Test 8: Velocity clamped to minimum (non-negative)
  final velMin = clamped2.dx(0.0);
  results.add('Velocity at t=0 (min check): $velMin');
  print('Velocity minimum check: $velMin');
  assert(velMin >= 0.0, 'Velocity should be at or above dxMin=0');

  // Test 9: Create with all bounds
  final clamped3 = ClampedSimulation(innerSim, 
    xMin: 0.0, xMax: 30.0, dxMin: -5.0, dxMax: 15.0);
  results.add('Test 9: ClampedSimulation with all bounds');
  print('Created ClampedSimulation with all bounds');

  // Test 10: isDone check
  final doneAtZero = clamped3.isDone(0.0);
  results.add('isDone at t=0: $doneAtZero');
  print('Clamped isDone at t=0: $doneAtZero');

  // Test 11: isDone at later time
  final doneAtFive = clamped3.isDone(5.0);
  results.add('isDone at t=5: $doneAtFive');
  print('Clamped isDone at t=5: $doneAtFive');

  // Test 12: Position with all bounds at small time
  final posSmall = clamped3.x(0.5);
  results.add('Position at t=0.5 (all bounds): $posSmall');
  print('Position with all bounds: $posSmall');

  // Test 13: Create with negative velocity simulation
  final negInner = GravitySimulation(-5.0, 50.0, 0.0, 0.0);
  final clampedNeg = ClampedSimulation(negInner, xMin: 10.0);
  results.add('Test 13: ClampedSimulation with xMin=10 (negative accel)');
  print('Created ClampedSimulation with minimum position bound');

  // Test 14: Minimum position bound enforced
  final posMinClamped = clampedNeg.x(10.0);
  results.add('Position at t=10 (min clamped): $posMinClamped');
  print('Position clamped to minimum: $posMinClamped');
  assert(posMinClamped >= 10.0, 'Position should be clamped to xMin=10');

  // Test 15: No bounds specified (defaults)
  final clampedDefault = ClampedSimulation(innerSim);
  results.add('Test 15: ClampedSimulation with no bounds');
  print('Created ClampedSimulation with default bounds');

  // Test 16: Default behavior follows inner simulation
  final defaultPos = clampedDefault.x(1.0);
  final innerPos = innerSim.x(1.0);
  results.add('Default clamped pos: $defaultPos, inner: $innerPos');
  print('Comparing default clamped vs inner simulation');

  // Test 17: Velocity bounds with negative dxMin
  final clampedNegDx = ClampedSimulation(negInner, dxMin: -10.0, dxMax: 0.0);
  results.add('Test 17: ClampedSimulation with dxMin=-10, dxMax=0');

  // Test 18: Negative velocity clamped
  final negVelClamped = clampedNegDx.dx(1.0);
  results.add('Negative velocity clamped: $negVelClamped');
  print('Clamped negative velocity: $negVelClamped');
  assert(negVelClamped >= -10.0, 'Velocity should be >= dxMin');
  assert(negVelClamped <= 0.0, 'Velocity should be <= dxMax');

  // Test 19: Position at large time (should saturate)
  final posLarge = clamped1.x(100.0);
  results.add('Position at t=100: $posLarge');
  print('Position at large time: $posLarge');
  assert(posLarge <= 50.0, 'Position should remain clamped');

  // Test 20: Multiple time queries consistency
  final pos1 = clamped3.x(2.0);
  final pos2 = clamped3.x(2.0);
  results.add('Position consistency: $pos1 == $pos2');
  print('Position query consistency check');

  print('ClampedSimulation test completed - ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('ClampedSimulation Tests (${results.length} tests)',
           style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 12)),
      )),
    ],
  );
}
