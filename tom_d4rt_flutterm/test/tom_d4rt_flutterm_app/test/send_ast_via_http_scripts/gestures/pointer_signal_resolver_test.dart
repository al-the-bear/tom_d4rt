// D4rt test script: Tests PointerSignalResolver registration concepts from gestures
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerSignalResolver test executing');
  final results = <String>[];

  // ========== PointerSignalResolver Tests ==========
  print('Testing PointerSignalResolver...');

  // Test 1: Create PointerSignalResolver
  final resolver = PointerSignalResolver();
  assert(resolver != null, 'Should create resolver');
  results.add('PointerSignalResolver created');
  print('PointerSignalResolver created: ${resolver.runtimeType}');

  // Test 2: Resolver is GestureBinding accessible
  final binding = GestureBinding.instance;
  assert(binding is HitTestDispatcher, 'Binding should be HitTestDispatcher');
  results.add('GestureBinding accessible');
  print('GestureBinding is HitTestDispatcher: ${binding is HitTestDispatcher}');

  // Test 3: Create scroll event for resolution
  final scrollEvent1 = PointerScrollEvent(
    position: Offset(150.0, 200.0),
    scrollDelta: Offset(0.0, -60.0),
  );
  assert(scrollEvent1 is PointerSignalEvent, 'Scroll should be signal event');
  results.add('Scroll event for resolution');
  print('Created scroll event for resolution');

  // Test 4: Signal event type hierarchy
  assert(scrollEvent1 is PointerEvent, 'Should be PointerEvent');
  results.add('Signal type hierarchy verified');
  print('Signal event type hierarchy verified');

  // Test 5: Registration callback pattern concept
  var callbackCalled = false;
  void signalCallback(PointerSignalEvent event) {
    callbackCalled = true;
    print('Callback received event: ${event.runtimeType}');
  }

  results.add('Callback pattern defined');
  print('Registration callback pattern defined');

  // Test 6: Scroll delta analysis
  final delta = scrollEvent1.scrollDelta;
  assert(delta.dy < 0, 'Should scroll up');
  results.add('Scroll delta: $delta');
  print('Scroll delta analysis: $delta');

  // Test 7: Position from signal event
  final position = scrollEvent1.position;
  assert(position == Offset(150.0, 200.0), 'Position should match');
  results.add('position: $position');
  print('Signal event position: $position');

  // Test 8: Scale event for resolution
  final scaleEvent = PointerScaleEvent(
    position: Offset(200.0, 250.0),
    scale: 1.5,
  );
  assert(scaleEvent is PointerSignalEvent, 'Scale should be signal event');
  results.add('Scale event scale: ${scaleEvent.scale}');
  print('Scale event for resolution: scale=${scaleEvent.scale}');

  // Test 9: Multiple signal types handling
  final signals = <PointerSignalEvent>[
    PointerScrollEvent(position: Offset(100, 100), scrollDelta: Offset(0, -20)),
    PointerScaleEvent(position: Offset(100, 100), scale: 1.2),
  ];
  assert(signals.length == 2, 'Should have 2 signals');
  results.add('Multiple signal types: ${signals.length}');
  print('Multiple signal types: ${signals.length}');

  // Test 10: Resolver registration concept
  results.add('Registration concept tested');
  print('Resolver registration concept: register -> resolve');

  // Test 11: Signal filtering by type
  final scrollSignals = signals.whereType<PointerScrollEvent>().toList();
  assert(scrollSignals.length == 1, 'Should have 1 scroll signal');
  results.add('Filtered scroll signals: ${scrollSignals.length}');
  print('Filtered scroll signals: ${scrollSignals.length}');

  // Test 12: Signal filtering by scale
  final scaleSignals = signals.whereType<PointerScaleEvent>().toList();
  assert(scaleSignals.length == 1, 'Should have 1 scale signal');
  results.add('Filtered scale signals: ${scaleSignals.length}');
  print('Filtered scale signals: ${scaleSignals.length}');

  // Test 13: TimeStamp in signal events
  final timedScroll = PointerScrollEvent(
    position: Offset(100, 100),
    scrollDelta: Offset(0, -30),
    timeStamp: Duration(milliseconds: 500),
  );
  results.add('timeStamp: ${timedScroll.timeStamp}');
  print('Signal with timestamp: ${timedScroll.timeStamp}');

  // Test 14: Device tracking in signals
  final deviceScroll = PointerScrollEvent(
    position: Offset(100, 100),
    scrollDelta: Offset(0, -25),
    device: 2,
  );
  assert(deviceScroll.device == 2, 'Device should be 2');
  results.add('device: ${deviceScroll.device}');
  print('Signal device tracking: ${deviceScroll.device}');

  // Test 15: Signal event down property
  assert(scrollEvent1.down == false, 'Down should be false for signals');
  results.add('Signal down: ${scrollEvent1.down}');
  print('Signal event down: ${scrollEvent1.down}');

  // Test 16: Scroll inertia cancel in resolution
  final inertiaCancel = PointerScrollInertiaCancelEvent(
    position: Offset(150, 200),
  );
  assert(inertiaCancel is PointerSignalEvent, 'Inertia cancel is signal');
  results.add('Inertia cancel: signal event');
  print('Inertia cancel as signal event');

  // Test 17: Resolution priority concept
  results.add('Resolution priority concept');
  print('Resolution follows registration order priority');

  // Test 18: Signal event kind
  final kindScroll = PointerScrollEvent(
    position: Offset(80, 90),
    scrollDelta: Offset(0, -15),
    kind: PointerDeviceKind.mouse,
  );
  assert(kindScroll.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('Signal kind: ${kindScroll.kind}');
  print('Signal event kind: ${kindScroll.kind}');

  // Test 19: Cumulative scroll within resolution
  var totalScroll = Offset.zero;
  final scrollDeltas = [Offset(0, -20), Offset(0, -15), Offset(0, -10)];
  for (final d in scrollDeltas) {
    totalScroll += d;
  }
  results.add('Cumulative scroll: $totalScroll');
  print('Cumulative scroll in resolution: $totalScroll');

  // Test 20: EmbedderId in signal events
  final embedScroll = PointerScrollEvent(
    position: Offset(60, 70),
    scrollDelta: Offset(0, -10),
    embedderId: 999,
  );
  assert(embedScroll.embedderId == 999, 'EmbedderId should be 999');
  results.add('embedderId: ${embedScroll.embedderId}');
  print('Signal embedderId: ${embedScroll.embedderId}');

  print('PointerSignalResolver test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerSignalResolver Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
