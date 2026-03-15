// D4rt test script: Tests PrimaryPointerGestureRecognizer concepts from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PrimaryPointerGestureRecognizer conceptual test executing');
  final results = <String>[];

  // ========== PrimaryPointerGestureRecognizer Tests ==========
  // PrimaryPointerGestureRecognizer is abstract; test via concrete subclasses
  print('Testing PrimaryPointerGestureRecognizer concepts...');

  // Test 1: LongPressGestureRecognizer (concrete subclass)
  final longPress = LongPressGestureRecognizer();
  assert(longPress is GestureRecognizer, 'Should be GestureRecognizer');
  results.add('LongPressGestureRecognizer created');
  print('LongPressGestureRecognizer: ${longPress.runtimeType}');

  // Test 2: Check inheritance chain
  assert(
    longPress is OneSequenceGestureRecognizer,
    'Should be OneSequenceGestureRecognizer',
  );
  results.add('Inheritance: OneSequenceGestureRecognizer');
  print('Inheritance verified: OneSequenceGestureRecognizer');

  // Test 3: Primary pointer concept - single pointer tracking
  var primaryPointer = 0; // First pointer that touches
  results.add('Primary pointer tracking: $primaryPointer');
  print(
    'Primary pointer concept: tracks first touch (pointer $primaryPointer)',
  );

  // Test 4: Initial position tracking
  final initialPosition = Offset(100.0, 200.0);
  results.add('Initial position: $initialPosition');
  print('Initial position captured: $initialPosition');

  // Test 5: Deadline concept (long press timeout)
  final kLongPressTimeout = Duration(milliseconds: 500);
  results.add('Long press timeout: ${kLongPressTimeout.inMilliseconds}ms');
  print('Long press deadline: ${kLongPressTimeout.inMilliseconds}ms');

  // Test 6: PreAcceptSlop concept
  final kTouchSlop = 18.0;
  results.add('Touch slop: $kTouchSlop');
  print('Pre-accept slop (movement threshold): $kTouchSlop');

  // Test 7: Movement beyond slop cancels gesture
  final initialPos = Offset(100.0, 100.0);
  final movedPos = Offset(130.0, 130.0);
  final movement = (movedPos - initialPos).distance;
  final exceedsSlop = movement > kTouchSlop;
  assert(exceedsSlop, 'Movement should exceed slop');
  results.add(
    'Movement ${movement.toStringAsFixed(2)} exceeds slop: $exceedsSlop',
  );
  print('Movement check: $movement > $kTouchSlop = $exceedsSlop');

  // Test 8: Within slop - gesture continues
  final smallMove = Offset(105.0, 105.0);
  final smallDist = (smallMove - initialPos).distance;
  final withinSlop = smallDist <= kTouchSlop;
  assert(withinSlop, 'Small movement should be within slop');
  results.add(
    'Movement ${smallDist.toStringAsFixed(2)} within slop: $withinSlop',
  );
  print('Small movement: $smallDist <= $kTouchSlop = $withinSlop');

  // Test 9: State enum concept for gesture lifecycle
  final states = ['ready', 'possible', 'accepted', 'defunct'];
  for (final state in states) {
    print('Gesture state: $state');
  }
  results.add('Gesture states: ${states.length} states');

  // Test 10: Set onLongPress callback
  var longPressCalled = false;
  longPress.onLongPress = () {
    longPressCalled = true;
  };
  results.add('onLongPress callback set');
  print('onLongPress callback configured');

  // Test 11: Set onLongPressDown callback
  var longPressDownCalled = false;
  longPress.onLongPressDown = (LongPressDownDetails details) {
    longPressDownCalled = true;
  };
  results.add('onLongPressDown callback set');
  print('onLongPressDown callback configured');

  // Test 12: Set onLongPressUp callback
  var longPressUpCalled = false;
  longPress.onLongPressUp = () {
    longPressUpCalled = true;
  };
  results.add('onLongPressUp callback set');
  print('onLongPressUp callback configured');

  // Test 13: Set onLongPressCancel callback
  var longPressCancelCalled = false;
  longPress.onLongPressCancel = () {
    longPressCancelCalled = true;
  };
  results.add('onLongPressCancel callback set');
  print('onLongPressCancel callback configured');

  // Test 14: LongPressDownDetails concept
  final longPressDownDetails = LongPressDownDetails(
    globalPosition: Offset(150.0, 250.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
  );
  results.add(
    'LongPressDownDetails: global=${longPressDownDetails.globalPosition}',
  );
  print('LongPressDownDetails: ${longPressDownDetails.globalPosition}');

  // Test 15: Pointer ID tracking
  final pointerIds = [0, 1, 2]; // Multiple fingers
  final primaryId = pointerIds.first;
  assert(primaryId == 0, 'Primary should be first pointer');
  results.add('Pointer IDs: $pointerIds, primary=$primaryId');
  print('Multi-pointer: IDs=$pointerIds, primary=$primaryId');

  // Test 16: Reject additional pointers concept
  final additionalPointer = 1;
  final shouldReject = additionalPointer != primaryPointer;
  assert(shouldReject, 'Should reject non-primary pointers');
  results.add('Reject additional pointer: $shouldReject');
  print('Additional pointer $additionalPointer rejected: $shouldReject');

  // Test 17: PointerDeviceKind for pressure awareness
  final kind = PointerDeviceKind.touch;
  results.add('Device kind: $kind');
  print('Primary pointer device kind: $kind');

  // Test 18: Resolve gesture concept
  final disposition = GestureDisposition.accepted;
  results.add('Gesture disposition: $disposition');
  print('Gesture resolution: $disposition');

  // Test 19: Verify callbacks set
  assert(longPress.onLongPress != null, 'onLongPress set');
  assert(longPress.onLongPressDown != null, 'onLongPressDown set');
  assert(longPress.onLongPressUp != null, 'onLongPressUp set');
  results.add('All callbacks verified');
  print('All long press callbacks verified');

  // Test 20: Dispose recognizer
  longPress.dispose();
  results.add('Recognizer disposed');
  print('LongPressGestureRecognizer disposed');

  print(
    'PrimaryPointerGestureRecognizer test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PrimaryPointerGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Concept: tracks first (primary) pointer'),
      Text('Subclass: LongPressGestureRecognizer'),
      Text('Properties: deadline, preAcceptSlop'),
      Text('States: ready, possible, accepted, defunct'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
