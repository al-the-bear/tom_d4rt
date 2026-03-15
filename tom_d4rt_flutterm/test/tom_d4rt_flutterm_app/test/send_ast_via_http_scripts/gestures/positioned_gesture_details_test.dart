// D4rt test script: Tests PositionedGestureDetails concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PositionedGestureDetails conceptual test executing');
  final results = <String>[];

  // ========== PositionedGestureDetails Tests ==========
  // PositionedGestureDetails may not be directly instantiable; test concepts
  print('Testing PositionedGestureDetails concepts...');

  // Test 1: Global position concept
  final globalPosition = Offset(300.0, 400.0);
  assert(globalPosition.dx == 300.0, 'dx should be 300');
  assert(globalPosition.dy == 400.0, 'dy should be 400');
  results.add('Global position: $globalPosition');
  print('Global position (screen coordinates): $globalPosition');

  // Test 2: Local position concept
  final localPosition = Offset(100.0, 150.0);
  assert(localPosition.dx == 100.0, 'dx should be 100');
  assert(localPosition.dy == 150.0, 'dy should be 150');
  results.add('Local position: $localPosition');
  print('Local position (widget coordinates): $localPosition');

  // Test 3: Position transform (global to local)
  final transform = globalPosition - localPosition;
  assert(transform == Offset(200.0, 250.0), 'Transform should be (200, 250)');
  results.add('Position transform: $transform');
  print('Global to local transform: $transform');

  // Test 4: Position distance from origin
  final distFromOrigin = globalPosition.distance;
  results.add('Distance from origin: ${distFromOrigin.toStringAsFixed(2)}');
  print('Distance from origin: ${distFromOrigin.toStringAsFixed(2)}');

  // Test 5: Position direction
  final direction = globalPosition.direction;
  results.add('Position direction: ${direction.toStringAsFixed(4)} rad');
  print('Position direction: ${direction.toStringAsFixed(4)} radians');

  // Test 6: TapDownDetails (concrete positioned details)
  final tapDown = TapDownDetails(
    globalPosition: globalPosition,
    localPosition: localPosition,
    kind: PointerDeviceKind.touch,
  );
  assert(tapDown.globalPosition == globalPosition, 'Global should match');
  assert(tapDown.localPosition == localPosition, 'Local should match');
  results.add('TapDownDetails: position=${tapDown.globalPosition}');
  print(
    'TapDownDetails: global=${tapDown.globalPosition}, local=${tapDown.localPosition}',
  );

  // Test 7: TapUpDetails (concrete positioned details)
  final tapUp = TapUpDetails(
    globalPosition: globalPosition,
    localPosition: localPosition,
    kind: PointerDeviceKind.touch,
  );
  assert(tapUp.globalPosition == globalPosition, 'Global should match');
  results.add('TapUpDetails: position=${tapUp.globalPosition}');
  print(
    'TapUpDetails: global=${tapUp.globalPosition}, local=${tapUp.localPosition}',
  );

  // Test 8: LongPressDownDetails (positioned gesture details)
  final longPressDown = LongPressDownDetails(
    globalPosition: globalPosition,
    localPosition: localPosition,
    kind: PointerDeviceKind.touch,
  );
  assert(longPressDown.globalPosition == globalPosition, 'Global should match');
  results.add('LongPressDownDetails: position=${longPressDown.globalPosition}');
  print('LongPressDownDetails with position');

  // Test 9: DragStartDetails (positioned gesture details)
  final dragStart = DragStartDetails(
    globalPosition: globalPosition,
    localPosition: localPosition,
    kind: PointerDeviceKind.touch,
  );
  assert(dragStart.globalPosition == globalPosition, 'Global should match');
  results.add('DragStartDetails: position=${dragStart.globalPosition}');
  print('DragStartDetails: global=${dragStart.globalPosition}');

  // Test 10: DragDownDetails (positioned gesture details)
  final dragDown = DragDownDetails(
    globalPosition: globalPosition,
    localPosition: localPosition,
  );
  assert(dragDown.globalPosition == globalPosition, 'Global should match');
  results.add('DragDownDetails: position=${dragDown.globalPosition}');
  print('DragDownDetails: global=${dragDown.globalPosition}');

  // Test 11: Position equality
  final pos1 = Offset(100.0, 200.0);
  final pos2 = Offset(100.0, 200.0);
  assert(pos1 == pos2, 'Same positions should be equal');
  results.add('Position equality: ${pos1 == pos2}');
  print('Position equality: ${pos1 == pos2}');

  // Test 12: Position hash code consistency
  assert(pos1.hashCode == pos2.hashCode, 'Same hash for same position');
  results.add('Position hash consistency verified');
  print('Position hash: ${pos1.hashCode}');

  // Test 13: Offset arithmetic for positions
  final pos3 = pos1 + Offset(50.0, 50.0);
  assert(pos3 == Offset(150.0, 250.0), 'Addition should work');
  results.add('Position addition: $pos3');
  print('Position addition: $pos1 + (50,50) = $pos3');

  // Test 14: Offset subtraction
  final delta = pos3 - pos1;
  assert(delta == Offset(50.0, 50.0), 'Delta should be (50, 50)');
  results.add('Position delta: $delta');
  print('Position delta: $delta');

  // Test 15: Offset scaling
  final scaled = pos1 * 2.0;
  assert(scaled == Offset(200.0, 400.0), 'Scaled should be (200, 400)');
  results.add('Position scaled: $scaled');
  print('Position scaled (2x): $scaled');

  // Test 16: Offset division
  final halved = pos1 / 2.0;
  assert(halved == Offset(50.0, 100.0), 'Halved should be (50, 100)');
  results.add('Position halved: $halved');
  print('Position halved: $halved');

  // Test 17: Position clamping to bounds
  final bounds = Rect.fromLTWH(0, 0, 300, 400);
  final outOfBounds = Offset(400.0, 500.0);
  final clamped = Offset(
    outOfBounds.dx.clamp(bounds.left, bounds.right),
    outOfBounds.dy.clamp(bounds.top, bounds.bottom),
  );
  results.add('Clamped position: $clamped');
  print('Clamped to bounds: $clamped');

  // Test 18: Position in hit testing
  final hitTestPos = Offset(150.0, 200.0);
  final targetRect = Rect.fromLTWH(100, 150, 100, 100);
  final isHit = targetRect.contains(hitTestPos);
  assert(isHit, 'Position should be within rect');
  results.add('Hit test: $isHit');
  print('Position hit test: $isHit');

  // Test 19: Device kind for positioned details
  final kind = PointerDeviceKind.touch;
  results.add('Device kind: $kind');
  print('Device kind associated with position: $kind');

  // Test 20: Summary of positioned gesture concepts
  results.add(
    'Concepts: globalPosition, localPosition, transform, distance, direction',
  );
  print(
    'PositionedGestureDetails: provides position context for gesture callbacks',
  );

  print('PositionedGestureDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PositionedGestureDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Concepts: globalPosition, localPosition'),
      Text('Transform: global - local = offset'),
      Text('Math: distance, direction, arithmetic'),
      Text('Concrete: TapDownDetails, DragStartDetails, etc.'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
