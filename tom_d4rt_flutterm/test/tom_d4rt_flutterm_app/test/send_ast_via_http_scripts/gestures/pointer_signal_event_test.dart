// D4rt test script: Tests PointerSignalEvent concepts from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerSignalEvent test executing');
  final results = <String>[];

  // ========== PointerSignalEvent Tests ==========
  // PointerSignalEvent is abstract, test via concrete implementations
  print('Testing PointerSignalEvent via concrete implementations...');

  // Test 1: PointerScrollEvent as PointerSignalEvent
  final scrollSignal = PointerScrollEvent(
    position: Offset(150.0, 200.0),
    scrollDelta: Offset(0.0, -50.0),
  );
  assert(
    scrollSignal is PointerSignalEvent,
    'PointerScrollEvent should be PointerSignalEvent',
  );
  results.add('PointerScrollEvent is PointerSignalEvent: true');
  print('PointerScrollEvent is PointerSignalEvent: true');

  // Test 2: Position property from PointerSignalEvent
  assert(
    scrollSignal.position == Offset(150.0, 200.0),
    'Position should match',
  );
  results.add('signal position: ${scrollSignal.position}');
  print('Signal event position: ${scrollSignal.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${scrollSignal.localPosition}');
  print('Signal event localPosition: ${scrollSignal.localPosition}');

  // Test 4: TimeStamp property
  final signalTime = PointerScrollEvent(
    position: Offset(100.0, 150.0),
    scrollDelta: Offset(0.0, -30.0),
    timeStamp: Duration(milliseconds: 750),
  );
  assert(
    signalTime.timeStamp == Duration(milliseconds: 750),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${signalTime.timeStamp}');
  print('Signal event timeStamp: ${signalTime.timeStamp}');

  // Test 5: Device property
  final signalDevice = PointerScrollEvent(
    position: Offset(180.0, 220.0),
    scrollDelta: Offset(0.0, -40.0),
    device: 5,
  );
  assert(signalDevice.device == 5, 'Device should be 5');
  results.add('device: ${signalDevice.device}');
  print('Signal event device: ${signalDevice.device}');

  // Test 6: Kind property
  final signalKind = PointerScrollEvent(
    position: Offset(160.0, 190.0),
    scrollDelta: Offset(0.0, -25.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(signalKind.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('kind: ${signalKind.kind}');
  print('Signal event kind: ${signalKind.kind}');

  // Test 7: Pointer ID
  final signalPointer = PointerScrollEvent(
    position: Offset(120.0, 140.0),
    scrollDelta: Offset(0.0, -20.0),
    pointer: 66,
  );
  assert(signalPointer.pointer == 66, 'Pointer should be 66');
  results.add('pointer: ${signalPointer.pointer}');
  print('Signal event pointer: ${signalPointer.pointer}');

  // Test 8: Down property (should be false for signal events)
  assert(scrollSignal.down == false, 'Down should be false for signal events');
  results.add('down: ${scrollSignal.down}');
  print('Signal event down: ${scrollSignal.down}');

  // Test 9: Buttons property
  results.add('buttons: ${scrollSignal.buttons}');
  print('Signal event buttons: ${scrollSignal.buttons}');

  // Test 10: PointerScaleEvent as PointerSignalEvent
  final scaleSignal = PointerScaleEvent(
    position: Offset(200.0, 250.0),
    scale: 1.5,
  );
  assert(
    scaleSignal is PointerSignalEvent,
    'PointerScaleEvent should be PointerSignalEvent',
  );
  results.add('PointerScaleEvent is PointerSignalEvent: true');
  print('PointerScaleEvent is PointerSignalEvent: true');

  // Test 11: Scale property
  assert(scaleSignal.scale == 1.5, 'Scale should be 1.5');
  results.add('scale: ${scaleSignal.scale}');
  print('Scale signal scale: ${scaleSignal.scale}');

  // Test 12: Pressure property
  results.add('pressure: ${scrollSignal.pressure}');
  print('Signal event pressure: ${scrollSignal.pressure}');

  // Test 13: EmbedderId property
  final signalEmbed = PointerScrollEvent(
    position: Offset(50, 70),
    scrollDelta: Offset(0, -15),
    embedderId: 222,
  );
  assert(signalEmbed.embedderId == 222, 'EmbedderId should be 222');
  results.add('embedderId: ${signalEmbed.embedderId}');
  print('Signal event embedderId: ${signalEmbed.embedderId}');

  // Test 14: Synthesized property
  results.add('synthesized: ${scrollSignal.synthesized}');
  print('Signal event synthesized: ${scrollSignal.synthesized}');

  // Test 15: Obscured property
  final signalObscured = PointerScrollEvent(
    position: Offset(90, 110),
    scrollDelta: Offset(0, -10),
    obscured: true,
  );
  assert(signalObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${signalObscured.obscured}');
  print('Signal event obscured: ${signalObscured.obscured}');

  // Test 16: Signal events are distinct from tap/drag events
  final downEvent = PointerDownEvent(position: Offset(100, 100));
  assert(
    downEvent is! PointerSignalEvent,
    'PointerDownEvent should not be PointerSignalEvent',
  );
  results.add('PointerDownEvent is not PointerSignalEvent');
  print('PointerDownEvent is not PointerSignalEvent');

  // Test 17: Signal event type hierarchy
  assert(scrollSignal is PointerEvent, 'Should be PointerEvent');
  results.add('Type hierarchy verified');
  print(
    'Signal event type hierarchy: PointerEvent -> PointerSignalEvent -> PointerScrollEvent',
  );

  // Test 18: Different signal types comparison
  final scroll1 = PointerScrollEvent(
    position: Offset(10, 10),
    scrollDelta: Offset(0, -5),
  );
  final scale1 = PointerScaleEvent(position: Offset(10, 10), scale: 1.2);
  assert(scroll1.runtimeType != scale1.runtimeType, 'Types should differ');
  results.add('Different signal types: scroll vs scale');
  print('Different signal types verified');

  // Test 19: Distance properties
  results.add('distance: ${scrollSignal.distance}');
  print('Signal event distance: ${scrollSignal.distance}');

  // Test 20: Signal with trackpad kind
  final trackpadSignal = PointerScrollEvent(
    position: Offset(130, 150),
    scrollDelta: Offset(5, -35),
    kind: PointerDeviceKind.trackpad,
  );
  assert(
    trackpadSignal.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('trackpad signal: ${trackpadSignal.kind}');
  print('Signal event with trackpad kind: ${trackpadSignal.kind}');

  print('PointerSignalEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerSignalEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
