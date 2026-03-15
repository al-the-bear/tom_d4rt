// D4rt test script: Tests PointerRemovedEvent concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerRemovedEvent test executing');
  final results = <String>[];

  // ========== PointerRemovedEvent Tests ==========
  print('Testing PointerRemovedEvent...');

  // Test 1: Create basic PointerRemovedEvent
  final removedEvent1 = PointerRemovedEvent(position: Offset(180.0, 220.0));
  assert(removedEvent1 is PointerEvent, 'Should be PointerEvent');
  results.add('PointerRemovedEvent created');
  print('PointerRemovedEvent created: ${removedEvent1.runtimeType}');

  // Test 2: Position property
  assert(
    removedEvent1.position == Offset(180.0, 220.0),
    'Position should match',
  );
  results.add('position: ${removedEvent1.position}');
  print('Removed event position: ${removedEvent1.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${removedEvent1.localPosition}');
  print('Removed event localPosition: ${removedEvent1.localPosition}');

  // Test 4: Default kind
  results.add('default kind: ${removedEvent1.kind}');
  print('Removed event default kind: ${removedEvent1.kind}');

  // Test 5: Removed with touch kind
  final removedTouch = PointerRemovedEvent(
    position: Offset(200.0, 250.0),
    kind: PointerDeviceKind.touch,
  );
  assert(removedTouch.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('touch kind: ${removedTouch.kind}');
  print('Removed event with touch kind: ${removedTouch.kind}');

  // Test 6: Removed with mouse kind
  final removedMouse = PointerRemovedEvent(
    position: Offset(150.0, 170.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(removedMouse.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('mouse kind: ${removedMouse.kind}');
  print('Removed event with mouse kind: ${removedMouse.kind}');

  // Test 7: TimeStamp property
  final removedTime = PointerRemovedEvent(
    position: Offset(100.0, 110.0),
    timeStamp: Duration(milliseconds: 2000),
  );
  assert(
    removedTime.timeStamp == Duration(milliseconds: 2000),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${removedTime.timeStamp}');
  print('Removed event timeStamp: ${removedTime.timeStamp}');

  // Test 8: Device property
  final removedDevice = PointerRemovedEvent(
    position: Offset(220.0, 270.0),
    device: 15,
  );
  assert(removedDevice.device == 15, 'Device should be 15');
  results.add('device: ${removedDevice.device}');
  print('Removed event device: ${removedDevice.device}');

  // Test 9: Down property should be false
  assert(removedEvent1.down == false, 'Down should be false for removed event');
  results.add('down: ${removedEvent1.down}');
  print('Removed event down: ${removedEvent1.down}');

  // Test 10: Pointer ID
  final removedPointer = PointerRemovedEvent(
    position: Offset(80.0, 95.0),
    pointer: 88,
  );
  assert(removedPointer.pointer == 88, 'Pointer should be 88');
  results.add('pointer: ${removedPointer.pointer}');
  print('Removed event pointer: ${removedPointer.pointer}');

  // Test 11: Buttons property (should be 0)
  results.add('buttons: ${removedEvent1.buttons}');
  print('Removed event buttons: ${removedEvent1.buttons}');

  // Test 12: Pressure property
  results.add('pressure: ${removedEvent1.pressure}');
  print('Removed event pressure: ${removedEvent1.pressure}');

  // Test 13: Stylus removed event
  final removedStylus = PointerRemovedEvent(
    position: Offset(175.0, 200.0),
    kind: PointerDeviceKind.stylus,
  );
  assert(
    removedStylus.kind == PointerDeviceKind.stylus,
    'Kind should be stylus',
  );
  results.add('stylus kind: ${removedStylus.kind}');
  print('Removed event stylus kind: ${removedStylus.kind}');

  // Test 14: Synthesized property
  results.add('synthesized: ${removedEvent1.synthesized}');
  print('Removed event synthesized: ${removedEvent1.synthesized}');

  // Test 15: Obscured property
  final removedObscured = PointerRemovedEvent(
    position: Offset(115.0, 135.0),
    obscured: true,
  );
  assert(removedObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${removedObscured.obscured}');
  print('Removed event obscured: ${removedObscured.obscured}');

  // Test 16: EmbedderId property
  final removedEmbed = PointerRemovedEvent(
    position: Offset(65, 75),
    embedderId: 654,
  );
  assert(removedEmbed.embedderId == 654, 'EmbedderId should be 654');
  results.add('embedderId: ${removedEmbed.embedderId}');
  print('Removed event embedderId: ${removedEmbed.embedderId}');

  // Test 17: Added/Removed event pair pattern
  final addedEvent = PointerAddedEvent(position: Offset(100, 100), device: 5);
  final removedEventPair = PointerRemovedEvent(
    position: Offset(100, 100),
    device: 5,
  );
  assert(addedEvent.device == removedEventPair.device, 'Devices should match');
  results.add('Added/Removed pair: device=${addedEvent.device}');
  print('Added/Removed event pair verified');

  // Test 18: Distance properties
  results.add('distance: ${removedEvent1.distance}');
  print('Removed event distance: ${removedEvent1.distance}');

  // Test 19: Multiple removed events tracking
  final devices = <int>[1, 2, 3];
  final removedEvents = devices
      .map((d) => PointerRemovedEvent(position: Offset.zero, device: d))
      .toList();
  assert(removedEvents.length == 3, 'Should have 3 events');
  results.add('Tracked ${removedEvents.length} removed events');
  print('Multiple removed events: ${removedEvents.length}');

  // Test 20: PointerDeviceKind values exploration
  final allKinds = PointerDeviceKind.values;
  results.add('Device kinds: ${allKinds.length} types');
  print('All pointer device kinds: $allKinds');

  print('PointerRemovedEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerRemovedEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
