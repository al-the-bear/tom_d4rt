// D4rt test script: Tests PointerScrollInertiaCancelEvent concepts from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScrollInertiaCancelEvent test executing');
  final results = <String>[];

  // ========== PointerScrollInertiaCancelEvent Tests ==========
  print('Testing PointerScrollInertiaCancelEvent...');

  // Test 1: Create basic PointerScrollInertiaCancelEvent
  final cancelEvent1 = PointerScrollInertiaCancelEvent(
    position: Offset(200.0, 250.0),
  );
  assert(cancelEvent1 is PointerEvent, 'Should be PointerEvent');
  assert(cancelEvent1 is PointerSignalEvent, 'Should be PointerSignalEvent');
  results.add('PointerScrollInertiaCancelEvent created');
  print('PointerScrollInertiaCancelEvent created: ${cancelEvent1.runtimeType}');

  // Test 2: Position property
  assert(
    cancelEvent1.position == Offset(200.0, 250.0),
    'Position should match',
  );
  results.add('position: ${cancelEvent1.position}');
  print('Cancel event position: ${cancelEvent1.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${cancelEvent1.localPosition}');
  print('Cancel event localPosition: ${cancelEvent1.localPosition}');

  // Test 4: TimeStamp property
  final cancelTime = PointerScrollInertiaCancelEvent(
    position: Offset(150.0, 180.0),
    timeStamp: Duration(milliseconds: 800),
  );
  assert(
    cancelTime.timeStamp == Duration(milliseconds: 800),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${cancelTime.timeStamp}');
  print('Cancel event timeStamp: ${cancelTime.timeStamp}');

  // Test 5: Device property
  final cancelDevice = PointerScrollInertiaCancelEvent(
    position: Offset(170.0, 200.0),
    device: 6,
  );
  assert(cancelDevice.device == 6, 'Device should be 6');
  results.add('device: ${cancelDevice.device}');
  print('Cancel event device: ${cancelDevice.device}');

  // Test 6: Pointer ID
  final cancelPointer = PointerScrollInertiaCancelEvent(
    position: Offset(120.0, 150.0),
    pointer: 88,
  );
  assert(cancelPointer.pointer == 88, 'Pointer should be 88');
  results.add('pointer: ${cancelPointer.pointer}');
  print('Cancel event pointer: ${cancelPointer.pointer}');

  // Test 7: Kind property
  final cancelKind = PointerScrollInertiaCancelEvent(
    position: Offset(140.0, 170.0),
    kind: PointerDeviceKind.trackpad,
  );
  assert(
    cancelKind.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('kind: ${cancelKind.kind}');
  print('Cancel event kind: ${cancelKind.kind}');

  // Test 8: Down property (should be false for signal events)
  assert(cancelEvent1.down == false, 'Down should be false');
  results.add('down: ${cancelEvent1.down}');
  print('Cancel event down: ${cancelEvent1.down}');

  // Test 9: Buttons property
  results.add('buttons: ${cancelEvent1.buttons}');
  print('Cancel event buttons: ${cancelEvent1.buttons}');

  // Test 10: EmbedderId property
  final cancelEmbed = PointerScrollInertiaCancelEvent(
    position: Offset(80, 90),
    embedderId: 777,
  );
  assert(cancelEmbed.embedderId == 777, 'EmbedderId should be 777');
  results.add('embedderId: ${cancelEmbed.embedderId}');
  print('Cancel event embedderId: ${cancelEmbed.embedderId}');

  // Test 11: Synthesized property
  results.add('synthesized: ${cancelEvent1.synthesized}');
  print('Cancel event synthesized: ${cancelEvent1.synthesized}');

  // Test 12: Obscured property
  final cancelObscured = PointerScrollInertiaCancelEvent(
    position: Offset(110, 130),
    obscured: true,
  );
  assert(cancelObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${cancelObscured.obscured}');
  print('Cancel event obscured: ${cancelObscured.obscured}');

  // Test 13: Type hierarchy verification
  assert(cancelEvent1 is PointerEvent, 'Should be PointerEvent');
  assert(cancelEvent1 is PointerSignalEvent, 'Should be PointerSignalEvent');
  results.add('Type hierarchy: PointerEvent -> PointerSignalEvent');
  print('Type hierarchy verified');

  // Test 14: Inertia scroll and cancel sequence concept
  final scrollEvent = PointerScrollEvent(
    position: Offset(100, 100),
    scrollDelta: Offset(0, -100),
  );
  final cancelAfterScroll = PointerScrollInertiaCancelEvent(
    position: Offset(100, 100),
    timeStamp: Duration(milliseconds: 500),
  );
  results.add('Scroll -> Cancel sequence');
  print('Inertia scroll followed by cancel event');

  // Test 15: Pressure property
  results.add('pressure: ${cancelEvent1.pressure}');
  print('Cancel event pressure: ${cancelEvent1.pressure}');

  // Test 16: Distance property
  results.add('distance: ${cancelEvent1.distance}');
  print('Cancel event distance: ${cancelEvent1.distance}');

  // Test 17: Mouse kind cancel event
  final cancelMouse = PointerScrollInertiaCancelEvent(
    position: Offset(160.0, 190.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(cancelMouse.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('mouse kind: ${cancelMouse.kind}');
  print('Cancel event with mouse kind: ${cancelMouse.kind}');

  // Test 18: Multiple cancel events
  final cancelEvents = <PointerScrollInertiaCancelEvent>[];
  for (int i = 0; i < 3; i++) {
    cancelEvents.add(
      PointerScrollInertiaCancelEvent(
        position: Offset(100.0 + i * 30, 100.0 + i * 30),
        pointer: i,
      ),
    );
  }
  assert(cancelEvents.length == 3, 'Should have 3 cancel events');
  results.add('Multiple cancel events: ${cancelEvents.length}');
  print('Multiple cancel events tracked');

  // Test 19: Duration concept for inertia
  final scrollStartTime = Duration(milliseconds: 0);
  final scrollEndTime = Duration(milliseconds: 300);
  final inertiaDuration = scrollEndTime - scrollStartTime;
  results.add('Inertia duration: ${inertiaDuration.inMilliseconds}ms');
  print('Inertia duration: $inertiaDuration');

  // Test 20: Position distance from origin
  final distanceFromOrigin = cancelEvent1.position.distance;
  results.add('Distance from origin: ${distanceFromOrigin.toStringAsFixed(2)}');
  print('Position distance from origin: $distanceFromOrigin');

  print(
    'PointerScrollInertiaCancelEvent test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerScrollInertiaCancelEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
