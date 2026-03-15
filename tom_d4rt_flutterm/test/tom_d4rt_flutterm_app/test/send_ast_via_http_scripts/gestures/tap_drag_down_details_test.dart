// D4rt test script: Tests TapDragDownDetails from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragDownDetails comprehensive test executing');
  final results = <String>[];

  // ========== TapDragDownDetails Tests ==========
  print('Testing TapDragDownDetails...');

  // Test 1: Create TapDragDownDetails
  final details = TapDragDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );
  assert(details != null, 'Should create details');
  results.add('TapDragDownDetails created');
  print('TapDragDownDetails created');

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

  // Test 6: Double tap down details
  final doubleTapDetails = TapDragDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 2,
  );
  assert(doubleTapDetails.consecutiveTapCount == 2, 'Count should be 2');
  results.add('Double tap count: ${doubleTapDetails.consecutiveTapCount}');
  print('Double tap down: count=${doubleTapDetails.consecutiveTapCount}');

  // Test 7: Triple tap down details
  final tripleTapDetails = TapDragDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 3,
  );
  assert(tripleTapDetails.consecutiveTapCount == 3, 'Count should be 3');
  results.add('Triple tap count: ${tripleTapDetails.consecutiveTapCount}');
  print('Triple tap down: count=${tripleTapDetails.consecutiveTapCount}');

  // Test 8: Mouse device
  final mouseDetails = TapDragDownDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 1,
  );
  assert(mouseDetails.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('Mouse device: ${mouseDetails.kind}');
  print('Mouse down: kind=${mouseDetails.kind}');

  // Test 9: Stylus device
  final stylusDetails = TapDragDownDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.stylus,
    consecutiveTapCount: 1,
  );
  assert(
    stylusDetails.kind == PointerDeviceKind.stylus,
    'Kind should be stylus',
  );
  results.add('Stylus device: ${stylusDetails.kind}');
  print('Stylus down: kind=${stylusDetails.kind}');

  // Test 10: Position transform
  final transform = details.globalPosition - details.localPosition;
  assert(transform == Offset(50.0, 100.0), 'Transform should match');
  results.add('Position transform: $transform');
  print('Global-local transform: $transform');

  // Test 11: Position comparison
  final posEquals = details.globalPosition == doubleTapDetails.globalPosition;
  assert(posEquals, 'Same position for consecutive taps');
  results.add('Position equality: $posEquals');
  print('Position equality across taps: $posEquals');

  // Test 12: Distance from origin
  final distFromOrigin = details.globalPosition.distance;
  results.add('Distance from origin: ${distFromOrigin.toStringAsFixed(2)}');
  print('Distance from origin: ${distFromOrigin.toStringAsFixed(2)}');

  // Test 13: Offset operations
  final scaledPos = details.globalPosition * 2.0;
  assert(scaledPos == Offset(200.0, 400.0), 'Scaled should be (200, 400)');
  results.add('Scaled position: $scaledPos');
  print('Scaled position (2x): $scaledPos');

  // Test 14: Position direction
  final direction = details.globalPosition.direction;
  results.add('Position direction: ${direction.toStringAsFixed(4)} rad');
  print('Position direction: ${direction.toStringAsFixed(4)} radians');

  // Test 15: High consecutive count
  final manyTaps = TapDragDownDetails(
    globalPosition: Offset.zero,
    localPosition: Offset.zero,
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 10,
  );
  assert(manyTaps.consecutiveTapCount == 10, 'Count should be 10');
  results.add('High tap count: ${manyTaps.consecutiveTapCount}');
  print('High consecutive count: ${manyTaps.consecutiveTapCount}');

  // Test 16: All device kinds
  final kinds = PointerDeviceKind.values;
  for (final k in kinds) {
    print('Device kind available: $k');
  }
  results.add('Device kinds: ${kinds.length} types');

  // Test 17: Use in callback pattern
  TapDragDownDetails? capturedDetails;
  void onTapDown(TapDragDownDetails d) {
    capturedDetails = d;
  }

  onTapDown(details);
  assert(capturedDetails != null, 'Should capture details');
  results.add('Callback pattern works');
  print('Callback captured details');

  // Test 18: Position hash
  final posHash1 = details.globalPosition.hashCode;
  final posHash2 = Offset(100.0, 200.0).hashCode;
  assert(posHash1 == posHash2, 'Same position same hash');
  results.add('Position hash consistency');
  print('Position hash: $posHash1');

  // Test 19: Tap count semantics
  final semantics = {1: 'single tap', 2: 'double tap', 3: 'triple tap'};
  for (var entry in semantics.entries) {
    print('Count ${entry.key}: ${entry.value}');
  }
  results.add('Tap count semantics documented');

  // Test 20: Summary
  results.add(
    'Properties: globalPosition, localPosition, kind, consecutiveTapCount',
  );
  print(
    'TapDragDownDetails: globalPosition, localPosition, kind, consecutiveTapCount',
  );

  print('TapDragDownDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapDragDownDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Properties: globalPosition, localPosition'),
      Text('Properties: kind, consecutiveTapCount'),
      Text('Usage: onTapDown in TapAndDragGestureRecognizer'),
      Text('Count: tracks consecutive taps'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
