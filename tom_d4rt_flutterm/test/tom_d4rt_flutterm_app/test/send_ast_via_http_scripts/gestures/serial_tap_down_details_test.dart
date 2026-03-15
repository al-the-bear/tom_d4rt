// D4rt test script: Tests SerialTapDownDetails concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapDownDetails comprehensive test executing');
  final results = <String>[];

  // ========== SerialTapDownDetails Tests ==========
  print('Testing SerialTapDownDetails...');

  // Test 1: Create SerialTapDownDetails with count 1 (single tap)
  final singleTapDetails = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 1,
    buttons: kPrimaryButton,
  );
  assert(singleTapDetails.count == 1, 'Count should be 1');
  results.add('Single tap: count=${singleTapDetails.count}');
  print('Single tap details: count=${singleTapDetails.count}');

  // Test 2: Global position property
  assert(
    singleTapDetails.globalPosition == Offset(100.0, 200.0),
    'Global position should match',
  );
  results.add('Global position: ${singleTapDetails.globalPosition}');
  print('Global position: ${singleTapDetails.globalPosition}');

  // Test 3: Local position property
  assert(
    singleTapDetails.localPosition == Offset(50.0, 100.0),
    'Local position should match',
  );
  results.add('Local position: ${singleTapDetails.localPosition}');
  print('Local position: ${singleTapDetails.localPosition}');

  // Test 4: Kind property
  assert(
    singleTapDetails.kind == PointerDeviceKind.touch,
    'Kind should be touch',
  );
  results.add('Kind: ${singleTapDetails.kind}');
  print('Device kind: ${singleTapDetails.kind}');

  // Test 5: Buttons property
  assert(
    singleTapDetails.buttons == kPrimaryButton,
    'Buttons should be primary',
  );
  results.add('Buttons: ${singleTapDetails.buttons}');
  print('Buttons: ${singleTapDetails.buttons}');

  // Test 6: Double tap details (count 2)
  final doubleTapDetails = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 2,
    buttons: kPrimaryButton,
  );
  assert(doubleTapDetails.count == 2, 'Count should be 2 for double tap');
  results.add('Double tap: count=${doubleTapDetails.count}');
  print('Double tap details: count=${doubleTapDetails.count}');

  // Test 7: Triple tap details (count 3)
  final tripleTapDetails = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 3,
    buttons: kPrimaryButton,
  );
  assert(tripleTapDetails.count == 3, 'Count should be 3 for triple tap');
  results.add('Triple tap: count=${tripleTapDetails.count}');
  print('Triple tap details: count=${tripleTapDetails.count}');

  // Test 8: Quadruple tap details (count 4)
  final quadTapDetails = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 4,
    buttons: kPrimaryButton,
  );
  assert(quadTapDetails.count == 4, 'Count should be 4 for quad tap');
  results.add('Quad tap: count=${quadTapDetails.count}');
  print('Quadruple tap details: count=${quadTapDetails.count}');

  // Test 9: Mouse device kind
  final mouseDetails = SerialTapDownDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.mouse,
    count: 1,
    buttons: kPrimaryButton,
  );
  assert(mouseDetails.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('Mouse device: ${mouseDetails.kind}');
  print('Mouse details: ${mouseDetails.kind}');

  // Test 10: Stylus device kind
  final stylusDetails = SerialTapDownDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.stylus,
    count: 1,
    buttons: kPrimaryButton,
  );
  assert(
    stylusDetails.kind == PointerDeviceKind.stylus,
    'Kind should be stylus',
  );
  results.add('Stylus device: ${stylusDetails.kind}');
  print('Stylus details: ${stylusDetails.kind}');

  // Test 11: Secondary button
  final secondaryDetails = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.mouse,
    count: 1,
    buttons: kSecondaryButton,
  );
  assert(
    secondaryDetails.buttons == kSecondaryButton,
    'Should be secondary button',
  );
  results.add('Secondary button: ${secondaryDetails.buttons}');
  print('Secondary button details: ${secondaryDetails.buttons}');

  // Test 12: Position equality check
  final pos1 = singleTapDetails.globalPosition;
  final pos2 = doubleTapDetails.globalPosition;
  assert(pos1 == pos2, 'Positions should be equal');
  results.add('Position equality: ${pos1 == pos2}');
  print('Position equality: ${pos1 == pos2}');

  // Test 13: Calculate distance between taps
  final tap1Pos = Offset(100.0, 100.0);
  final tap2Pos = Offset(110.0, 115.0);
  final distance = (tap2Pos - tap1Pos).distance;
  results.add('Tap distance: ${distance.toStringAsFixed(2)}');
  print('Distance between taps: ${distance.toStringAsFixed(2)}');

  // Test 14: Within double-tap slop
  final kDoubleTapSlop = 100.0;
  final withinSlop = distance < kDoubleTapSlop;
  assert(withinSlop, 'Distance should be within slop');
  results.add('Within slop ($kDoubleTapSlop): $withinSlop');
  print('Within double-tap slop: $withinSlop');

  // Test 15: Global to local transform
  final transform =
      singleTapDetails.globalPosition - singleTapDetails.localPosition;
  assert(transform == Offset(50.0, 100.0), 'Transform should be (50, 100)');
  results.add('Global to local transform: $transform');
  print('Position transform: $transform');

  // Test 16: Offset operations
  final scaledPos = singleTapDetails.globalPosition * 2.0;
  assert(
    scaledPos == Offset(200.0, 400.0),
    'Scaled position should be (200, 400)',
  );
  results.add('Scaled position: $scaledPos');
  print('Scaled position (2x): $scaledPos');

  // Test 17: Button constants
  assert(kPrimaryButton == 1, 'Primary is 1');
  assert(kSecondaryButton == 2, 'Secondary is 2');
  assert(kTertiaryButton == 4, 'Tertiary is 4');
  results.add('Button constants: 1, 2, 4');
  print('Button constants: primary=1, secondary=2, tertiary=4');

  // Test 18: PointerDeviceKind enumeration
  final kinds = PointerDeviceKind.values;
  assert(kinds.length >= 5, 'Should have multiple kinds');
  results.add('Device kinds: ${kinds.length} types');
  print('PointerDeviceKind values: $kinds');

  // Test 19: Count as tap sequence indicator
  for (var i = 1; i <= 5; i++) {
    final details = SerialTapDownDetails(
      globalPosition: Offset.zero,
      localPosition: Offset.zero,
      kind: PointerDeviceKind.touch,
      count: i,
      buttons: kPrimaryButton,
    );
    print('Tap sequence $i: count=${details.count}');
  }
  results.add('Tap sequence 1-5 tested');

  // Test 20: Summary of SerialTapDownDetails properties
  results.add(
    'Properties: globalPosition, localPosition, kind, count, buttons',
  );
  print(
    'SerialTapDownDetails properties: globalPosition, localPosition, kind, count, buttons',
  );

  print('SerialTapDownDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SerialTapDownDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Properties: globalPosition, localPosition'),
      Text('Properties: kind, count, buttons'),
      Text('Count: 1=single, 2=double, 3=triple, 4+=more'),
      Text('Device kinds: touch, mouse, stylus'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
