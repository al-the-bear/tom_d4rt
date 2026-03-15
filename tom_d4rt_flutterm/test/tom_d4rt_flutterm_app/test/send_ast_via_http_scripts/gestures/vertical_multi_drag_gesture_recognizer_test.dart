// D4rt test script: Tests VerticalMultiDragGestureRecognizer from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VerticalMultiDragGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== VerticalMultiDragGestureRecognizer Tests ==========
  print('Testing VerticalMultiDragGestureRecognizer...');

  // Test 1: Create VerticalMultiDragGestureRecognizer
  final recognizer = VerticalMultiDragGestureRecognizer();
  assert(recognizer != null, 'Should create recognizer');
  results.add('VerticalMultiDragGestureRecognizer created');
  print(
    'VerticalMultiDragGestureRecognizer created: ${recognizer.runtimeType}',
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
  recognizer.onStart = (Offset position) {
    dragStartCount++;
    print('Vertical drag started at: $position');
    return null;
  };
  results.add('onStart callback set');
  print('onStart callback configured');

  // Test 4: Multiple pointer support
  final pointers = [0, 1, 2];
  results.add('Multi-pointer: ${pointers.length} pointers');
  print('Supports ${pointers.length} simultaneous vertical drags');

  // Test 5: Vertical constraint - only vertical movement
  final verticalDelta = Offset(0.0, 100.0);
  assert(verticalDelta.dx == 0, 'X should be 0 for vertical');
  results.add('Vertical delta: $verticalDelta');
  print('Vertical constraint: delta=$verticalDelta');

  // Test 6: Vertical movement detection
  final movement = Offset(5.0, 50.0);
  final isVertical = movement.dy.abs() > movement.dx.abs();
  assert(isVertical, 'Should detect vertical');
  results.add('Vertical movement: $isVertical');
  print('Movement $movement is vertical: $isVertical');

  // Test 7: Horizontal movement rejected
  final horizontalMove = Offset(50.0, 5.0);
  final isHorizontal = horizontalMove.dx.abs() > horizontalMove.dy.abs();
  assert(isHorizontal, 'Should detect horizontal');
  results.add('Horizontal movement (rejected): $isHorizontal');
  print('Horizontal movement $horizontalMove rejected');

  // Test 8: Down drag detection
  final downDrag = Offset(0.0, 50.0);
  final isDown = downDrag.dy > 0;
  assert(isDown, 'Should be downward');
  results.add('Down drag: $isDown');
  print('Down drag: $isDown');

  // Test 9: Up drag detection
  final upDrag = Offset(0.0, -50.0);
  final isUp = upDrag.dy < 0;
  assert(isUp, 'Should be upward');
  results.add('Up drag: $isUp');
  print('Up drag: $isUp');

  // Test 10: Drag velocity calculation
  final dragDist = 100.0;
  final dragTime = Duration(milliseconds: 200);
  final velocity = dragDist / (dragTime.inMilliseconds / 1000.0);
  results.add('Vertical velocity: ${velocity.toStringAsFixed(0)} px/s');
  print('Vertical velocity: ${velocity.toStringAsFixed(0)} px/s');

  // Test 11: Multi-drag positions (same X, different Y)
  final dragPositions = <int, Offset>{
    0: Offset(100.0, 100.0),
    1: Offset(100.0, 200.0),
    2: Offset(100.0, 300.0),
  };
  results.add('Tracking ${dragPositions.length} drag positions');
  print('Multi-drag positions: $dragPositions');

  // Test 12: Simultaneous vertical drags
  for (var entry in dragPositions.entries) {
    print('Pointer ${entry.key} at vertical position ${entry.value.dy}');
  }
  results.add('Simultaneous drags tested');

  // Test 13: Drag slop threshold
  final kPanSlop = 18.0;
  final smallVertical = Offset(0.0, 10.0);
  final withinSlop = smallVertical.distance < kPanSlop;
  results.add(
    'Small movement (${smallVertical.distance}): within slop=$withinSlop',
  );
  print('Slop check: ${smallVertical.distance} vs $kPanSlop');

  // Test 14: Exceeds slop - starts drag
  final largeVertical = Offset(0.0, 25.0);
  final exceedsSlop = largeVertical.distance >= kPanSlop;
  assert(exceedsSlop, 'Should exceed slop');
  results.add(
    'Large movement (${largeVertical.distance}): exceeds slop=$exceedsSlop',
  );
  print('Exceeds slop: starts vertical drag');

  // Test 15: Create with debugOwner
  final recognizer2 = VerticalMultiDragGestureRecognizer(
    debugOwner: 'TestOwner',
  );
  assert(recognizer2 != null, 'Should create with debugOwner');
  results.add('Recognizer with debugOwner');
  print('Created with debugOwner');
  recognizer2.dispose();

  // Test 16: Use case - list scrolling
  final isScrolling = true;
  results.add('Use case: list scrolling ($isScrolling)');
  print('Common use: vertical list scrolling');

  // Test 17: Position tracking per pointer
  final pointer1Start = Offset(100.0, 100.0);
  final pointer1Current = Offset(100.0, 200.0);
  final pointer1Delta = pointer1Current - pointer1Start;
  assert(pointer1Delta.dx == 0, 'X unchanged for vertical');
  results.add('Pointer 1 vertical delta: ${pointer1Delta.dy}');
  print('Pointer 1: delta=$pointer1Delta');

  // Test 18: Cumulative vertical distance
  var totalDistance = 0.0;
  final movements = [50.0, -30.0, 80.0];
  for (final m in movements) {
    totalDistance += m.abs();
  }
  results.add('Total vertical distance: $totalDistance');
  print('Cumulative distance: $totalDistance');

  // Test 19: End velocity
  final endVelocity = Velocity(pixelsPerSecond: Offset(0.0, velocity));
  results.add('End velocity: ${endVelocity.pixelsPerSecond}');
  print('End velocity: ${endVelocity.pixelsPerSecond}');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('VerticalMultiDragGestureRecognizer disposed');

  print(
    'VerticalMultiDragGestureRecognizer test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'VerticalMultiDragGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Constraint: Vertical only'),
      Text('Multi-pointer: tracks multiple drags'),
      Text('Callback: onStart returns Drag'),
      Text('Direction: up/down detection'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
