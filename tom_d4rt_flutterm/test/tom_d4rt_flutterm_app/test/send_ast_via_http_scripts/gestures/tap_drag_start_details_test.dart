// D4rt test script: Tests TapDragStartDetails from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragStartDetails comprehensive test executing');
  final results = <String>[];

  // ========== TapDragStartDetails Tests ==========
  print('Testing TapDragStartDetails...');

  // Test 1: Create TapDragStartDetails
  final details = TapDragStartDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );
  assert(details != null, 'Should create details');
  results.add('TapDragStartDetails created');
  print('TapDragStartDetails created');

  // Test 2: Global position property
  assert(details.globalPosition == Offset(100.0, 200.0), 'Global should match');
  results.add('Global position: ${details.globalPosition}');
  print('Global position: ${details.globalPosition}');

  // Test 3: Local position property
  assert(details.localPosition == Offset(50.0, 100.0), 'Local should match');
  results.add('Local position: ${details.localPosition}');
  print('Local position: ${details.localPosition}');

  // Test 4: Kind property
  assert(details.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('Kind: ${details.kind}');
  print('Device kind: ${details.kind}');

  // Test 5: Consecutive tap count
  assert(details.consecutiveTapCount == 1, 'Count should be 1');
  results.add('Consecutive tap count: ${details.consecutiveTapCount}');
  print('Consecutive tap count: ${details.consecutiveTapCount}');

  // Test 6: Double tap drag start
  final doubleTapStart = TapDragStartDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 2,
  );
  assert(doubleTapStart.consecutiveTapCount == 2, 'Count should be 2');
  results.add('Double tap start count: ${doubleTapStart.consecutiveTapCount}');
  print('Double tap drag start: count=${doubleTapStart.consecutiveTapCount}');

  // Test 7: Triple tap drag start
  final tripleTapStart = TapDragStartDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 3,
  );
  assert(tripleTapStart.consecutiveTapCount == 3, 'Count should be 3');
  results.add('Triple tap start count: ${tripleTapStart.consecutiveTapCount}');
  print('Triple tap drag start: count=${tripleTapStart.consecutiveTapCount}');

  // Test 8: Drag start as transition from tap
  final tapDownPos = Offset(100.0, 200.0);
  final dragStartPos = details.globalPosition;
  final positionMatch = tapDownPos == dragStartPos;
  assert(positionMatch, 'Start position should match tap down');
  results.add('Tap-to-drag transition: position match=$positionMatch');
  print('Tap-to-drag: position continuity=$positionMatch');

  // Test 9: Mouse device
  final mouseStart = TapDragStartDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 1,
  );
  assert(mouseStart.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('Mouse start: ${mouseStart.kind}');
  print('Mouse drag start: kind=${mouseStart.kind}');

  // Test 10: Drag delta calculation concept
  final startPos = details.globalPosition;
  final currentPos = Offset(150.0, 250.0);
  final delta = currentPos - startPos;
  assert(delta == Offset(50.0, 50.0), 'Delta should be (50, 50)');
  results.add('Initial delta: $delta');
  print('Delta from start: $delta');

  // Test 11: Drag distance from start
  final distance = delta.distance;
  assert((distance - 70.71).abs() < 0.1, 'Distance should be ~70.71');
  results.add('Drag distance: ${distance.toStringAsFixed(2)}');
  print('Drag distance from start: ${distance.toStringAsFixed(2)}');

  // Test 12: Drag direction from start
  final direction = delta.direction;
  results.add('Drag direction: ${direction.toStringAsFixed(4)} rad');
  print('Drag direction: ${direction.toStringAsFixed(4)} radians');

  // Test 13: Start time concept
  final startTime = Duration(milliseconds: 100);
  results.add('Start time concept: ${startTime.inMilliseconds}ms');
  print('Drag start time: ${startTime.inMilliseconds}ms');

  // Test 14: Stylus device
  final stylusStart = TapDragStartDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.stylus,
    consecutiveTapCount: 1,
  );
  assert(stylusStart.kind == PointerDeviceKind.stylus, 'Kind should be stylus');
  results.add('Stylus start: ${stylusStart.kind}');
  print('Stylus drag start');

  // Test 15: Position transform
  final transform = details.globalPosition - details.localPosition;
  results.add('Position transform: $transform');
  print('Global-local transform: $transform');

  // Test 16: Callback pattern
  TapDragStartDetails? capturedStart;
  void onDragStart(TapDragStartDetails d) {
    capturedStart = d;
  }

  onDragStart(details);
  assert(capturedStart != null, 'Should capture start');
  results.add('Callback pattern works');
  print('Callback captured start details');

  // Test 17: High consecutive count
  final manyTapStart = TapDragStartDetails(
    globalPosition: Offset.zero,
    localPosition: Offset.zero,
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 5,
  );
  assert(manyTapStart.consecutiveTapCount == 5, 'Count should be 5');
  results.add('High tap count: ${manyTapStart.consecutiveTapCount}');
  print('High consecutive count start: ${manyTapStart.consecutiveTapCount}');

  // Test 18: Start vs Down comparison
  final downPos = Offset(100.0, 200.0);
  final startMatchesDown = details.globalPosition == downPos;
  assert(startMatchesDown, 'Start should match down position');
  results.add('Start matches down: $startMatchesDown');
  print('Start position equals down position: $startMatchesDown');

  // Test 19: All device kinds
  for (final kind in PointerDeviceKind.values) {
    print('Available device kind: $kind');
  }
  results.add('Device kinds enumerated');

  // Test 20: Summary
  results.add(
    'Properties: globalPosition, localPosition, kind, consecutiveTapCount',
  );
  print(
    'TapDragStartDetails: marks drag gesture initiation after slop exceeded',
  );

  print('TapDragStartDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapDragStartDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Properties: globalPosition, localPosition'),
      Text('Properties: kind, consecutiveTapCount'),
      Text('Usage: onDragStart callback'),
      Text('Event: triggered when drag slop exceeded'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
