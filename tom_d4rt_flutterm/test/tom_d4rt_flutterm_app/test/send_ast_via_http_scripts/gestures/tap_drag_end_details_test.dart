// D4rt test script: Tests TapDragEndDetails from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragEndDetails comprehensive test executing');
  final results = <String>[];

  // ========== TapDragEndDetails Tests ==========
  print('Testing TapDragEndDetails...');

  // Test 1: Create TapDragEndDetails
  final details = TapDragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(500.0, 300.0)),
    consecutiveTapCount: 1,
  );
  assert(details != null, 'Should create details');
  results.add('TapDragEndDetails created');
  print('TapDragEndDetails created');

  // Test 2: Velocity property
  assert(
    details.velocity.pixelsPerSecond == Offset(500.0, 300.0),
    'Velocity should match',
  );
  results.add('Velocity: ${details.velocity.pixelsPerSecond}');
  print('Velocity: ${details.velocity.pixelsPerSecond}');

  // Test 3: Consecutive tap count
  assert(details.consecutiveTapCount == 1, 'Count should be 1');
  results.add('Consecutive tap count: ${details.consecutiveTapCount}');
  print('Consecutive tap count: ${details.consecutiveTapCount}');

  // Test 4: Velocity speed (magnitude)
  final speed = details.velocity.pixelsPerSecond.distance;
  results.add('Speed: ${speed.toStringAsFixed(2)} px/s');
  print('Velocity speed: ${speed.toStringAsFixed(2)} px/s');

  // Test 5: Velocity direction
  final velDirection = details.velocity.pixelsPerSecond.direction;
  results.add('Velocity direction: ${velDirection.toStringAsFixed(4)} rad');
  print('Velocity direction: ${velDirection.toStringAsFixed(4)} radians');

  // Test 6: Double tap drag end
  final doubleTapEnd = TapDragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(800.0, 400.0)),
    consecutiveTapCount: 2,
  );
  assert(doubleTapEnd.consecutiveTapCount == 2, 'Count should be 2');
  results.add('Double tap end: count=${doubleTapEnd.consecutiveTapCount}');
  print('Double tap drag end: count=${doubleTapEnd.consecutiveTapCount}');

  // Test 7: Zero velocity (slow end)
  final slowEnd = TapDragEndDetails(
    velocity: Velocity.zero,
    consecutiveTapCount: 1,
  );
  assert(slowEnd.velocity == Velocity.zero, 'Velocity should be zero');
  results.add('Zero velocity end');
  print('Slow drag end: velocity=${slowEnd.velocity.pixelsPerSecond}');

  // Test 8: Velocity.zero properties
  assert(
    Velocity.zero.pixelsPerSecond == Offset.zero,
    'Zero velocity should be zero offset',
  );
  results.add('Velocity.zero: ${Velocity.zero.pixelsPerSecond}');
  print('Velocity.zero: ${Velocity.zero.pixelsPerSecond}');

  // Test 9: Fling detection concept
  final kMinFlingVelocity = 50.0;
  final isFling = speed > kMinFlingVelocity;
  results.add('Is fling (>$kMinFlingVelocity): $isFling');
  print('Fling detection: $isFling');

  // Test 10: Max fling velocity concept
  final kMaxFlingVelocity = 8000.0;
  final cappedSpeed = speed.clamp(0.0, kMaxFlingVelocity);
  results.add('Capped speed: ${cappedSpeed.toStringAsFixed(2)}');
  print(
    'Capped velocity: ${cappedSpeed.toStringAsFixed(2)} px/s (max $kMaxFlingVelocity)',
  );

  // Test 11: Horizontal velocity component
  final horizontalVel = details.velocity.pixelsPerSecond.dx;
  results.add('Horizontal velocity: $horizontalVel px/s');
  print('Horizontal velocity: $horizontalVel px/s');

  // Test 12: Vertical velocity component
  final verticalVel = details.velocity.pixelsPerSecond.dy;
  results.add('Vertical velocity: $verticalVel px/s');
  print('Vertical velocity: $verticalVel px/s');

  // Test 13: High velocity fling
  final fastFling = TapDragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(3000.0, 2000.0)),
    consecutiveTapCount: 1,
  );
  final fastSpeed = fastFling.velocity.pixelsPerSecond.distance;
  results.add('Fast fling speed: ${fastSpeed.toStringAsFixed(0)} px/s');
  print('Fast fling: ${fastSpeed.toStringAsFixed(0)} px/s');

  // Test 14: Triple tap drag end
  final tripleTapEnd = TapDragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(200.0, 100.0)),
    consecutiveTapCount: 3,
  );
  assert(tripleTapEnd.consecutiveTapCount == 3, 'Count should be 3');
  results.add('Triple tap end: count=${tripleTapEnd.consecutiveTapCount}');
  print('Triple tap drag end: count=${tripleTapEnd.consecutiveTapCount}');

  // Test 15: Velocity for animation
  final animationDuration = 300; // milliseconds
  final travelDistance = speed * (animationDuration / 1000.0);
  results.add(
    'Travel estimate: ${travelDistance.toStringAsFixed(2)} px over ${animationDuration}ms',
  );
  print('Animation travel: ${travelDistance.toStringAsFixed(2)} px');

  // Test 16: Dominant axis detection
  final isHorizontalFling = horizontalVel.abs() > verticalVel.abs();
  results.add('Horizontal fling: $isHorizontalFling');
  print('Dominant axis horizontal: $isHorizontalFling');

  // Test 17: Velocity negation for reverse
  final reversed = Velocity(pixelsPerSecond: -details.velocity.pixelsPerSecond);
  results.add('Reversed velocity: ${reversed.pixelsPerSecond}');
  print('Reversed velocity: ${reversed.pixelsPerSecond}');

  // Test 18: Callback pattern
  TapDragEndDetails? capturedEnd;
  void onDragEnd(TapDragEndDetails d) {
    capturedEnd = d;
  }

  onDragEnd(details);
  assert(capturedEnd != null, 'Should capture end');
  results.add('Callback pattern works');
  print('Callback captured end details');

  // Test 19: Velocity scaling
  final scaledVel = Offset(horizontalVel * 0.5, verticalVel * 0.5);
  results.add('Scaled velocity (50%): $scaledVel');
  print('Scaled velocity: $scaledVel');

  // Test 20: Summary
  results.add('Properties: velocity, consecutiveTapCount');
  print(
    'TapDragEndDetails: velocity for fling animations, tap count for multi-tap-drag',
  );

  print('TapDragEndDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapDragEndDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Properties: velocity, consecutiveTapCount'),
      Text('Velocity: pixelsPerSecond, speed, direction'),
      Text('Fling: detect and animate based on velocity'),
      Text('Usage: onDragEnd callback'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
