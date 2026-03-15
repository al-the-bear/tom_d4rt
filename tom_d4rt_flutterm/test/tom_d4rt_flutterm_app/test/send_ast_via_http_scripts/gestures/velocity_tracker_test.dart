// D4rt test script: Tests VelocityTracker(kind) from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VelocityTracker test executing');
  final results = <String>[];

  // ========== VelocityTracker Tests ==========
  print('Testing VelocityTracker...');

  // Test 1: Create VelocityTracker with touch kind
  final tracker1 = VelocityTracker.withKind(PointerDeviceKind.touch);
  assert(tracker1 != null, 'Should create VelocityTracker');
  results.add('VelocityTracker(touch) created');
  print('VelocityTracker with touch kind created');

  // Test 2: Create VelocityTracker with mouse kind
  final tracker2 = VelocityTracker.withKind(PointerDeviceKind.mouse);
  assert(tracker2 != null, 'Should create VelocityTracker');
  results.add('VelocityTracker(mouse) created');
  print('VelocityTracker with mouse kind created');

  // Test 3: Add single position sample
  final time1 = Duration(milliseconds: 0);
  final pos1 = Offset(100.0, 100.0);
  tracker1.addPosition(time1, pos1);
  results.add('Added position: $pos1 at $time1');
  print('Added first position: $pos1 at $time1');

  // Test 4: Add second position sample
  final time2 = Duration(milliseconds: 16);
  final pos2 = Offset(150.0, 120.0);
  tracker1.addPosition(time2, pos2);
  results.add('Added position: $pos2 at $time2');
  print('Added second position: $pos2 at $time2');

  // Test 5: Add third position sample
  final time3 = Duration(milliseconds: 32);
  final pos3 = Offset(200.0, 140.0);
  tracker1.addPosition(time3, pos3);
  results.add('Added position: $pos3 at $time3');
  print('Added third position: $pos3 at $time3');

  // Test 6: Get velocity estimate
  final estimate = tracker1.getVelocityEstimate();
  if (estimate != null) {
    results.add('Velocity estimate: ${estimate.pixelsPerSecond}');
    print('Velocity estimate: ${estimate.pixelsPerSecond}');
  } else {
    results.add('Velocity estimate: null (need more samples)');
    print('Velocity estimate: null');
  }

  // Test 7: Get velocity (with Velocity.zero fallback)
  final velocity = tracker1.getVelocity();
  results.add('Velocity: ${velocity.pixelsPerSecond}');
  print('Velocity: ${velocity.pixelsPerSecond}');

  // Test 8: Calculate expected velocity manually
  final timeDelta = (time3 - time1).inMilliseconds / 1000.0; // in seconds
  final posDelta = pos3 - pos1;
  final expectedVelX = posDelta.dx / timeDelta;
  final expectedVelY = posDelta.dy / timeDelta;
  results.add(
    'Expected velocity: (${expectedVelX.toStringAsFixed(1)}, ${expectedVelY.toStringAsFixed(1)})',
  );
  print('Expected velocity: ($expectedVelX, $expectedVelY)');

  // Test 9: Create tracker with stylus kind
  final tracker3 = VelocityTracker.withKind(PointerDeviceKind.stylus);
  results.add('VelocityTracker(stylus) created');
  print('VelocityTracker with stylus kind created');

  // Test 10: Create tracker with trackpad kind
  final tracker4 = VelocityTracker.withKind(PointerDeviceKind.trackpad);
  results.add('VelocityTracker(trackpad) created');
  print('VelocityTracker with trackpad kind created');

  // Test 11: Multiple position samples for accuracy
  final accurateTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  for (int i = 0; i < 10; i++) {
    accurateTracker.addPosition(
      Duration(milliseconds: i * 16),
      Offset(100.0 + i * 10.0, 100.0 + i * 5.0),
    );
  }
  final accurateVelocity = accurateTracker.getVelocity();
  results.add('Accurate velocity: ${accurateVelocity.pixelsPerSecond}');
  print('Velocity with 10 samples: ${accurateVelocity.pixelsPerSecond}');

  // Test 12: Velocity zero check
  final zeroVelocity = Velocity.zero;
  assert(
    zeroVelocity.pixelsPerSecond == Offset.zero,
    'Zero velocity should be zero',
  );
  results.add('Velocity.zero: ${zeroVelocity.pixelsPerSecond}');
  print('Velocity.zero: ${zeroVelocity.pixelsPerSecond}');

  // Test 13: Horizontal movement only
  final hTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  hTracker.addPosition(Duration(milliseconds: 0), Offset(0, 100));
  hTracker.addPosition(Duration(milliseconds: 16), Offset(50, 100));
  hTracker.addPosition(Duration(milliseconds: 32), Offset(100, 100));
  final hVelocity = hTracker.getVelocity();
  results.add('Horizontal velocity: ${hVelocity.pixelsPerSecond}');
  print('Horizontal velocity: ${hVelocity.pixelsPerSecond}');

  // Test 14: Vertical movement only
  final vTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  vTracker.addPosition(Duration(milliseconds: 0), Offset(100, 0));
  vTracker.addPosition(Duration(milliseconds: 16), Offset(100, 50));
  vTracker.addPosition(Duration(milliseconds: 32), Offset(100, 100));
  final vVelocity = vTracker.getVelocity();
  results.add('Vertical velocity: ${vVelocity.pixelsPerSecond}');
  print('Vertical velocity: ${vVelocity.pixelsPerSecond}');

  // Test 15: Velocity magnitude (speed)
  final speed = velocity.pixelsPerSecond.distance;
  results.add('Speed: ${speed.toStringAsFixed(2)} px/s');
  print('Speed (velocity magnitude): $speed px/s');

  // Test 16: Velocity direction
  final direction = velocity.pixelsPerSecond.direction;
  results.add('Direction: ${direction.toStringAsFixed(4)} rad');
  print('Velocity direction: $direction radians');

  // Test 17: Create new tracker for fresh test
  final freshTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  results.add('Fresh tracker created');
  print('Created fresh velocity tracker');

  // Test 18: Negative velocity (moving backwards)
  final negTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  negTracker.addPosition(Duration(milliseconds: 0), Offset(200, 200));
  negTracker.addPosition(Duration(milliseconds: 16), Offset(150, 150));
  negTracker.addPosition(Duration(milliseconds: 32), Offset(100, 100));
  final negVelocity = negTracker.getVelocity();
  results.add('Negative velocity: ${negVelocity.pixelsPerSecond}');
  print('Negative velocity (backwards): ${negVelocity.pixelsPerSecond}');

  // Test 19: PointerDeviceKind values
  final kinds = PointerDeviceKind.values;
  results.add('Device kinds: ${kinds.length} types');
  print('PointerDeviceKind values: $kinds');

  // Test 20: Velocity clamp concept
  final maxVelocity = 8000.0; // typical max fling velocity
  final clampedSpeed = speed.clamp(0.0, maxVelocity);
  results.add('Clamped speed: ${clampedSpeed.toStringAsFixed(2)}');
  print('Clamped speed (max $maxVelocity): $clampedSpeed');

  print('VelocityTracker test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VelocityTracker Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
