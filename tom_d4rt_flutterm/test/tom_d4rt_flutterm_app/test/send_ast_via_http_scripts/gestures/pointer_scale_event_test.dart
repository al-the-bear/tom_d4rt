// D4rt test script: Tests PointerScaleEvent concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScaleEvent test executing');
  final results = <String>[];

  // ========== PointerScaleEvent Tests ==========
  print('Testing PointerScaleEvent...');

  // Test 1: Create basic PointerScaleEvent
  final scaleEvent1 = PointerScaleEvent(
    position: Offset(200.0, 250.0),
    scale: 1.5,
  );
  assert(scaleEvent1 is PointerEvent, 'Should be PointerEvent');
  assert(scaleEvent1 is PointerSignalEvent, 'Should be PointerSignalEvent');
  results.add('PointerScaleEvent created');
  print('PointerScaleEvent created: ${scaleEvent1.runtimeType}');

  // Test 2: Scale property
  assert(scaleEvent1.scale == 1.5, 'Scale should be 1.5');
  results.add('scale: ${scaleEvent1.scale}');
  print('Scale event scale: ${scaleEvent1.scale}');

  // Test 3: Position property
  assert(scaleEvent1.position == Offset(200.0, 250.0), 'Position should match');
  results.add('position: ${scaleEvent1.position}');
  print('Scale event position: ${scaleEvent1.position}');

  // Test 4: Zoom in (scale > 1)
  final scaleZoomIn = PointerScaleEvent(
    position: Offset(150.0, 180.0),
    scale: 2.0,
  );
  assert(scaleZoomIn.scale > 1.0, 'Zoom in should have scale > 1');
  results.add('zoom in scale: ${scaleZoomIn.scale}');
  print('Zoom in event: ${scaleZoomIn.scale}');

  // Test 5: Zoom out (scale < 1)
  final scaleZoomOut = PointerScaleEvent(
    position: Offset(150.0, 180.0),
    scale: 0.5,
  );
  assert(scaleZoomOut.scale < 1.0, 'Zoom out should have scale < 1');
  results.add('zoom out scale: ${scaleZoomOut.scale}');
  print('Zoom out event: ${scaleZoomOut.scale}');

  // Test 6: No scale change (scale = 1)
  final scaleNoChange = PointerScaleEvent(
    position: Offset(150.0, 180.0),
    scale: 1.0,
  );
  assert(scaleNoChange.scale == 1.0, 'No change should have scale = 1');
  results.add('no scale change: ${scaleNoChange.scale}');
  print('No scale change event: ${scaleNoChange.scale}');

  // Test 7: LocalPosition property
  results.add('localPosition: ${scaleEvent1.localPosition}');
  print('Scale event localPosition: ${scaleEvent1.localPosition}');

  // Test 8: TimeStamp property
  final scaleTime = PointerScaleEvent(
    position: Offset(100.0, 120.0),
    scale: 1.3,
    timeStamp: Duration(milliseconds: 600),
  );
  assert(
    scaleTime.timeStamp == Duration(milliseconds: 600),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${scaleTime.timeStamp}');
  print('Scale event timeStamp: ${scaleTime.timeStamp}');

  // Test 9: Device property
  final scaleDevice = PointerScaleEvent(
    position: Offset(180.0, 210.0),
    scale: 1.75,
    device: 4,
  );
  assert(scaleDevice.device == 4, 'Device should be 4');
  results.add('device: ${scaleDevice.device}');
  print('Scale event device: ${scaleDevice.device}');

  // Test 10: Kind property
  final scaleKind = PointerScaleEvent(
    position: Offset(160.0, 190.0),
    scale: 1.25,
    kind: PointerDeviceKind.trackpad,
  );
  assert(
    scaleKind.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('kind: ${scaleKind.kind}');
  print('Scale event kind: ${scaleKind.kind}');

  // Test 11: Pointer ID
  final scalePointer = PointerScaleEvent(
    position: Offset(120.0, 140.0),
    scale: 0.8,
    pointer: 77,
  );
  assert(scalePointer.pointer == 77, 'Pointer should be 77');
  results.add('pointer: ${scalePointer.pointer}');
  print('Scale event pointer: ${scalePointer.pointer}');

  // Test 12: Down property (should be false for scale signal)
  assert(scaleEvent1.down == false, 'Down should be false for scale event');
  results.add('down: ${scaleEvent1.down}');
  print('Scale event down: ${scaleEvent1.down}');

  // Test 13: Buttons property
  results.add('buttons: ${scaleEvent1.buttons}');
  print('Scale event buttons: ${scaleEvent1.buttons}');

  // Test 14: EmbedderId property
  final scaleEmbed = PointerScaleEvent(
    position: Offset(50, 60),
    scale: 1.1,
    embedderId: 333,
  );
  assert(scaleEmbed.embedderId == 333, 'EmbedderId should be 333');
  results.add('embedderId: ${scaleEmbed.embedderId}');
  print('Scale event embedderId: ${scaleEmbed.embedderId}');

  // Test 15: Cumulative scale calculation
  var cumulativeScale = 1.0;
  final scales = [1.1, 1.2, 0.9];
  for (final s in scales) {
    cumulativeScale *= s;
  }
  results.add('cumulative scale: ${cumulativeScale.toStringAsFixed(3)}');
  print('Cumulative scale: $cumulativeScale');

  // Test 16: Scale percentage
  final percentage = (scaleEvent1.scale - 1.0) * 100;
  results.add('scale change: ${percentage.toStringAsFixed(1)}%');
  print('Scale change: $percentage%');

  // Test 17: Synthesized property
  results.add('synthesized: ${scaleEvent1.synthesized}');
  print('Scale event synthesized: ${scaleEvent1.synthesized}');

  // Test 18: Obscured property
  final scaleObscured = PointerScaleEvent(
    position: Offset(90, 100),
    scale: 0.75,
    obscured: true,
  );
  assert(scaleObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${scaleObscured.obscured}');
  print('Scale event obscured: ${scaleObscured.obscured}');

  // Test 19: Distance properties
  results.add('distance: ${scaleEvent1.distance}');
  print('Scale event distance: ${scaleEvent1.distance}');

  // Test 20: Very small scale
  final scaleSmall = PointerScaleEvent(position: Offset(100, 100), scale: 0.1);
  assert(scaleSmall.scale == 0.1, 'Small scale should be 0.1');
  results.add('very small scale: ${scaleSmall.scale}');
  print('Very small scale: ${scaleSmall.scale}');

  print('PointerScaleEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerScaleEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
