// D4rt test script: Tests SerialTapUpDetails concepts from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapUpDetails comprehensive test executing');
  final results = <String>[];

  // ========== SerialTapUpDetails Tests ==========
  print('Testing SerialTapUpDetails...');

  // Test 1: Create SerialTapUpDetails with count 1 (single tap)
  final singleTapUp = SerialTapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 1,
  );
  assert(singleTapUp.count == 1, 'Count should be 1');
  results.add('Single tap up: count=${singleTapUp.count}');
  print('Single tap up details: count=${singleTapUp.count}');

  // Test 2: Global position property
  assert(
    singleTapUp.globalPosition == Offset(100.0, 200.0),
    'Global position should match',
  );
  results.add('Global position: ${singleTapUp.globalPosition}');
  print('Global position: ${singleTapUp.globalPosition}');

  // Test 3: Local position property
  assert(
    singleTapUp.localPosition == Offset(50.0, 100.0),
    'Local position should match',
  );
  results.add('Local position: ${singleTapUp.localPosition}');
  print('Local position: ${singleTapUp.localPosition}');

  // Test 4: Kind property
  assert(singleTapUp.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('Kind: ${singleTapUp.kind}');
  print('Device kind: ${singleTapUp.kind}');

  // Test 5: Double tap up (count 2)
  final doubleTapUp = SerialTapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 2,
  );
  assert(doubleTapUp.count == 2, 'Count should be 2');
  results.add('Double tap up: count=${doubleTapUp.count}');
  print('Double tap up details: count=${doubleTapUp.count}');

  // Test 6: Triple tap up (count 3)
  final tripleTapUp = SerialTapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 3,
  );
  assert(tripleTapUp.count == 3, 'Count should be 3');
  results.add('Triple tap up: count=${tripleTapUp.count}');
  print('Triple tap up details: count=${tripleTapUp.count}');

  // Test 7: Mouse device kind
  final mouseUp = SerialTapUpDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.mouse,
    count: 1,
  );
  assert(mouseUp.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('Mouse up: ${mouseUp.kind}');
  print('Mouse up details: ${mouseUp.kind}');

  // Test 8: Stylus device kind
  final stylusUp = SerialTapUpDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.stylus,
    count: 1,
  );
  assert(stylusUp.kind == PointerDeviceKind.stylus, 'Kind should be stylus');
  results.add('Stylus up: ${stylusUp.kind}');
  print('Stylus up details: ${stylusUp.kind}');

  // Test 9: Trackpad device kind
  final trackpadUp = SerialTapUpDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.trackpad,
    count: 1,
  );
  assert(
    trackpadUp.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('Trackpad up: ${trackpadUp.kind}');
  print('Trackpad up details: ${trackpadUp.kind}');

  // Test 10: Position equality between down and up
  final downPos = Offset(100.0, 200.0);
  final upPos = singleTapUp.globalPosition;
  assert(downPos == upPos, 'Down and up positions should match');
  results.add('Position equality: ${downPos == upPos}');
  print('Down/Up position equality: ${downPos == upPos}');

  // Test 11: Calculate tap duration concept
  final downTime = Duration(milliseconds: 100);
  final upTime = Duration(milliseconds: 150);
  final tapDuration = upTime - downTime;
  assert(tapDuration.inMilliseconds == 50, 'Duration should be 50ms');
  results.add('Tap duration concept: ${tapDuration.inMilliseconds}ms');
  print('Tap duration: ${tapDuration.inMilliseconds}ms');

  // Test 12: Long press threshold (tap is shorter)
  final kLongPressTimeout = Duration(milliseconds: 500);
  final isQuickTap = tapDuration < kLongPressTimeout;
  assert(isQuickTap, 'Should be quick tap, not long press');
  results.add('Quick tap (not long press): $isQuickTap');
  print('Quick tap vs long press: $isQuickTap');

  // Test 13: Position delta during tap
  final tapDownPos = Offset(100.0, 200.0);
  final tapUpPos = Offset(102.0, 203.0);
  final delta = tapUpPos - tapDownPos;
  final deltaDist = delta.distance;
  results.add('Tap delta distance: ${deltaDist.toStringAsFixed(2)}');
  print(
    'Position delta during tap: $delta (distance: ${deltaDist.toStringAsFixed(2)})',
  );

  // Test 14: Within tap tolerance
  final kTapTolerance = 18.0;
  final withinTolerance = deltaDist < kTapTolerance;
  assert(withinTolerance, 'Delta should be within tolerance');
  results.add('Within tap tolerance: $withinTolerance');
  print('Within tap tolerance ($kTapTolerance): $withinTolerance');

  // Test 15: Global to local transform
  final transform = singleTapUp.globalPosition - singleTapUp.localPosition;
  results.add('Position transform: $transform');
  print('Global to local transform: $transform');

  // Test 16: Quadruple tap up
  final quadTapUp = SerialTapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 4,
  );
  assert(quadTapUp.count == 4, 'Count should be 4');
  results.add('Quad tap up: count=${quadTapUp.count}');
  print('Quadruple tap up: count=${quadTapUp.count}');

  // Test 17: High count taps (5 or more)
  final manyTapUp = SerialTapUpDetails(
    globalPosition: Offset.zero,
    localPosition: Offset.zero,
    kind: PointerDeviceKind.touch,
    count: 10,
  );
  assert(manyTapUp.count == 10, 'Count should be 10');
  results.add('Many taps: count=${manyTapUp.count}');
  print('Many tap up: count=${manyTapUp.count}');

  // Test 18: Offset operations
  final scaledPos = singleTapUp.globalPosition * 1.5;
  results.add('Scaled position (1.5x): $scaledPos');
  print('Scaled position: $scaledPos');

  // Test 19: All device kinds enumeration
  final kinds = PointerDeviceKind.values;
  results.add('Device kinds count: ${kinds.length}');
  print('Available device kinds: $kinds');

  // Test 20: Up event as tap completion indicator
  final tapCompleted = singleTapUp.count > 0;
  assert(tapCompleted, 'Valid up means tap completed');
  results.add('Tap completed: $tapCompleted');
  print('Tap completed indicator: $tapCompleted');

  print('SerialTapUpDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SerialTapUpDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Properties: globalPosition, localPosition'),
      Text('Properties: kind, count'),
      Text('Count: indicates tap sequence completion'),
      Text('Usage: onSerialTapUp callback'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
