// D4rt test script: Tests PointerPanZoomStartEvent concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerPanZoomStartEvent test executing');
  final results = <String>[];

  // ========== PointerPanZoomStartEvent Tests ==========
  print('Testing PointerPanZoomStartEvent...');

  // Test 1: Create basic PointerPanZoomStartEvent
  final panZoomStart1 = PointerPanZoomStartEvent(
    position: Offset(200.0, 300.0),
  );
  assert(panZoomStart1 is PointerEvent, 'Should be PointerEvent');
  results.add('PointerPanZoomStartEvent created');
  print('PointerPanZoomStartEvent created: ${panZoomStart1.runtimeType}');

  // Test 2: Position property
  assert(
    panZoomStart1.position == Offset(200.0, 300.0),
    'Position should match',
  );
  results.add('position: ${panZoomStart1.position}');
  print('PanZoomStart event position: ${panZoomStart1.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${panZoomStart1.localPosition}');
  print('PanZoomStart event localPosition: ${panZoomStart1.localPosition}');

  // Test 4: Default kind for pan zoom (usually trackpad)
  final panZoomTrackpad = PointerPanZoomStartEvent(
    position: Offset(150.0, 200.0),
    kind: PointerDeviceKind.trackpad,
  );
  assert(
    panZoomTrackpad.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('trackpad kind: ${panZoomTrackpad.kind}');
  print('PanZoomStart with trackpad kind: ${panZoomTrackpad.kind}');

  // Test 5: TimeStamp property
  final panZoomTime = PointerPanZoomStartEvent(
    position: Offset(100.0, 150.0),
    timeStamp: Duration(milliseconds: 1000),
  );
  assert(
    panZoomTime.timeStamp == Duration(milliseconds: 1000),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${panZoomTime.timeStamp}');
  print('PanZoomStart event timeStamp: ${panZoomTime.timeStamp}');

  // Test 6: Device property
  final panZoomDevice = PointerPanZoomStartEvent(
    position: Offset(180.0, 220.0),
    device: 8,
  );
  assert(panZoomDevice.device == 8, 'Device should be 8');
  results.add('device: ${panZoomDevice.device}');
  print('PanZoomStart event device: ${panZoomDevice.device}');

  // Test 7: Pointer ID
  final panZoomPointer = PointerPanZoomStartEvent(
    position: Offset(120.0, 160.0),
    pointer: 44,
  );
  assert(panZoomPointer.pointer == 44, 'Pointer should be 44');
  results.add('pointer: ${panZoomPointer.pointer}');
  print('PanZoomStart event pointer: ${panZoomPointer.pointer}');

  // Test 8: Down property
  results.add('down: ${panZoomStart1.down}');
  print('PanZoomStart event down: ${panZoomStart1.down}');

  // Test 9: Buttons property
  results.add('buttons: ${panZoomStart1.buttons}');
  print('PanZoomStart event buttons: ${panZoomStart1.buttons}');

  // Test 10: EmbedderId property
  final panZoomEmbed = PointerPanZoomStartEvent(
    position: Offset(50, 60),
    embedderId: 444,
  );
  assert(panZoomEmbed.embedderId == 444, 'EmbedderId should be 444');
  results.add('embedderId: ${panZoomEmbed.embedderId}');
  print('PanZoomStart event embedderId: ${panZoomEmbed.embedderId}');

  // Test 11: Synthesized property
  results.add('synthesized: ${panZoomStart1.synthesized}');
  print('PanZoomStart event synthesized: ${panZoomStart1.synthesized}');

  // Test 12: Obscured property
  final panZoomObscured = PointerPanZoomStartEvent(
    position: Offset(90, 110),
    obscured: true,
  );
  assert(panZoomObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${panZoomObscured.obscured}');
  print('PanZoomStart event obscured: ${panZoomObscured.obscured}');

  // Test 13: Start with mouse kind
  final panZoomMouse = PointerPanZoomStartEvent(
    position: Offset(170.0, 210.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(panZoomMouse.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('mouse kind: ${panZoomMouse.kind}');
  print('PanZoomStart with mouse kind: ${panZoomMouse.kind}');

  // Test 14: Pressure property
  results.add('pressure: ${panZoomStart1.pressure}');
  print('PanZoomStart event pressure: ${panZoomStart1.pressure}');

  // Test 15: Distance property
  results.add('distance: ${panZoomStart1.distance}');
  print('PanZoomStart event distance: ${panZoomStart1.distance}');

  // Test 16: Pan zoom sequence pattern (start -> updates -> end)
  final sequenceId = 123;
  final startEvent = PointerPanZoomStartEvent(
    position: Offset(100, 100),
    pointer: sequenceId,
  );
  results.add('Sequence started with pointer: $sequenceId');
  print('Pan zoom sequence started with pointer: $sequenceId');

  // Test 17: Different start positions
  final positions = [Offset(0, 0), Offset(100, 100), Offset(200, 200)];
  for (int i = 0; i < positions.length; i++) {
    final event = PointerPanZoomStartEvent(position: positions[i]);
    assert(event.position == positions[i], 'Position should match');
  }
  results.add('Tested ${positions.length} start positions');
  print('Tested multiple start positions');

  // Test 18: Offset calculations for position
  final startPos = panZoomStart1.position;
  final endPos = Offset(250.0, 350.0);
  final totalMovement = endPos - startPos;
  results.add('Total movement: $totalMovement');
  print('Total movement from start: $totalMovement');

  // Test 19: Multiple pan zoom gestures
  final gesture1 = PointerPanZoomStartEvent(
    position: Offset(50, 50),
    device: 1,
  );
  final gesture2 = PointerPanZoomStartEvent(
    position: Offset(250, 250),
    device: 2,
  );
  assert(gesture1.device != gesture2.device, 'Devices should differ');
  results.add(
    'Multiple gestures: devices ${gesture1.device} and ${gesture2.device}',
  );
  print('Multiple pan zoom gestures tracked');

  // Test 20: Start position distance from origin
  final distanceFromOrigin = panZoomStart1.position.distance;
  results.add('Distance from origin: ${distanceFromOrigin.toStringAsFixed(2)}');
  print('Start position distance from origin: $distanceFromOrigin');

  print('PointerPanZoomStartEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerPanZoomStartEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
