// D4rt test script: Tests TapGestureRecognizer concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== TapGestureRecognizer Tests ==========
  print('Testing TapGestureRecognizer...');

  // Test 1: Create TapGestureRecognizer
  final recognizer = TapGestureRecognizer();
  assert(recognizer != null, 'Should create TapGestureRecognizer');
  results.add('TapGestureRecognizer created');
  print('TapGestureRecognizer created: ${recognizer.runtimeType}');

  // Test 2: Check inheritance
  assert(recognizer is GestureRecognizer, 'Should be GestureRecognizer');
  assert(
    recognizer is OneSequenceGestureRecognizer,
    'Should be OneSequenceGestureRecognizer',
  );
  results.add(
    'Inheritance verified: GestureRecognizer, OneSequenceGestureRecognizer',
  );
  print('Inheritance: GestureRecognizer, OneSequenceGestureRecognizer');

  // Test 3: Set onTapDown callback
  var tapDownCalled = false;
  TapDownDetails? lastTapDownDetails;
  recognizer.onTapDown = (TapDownDetails details) {
    tapDownCalled = true;
    lastTapDownDetails = details;
  };
  results.add('onTapDown callback set');
  print('onTapDown callback configured');

  // Test 4: Set onTapUp callback
  var tapUpCalled = false;
  TapUpDetails? lastTapUpDetails;
  recognizer.onTapUp = (TapUpDetails details) {
    tapUpCalled = true;
    lastTapUpDetails = details;
  };
  results.add('onTapUp callback set');
  print('onTapUp callback configured');

  // Test 5: Set onTap callback
  var tapCalled = false;
  recognizer.onTap = () {
    tapCalled = true;
  };
  results.add('onTap callback set');
  print('onTap callback configured');

  // Test 6: Set onTapCancel callback
  var tapCancelCalled = false;
  recognizer.onTapCancel = () {
    tapCancelCalled = true;
  };
  results.add('onTapCancel callback set');
  print('onTapCancel callback configured');

  // Test 7: Set onSecondaryTap callback
  var secondaryTapCalled = false;
  recognizer.onSecondaryTap = () {
    secondaryTapCalled = true;
  };
  results.add('onSecondaryTap callback set');
  print('onSecondaryTap callback configured');

  // Test 8: Set onSecondaryTapDown callback
  var secondaryTapDownCalled = false;
  recognizer.onSecondaryTapDown = (TapDownDetails details) {
    secondaryTapDownCalled = true;
  };
  results.add('onSecondaryTapDown callback set');
  print('onSecondaryTapDown callback configured');

  // Test 9: Set onSecondaryTapUp callback
  var secondaryTapUpCalled = false;
  recognizer.onSecondaryTapUp = (TapUpDetails details) {
    secondaryTapUpCalled = true;
  };
  results.add('onSecondaryTapUp callback set');
  print('onSecondaryTapUp callback configured');

  // Test 10: Set onSecondaryTapCancel callback
  var secondaryTapCancelCalled = false;
  recognizer.onSecondaryTapCancel = () {
    secondaryTapCancelCalled = true;
  };
  results.add('onSecondaryTapCancel callback set');
  print('onSecondaryTapCancel callback configured');

  // Test 11: Set onTertiaryTapDown callback
  var tertiaryTapDownCalled = false;
  recognizer.onTertiaryTapDown = (TapDownDetails details) {
    tertiaryTapDownCalled = true;
  };
  results.add('onTertiaryTapDown callback set');
  print('onTertiaryTapDown callback configured');

  // Test 12: Set onTertiaryTapUp callback
  var tertiaryTapUpCalled = false;
  recognizer.onTertiaryTapUp = (TapUpDetails details) {
    tertiaryTapUpCalled = true;
  };
  results.add('onTertiaryTapUp callback set');
  print('onTertiaryTapUp callback configured');

  // Test 13: Set onTertiaryTapCancel callback
  var tertiaryTapCancelCalled = false;
  recognizer.onTertiaryTapCancel = () {
    tertiaryTapCancelCalled = true;
  };
  results.add('onTertiaryTapCancel callback set');
  print('onTertiaryTapCancel callback configured');

  // Test 14: TapDownDetails construction
  final tapDownDetails = TapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
  );
  assert(
    tapDownDetails.globalPosition == Offset(100.0, 200.0),
    'Global position should match',
  );
  assert(
    tapDownDetails.localPosition == Offset(50.0, 100.0),
    'Local position should match',
  );
  assert(
    tapDownDetails.kind == PointerDeviceKind.touch,
    'Kind should be touch',
  );
  results.add(
    'TapDownDetails: global=${tapDownDetails.globalPosition}, local=${tapDownDetails.localPosition}',
  );
  print(
    'TapDownDetails: global=${tapDownDetails.globalPosition}, local=${tapDownDetails.localPosition}, kind=${tapDownDetails.kind}',
  );

  // Test 15: TapUpDetails construction
  final tapUpDetails = TapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(
    tapUpDetails.globalPosition == Offset(100.0, 200.0),
    'Global position should match',
  );
  assert(
    tapUpDetails.localPosition == Offset(50.0, 100.0),
    'Local position should match',
  );
  assert(tapUpDetails.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add(
    'TapUpDetails: global=${tapUpDetails.globalPosition}, local=${tapUpDetails.localPosition}',
  );
  print(
    'TapUpDetails: global=${tapUpDetails.globalPosition}, local=${tapUpDetails.localPosition}, kind=${tapUpDetails.kind}',
  );

  // Test 16: PointerDeviceKind values for tap gestures
  final deviceKinds = PointerDeviceKind.values;
  assert(deviceKinds.contains(PointerDeviceKind.touch), 'Should contain touch');
  assert(deviceKinds.contains(PointerDeviceKind.mouse), 'Should contain mouse');
  assert(
    deviceKinds.contains(PointerDeviceKind.stylus),
    'Should contain stylus',
  );
  results.add('PointerDeviceKind types: ${deviceKinds.length}');
  print('PointerDeviceKind values: $deviceKinds');

  // Test 17: Button constants for tap types
  assert(kPrimaryButton == 1, 'Primary button should be 1');
  assert(kSecondaryButton == 2, 'Secondary button should be 2');
  assert(kTertiaryButton == 4, 'Tertiary button should be 4');
  results.add(
    'Button constants: primary=$kPrimaryButton, secondary=$kSecondaryButton, tertiary=$kTertiaryButton',
  );
  print(
    'Button constants verified: primary=$kPrimaryButton, secondary=$kSecondaryButton, tertiary=$kTertiaryButton',
  );

  // Test 18: Offset calculations for tap positions
  final startPos = Offset(100.0, 100.0);
  final endPos = Offset(105.0, 103.0);
  final tapDistance = (endPos - startPos).distance;
  assert(tapDistance < 20.0, 'Should be within tap tolerance');
  results.add('Tap movement distance: ${tapDistance.toStringAsFixed(2)}');
  print('Tap movement detection: distance=${tapDistance.toStringAsFixed(2)}px');

  // Test 19: Create second recognizer with debugOwner
  final recognizer2 = TapGestureRecognizer(debugOwner: 'TestOwner');
  assert(recognizer2 != null, 'Should create with debugOwner');
  results.add('TapGestureRecognizer with debugOwner created');
  print('TapGestureRecognizer with debugOwner: TestOwner');
  recognizer2.dispose();

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('TapGestureRecognizer disposed');

  print('TapGestureRecognizer test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Callbacks: onTap, onTapDown, onTapUp, onTapCancel'),
      Text('Secondary: onSecondaryTap, onSecondaryTapDown/Up/Cancel'),
      Text('Tertiary: onTertiaryTapDown/Up/Cancel'),
      Text('Details: TapDownDetails, TapUpDetails'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
