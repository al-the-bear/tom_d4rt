// D4rt test script: Tests SerialTapGestureRecognizer concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== SerialTapGestureRecognizer Tests ==========
  print('Testing SerialTapGestureRecognizer...');

  // Test 1: Create SerialTapGestureRecognizer
  final recognizer = SerialTapGestureRecognizer();
  assert(recognizer != null, 'Should create SerialTapGestureRecognizer');
  results.add('SerialTapGestureRecognizer created');
  print('SerialTapGestureRecognizer created: ${recognizer.runtimeType}');

  // Test 2: Check inheritance
  assert(recognizer is GestureRecognizer, 'Should be GestureRecognizer');
  results.add('Inheritance: GestureRecognizer');
  print('Inheritance verified: GestureRecognizer');

  // Test 3: Set onSerialTapDown callback
  var serialTapDownCount = 0;
  SerialTapDownDetails? lastDownDetails;
  recognizer.onSerialTapDown = (SerialTapDownDetails details) {
    serialTapDownCount++;
    lastDownDetails = details;
  };
  results.add('onSerialTapDown callback set');
  print('onSerialTapDown callback configured');

  // Test 4: Set onSerialTapUp callback
  var serialTapUpCount = 0;
  SerialTapUpDetails? lastUpDetails;
  recognizer.onSerialTapUp = (SerialTapUpDetails details) {
    serialTapUpCount++;
    lastUpDetails = details;
  };
  results.add('onSerialTapUp callback set');
  print('onSerialTapUp callback configured');

  // Test 5: Set onSerialTapCancel callback
  var serialTapCancelCount = 0;
  SerialTapCancelDetails? lastCancelDetails;
  recognizer.onSerialTapCancel = (SerialTapCancelDetails details) {
    serialTapCancelCount++;
    lastCancelDetails = details;
  };
  results.add('onSerialTapCancel callback set');
  print('onSerialTapCancel callback configured');

  // Test 6: SerialTapDownDetails construction
  final downDetails = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 1,
    buttons: kPrimaryButton,
  );
  assert(
    downDetails.globalPosition == Offset(100.0, 200.0),
    'Global should match',
  );
  assert(downDetails.count == 1, 'Count should be 1');
  results.add('SerialTapDownDetails: count=${downDetails.count}');
  print(
    'SerialTapDownDetails: global=${downDetails.globalPosition}, count=${downDetails.count}',
  );

  // Test 7: SerialTapDownDetails for double tap
  final doubleTapDown = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 2,
    buttons: kPrimaryButton,
  );
  assert(doubleTapDown.count == 2, 'Count should be 2 for double tap');
  results.add('Double tap count: ${doubleTapDown.count}');
  print('Double tap SerialTapDownDetails: count=${doubleTapDown.count}');

  // Test 8: SerialTapDownDetails for triple tap
  final tripleTapDown = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 3,
    buttons: kPrimaryButton,
  );
  assert(tripleTapDown.count == 3, 'Count should be 3 for triple tap');
  results.add('Triple tap count: ${tripleTapDown.count}');
  print('Triple tap SerialTapDownDetails: count=${tripleTapDown.count}');

  // Test 9: SerialTapUpDetails construction
  final upDetails = SerialTapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 1,
  );
  assert(
    upDetails.globalPosition == Offset(100.0, 200.0),
    'Global should match',
  );
  assert(upDetails.count == 1, 'Count should be 1');
  results.add('SerialTapUpDetails: count=${upDetails.count}');
  print(
    'SerialTapUpDetails: global=${upDetails.globalPosition}, count=${upDetails.count}',
  );

  // Test 10: SerialTapCancelDetails construction
  final cancelDetails = SerialTapCancelDetails(count: 2);
  assert(cancelDetails.count == 2, 'Count should be 2');
  results.add('SerialTapCancelDetails: count=${cancelDetails.count}');
  print('SerialTapCancelDetails: count=${cancelDetails.count}');

  // Test 11: Position and local position relationship
  final globalPos = Offset(300.0, 400.0);
  final localPos = Offset(100.0, 150.0);
  final transform = globalPos - localPos;
  assert(transform == Offset(200.0, 250.0), 'Transform should be (200, 250)');
  results.add('Position transform: $transform');
  print('Global to local transform: $transform');

  // Test 12: Buttons property for different tap types
  assert(kPrimaryButton == 1, 'Primary button is 1');
  assert(kSecondaryButton == 2, 'Secondary button is 2');
  results.add(
    'Button values: primary=$kPrimaryButton, secondary=$kSecondaryButton',
  );
  print('Button values: primary=$kPrimaryButton, secondary=$kSecondaryButton');

  // Test 13: Multiple pointer device kinds
  for (final kind in [
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
  ]) {
    final details = SerialTapDownDetails(
      globalPosition: Offset.zero,
      localPosition: Offset.zero,
      kind: kind,
      count: 1,
      buttons: kPrimaryButton,
    );
    assert(details.kind == kind, 'Kind should match');
    print('SerialTapDownDetails with $kind');
  }
  results.add('Device kinds tested: touch, mouse, stylus');

  // Test 14: Tap timing concept
  final tapTimeout = Duration(milliseconds: 300);
  assert(tapTimeout.inMilliseconds == 300, 'Timeout should be 300ms');
  results.add('Tap timeout concept: ${tapTimeout.inMilliseconds}ms');
  print('Double tap timeout concept: ${tapTimeout.inMilliseconds}ms');

  // Test 15: Tap slop distance concept
  final kDoubleTapSlop = 100.0; // typical double tap slop
  final firstTapPos = Offset(100.0, 100.0);
  final secondTapPos = Offset(120.0, 110.0);
  final tapDistance = (secondTapPos - firstTapPos).distance;
  final withinSlop = tapDistance < kDoubleTapSlop;
  assert(withinSlop, 'Taps should be within slop');
  results.add(
    'Tap distance ${tapDistance.toStringAsFixed(2)} within slop: $withinSlop',
  );
  print(
    'Tap slop: distance=${tapDistance.toStringAsFixed(2)}, within=$withinSlop',
  );

  // Test 16: Tap count tracking concept
  var tapCount = 0;
  void simulateTap() {
    tapCount++;
    print('Tap count: $tapCount');
  }

  simulateTap();
  simulateTap();
  simulateTap();
  assert(tapCount == 3, 'Should track 3 taps');
  results.add('Tap count tracking: $tapCount');

  // Test 17: Position hash for tap location grouping
  final posHash1 = Offset(100.0, 100.0).hashCode;
  final posHash2 = Offset(100.0, 100.0).hashCode;
  assert(posHash1 == posHash2, 'Same position same hash');
  results.add('Position hash consistency verified');
  print('Position hash: $posHash1');

  // Test 18: Create recognizer with debugOwner
  final recognizer2 = SerialTapGestureRecognizer(debugOwner: 'TestOwner');
  assert(recognizer2 != null, 'Should create with debugOwner');
  results.add('SerialTapGestureRecognizer with debugOwner');
  print('Created recognizer with debugOwner');
  recognizer2.dispose();

  // Test 19: Callback state verification
  assert(recognizer.onSerialTapDown != null, 'onSerialTapDown should be set');
  assert(recognizer.onSerialTapUp != null, 'onSerialTapUp should be set');
  assert(
    recognizer.onSerialTapCancel != null,
    'onSerialTapCancel should be set',
  );
  results.add('All callbacks verified as set');
  print('Callbacks state verified');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('SerialTapGestureRecognizer disposed');

  print(
    'SerialTapGestureRecognizer test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SerialTapGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Callbacks: onSerialTapDown, onSerialTapUp, onSerialTapCancel'),
      Text('Details: SerialTapDownDetails, SerialTapUpDetails'),
      Text('Multi-tap: single, double, triple (count property)'),
      Text('Timing: tap timeout, slop distance'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
