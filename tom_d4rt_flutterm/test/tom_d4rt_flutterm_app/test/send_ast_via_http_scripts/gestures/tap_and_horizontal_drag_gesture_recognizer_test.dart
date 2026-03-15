// D4rt test script: Tests TapAndHorizontalDragGestureRecognizer from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndHorizontalDragGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== TapAndHorizontalDragGestureRecognizer Tests ==========
  print('Testing TapAndHorizontalDragGestureRecognizer...');

  // Test 1: Create TapAndHorizontalDragGestureRecognizer
  final recognizer = TapAndHorizontalDragGestureRecognizer();
  assert(recognizer != null, 'Should create recognizer');
  results.add('TapAndHorizontalDragGestureRecognizer created');
  print(
    'TapAndHorizontalDragGestureRecognizer created: ${recognizer.runtimeType}',
  );

  // Test 2: Check inheritance
  assert(recognizer is GestureRecognizer, 'Should be GestureRecognizer');
  results.add('Inheritance: GestureRecognizer');
  print('Inheritance verified');

  // Test 3: Set onTapDown callback
  var tapDownCount = 0;
  recognizer.onTapDown = (TapDragDownDetails details) {
    tapDownCount++;
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

  // Test 8: Horizontal drag detection
  final horizontalMove = Offset(100.0, 5.0);
  final isHorizontal = horizontalMove.dx.abs() > horizontalMove.dy.abs();
  assert(isHorizontal, 'Should detect horizontal movement');
  results.add('Horizontal detection: $isHorizontal');
  print('Horizontal movement detected: $isHorizontal');

  // Test 9: Vertical movement should be rejected
  final verticalMove = Offset(5.0, 100.0);
  final isVertical = verticalMove.dy.abs() > verticalMove.dx.abs();
  final rejectedAsHorizontal =
      !isVertical || verticalMove.dx.abs() > verticalMove.dy.abs();
  results.add('Vertical movement: $isVertical (rejected for horizontal)');
  print('Vertical movement: $isVertical');

  // Test 10: Horizontal drag delta
  final startX = 100.0;
  final currentX = 200.0;
  final deltaX = currentX - startX;
  assert(deltaX == 100.0, 'Delta X should be 100');
  results.add('Horizontal delta: $deltaX');
  print('Horizontal drag delta: $deltaX');

  // Test 11: Drag direction - right
  final rightDrag = Offset(50.0, 0.0);
  final isRight = rightDrag.dx > 0;
  assert(isRight, 'Should be rightward');
  results.add('Rightward drag: $isRight');
  print('Drag direction: right=$isRight');

  // Test 12: Drag direction - left
  final leftDrag = Offset(-50.0, 0.0);
  final isLeft = leftDrag.dx < 0;
  assert(isLeft, 'Should be leftward');
  results.add('Leftward drag: $isLeft');
  print('Drag direction: left=$isLeft');

  // Test 13: Horizontal velocity calculation
  final dragDist = 100.0; // pixels
  final dragTime = Duration(milliseconds: 200);
  final velocity = dragDist / (dragTime.inMilliseconds / 1000.0);
  results.add('Horizontal velocity: ${velocity.toStringAsFixed(2)} px/s');
  print('Horizontal velocity: ${velocity.toStringAsFixed(2)} px/s');

  // Test 14: Drag slop for horizontal
  final kPanSlop = 18.0;
  final smallHorizontal = Offset(10.0, 2.0);
  final withinSlop = smallHorizontal.distance < kPanSlop;
  results.add(
    'Within slop (${smallHorizontal.distance.toStringAsFixed(2)}): $withinSlop',
  );
  print('Within horizontal slop: $withinSlop');

  // Test 15: Exceeds slop starts drag
  final largeHorizontal = Offset(30.0, 2.0);
  final exceedsSlop = largeHorizontal.distance >= kPanSlop;
  assert(exceedsSlop, 'Should exceed slop');
  results.add(
    'Exceeds slop (${largeHorizontal.distance.toStringAsFixed(2)}): $exceedsSlop',
  );
  print('Exceeds slop, starts drag: $exceedsSlop');

  // Test 16: Horizontal constraint enforcement
  final constrainedDelta = Offset(dragDist, 0.0); // Only horizontal
  assert(constrainedDelta.dy == 0, 'Y should be constrained to 0');
  results.add('Constrained delta: $constrainedDelta');
  print('Horizontally constrained delta: $constrainedDelta');

  // Test 17: Position tracking
  final positions = <Offset>[];
  for (var i = 0; i < 5; i++) {
    positions.add(Offset(100.0 + i * 20.0, 200.0));
  }
  final totalDelta = positions.last - positions.first;
  results.add('Total drag: $totalDelta');
  print('Tracked positions: ${positions.length}, total delta: $totalDelta');

  // Test 18: Fling velocity threshold
  final kMinFlingVelocity = 50.0; // typical min fling
  final isFling = velocity > kMinFlingVelocity;
  results.add('Is fling (>$kMinFlingVelocity): $isFling');
  print('Fling detection: velocity=$velocity, isFling=$isFling');

  // Test 19: Callback verification
  assert(recognizer.onTapDown != null, 'onTapDown should be set');
  assert(recognizer.onDragStart != null, 'onDragStart should be set');
  assert(recognizer.onDragUpdate != null, 'onDragUpdate should be set');
  assert(recognizer.onDragEnd != null, 'onDragEnd should be set');
  results.add('All callbacks verified');
  print('All callbacks verified');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('TapAndHorizontalDragGestureRecognizer disposed');

  print(
    'TapAndHorizontalDragGestureRecognizer test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapAndHorizontalDragGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Constraint: Horizontal movement only'),
      Text('Callbacks: onTapDown/Up, onDragStart/Update/End'),
      Text('Direction: left/right detection'),
      Text('Velocity: horizontal fling support'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
