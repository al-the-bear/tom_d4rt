// D4rt test script: Tests PointerMoveEvent concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerMoveEvent test executing');
  final results = <String>[];

  // ========== PointerMoveEvent Tests ==========
  print('Testing PointerMoveEvent...');

  // Test 1: Create basic PointerMoveEvent
  final moveEvent1 = PointerMoveEvent(
    position: Offset(200.0, 300.0),
    delta: Offset(10.0, 15.0),
  );
  assert(moveEvent1 is PointerEvent, 'Should be PointerEvent');
  results.add('PointerMoveEvent created');
  print('PointerMoveEvent created: ${moveEvent1.runtimeType}');

  // Test 2: Position property
  assert(moveEvent1.position == Offset(200.0, 300.0), 'Position should match');
  results.add('position: ${moveEvent1.position}');
  print('Move event position: ${moveEvent1.position}');

  // Test 3: Delta property
  assert(moveEvent1.delta == Offset(10.0, 15.0), 'Delta should match');
  results.add('delta: ${moveEvent1.delta}');
  print('Move event delta: ${moveEvent1.delta}');

  // Test 4: LocalPosition property
  results.add('localPosition: ${moveEvent1.localPosition}');
  print('Move event localPosition: ${moveEvent1.localPosition}');

  // Test 5: LocalDelta property
  results.add('localDelta: ${moveEvent1.localDelta}');
  print('Move event localDelta: ${moveEvent1.localDelta}');

  // Test 6: Move with touch kind
  final moveTouch = PointerMoveEvent(
    position: Offset(150.0, 200.0),
    delta: Offset(20.0, 25.0),
    kind: PointerDeviceKind.touch,
  );
  assert(moveTouch.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('touch kind: ${moveTouch.kind}');
  print('Move event with touch kind: ${moveTouch.kind}');

  // Test 7: Move with pressure
  final movePressure = PointerMoveEvent(
    position: Offset(100.0, 150.0),
    delta: Offset(5.0, 5.0),
    pressure: 0.7,
    pressureMin: 0.0,
    pressureMax: 1.0,
  );
  assert(movePressure.pressure == 0.7, 'Pressure should be 0.7');
  results.add('pressure: ${movePressure.pressure}');
  print('Move event pressure: ${movePressure.pressure}');

  // Test 8: TimeStamp property
  final moveTime = PointerMoveEvent(
    position: Offset(80.0, 90.0),
    delta: Offset.zero,
    timeStamp: Duration(milliseconds: 750),
  );
  assert(
    moveTime.timeStamp == Duration(milliseconds: 750),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${moveTime.timeStamp}');
  print('Move event timeStamp: ${moveTime.timeStamp}');

  // Test 9: Device property
  final moveDevice = PointerMoveEvent(
    position: Offset(170.0, 220.0),
    delta: Offset(15.0, 20.0),
    device: 7,
  );
  assert(moveDevice.device == 7, 'Device should be 7');
  results.add('device: ${moveDevice.device}');
  print('Move event device: ${moveDevice.device}');

  // Test 10: Down property should be true for move
  assert(moveEvent1.down == true, 'Down should be true for move event');
  results.add('down: ${moveEvent1.down}');
  print('Move event down: ${moveEvent1.down}');

  // Test 11: Buttons property
  final moveButtons = PointerMoveEvent(
    position: Offset(300.0, 350.0),
    delta: Offset(8.0, 12.0),
    buttons: kPrimaryButton,
  );
  assert(moveButtons.buttons == kPrimaryButton, 'Buttons should be primary');
  results.add('buttons: ${moveButtons.buttons}');
  print('Move event buttons: ${moveButtons.buttons}');

  // Test 12: Move with stylus kind
  final moveStylus = PointerMoveEvent(
    position: Offset(130.0, 160.0),
    delta: Offset(3.0, 4.0),
    kind: PointerDeviceKind.stylus,
    tilt: 0.15,
  );
  assert(moveStylus.kind == PointerDeviceKind.stylus, 'Kind should be stylus');
  results.add('stylus tilt: ${moveStylus.tilt}');
  print('Move event stylus tilt: ${moveStylus.tilt}');

  // Test 13: Pointer ID
  final movePointer = PointerMoveEvent(
    position: Offset(60.0, 70.0),
    delta: Offset(2.0, 3.0),
    pointer: 55,
  );
  assert(movePointer.pointer == 55, 'Pointer should be 55');
  results.add('pointer: ${movePointer.pointer}');
  print('Move event pointer: ${movePointer.pointer}');

  // Test 14: Synthesized property
  results.add('synthesized: ${moveEvent1.synthesized}');
  print('Move event synthesized: ${moveEvent1.synthesized}');

  // Test 15: Obscured property
  final moveObscured = PointerMoveEvent(
    position: Offset(110.0, 120.0),
    delta: Offset(5.0, 6.0),
    obscured: true,
  );
  assert(moveObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${moveObscured.obscured}');
  print('Move event obscured: ${moveObscured.obscured}');

  // Test 16: Delta magnitude calculation
  final deltaDistance = moveEvent1.delta.distance;
  results.add('delta distance: ${deltaDistance.toStringAsFixed(2)}');
  print('Move delta magnitude: $deltaDistance');

  // Test 17: Accumulated position tracking
  var accumulatedDelta = Offset.zero;
  final moves = [Offset(5, 5), Offset(10, 10), Offset(3, 7)];
  for (final d in moves) {
    accumulatedDelta += d;
  }
  assert(accumulatedDelta == Offset(18, 22), 'Accumulated should match');
  results.add('accumulated: $accumulatedDelta');
  print('Accumulated delta: $accumulatedDelta');

  // Test 18: EmbedderId property
  final moveEmbed = PointerMoveEvent(
    position: Offset(40, 50),
    delta: Offset(1, 1),
    embedderId: 789,
  );
  assert(moveEmbed.embedderId == 789, 'EmbedderId should be 789');
  results.add('embedderId: ${moveEmbed.embedderId}');
  print('Move event embedderId: ${moveEmbed.embedderId}');

  // Test 19: Size and radiusMajor
  final moveSize = PointerMoveEvent(
    position: Offset(250, 280),
    delta: Offset(7, 8),
    size: 2.0,
    radiusMajor: 10.0,
  );
  results.add('size: ${moveSize.size}');
  print(
    'Move event size: ${moveSize.size}, radiusMajor: ${moveSize.radiusMajor}',
  );

  // Test 20: Distance properties
  results.add('distance: ${moveEvent1.distance}');
  print(
    'Move event distance: ${moveEvent1.distance}, distanceMax: ${moveEvent1.distanceMax}',
  );

  print('PointerMoveEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerMoveEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
