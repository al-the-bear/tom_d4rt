// D4rt test script: Tests VelocityEstimate(pixelsPerSecond, confidence, duration, offset) from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VelocityEstimate test executing');
  final results = <String>[];

  // ========== VelocityEstimate Tests ==========
  print('Testing VelocityEstimate...');

  // Test 1: Create VelocityEstimate
  final estimate1 = VelocityEstimate(
    pixelsPerSecond: Offset(500.0, 300.0),
    confidence: 0.95,
    duration: Duration(milliseconds: 100),
    offset: Offset(50.0, 30.0),
  );
  assert(estimate1 != null, 'Should create VelocityEstimate');
  results.add('VelocityEstimate created');
  print('VelocityEstimate created: ${estimate1.runtimeType}');

  // Test 2: pixelsPerSecond property
  assert(
    estimate1.pixelsPerSecond == Offset(500.0, 300.0),
    'pixelsPerSecond should match',
  );
  results.add('pixelsPerSecond: ${estimate1.pixelsPerSecond}');
  print('pixelsPerSecond: ${estimate1.pixelsPerSecond}');

  // Test 3: confidence property
  assert(estimate1.confidence == 0.95, 'Confidence should be 0.95');
  results.add('confidence: ${estimate1.confidence}');
  print('confidence: ${estimate1.confidence}');

  // Test 4: duration property
  assert(
    estimate1.duration == Duration(milliseconds: 100),
    'Duration should match',
  );
  results.add('duration: ${estimate1.duration}');
  print('duration: ${estimate1.duration}');

  // Test 5: offset property
  assert(estimate1.offset == Offset(50.0, 30.0), 'Offset should match');
  results.add('offset: ${estimate1.offset}');
  print('offset: ${estimate1.offset}');

  // Test 6: Speed calculation (magnitude of pixelsPerSecond)
  final speed = estimate1.pixelsPerSecond.distance;
  results.add('Speed: ${speed.toStringAsFixed(2)} px/s');
  print('Speed: $speed px/s');

  // Test 7: High confidence estimate
  final highConfidence = VelocityEstimate(
    pixelsPerSecond: Offset(1000.0, 800.0),
    confidence: 1.0,
    duration: Duration(milliseconds: 200),
    offset: Offset(200.0, 160.0),
  );
  assert(highConfidence.confidence == 1.0, 'High confidence should be 1.0');
  results.add('High confidence: ${highConfidence.confidence}');
  print('High confidence estimate: ${highConfidence.confidence}');

  // Test 8: Low confidence estimate
  final lowConfidence = VelocityEstimate(
    pixelsPerSecond: Offset(100.0, 50.0),
    confidence: 0.3,
    duration: Duration(milliseconds: 50),
    offset: Offset(5.0, 2.5),
  );
  assert(lowConfidence.confidence == 0.3, 'Low confidence should be 0.3');
  results.add('Low confidence: ${lowConfidence.confidence}');
  print('Low confidence estimate: ${lowConfidence.confidence}');

  // Test 9: Horizontal velocity estimate
  final horizontalEst = VelocityEstimate(
    pixelsPerSecond: Offset(800.0, 0.0),
    confidence: 0.9,
    duration: Duration(milliseconds: 80),
    offset: Offset(64.0, 0.0),
  );
  assert(horizontalEst.pixelsPerSecond.dy == 0, 'Y velocity should be 0');
  results.add('Horizontal: ${horizontalEst.pixelsPerSecond}');
  print('Horizontal velocity estimate: ${horizontalEst.pixelsPerSecond}');

  // Test 10: Vertical velocity estimate
  final verticalEst = VelocityEstimate(
    pixelsPerSecond: Offset(0.0, 600.0),
    confidence: 0.85,
    duration: Duration(milliseconds: 75),
    offset: Offset(0.0, 45.0),
  );
  assert(verticalEst.pixelsPerSecond.dx == 0, 'X velocity should be 0');
  results.add('Vertical: ${verticalEst.pixelsPerSecond}');
  print('Vertical velocity estimate: ${verticalEst.pixelsPerSecond}');

  // Test 11: Negative velocity (moving backwards)
  final negativeEst = VelocityEstimate(
    pixelsPerSecond: Offset(-400.0, -200.0),
    confidence: 0.88,
    duration: Duration(milliseconds: 90),
    offset: Offset(-36.0, -18.0),
  );
  assert(negativeEst.pixelsPerSecond.dx < 0, 'X should be negative');
  results.add('Negative: ${negativeEst.pixelsPerSecond}');
  print('Negative velocity estimate: ${negativeEst.pixelsPerSecond}');

  // Test 12: Direction from velocity
  final direction = estimate1.pixelsPerSecond.direction;
  results.add('Direction: ${direction.toStringAsFixed(4)} rad');
  print('Velocity direction: $direction radians');

  // Test 13: Convert direction to degrees
  final degrees = direction * (180.0 / 3.14159);
  results.add('Direction: ${degrees.toStringAsFixed(2)} deg');
  print('Velocity direction: $degrees degrees');

  // Test 14: Obtain VelocityEstimate from VelocityTracker
  final tracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  tracker.addPosition(Duration(milliseconds: 0), Offset(100, 100));
  tracker.addPosition(Duration(milliseconds: 16), Offset(150, 120));
  tracker.addPosition(Duration(milliseconds: 32), Offset(200, 140));
  tracker.addPosition(Duration(milliseconds: 48), Offset(250, 160));
  final trackerEstimate = tracker.getVelocityEstimate();
  results.add('Tracker estimate: ${trackerEstimate?.pixelsPerSecond}');
  print('VelocityEstimate from tracker: ${trackerEstimate?.pixelsPerSecond}');

  // Test 15: Confidence from tracker estimate
  if (trackerEstimate != null) {
    results.add(
      'Tracker confidence: ${trackerEstimate.confidence.toStringAsFixed(3)}',
    );
    print('Tracker estimate confidence: ${trackerEstimate.confidence}');
  } else {
    results.add('Tracker confidence: null');
    print('Tracker estimate is null');
  }

  // Test 16: Duration milliseconds
  final durationMs = estimate1.duration.inMilliseconds;
  results.add('Duration: ${durationMs}ms');
  print('Duration in milliseconds: $durationMs');

  // Test 17: Velocity to Velocity object
  final velocity = Velocity(pixelsPerSecond: estimate1.pixelsPerSecond);
  assert(velocity.pixelsPerSecond == estimate1.pixelsPerSecond, 'Should match');
  results.add('Velocity obj: ${velocity.pixelsPerSecond}');
  print('Velocity object: ${velocity.pixelsPerSecond}');

  // Test 18: Fast fling estimate
  final fastFling = VelocityEstimate(
    pixelsPerSecond: Offset(3000.0, 2500.0),
    confidence: 0.98,
    duration: Duration(milliseconds: 120),
    offset: Offset(360.0, 300.0),
  );
  final flingSpeed = fastFling.pixelsPerSecond.distance;
  results.add('Fling speed: ${flingSpeed.toStringAsFixed(1)} px/s');
  print('Fast fling speed: $flingSpeed px/s');

  // Test 19: Offset distance matches duration concept
  final offsetDistance = estimate1.offset.distance;
  results.add('Offset distance: ${offsetDistance.toStringAsFixed(2)}');
  print('Offset distance: $offsetDistance');

  // Test 20: Calculate velocity from offset and duration
  final durationSeconds = estimate1.duration.inMicroseconds / 1000000.0;
  final calcVelX = estimate1.offset.dx / durationSeconds;
  final calcVelY = estimate1.offset.dy / durationSeconds;
  results.add(
    'Calc velocity: (${calcVelX.toStringAsFixed(1)}, ${calcVelY.toStringAsFixed(1)})',
  );
  print('Calculated velocity: ($calcVelX, $calcVelY)');

  print('VelocityEstimate test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VelocityEstimate Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
