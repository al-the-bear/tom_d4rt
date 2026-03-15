// D4rt test script: Tests TapMoveDetails conceptual from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapMoveDetails conceptual test executing');
  final results = <String>[];

  // ========== TapMoveDetails Conceptual Tests ==========
  // TapMoveDetails represents movement during a tap gesture
  print('Testing TapMoveDetails concepts...');

  // Test 1: Offset for global position
  final globalPosition = Offset(150.0, 250.0);
  assert(globalPosition.dx == 150.0, 'dx should be 150.0');
  assert(globalPosition.dy == 250.0, 'dy should be 250.0');
  results.add('Global position: $globalPosition');
  print('Global position: $globalPosition');

  // Test 2: Offset for local position
  final localPosition = Offset(50.0, 100.0);
  assert(localPosition.dx == 50.0, 'dx should be 50.0');
  assert(localPosition.dy == 100.0, 'dy should be 100.0');
  results.add('Local position: $localPosition');
  print('Local position: $localPosition');

  // Test 3: Calculate offset from start
  final startPosition = Offset(100.0, 200.0);
  final currentPosition = Offset(150.0, 250.0);
  final offsetFromStart = currentPosition - startPosition;
  assert(offsetFromStart == Offset(50.0, 50.0), 'Offset should be (50, 50)');
  results.add('Offset from start: $offsetFromStart');
  print('Offset from start: $offsetFromStart');

  // Test 4: Distance calculation
  final distance = offsetFromStart.distance;
  final expectedDistance = 70.71; // sqrt(50^2 + 50^2)
  assert(
    (distance - expectedDistance).abs() < 0.1,
    'Distance should be ~70.71',
  );
  results.add('Distance moved: ${distance.toStringAsFixed(2)}');
  print('Distance moved: ${distance.toStringAsFixed(2)}');

  // Test 5: Direction calculation
  final direction = offsetFromStart.direction;
  results.add('Direction: ${direction.toStringAsFixed(4)} rad');
  print('Direction: ${direction.toStringAsFixed(4)} radians');

  // Test 6: PointerDeviceKind for tap source
  final kind = PointerDeviceKind.touch;
  assert(kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('Device kind: $kind');
  print('Device kind: $kind');

  // Test 7: Movement threshold concept
  final kTouchSlop = 18.0; // typical touch slop value
  final smallMovement = Offset(5.0, 5.0);
  final smallDistance = smallMovement.distance;
  final withinSlop = smallDistance < kTouchSlop;
  assert(withinSlop, 'Small movement should be within slop');
  results.add(
    'Movement ${smallDistance.toStringAsFixed(2)} within slop: $withinSlop',
  );
  print(
    'Movement ${smallDistance.toStringAsFixed(2)}px within slop ($kTouchSlop): $withinSlop',
  );

  // Test 8: Movement exceeds threshold
  final largeMovement = Offset(20.0, 20.0);
  final largeDistance = largeMovement.distance;
  final exceedsSlop = largeDistance > kTouchSlop;
  assert(exceedsSlop, 'Large movement should exceed slop');
  results.add(
    'Movement ${largeDistance.toStringAsFixed(2)} exceeds slop: $exceedsSlop',
  );
  print(
    'Movement ${largeDistance.toStringAsFixed(2)}px exceeds slop ($kTouchSlop): $exceedsSlop',
  );

  // Test 9: Delta for incremental movement
  final previousPosition = Offset(130.0, 220.0);
  final delta = currentPosition - previousPosition;
  assert(delta == Offset(20.0, 30.0), 'Delta should be (20, 30)');
  results.add('Delta: $delta');
  print('Delta from previous: $delta');

  // Test 10: Offset operations
  final scaledOffset = offsetFromStart * 2.0;
  assert(scaledOffset == Offset(100.0, 100.0), 'Scaled should be (100, 100)');
  results.add('Scaled offset (2x): $scaledOffset');
  print('Scaled offset (2x): $scaledOffset');

  // Test 11: Offset division
  final halfOffset = offsetFromStart / 2.0;
  assert(halfOffset == Offset(25.0, 25.0), 'Half should be (25, 25)');
  results.add('Half offset: $halfOffset');
  print('Half offset: $halfOffset');

  // Test 12: Unit vector for direction
  final unitVector = Offset.fromDirection(direction);
  results.add(
    'Unit vector: (${unitVector.dx.toStringAsFixed(3)}, ${unitVector.dy.toStringAsFixed(3)})',
  );
  print('Unit vector: $unitVector');

  // Test 13: Offset.zero constant
  assert(Offset.zero == Offset(0, 0), 'Zero should be (0, 0)');
  results.add('Offset.zero: ${Offset.zero}');
  print('Offset.zero: ${Offset.zero}');

  // Test 14: Offset equality
  final pos1 = Offset(100.0, 200.0);
  final pos2 = Offset(100.0, 200.0);
  assert(pos1 == pos2, 'Equal offsets should be equal');
  results.add('Offset equality: ${pos1 == pos2}');
  print('Offset equality: ${pos1 == pos2}');

  // Test 15: Offset hash code consistency
  assert(
    pos1.hashCode == pos2.hashCode,
    'Equal offsets should have same hashCode',
  );
  results.add('HashCode consistency: ${pos1.hashCode == pos2.hashCode}');
  print('Offset hashCode: ${pos1.hashCode}');

  // Test 16: Horizontal movement detection
  final horizontalMove = Offset(50.0, 2.0);
  final isHorizontal = horizontalMove.dx.abs() > horizontalMove.dy.abs();
  assert(isHorizontal, 'Should be horizontal movement');
  results.add('Horizontal movement: $isHorizontal');
  print('Horizontal movement detected: $isHorizontal');

  // Test 17: Vertical movement detection
  final verticalMove = Offset(2.0, 50.0);
  final isVertical = verticalMove.dy.abs() > verticalMove.dx.abs();
  assert(isVertical, 'Should be vertical movement');
  results.add('Vertical movement: $isVertical');
  print('Vertical movement detected: $isVertical');

  // Test 18: Velocity-like calculation
  final timeDelta = Duration(milliseconds: 16);
  final velocityX = delta.dx / (timeDelta.inMilliseconds / 1000.0);
  final velocityY = delta.dy / (timeDelta.inMilliseconds / 1000.0);
  results.add('Velocity estimate: ($velocityX, $velocityY) px/s');
  print('Velocity estimate: ($velocityX, $velocityY) px/s');

  // Test 19: Multiple device kinds
  final kinds = [
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
  ];
  results.add('Supported device kinds: ${kinds.length}');
  print('Supported device kinds for tap move: $kinds');

  // Test 20: Position clamping concept
  final screenBounds = Rect.fromLTWH(0, 0, 400, 800);
  final clampedX = currentPosition.dx.clamp(
    screenBounds.left,
    screenBounds.right,
  );
  final clampedY = currentPosition.dy.clamp(
    screenBounds.top,
    screenBounds.bottom,
  );
  final clampedPos = Offset(clampedX, clampedY);
  results.add('Clamped position: $clampedPos');
  print('Clamped position to bounds: $clampedPos');

  print(
    'TapMoveDetails conceptual test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapMoveDetails Conceptual Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Position: global, local'),
      Text('Movement: offset, distance, direction'),
      Text('Detection: horizontal, vertical, slop'),
      Text('Operations: scale, divide, delta'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
