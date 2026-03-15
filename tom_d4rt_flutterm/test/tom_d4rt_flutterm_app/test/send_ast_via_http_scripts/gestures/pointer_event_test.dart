// D4rt test script: Tests PointerEvent base class concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEvent base class concepts test executing');
  final results = <String>[];

  // ========== PointerEvent Base Class Concepts ==========
  // PointerEvent is abstract, test via concrete subclasses
  print('Testing PointerEvent concepts via concrete implementations...');

  // Test 1: PointerDownEvent as PointerEvent
  final downEvent = PointerDownEvent(
    position: Offset(100.0, 200.0),
    kind: PointerDeviceKind.touch,
    device: 0,
    buttons: kPrimaryButton,
    pressure: 0.5,
    pressureMin: 0.0,
    pressureMax: 1.0,
  );
  assert(downEvent is PointerEvent, 'PointerDownEvent should be PointerEvent');
  results.add('PointerDownEvent is PointerEvent: true');
  print('PointerDownEvent is PointerEvent: true');

  // Test 2: Position property
  assert(downEvent.position == Offset(100.0, 200.0), 'Position should match');
  results.add('position: ${downEvent.position}');
  print('Event position: ${downEvent.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${downEvent.localPosition}');
  print('Event localPosition: ${downEvent.localPosition}');

  // Test 4: PointerDeviceKind enumeration
  assert(downEvent.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('kind: ${downEvent.kind}');
  print('Event kind: ${downEvent.kind}');

  // Test 5: Device identifier
  assert(downEvent.device == 0, 'Device ID should be 0');
  results.add('device: ${downEvent.device}');
  print('Event device: ${downEvent.device}');

  // Test 6: Buttons property
  assert(downEvent.buttons == kPrimaryButton, 'Buttons should be primary');
  results.add('buttons: ${downEvent.buttons}');
  print('Event buttons: ${downEvent.buttons}');

  // Test 7: Pressure properties
  assert(downEvent.pressure == 0.5, 'Pressure should be 0.5');
  assert(downEvent.pressureMin == 0.0, 'PressureMin should be 0.0');
  assert(downEvent.pressureMax == 1.0, 'PressureMax should be 1.0');
  results.add('pressure: ${downEvent.pressure}');
  print(
    'Event pressure: ${downEvent.pressure}, min: ${downEvent.pressureMin}, max: ${downEvent.pressureMax}',
  );

  // Test 8: TimeStamp property
  results.add('timeStamp: ${downEvent.timeStamp}');
  print('Event timeStamp: ${downEvent.timeStamp}');

  // Test 9: Down property
  assert(downEvent.down == true, 'Down should be true for PointerDownEvent');
  results.add('down: ${downEvent.down}');
  print('Event down: ${downEvent.down}');

  // Test 10: PointerMoveEvent as PointerEvent
  final moveEvent = PointerMoveEvent(
    position: Offset(150.0, 250.0),
    delta: Offset(50.0, 50.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(moveEvent is PointerEvent, 'PointerMoveEvent should be PointerEvent');
  results.add('PointerMoveEvent is PointerEvent: true');
  print('PointerMoveEvent is PointerEvent: true');

  // Test 11: Delta property on move event
  assert(moveEvent.delta == Offset(50.0, 50.0), 'Delta should match');
  results.add('delta: ${moveEvent.delta}');
  print('Move event delta: ${moveEvent.delta}');

  // Test 12: PointerUpEvent as PointerEvent
  final upEvent = PointerUpEvent(
    position: Offset(200.0, 300.0),
    kind: PointerDeviceKind.touch,
  );
  assert(upEvent is PointerEvent, 'PointerUpEvent should be PointerEvent');
  assert(upEvent.down == false, 'Down should be false for PointerUpEvent');
  results.add('PointerUpEvent down: ${upEvent.down}');
  print('PointerUpEvent down: ${upEvent.down}');

  // Test 13: PointerDeviceKind enum values
  final kindValues = PointerDeviceKind.values;
  assert(kindValues.contains(PointerDeviceKind.touch), 'Should have touch');
  assert(kindValues.contains(PointerDeviceKind.mouse), 'Should have mouse');
  assert(kindValues.contains(PointerDeviceKind.stylus), 'Should have stylus');
  results.add('PointerDeviceKind count: ${kindValues.length}');
  print('PointerDeviceKind values: $kindValues');

  // Test 14: Pointer with stylus kind
  final stylusEvent = PointerDownEvent(
    position: Offset(50.0, 50.0),
    kind: PointerDeviceKind.stylus,
    tilt: 0.3,
  );
  assert(stylusEvent.kind == PointerDeviceKind.stylus, 'Kind should be stylus');
  results.add('Stylus tilt: ${stylusEvent.tilt}');
  print('Stylus event tilt: ${stylusEvent.tilt}');

  // Test 15: Pointer with specific device ID
  final deviceEvent = PointerDownEvent(
    position: Offset(75.0, 125.0),
    device: 42,
    kind: PointerDeviceKind.touch,
  );
  assert(deviceEvent.device == 42, 'Device should be 42');
  results.add('Custom device ID: ${deviceEvent.device}');
  print('Event with device ID 42: ${deviceEvent.device}');

  // Test 16: Obscured property
  results.add('obscured: ${downEvent.obscured}');
  print('Event obscured: ${downEvent.obscured}');

  // Test 17: Synthesized property
  results.add('synthesized: ${downEvent.synthesized}');
  print('Event synthesized: ${downEvent.synthesized}');

  // Test 18: Embdder ID
  results.add('embedderId: ${downEvent.embedderId}');
  print('Event embedderId: ${downEvent.embedderId}');

  // Test 19: Pointer ID
  results.add('pointer: ${downEvent.pointer}');
  print('Event pointer ID: ${downEvent.pointer}');

  // Test 20: Distance and distanceMax
  results.add('distance: ${downEvent.distance}');
  print(
    'Event distance: ${downEvent.distance}, distanceMax: ${downEvent.distanceMax}',
  );

  print('PointerEvent base class test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEvent Base Class Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
