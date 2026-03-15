// D4rt test script: Tests AndroidMotionEvent from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';

dynamic build(BuildContext context) {
  print('AndroidMotionEvent comprehensive test executing');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Helper to record test results
  void recordTest(String name, bool passed) {
    if (passed) {
      passCount++;
      results.add('✓ $name');
      print('PASS: $name');
    } else {
      failCount++;
      results.add('✗ $name');
      print('FAIL: $name');
    }
  }

  // Test 1: AndroidMotionEvent creation with basic parameters
  print('\n--- Test 1: AndroidMotionEvent creation ---');
  try {
    final pointerCoords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 100.0,
        y: 200.0,
      ),
    ];
    final pointerProperties = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 1000,
      eventTime: 1001,
      action: 0,
      pointerCount: 1,
      pointerProperties: pointerProperties,
      pointerCoords: pointerCoords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 123,
    );
    assert(event.downTime == 1000);
    assert(event.eventTime == 1001);
    assert(event.action == 0);
    assert(event.pointerCount == 1);
    print('Event downTime: ${event.downTime}');
    print('Event eventTime: ${event.eventTime}');
    print('Event action: ${event.action}');
    print('Event pointerCount: ${event.pointerCount}');
    recordTest('AndroidMotionEvent creation with basic parameters', true);
  } catch (e) {
    print('Error: $e');
    recordTest('AndroidMotionEvent creation with basic parameters', false);
  }

  // Test 2: AndroidMotionEvent with multiple pointers
  print('\n--- Test 2: Multi-pointer AndroidMotionEvent ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 100.0,
        y: 200.0,
      ),
      AndroidPointerCoords(
        orientation: 0.5,
        pressure: 0.8,
        size: 0.4,
        toolMajor: 8.0,
        toolMinor: 8.0,
        touchMajor: 12.0,
        touchMinor: 12.0,
        x: 300.0,
        y: 400.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
      AndroidPointerProperties(id: 1, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 2000,
      eventTime: 2001,
      action: 5,
      pointerCount: 2,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 456,
    );
    assert(event.pointerCount == 2);
    assert(event.pointerCoords.length == 2);
    assert(event.pointerProperties.length == 2);
    print('Multi-pointer event created with ${event.pointerCount} pointers');
    recordTest('Multi-pointer AndroidMotionEvent creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Multi-pointer AndroidMotionEvent creation', false);
  }

  // Test 3: Motion event actions
  print('\n--- Test 3: Motion event action values ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 50.0,
        y: 50.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];

    // ACTION_DOWN = 0
    final downEvent = AndroidMotionEvent(
      downTime: 3000,
      eventTime: 3001,
      action: 0,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 789,
    );
    assert(downEvent.action == 0);
    print('ACTION_DOWN event action: ${downEvent.action}');

    // ACTION_UP = 1
    final upEvent = AndroidMotionEvent(
      downTime: 3000,
      eventTime: 3100,
      action: 1,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 790,
    );
    assert(upEvent.action == 1);
    print('ACTION_UP event action: ${upEvent.action}');
    recordTest('Motion event action values', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Motion event action values', false);
  }

  // Test 4: Meta state flags
  print('\n--- Test 4: Meta state flags ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 150.0,
        y: 250.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 4000,
      eventTime: 4001,
      action: 2,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 65, // SHIFT + ALT
      buttonState: 1,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 1,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 1000,
    );
    assert(event.metaState == 65);
    assert(event.buttonState == 1);
    print('Meta state: ${event.metaState}');
    print('Button state: ${event.buttonState}');
    recordTest('Meta state flags handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Meta state flags handling', false);
  }

  // Test 5: Device and source information
  print('\n--- Test 5: Device and source information ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 200.0,
        y: 300.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 5000,
      eventTime: 5001,
      action: 0,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 2.0,
      yPrecision: 2.0,
      deviceId: 5,
      edgeFlags: 3,
      source: 0x1002,
      flags: 128,
      motionEventId: 2000,
    );
    assert(event.deviceId == 5);
    assert(event.source == 0x1002);
    assert(event.flags == 128);
    assert(event.edgeFlags == 3);
    print('Device ID: ${event.deviceId}');
    print('Source: ${event.source}');
    print('Flags: ${event.flags}');
    print('Edge flags: ${event.edgeFlags}');
    recordTest('Device and source information', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Device and source information', false);
  }

  // Test 6: Precision values
  print('\n--- Test 6: Precision values ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 250.0,
        y: 350.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 6000,
      eventTime: 6001,
      action: 2,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 3.5,
      yPrecision: 4.5,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 3000,
    );
    assert(event.xPrecision == 3.5);
    assert(event.yPrecision == 4.5);
    print('X Precision: ${event.xPrecision}');
    print('Y Precision: ${event.yPrecision}');
    recordTest('Precision values handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Precision values handling', false);
  }

  // Print summary
  print('\n========================================');
  print('AndroidMotionEvent Test Summary');
  print('========================================');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('Total:  ${passCount + failCount}');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'AndroidMotionEvent Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount | Failed: $failCount',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
