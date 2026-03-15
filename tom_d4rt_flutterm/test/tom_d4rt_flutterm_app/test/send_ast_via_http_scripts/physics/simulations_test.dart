// D4rt test script: Tests SpringSimulation, ScrollSpringSimulation, FrictionSimulation from physics
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/physics.dart';

dynamic build(BuildContext context) {
  print('Physics simulations test executing');

  // ========== SPRINGSIMULATION ==========
  print('--- SpringSimulation Tests ---');

  // Create a spring description
  final springDesc = SpringDescription(
    mass: 1.0,
    stiffness: 100.0,
    damping: 10.0,
  );
  print(
    'SpringDescription: mass=${springDesc.mass}, stiffness=${springDesc.stiffness}, damping=${springDesc.damping}',
  );

  // SpringSimulation: start at position 0, target 1, initial velocity 0
  final springSim = SpringSimulation(springDesc, 0.0, 1.0, 0.0);
  print('SpringSimulation(spring, start=0, end=1, velocity=0):');
  for (final t in [0.0, 0.1, 0.2, 0.5, 1.0, 2.0, 3.0, 5.0]) {
    print(
      '  t=$t: x=${springSim.x(t).toStringAsFixed(4)}, dx=${springSim.dx(t).toStringAsFixed(4)}, isDone=${springSim.isDone(t)}',
    );
  }

  // SpringSimulation with initial velocity
  final springSimVelocity = SpringSimulation(springDesc, 0.0, 1.0, 5.0);
  print('SpringSimulation(spring, start=0, end=1, velocity=5):');
  for (final t in [0.0, 0.1, 0.2, 0.5, 1.0, 2.0]) {
    print(
      '  t=$t: x=${springSimVelocity.x(t).toStringAsFixed(4)}, dx=${springSimVelocity.dx(t).toStringAsFixed(4)}',
    );
  }

  // SpringSimulation with critically damped spring
  final criticalSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 1.0,
  );
  final criticalSim = SpringSimulation(criticalSpring, 0.0, 1.0, 0.0);
  print('Critically damped SpringSimulation:');
  for (final t in [0.0, 0.1, 0.2, 0.5, 1.0, 2.0]) {
    print(
      '  t=$t: x=${criticalSim.x(t).toStringAsFixed(4)}, isDone=${criticalSim.isDone(t)}',
    );
  }

  // SpringSimulation with underdamped spring
  final underSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 0.3,
  );
  final underSim = SpringSimulation(underSpring, 0.0, 1.0, 0.0);
  print('Underdamped SpringSimulation (ratio=0.3):');
  for (final t in [0.0, 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.5, 2.0]) {
    print('  t=$t: x=${underSim.x(t).toStringAsFixed(4)}');
  }

  // SpringSimulation with overdamped spring
  final overSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 2.0,
  );
  final overSim = SpringSimulation(overSpring, 0.0, 1.0, 0.0);
  print('Overdamped SpringSimulation (ratio=2.0):');
  for (final t in [0.0, 0.1, 0.5, 1.0, 2.0, 5.0]) {
    print('  t=$t: x=${overSim.x(t).toStringAsFixed(4)}');
  }

  // ========== SCROLLSPRINGSIMULATION ==========
  print('--- ScrollSpringSimulation Tests ---');

  // ScrollSpringSimulation extends SpringSimulation with clamping
  final scrollSpring = SpringDescription(
    mass: 1.0,
    stiffness: 100.0,
    damping: 15.0,
  );

  final scrollSim = ScrollSpringSimulation(scrollSpring, 0.0, 1.0, 0.0);
  print('ScrollSpringSimulation(spring, start=0, end=1, velocity=0):');
  for (final t in [0.0, 0.1, 0.2, 0.5, 1.0, 2.0, 3.0]) {
    print(
      '  t=$t: x=${scrollSim.x(t).toStringAsFixed(4)}, dx=${scrollSim.dx(t).toStringAsFixed(4)}, isDone=${scrollSim.isDone(t)}',
    );
  }

  // ScrollSpringSimulation with initial velocity
  final scrollSimVelocity = ScrollSpringSimulation(
    scrollSpring,
    0.0,
    1.0,
    10.0,
  );
  print('ScrollSpringSimulation(spring, start=0, end=1, velocity=10):');
  for (final t in [0.0, 0.1, 0.2, 0.5, 1.0]) {
    print('  t=$t: x=${scrollSimVelocity.x(t).toStringAsFixed(4)}');
  }

  // ScrollSpringSimulation going backwards
  final scrollSimBack = ScrollSpringSimulation(scrollSpring, 1.0, 0.0, 0.0);
  print('ScrollSpringSimulation(spring, start=1, end=0, velocity=0):');
  for (final t in [0.0, 0.1, 0.5, 1.0, 2.0]) {
    print('  t=$t: x=${scrollSimBack.x(t).toStringAsFixed(4)}');
  }

  // ========== FRICTIONSIMULATION ==========
  print('--- FrictionSimulation Tests ---');

  // FrictionSimulation: drag coefficient, initial position, initial velocity
  final frictionSim = FrictionSimulation(0.135, 0.0, 100.0);
  print('FrictionSimulation(drag=0.135, position=0, velocity=100):');
  for (final t in [0.0, 0.1, 0.5, 1.0, 2.0, 5.0, 10.0]) {
    print(
      '  t=$t: x=${frictionSim.x(t).toStringAsFixed(4)}, dx=${frictionSim.dx(t).toStringAsFixed(4)}, isDone=${frictionSim.isDone(t)}',
    );
  }

  // FrictionSimulation with stronger drag
  final strongFriction = FrictionSimulation(0.5, 0.0, 100.0);
  print('FrictionSimulation(drag=0.5, position=0, velocity=100):');
  for (final t in [0.0, 0.1, 0.5, 1.0, 2.0, 5.0]) {
    print(
      '  t=$t: x=${strongFriction.x(t).toStringAsFixed(4)}, dx=${strongFriction.dx(t).toStringAsFixed(4)}',
    );
  }

  // FrictionSimulation with weak drag
  final weakFriction = FrictionSimulation(0.02, 0.0, 100.0);
  print('FrictionSimulation(drag=0.02, position=0, velocity=100):');
  for (final t in [0.0, 0.1, 0.5, 1.0, 2.0]) {
    print('  t=$t: x=${weakFriction.x(t).toStringAsFixed(4)}');
  }

  // FrictionSimulation with negative velocity
  final negFriction = FrictionSimulation(0.135, 100.0, -50.0);
  print('FrictionSimulation(drag=0.135, position=100, velocity=-50):');
  for (final t in [0.0, 0.1, 0.5, 1.0, 2.0]) {
    print(
      '  t=$t: x=${negFriction.x(t).toStringAsFixed(4)}, dx=${negFriction.dx(t).toStringAsFixed(4)}',
    );
  }

  // FrictionSimulation.through - creates simulation that reaches a specific point
  final throughSim = FrictionSimulation.through(0.0, 500.0, 100.0, 10.0);
  print(
    'FrictionSimulation.through(start=0, end=500, startVel=100, endVel=10):',
  );
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  t=$t: x=${throughSim.x(t).toStringAsFixed(4)}');
  }

  // ========== GRAVITYSIMULATION ==========
  print('--- GravitySimulation Tests ---');

  // GravitySimulation(acceleration, distance, endDistance, velocity)
  final gravitySim = GravitySimulation(9.8, 0.0, 100.0, 0.0);
  print(
    'GravitySimulation(accel=9.8, distance=0, endDistance=100, velocity=0):',
  );
  for (final t in [0.0, 0.5, 1.0, 2.0, 3.0, 4.0]) {
    print(
      '  t=$t: x=${gravitySim.x(t).toStringAsFixed(4)}, dx=${gravitySim.dx(t).toStringAsFixed(4)}, isDone=${gravitySim.isDone(t)}',
    );
  }

  // GravitySimulation with initial velocity upward
  final gravityUp = GravitySimulation(9.8, 0.0, 100.0, -20.0);
  print(
    'GravitySimulation(accel=9.8, distance=0, endDistance=100, velocity=-20):',
  );
  for (final t in [0.0, 1.0, 2.0, 3.0, 4.0]) {
    print('  t=$t: x=${gravityUp.x(t).toStringAsFixed(4)}');
  }

  // ========== TOLERANCE ==========
  print('--- Tolerance in Simulations ---');

  final customTolerance = Tolerance(distance: 0.01, time: 0.01, velocity: 0.01);
  print(
    'Custom Tolerance: distance=${customTolerance.distance}, time=${customTolerance.time}, velocity=${customTolerance.velocity}',
  );

  // SpringSimulation with custom tolerance
  final tolerantSim = SpringSimulation(
    springDesc,
    0.0,
    1.0,
    0.0,
    tolerance: customTolerance,
  );
  print('SpringSimulation with tight tolerance:');
  for (final t in [0.0, 0.5, 1.0, 2.0, 3.0]) {
    print(
      '  t=$t: x=${tolerantSim.x(t).toStringAsFixed(4)}, isDone=${tolerantSim.isDone(t)}',
    );
  }

  // ========== WIDGET TREE ==========
  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Physics Simulations Test Results',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 16.0),

          // SpringSimulation visualization
          Text(
            'SpringSimulation (underdamped):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _simulationChart(underSim, 0.0, 3.0, 21, Color(0xFF2196F3)),
          SizedBox(height: 12.0),

          // Critically damped
          Text(
            'SpringSimulation (critically damped):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _simulationChart(criticalSim, 0.0, 3.0, 21, Color(0xFF4CAF50)),
          SizedBox(height: 12.0),

          // Overdamped
          Text(
            'SpringSimulation (overdamped):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _simulationChart(overSim, 0.0, 5.0, 21, Color(0xFFFF9800)),
          SizedBox(height: 12.0),

          // ScrollSpringSimulation
          Text(
            'ScrollSpringSimulation:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _simulationChart(scrollSim, 0.0, 3.0, 21, Color(0xFF9C27B0)),
          SizedBox(height: 12.0),

          // FrictionSimulation
          Text(
            'FrictionSimulation (drag=0.135):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _frictionChart(frictionSim, 0.0, 5.0, 21, Color(0xFFE91E63)),
          SizedBox(height: 16.0),

          // Legend
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF5F5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Simulation Types:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                SizedBox(height: 4.0),
                _simulationRow(
                  'Spring',
                  'Oscillates toward target (F = -kx - cv)',
                  Color(0xFF2196F3),
                ),
                SizedBox(height: 2.0),
                _simulationRow(
                  'ScrollSpring',
                  'Spring with scroll clamping behavior',
                  Color(0xFF9C27B0),
                ),
                SizedBox(height: 2.0),
                _simulationRow(
                  'Friction',
                  'Decelerates with drag coefficient',
                  Color(0xFFE91E63),
                ),
                SizedBox(height: 2.0),
                _simulationRow(
                  'Gravity',
                  'Constant acceleration (free fall)',
                  Color(0xFFFF9800),
                ),
                SizedBox(height: 8.0),
                Text(
                  '• x(t) = position at time t',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• dx(t) = velocity at time t',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• isDone(t) = within tolerance of target',
                  style: TextStyle(fontSize: 11.0),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _simulationChart(
  Simulation sim,
  double tStart,
  double tEnd,
  int steps,
  Color color,
) {
  final stepSize = (tEnd - tStart) / (steps - 1);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      for (int i = 0; i < steps; i++)
        Expanded(
          child: Container(
            // x() goes from 0 to ~1 for spring sims, scale to 50px max
            height: (sim.x(tStart + i * stepSize).clamp(0.0, 1.5) * 40 + 5),
            margin: EdgeInsets.symmetric(horizontal: 0.5),
            color: color,
          ),
        ),
    ],
  );
}

Widget _frictionChart(
  Simulation sim,
  double tStart,
  double tEnd,
  int steps,
  Color color,
) {
  final stepSize = (tEnd - tStart) / (steps - 1);
  // Friction sim can have large x values, normalize
  final maxX = sim.x(tEnd);
  final scale = maxX > 0 ? 50.0 / maxX : 1.0;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      for (int i = 0; i < steps; i++)
        Expanded(
          child: Container(
            height: (sim.x(tStart + i * stepSize) * scale).clamp(5.0, 55.0),
            margin: EdgeInsets.symmetric(horizontal: 0.5),
            color: color,
          ),
        ),
    ],
  );
}

Widget _simulationRow(String name, String description, Color color) {
  return Row(
    children: [
      Container(width: 12.0, height: 12.0, color: color),
      SizedBox(width: 8.0),
      Text(name, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
      SizedBox(width: 8.0),
      Expanded(child: Text('- $description', style: TextStyle(fontSize: 11.0))),
    ],
  );
}
