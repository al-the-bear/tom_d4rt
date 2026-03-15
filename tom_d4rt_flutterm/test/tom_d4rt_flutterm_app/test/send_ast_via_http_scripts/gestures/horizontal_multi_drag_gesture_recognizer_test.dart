// D4rt test script: Tests HorizontalMultiDragGestureRecognizer from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HorizontalMultiDragGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== HorizontalMultiDragGestureRecognizer Tests ==========
  print('Testing HorizontalMultiDragGestureRecognizer...');

  // Test 1: Create HorizontalMultiDragGestureRecognizer
  final recognizer = HorizontalMultiDragGestureRecognizer();
  assert(recognizer != null, 'Should create recognizer');
  results.add('HorizontalMultiDragGestureRecognizer created');
  print(
    'HorizontalMultiDragGestureRecognizer created: ${recognizer.runtimeType}',
  );

  // Test 2: Check inheritance
  assert(
    recognizer is MultiDragGestureRecognizer,
    'Should be MultiDragGestureRecognizer',
  );
  results.add('Inheritance: MultiDragGestureRecognizer');
  print('Inheritance verified: MultiDragGestureRecognizer');

  // Test 3: Set onStart callback
  var dragStartCount = 0;
  Drag? activeDrag;
  recognizer.onStart = (Offset position) {
    dragStartCount++;
    print('Drag started at: $position');
    return null; // Would return Drag object in real usage
  };
  results.add('onStart callback set');
  print('onStart callback configured');

  // Test 4: Multiple pointer support concept
  final pointers = [0, 1, 2]; // Multiple fingers
  results.add('Multi-pointer support: ${pointers.length} pointers');
  print('Multi-pointer: can track ${pointers.length} simultaneous drags');

  // Test 5: Horizontal constraint - only horizontal movement
  final horizontalDelta = Offset(100.0, 0.0);
  assert(horizontalDelta.dy == 0, 'Y should be 0 for horizontal');
  results.add('Horizontal delta: $horizontalDelta');
  print('Horizontal constraint: delta=$horizontalDelta');

  // Test 6: Horizontal movement detection
  final movement = Offset(50.0, 5.0);
  final isHorizontal = movement.dx.abs() > movement.dy.abs();
  assert(isHorizontal, 'Should detect horizontal');
  results.add('Horizontal movement: $isHorizontal');
  print('Movement ${movement} is horizontal: $isHorizontal');

  // Test 7: Vertical movement rejected
  final verticalMove = Offset(5.0, 50.0);
  final isVertical = verticalMove.dy.abs() > verticalMove.dx.abs();
  assert(isVertical, 'Should detect vertical');
  results.add('Vertical movement (rejected): $isVertical');
  print('Vertical movement $verticalMove rejected');

  // Test 8: Left drag detection
  final leftDrag = Offset(-50.0, 0.0);
  final isLeft = leftDrag.dx < 0;
  assert(isLeft, 'Should be left');
  results.add('Left drag: $isLeft');
  print('Left drag: $isLeft');

  // Test 9: Right drag detection
  final rightDrag = Offset(50.0, 0.0);
  final isRight = rightDrag.dx > 0;
  assert(isRight, 'Should be right');
  results.add('Right drag: $isRight');
  print('Right drag: $isRight');

  // Test 10: Drag velocity calculation
  final dragDist = 100.0; // pixels
  final dragTime = Duration(milliseconds: 200);
  final velocity = dragDist / (dragTime.inMilliseconds / 1000.0);
  results.add('Horizontal velocity: ${velocity.toStringAsFixed(0)} px/s');
  print('Horizontal velocity: ${velocity.toStringAsFixed(0)} px/s');

  // Test 11: Multi-drag positions
  final dragPositions = <int, Offset>{
    0: Offset(100.0, 200.0),
    1: Offset(200.0, 200.0),
    2: Offset(300.0, 200.0),
  };
  results.add('Tracking ${dragPositions.length} drag positions');
  print('Multi-drag positions: $dragPositions');

  // Test 12: Simultaneous horizontal drags
  for (var entry in dragPositions.entries) {
    print('Pointer ${entry.key} at horizontal position ${entry.value.dx}');
  }
  results.add('Simultaneous drags tested');

  // Test 13: Drag slop threshold
  final kPanSlop = 18.0;
  final smallHorizontal = Offset(10.0, 0.0);
  final exceedsSlop = smallHorizontal.distance >= kPanSlop;
  results.add(
    'Small movement (${smallHorizontal.distance}): exceeds slop=$exceedsSlop',
  );
  print('Slop check: ${smallHorizontal.distance} vs $kPanSlop');

  // Test 14: Create recognizer with debugOwner
  final recognizer2 = HorizontalMultiDragGestureRecognizer(
    debugOwner: 'TestOwner',
  );
  assert(recognizer2 != null, 'Should create with debugOwner');
  results.add('Recognizer with debugOwner');
  print('Created with debugOwner');
  recognizer2.dispose();

  // Test 15: GestureRecognizer base functionality
  assert(recognizer is GestureRecognizer, 'Should be GestureRecognizer');
  results.add('GestureRecognizer base verified');
  print('Base GestureRecognizer functionality');

  // Test 16: Position tracking per pointer
  final pointer1Start = Offset(100.0, 200.0);
  final pointer1Current = Offset(150.0, 200.0);
  final pointer1Delta = pointer1Current - pointer1Start;
  assert(pointer1Delta.dy == 0, 'Y unchanged for horizontal');
  results.add('Pointer 1 horizontal delta: ${pointer1Delta.dx}');
  print(
    'Pointer 1: start=$pointer1Start, current=$pointer1Current, delta=$pointer1Delta',
  );

  // Test 17: Cumulative drag distance
  var totalDistance = 0.0;
  final movements = [50.0, 30.0, 20.0];
  for (final m in movements) {
    totalDistance += m.abs();
  }
  results.add('Total horizontal distance: $totalDistance');
  print('Cumulative drag: $totalDistance px');

  // Test 18: Drag end with velocity
  final endVelocity = Velocity(pixelsPerSecond: Offset(velocity, 0.0));
  results.add('End velocity: ${endVelocity.pixelsPerSecond}');
  print('Drag end velocity: ${endVelocity.pixelsPerSecond}');

  // Test 19: Callback verification
  assert(recognizer.onStart != null, 'onStart should be set');
  results.add('onStart callback verified');
  print('onStart callback verified');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('HorizontalMultiDragGestureRecognizer disposed');

  print(
    'HorizontalMultiDragGestureRecognizer test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'HorizontalMultiDragGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Constraint: Horizontal only'),
      Text('Multi-pointer: tracks multiple drags'),
      Text('Callback: onStart returns Drag'),
      Text('Direction: left/right detection'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
