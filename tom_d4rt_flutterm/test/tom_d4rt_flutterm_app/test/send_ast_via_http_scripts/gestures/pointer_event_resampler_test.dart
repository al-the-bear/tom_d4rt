// D4rt test script: Tests PointerEventResampler concepts from gestures
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEventResampler test executing');
  final results = <String>[];

  // ========== PointerEventResampler Concepts ==========
  print('Testing PointerEventResampler concepts...');

  // Test 1: Create PointerEventResampler
  final resampler = PointerEventResampler();
  assert(resampler != null, 'Should create resampler');
  results.add('PointerEventResampler created');
  print('PointerEventResampler created: ${resampler.runtimeType}');

  // Test 2: Check hasPendingEvents initially
  assert(
    resampler.hasPendingEvents == false,
    'Should have no pending events initially',
  );
  results.add('hasPendingEvents initial: ${resampler.hasPendingEvents}');
  print('Initial hasPendingEvents: ${resampler.hasPendingEvents}');

  // Test 3: Add sample event - PointerDownEvent
  final downEvent = PointerDownEvent(
    position: Offset(100.0, 150.0),
    timeStamp: Duration(milliseconds: 0),
    kind: PointerDeviceKind.touch,
  );
  resampler.addEvent(downEvent);
  results.add('Added PointerDownEvent');
  print('Added PointerDownEvent at position ${downEvent.position}');

  // Test 4: Check hasPendingEvents after adding
  results.add('hasPendingEvents after add: ${resampler.hasPendingEvents}');
  print('hasPendingEvents after adding event: ${resampler.hasPendingEvents}');

  // Test 5: Add sample move events
  final moveEvent1 = PointerMoveEvent(
    position: Offset(110.0, 160.0),
    delta: Offset(10.0, 10.0),
    timeStamp: Duration(milliseconds: 16),
    kind: PointerDeviceKind.touch,
  );
  resampler.addEvent(moveEvent1);
  results.add('Added MoveEvent 1');
  print('Added MoveEvent at ${moveEvent1.position}');

  // Test 6: Add more move events
  final moveEvent2 = PointerMoveEvent(
    position: Offset(120.0, 170.0),
    delta: Offset(10.0, 10.0),
    timeStamp: Duration(milliseconds: 32),
    kind: PointerDeviceKind.touch,
  );
  resampler.addEvent(moveEvent2);
  results.add('Added MoveEvent 2');
  print('Added MoveEvent at ${moveEvent2.position}');

  // Test 7: TimeStamp progression concept
  final timestamps = [
    Duration(milliseconds: 0),
    Duration(milliseconds: 16),
    Duration(milliseconds: 32),
  ];
  results.add('Timestamps: 0, 16, 32 ms');
  print('Event timestamps: $timestamps');

  // Test 8: Test resampling interval (typical 16.67ms for 60fps)
  final frameInterval = Duration(microseconds: 16667);
  results.add('Frame interval: ${frameInterval.inMicroseconds}µs');
  print('Typical frame interval: $frameInterval');

  // Test 9: Sampling clock concept
  final sampleTime = Duration(milliseconds: 24);
  results.add('Sample time: ${sampleTime.inMilliseconds}ms');
  print('Sample time between frames: $sampleTime');

  // Test 10: PointerUpEvent for sequence end
  final upEvent = PointerUpEvent(
    position: Offset(130.0, 180.0),
    timeStamp: Duration(milliseconds: 48),
    kind: PointerDeviceKind.touch,
  );
  resampler.addEvent(upEvent);
  results.add('Added PointerUpEvent');
  print('Added PointerUpEvent at ${upEvent.position}');

  // Test 11: Position interpolation concept
  final pos1 = Offset(100, 100);
  final pos2 = Offset(200, 200);
  final t = 0.5; // midpoint
  final interpolated = Offset(
    pos1.dx + (pos2.dx - pos1.dx) * t,
    pos1.dy + (pos2.dy - pos1.dy) * t,
  );
  assert(interpolated == Offset(150, 150), 'Should be midpoint');
  results.add('Interpolated: $interpolated');
  print('Position interpolation: $interpolated');

  // Test 12: Create another resampler for clean tests
  final resampler2 = PointerEventResampler();
  results.add('New resampler created');
  print('Created new resampler instance');

  // Test 13: Delta calculation between events
  final deltaPos = moveEvent2.position - moveEvent1.position;
  assert(deltaPos == Offset(10, 10), 'Delta should be (10, 10)');
  results.add('Delta between moves: $deltaPos');
  print('Position delta: $deltaPos');

  // Test 14: Time delta calculation
  final timeDelta = moveEvent2.timeStamp - moveEvent1.timeStamp;
  assert(timeDelta == Duration(milliseconds: 16), 'Time delta should be 16ms');
  results.add('Time delta: ${timeDelta.inMilliseconds}ms');
  print('Time delta: $timeDelta');

  // Test 15: Velocity from resampled data
  final velocity = deltaPos.dx / (timeDelta.inMilliseconds / 1000.0);
  results.add('Velocity X: ${velocity.toStringAsFixed(2)} px/s');
  print('Calculated velocity X: $velocity px/s');

  // Test 16: Stop resampler (cleanup)
  resampler.stop();
  results.add('Resampler stopped');
  print('Resampler stopped');

  // Test 17: Check hasPendingEvents after stop
  results.add('hasPendingEvents after stop: ${resampler.hasPendingEvents}');
  print('hasPendingEvents after stop: ${resampler.hasPendingEvents}');

  // Test 18: Resample frequency concept
  final freq60Hz = Duration(microseconds: 16667);
  final freq120Hz = Duration(microseconds: 8333);
  results.add(
    '60Hz: ${freq60Hz.inMicroseconds}µs, 120Hz: ${freq120Hz.inMicroseconds}µs',
  );
  print(
    'Resample frequencies: 60Hz=${freq60Hz.inMicroseconds}µs, 120Hz=${freq120Hz.inMicroseconds}µs',
  );

  // Test 19: Event preservation through resampling
  assert(downEvent.position == Offset(100.0, 150.0), 'Original preserved');
  results.add('Original events preserved');
  print('Original events remain unchanged');

  // Test 20: Multiple pointer tracking concept
  final pointer1Events = [
    PointerDownEvent(position: Offset(100, 100), pointer: 1),
    PointerMoveEvent(
      position: Offset(110, 110),
      delta: Offset(10, 10),
      pointer: 1,
    ),
  ];
  final pointer2Events = [
    PointerDownEvent(position: Offset(200, 200), pointer: 2),
    PointerMoveEvent(
      position: Offset(210, 210),
      delta: Offset(10, 10),
      pointer: 2,
    ),
  ];
  results.add(
    'Multi-pointer: ${pointer1Events.length + pointer2Events.length} events',
  );
  print(
    'Multi-pointer resampling concept: ${pointer1Events.length + pointer2Events.length} events',
  );

  print('PointerEventResampler test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEventResampler Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
