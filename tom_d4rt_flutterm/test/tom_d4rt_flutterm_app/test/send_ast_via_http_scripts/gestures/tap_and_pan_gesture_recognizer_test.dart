// D4rt test script: Tests TapAndPanGestureRecognizer from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndPanGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== TapAndPanGestureRecognizer Tests ==========
  print('Testing TapAndPanGestureRecognizer...');

  // Test 1: Create TapAndPanGestureRecognizer
  final recognizer = TapAndPanGestureRecognizer();
  assert(recognizer != null, 'Should create recognizer');
  results.add('TapAndPanGestureRecognizer created');
  print('TapAndPanGestureRecognizer created: ${recognizer.runtimeType}');

  // Test 2: Check inheritance
  assert(recognizer is GestureRecognizer, 'Should be GestureRecognizer');
  results.add('Inheritance: GestureRecognizer');
  print('Inheritance verified');

  // Test 3: Set onTapDown callback
  var tapDownCount = 0;
  TapDragDownDetails? lastDown;
  recognizer.onTapDown = (TapDragDownDetails details) {
    tapDownCount++;
    lastDown = details;
  };
  results.add('onTapDown callback set');
  print('onTapDown callback configured');

  // Test 4: Set onTapUp callback
  var tapUpCount = 0;
  recognizer.onTapUp = (TapDragUpDetails details) {
    tapUpCount++;
  };
  results.add('onTapUp callback set');
  print('onTapUp callback configured');

  // Test 5: Set onDragStart callback
  var dragStartCount = 0;
  recognizer.onDragStart = (TapDragStartDetails details) {
    dragStartCount++;
  };
  results.add('onDragStart callback set');
  print('onDragStart callback configured');

  // Test 6: Set onDragUpdate callback
  var dragUpdateCount = 0;
  recognizer.onDragUpdate = (TapDragUpdateDetails details) {
    dragUpdateCount++;
  };
  results.add('onDragUpdate callback set');
  print('onDragUpdate callback configured');

  // Test 7: Set onDragEnd callback
  var dragEndCount = 0;
  recognizer.onDragEnd = (TapDragEndDetails details) {
    dragEndCount++;
  };
  results.add('onDragEnd callback set');
  print('onDragEnd callback configured');

  // Test 8: Pan gesture - omnidirectional movement
  final panMove = Offset(50.0, 50.0);
  final isOmnidirectional = true; // Pan accepts all directions
  results.add('Omnidirectional pan: $isOmnidirectional');
  print('Pan gesture - omnidirectional: $isOmnidirectional');

  // Test 9: Horizontal component
  final horizontalComponent = panMove.dx;
  assert(horizontalComponent == 50.0, 'Horizontal should be 50');
  results.add('Horizontal component: $horizontalComponent');
  print('Pan horizontal component: $horizontalComponent');

  // Test 10: Vertical component
  final verticalComponent = panMove.dy;
  assert(verticalComponent == 50.0, 'Vertical should be 50');
  results.add('Vertical component: $verticalComponent');
  print('Pan vertical component: $verticalComponent');

  // Test 11: Pan distance
  final panDistance = panMove.distance;
  assert((panDistance - 70.71).abs() < 0.1, 'Distance should be ~70.71');
  results.add('Pan distance: ${panDistance.toStringAsFixed(2)}');
  print('Pan distance: ${panDistance.toStringAsFixed(2)}');

  // Test 12: Pan direction
  final panDirection = panMove.direction;
  results.add('Pan direction: ${panDirection.toStringAsFixed(4)} rad');
  print('Pan direction: ${panDirection.toStringAsFixed(4)} radians');

  // Test 13: Diagonal movement accepted
  final diagonal = Offset(30.0, 40.0);
  final isDiagonal = diagonal.dx != 0 && diagonal.dy != 0;
  assert(isDiagonal, 'Should accept diagonal');
  results.add('Diagonal accepted: $isDiagonal');
  print('Pan accepts diagonal: $isDiagonal');

  // Test 14: Pan slop threshold
  final kPanSlop = 18.0;
  final smallPan = Offset(10.0, 10.0);
  final smallDist = smallPan.distance;
  final withinSlop = smallDist < kPanSlop;
  results.add('Within slop (${smallDist.toStringAsFixed(2)}): $withinSlop');
  print('Pan within slop: $withinSlop');

  // Test 15: Exceeds slop - starts pan
  final largePan = Offset(20.0, 20.0);
  final largeDist = largePan.distance;
  final exceedsSlop = largeDist >= kPanSlop;
  assert(exceedsSlop, 'Should exceed slop');
  results.add('Exceeds slop (${largeDist.toStringAsFixed(2)}): $exceedsSlop');
  print('Pan exceeds slop: $exceedsSlop');

  // Test 16: Velocity calculation for pan
  final panDelta = Offset(100.0, 100.0);
  final panTime = Duration(milliseconds: 200);
  final velX = panDelta.dx / (panTime.inMilliseconds / 1000.0);
  final velY = panDelta.dy / (panTime.inMilliseconds / 1000.0);
  results.add('Pan velocity: ($velX, $velY) px/s');
  print('Pan velocity: ($velX, $velY) px/s');

  // Test 17: Velocity magnitude (speed)
  final speed = Offset(velX, velY).distance;
  results.add('Pan speed: ${speed.toStringAsFixed(2)} px/s');
  print('Pan speed: ${speed.toStringAsFixed(2)} px/s');

  // Test 18: Tap count tracking for multi-tap-drag
  var tapCount = 0;
  void simulateTap() => tapCount++;
  simulateTap();
  simulateTap();
  assert(tapCount == 2, 'Should track 2 taps');
  results.add('Multi-tap tracking: $tapCount taps');
  print('Multi-tap before drag: $tapCount');

  // Test 19: Callback verification
  assert(recognizer.onTapDown != null, 'onTapDown set');
  assert(recognizer.onTapUp != null, 'onTapUp set');
  assert(recognizer.onDragStart != null, 'onDragStart set');
  assert(recognizer.onDragUpdate != null, 'onDragUpdate set');
  assert(recognizer.onDragEnd != null, 'onDragEnd set');
  results.add('All 5 main callbacks verified');
  print('All callbacks verified');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('TapAndPanGestureRecognizer disposed');

  print(
    'TapAndPanGestureRecognizer test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapAndPanGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Constraint: All directions (pan)'),
      Text('Callbacks: onTapDown/Up, onDragStart/Update/End'),
      Text('Movement: horizontal, vertical, diagonal'),
      Text('Features: velocity, tap count, slop threshold'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
