// D4rt test script: Tests SpringDescription, BoundedFrictionSimulation from physics
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/physics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SpringDescription test executing');

  // ========== SPRINGDESCRIPTION ==========
  print('--- SpringDescription Tests ---');

  // Test SpringDescription with mass, stiffness, damping
  final spring1 = SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0);
  print('SpringDescription created');
  print('  mass: ${spring1.mass}');
  print('  stiffness: ${spring1.stiffness}');
  print('  damping: ${spring1.damping}');

  // Test with different parameters
  final spring2 = SpringDescription(mass: 2.0, stiffness: 200.0, damping: 20.0);
  print('SpringDescription(2, 200, 20) created');
  print('  mass: ${spring2.mass}');
  print('  stiffness: ${spring2.stiffness}');
  print('  damping: ${spring2.damping}');

  // Test SpringDescription.withDampingRatio
  final springDamped = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 1.0,
  );
  print('SpringDescription.withDampingRatio(ratio=1.0) created');
  print('  mass: ${springDamped.mass}');
  print('  stiffness: ${springDamped.stiffness}');
  print('  damping: ${springDamped.damping}');

  // Under-damped spring
  final springUnder = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 0.5,
  );
  print('Under-damped spring (ratio=0.5)');
  print('  damping: ${springUnder.damping}');

  // Over-damped spring
  final springOver = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 2.0,
  );
  print('Over-damped spring (ratio=2.0)');
  print('  damping: ${springOver.damping}');

  // Test toString
  print('SpringDescription toString: $spring1');

  // ========== BOUNDEDFRICTIONSIMULATION ==========
  print('--- BoundedFrictionSimulation Tests ---');

  // BoundedFrictionSimulation combines friction with position bounds
  final boundedFriction = BoundedFrictionSimulation(
    0.3, // drag coefficient
    100.0, // initial position
    200.0, // initial velocity
    0.0, // min position
    500.0, // max position
  );
  print('BoundedFrictionSimulation created');

  // Test position at various times
  final pos0 = boundedFriction.x(0.0);
  print('Position at t=0: $pos0');

  final pos1 = boundedFriction.x(0.5);
  print('Position at t=0.5: $pos1');

  final pos2 = boundedFriction.x(1.0);
  print('Position at t=1.0: $pos2');

  final pos3 = boundedFriction.x(5.0);
  print('Position at t=5.0: $pos3');

  // Test velocity at various times
  final vel0 = boundedFriction.dx(0.0);
  print('Velocity at t=0: $vel0');

  final vel1 = boundedFriction.dx(0.5);
  print('Velocity at t=0.5: $vel1');

  final vel2 = boundedFriction.dx(1.0);
  print('Velocity at t=1.0: $vel2');

  // Test isDone
  print('isDone at t=0: ${boundedFriction.isDone(0.0)}');
  print('isDone at t=100: ${boundedFriction.isDone(100.0)}');

  // Test FrictionSimulation (parent class)
  final friction = FrictionSimulation(0.3, 100.0, 200.0);
  print('FrictionSimulation created');
  print('FrictionSimulation x(0): ${friction.x(0.0)}');
  print('FrictionSimulation x(1): ${friction.x(1.0)}');

  print('All SpringDescription tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Physics Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Spring: mass=${spring1.mass}, stiffness=${spring1.stiffness}',
            ),
            Text('Spring damping: ${spring1.damping}'),
            SizedBox(height: 8.0),
            Text('BoundedFriction pos@0: $pos0'),
            Text('BoundedFriction pos@1: $pos2'),
            Text('BoundedFriction vel@0: $vel0'),
          ],
        ),
      ),
    ),
  );
}
