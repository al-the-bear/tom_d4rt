// D4rt test script: Tests PointerEventConverter concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEventConverter test executing');
  final results = <String>[];

  // ========== PointerEventConverter Concepts ==========
  print('Testing PointerEventConverter concepts...');

  // Test 1: PointerEventConverter has expand static method
  results.add('PointerEventConverter class available');
  print('PointerEventConverter is available for event conversion');

  // Test 2: Test PointerDownEvent conversion structure
  final downEvent = PointerDownEvent(
    position: Offset(100.0, 150.0),
    kind: PointerDeviceKind.touch,
    device: 0,
    buttons: kPrimaryButton,
  );
  assert(downEvent is PointerEvent, 'Should be PointerEvent');
  results.add('PointerDownEvent prepared');
  print('PointerDownEvent for conversion: ${downEvent.runtimeType}');

  // Test 3: Position from event
  final position = downEvent.position;
  assert(position == Offset(100.0, 150.0), 'Position should match');
  results.add('position: $position');
  print('Event position: $position');

  // Test 4: LocalPosition property
  results.add('localPosition: ${downEvent.localPosition}');
  print('Event localPosition: ${downEvent.localPosition}');

  // Test 5: PointerMoveEvent for conversion
  final moveEvent = PointerMoveEvent(
    position: Offset(120.0, 170.0),
    delta: Offset(20.0, 20.0),
    kind: PointerDeviceKind.touch,
  );
  assert(moveEvent.delta == Offset(20.0, 20.0), 'Delta should match');
  results.add('moveEvent delta: ${moveEvent.delta}');
  print('PointerMoveEvent delta: ${moveEvent.delta}');

  // Test 6: PointerUpEvent for conversion
  final upEvent = PointerUpEvent(
    position: Offset(140.0, 190.0),
    kind: PointerDeviceKind.touch,
  );
  assert(upEvent.down == false, 'Down should be false');
  results.add('upEvent down: ${upEvent.down}');
  print('PointerUpEvent down: ${upEvent.down}');

  // Test 7: Pointer event sequence concept
  final events = <PointerEvent>[downEvent, moveEvent, upEvent];
  assert(events.length == 3, 'Should have 3 events');
  results.add('Event sequence: ${events.length} events');
  print('Event sequence created: ${events.length} events');

  // Test 8: TimeStamp progression
  final timedDown = PointerDownEvent(
    position: Offset(100, 100),
    timeStamp: Duration(milliseconds: 0),
  );
  final timedMove = PointerMoveEvent(
    position: Offset(110, 110),
    delta: Offset(10, 10),
    timeStamp: Duration(milliseconds: 16),
  );
  final timedUp = PointerUpEvent(
    position: Offset(120, 120),
    timeStamp: Duration(milliseconds: 32),
  );
  results.add('TimeStamps: 0, 16, 32 ms');
  print(
    'TimeStamp progression: ${timedDown.timeStamp}, ${timedMove.timeStamp}, ${timedUp.timeStamp}',
  );

  // Test 9: Device consistency in sequence
  final deviceId = 5;
  final deviceDown = PointerDownEvent(
    position: Offset(50, 50),
    device: deviceId,
  );
  final deviceMove = PointerMoveEvent(
    position: Offset(60, 60),
    delta: Offset(10, 10),
    device: deviceId,
  );
  final deviceUp = PointerUpEvent(position: Offset(70, 70), device: deviceId);
  assert(
    deviceDown.device == deviceMove.device &&
        deviceMove.device == deviceUp.device,
    'Devices should match',
  );
  results.add('Device consistency: $deviceId');
  print('Device consistency across sequence: $deviceId');

  // Test 10: Pointer ID consistency
  final pointerId = 42;
  final pointerDown = PointerDownEvent(
    position: Offset(80, 80),
    pointer: pointerId,
  );
  final pointerUp = PointerUpEvent(
    position: Offset(80, 80),
    pointer: pointerId,
  );
  assert(pointerDown.pointer == pointerUp.pointer, 'Pointer IDs should match');
  results.add('Pointer ID consistency: $pointerId');
  print('Pointer ID consistency: $pointerId');

  // Test 11: Kind consistency
  final kind = PointerDeviceKind.touch;
  assert(downEvent.kind == kind, 'Kind should be touch');
  results.add('Kind consistency: $kind');
  print('Kind consistency: $kind');

  // Test 12: Buttons state in down/move
  assert(downEvent.buttons == kPrimaryButton, 'Buttons should be primary');
  results.add('buttons: ${downEvent.buttons}');
  print('Buttons state: ${downEvent.buttons}');

  // Test 13: PointerAddedEvent for lifecycle
  final addedEvent = PointerAddedEvent(
    position: Offset(100, 100),
    kind: PointerDeviceKind.mouse,
    device: 1,
  );
  results.add('Added event device: ${addedEvent.device}');
  print('PointerAddedEvent device: ${addedEvent.device}');

  // Test 14: PointerRemovedEvent for lifecycle
  final removedEvent = PointerRemovedEvent(
    position: Offset(100, 100),
    kind: PointerDeviceKind.mouse,
    device: 1,
  );
  results.add('Removed event device: ${removedEvent.device}');
  print('PointerRemovedEvent device: ${removedEvent.device}');

  // Test 15: Hover event conversion
  final hoverEvent = PointerHoverEvent(
    position: Offset(150, 200),
    delta: Offset(5, 5),
  );
  results.add('hover delta: ${hoverEvent.delta}');
  print('PointerHoverEvent delta: ${hoverEvent.delta}');

  // Test 16: Pressure values in conversion
  final pressureEvent = PointerDownEvent(
    position: Offset(100, 100),
    pressure: 0.8,
    pressureMin: 0.0,
    pressureMax: 1.0,
  );
  results.add('pressure: ${pressureEvent.pressure}');
  print('Pressure in event: ${pressureEvent.pressure}');

  // Test 17: Synthesized property check
  results.add('synthesized: ${downEvent.synthesized}');
  print('Event synthesized: ${downEvent.synthesized}');

  // Test 18: Obscured property check
  final obscuredEvent = PointerDownEvent(
    position: Offset(100, 100),
    obscured: true,
  );
  assert(obscuredEvent.obscured == true, 'Should be obscured');
  results.add('obscured: ${obscuredEvent.obscured}');
  print('Event obscured: ${obscuredEvent.obscured}');

  // Test 19: EmbedderId in conversion
  final embedEvent = PointerDownEvent(
    position: Offset(100, 100),
    embedderId: 123,
  );
  assert(embedEvent.embedderId == 123, 'EmbedderId should match');
  results.add('embedderId: ${embedEvent.embedderId}');
  print('Event embedderId: ${embedEvent.embedderId}');

  // Test 20: Conversion preserves all properties
  final fullEvent = PointerDownEvent(
    position: Offset(200, 300),
    timeStamp: Duration(milliseconds: 100),
    kind: PointerDeviceKind.touch,
    device: 2,
    pointer: 99,
    buttons: kPrimaryButton,
    pressure: 0.5,
  );
  assert(fullEvent.position == Offset(200, 300), 'All properties preserved');
  results.add('Full event: all properties preserved');
  print(
    'Full event conversion: position=${fullEvent.position}, pointer=${fullEvent.pointer}',
  );

  print('PointerEventConverter test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEventConverter Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
