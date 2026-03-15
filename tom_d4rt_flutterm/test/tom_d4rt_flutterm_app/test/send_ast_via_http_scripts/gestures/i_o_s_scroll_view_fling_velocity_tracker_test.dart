import 'package:flutter/gestures.dart';
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('IOSScrollViewFlingVelocityTracker test failed: $message');
  }
  logs.add('PASS: $message');
}

String _formatVelocity(Velocity velocity) {
  return '(${velocity.pixelsPerSecond.dx.toStringAsFixed(2)}, '
      '${velocity.pixelsPerSecond.dy.toStringAsFixed(2)})';
}

dynamic build(BuildContext context) {
  print('=== IOSScrollViewFlingVelocityTracker comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final trackerTouch = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  final trackerMouse = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.mouse);

  _expectCondition(
    trackerTouch is VelocityTracker,
    'trackerTouch is a VelocityTracker',
    logs,
  );
  assertionCount++;

  _expectCondition(
    trackerMouse.runtimeType == IOSScrollViewFlingVelocityTracker,
    'trackerMouse runtimeType matches IOSScrollViewFlingVelocityTracker',
    logs,
  );
  assertionCount++;

  print('trackerTouch.runtimeType: ${trackerTouch.runtimeType}');
  print('trackerMouse.runtimeType: ${trackerMouse.runtimeType}');

  final samplePoints = <({Duration t, Offset p})>[
    (t: const Duration(milliseconds: 0), p: const Offset(0, 0)),
    (t: const Duration(milliseconds: 16), p: const Offset(4, 2)),
    (t: const Duration(milliseconds: 32), p: const Offset(12, 6)),
    (t: const Duration(milliseconds: 48), p: const Offset(24, 12)),
    (t: const Duration(milliseconds: 64), p: const Offset(38, 20)),
    (t: const Duration(milliseconds: 80), p: const Offset(56, 31)),
  ];

  for (final point in samplePoints) {
    trackerTouch.addPosition(point.t, point.p);
    trackerMouse.addPosition(point.t, point.p);
    print('addPosition(t=${point.t.inMilliseconds}ms, p=${point.p})');
  }

  final estimateTouch = trackerTouch.getVelocityEstimate();
  final estimateMouse = trackerMouse.getVelocityEstimate();

  _expectCondition(
    estimateTouch != null,
    'touch tracker returns non-null VelocityEstimate after sufficient samples',
    logs,
  );
  assertionCount++;

  _expectCondition(
    estimateMouse != null,
    'mouse tracker returns non-null VelocityEstimate after sufficient samples',
    logs,
  );
  assertionCount++;

  final velocityTouch = trackerTouch.getVelocity();
  final velocityMouse = trackerMouse.getVelocity();

  print('touch estimate pixelsPerSecond: ${estimateTouch?.pixelsPerSecond}');
  print('mouse estimate pixelsPerSecond: ${estimateMouse?.pixelsPerSecond}');
  print('touch velocity: ${_formatVelocity(velocityTouch)}');
  print('mouse velocity: ${_formatVelocity(velocityMouse)}');

  _expectCondition(
    velocityTouch.pixelsPerSecond.distance > 0,
    'touch velocity magnitude is greater than zero',
    logs,
  );
  assertionCount++;

  _expectCondition(
    velocityMouse.pixelsPerSecond.distance > 0,
    'mouse velocity magnitude is greater than zero',
    logs,
  );
  assertionCount++;

  final freshTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  final freshVelocity = freshTracker.getVelocity();
  final freshEstimate = freshTracker.getVelocityEstimate();

  _expectCondition(
    freshEstimate == null,
    'fresh tracker has null VelocityEstimate before input',
    logs,
  );
  assertionCount++;

  _expectCondition(
    freshVelocity.pixelsPerSecond == Offset.zero,
    'fresh tracker velocity defaults to Offset.zero',
    logs,
  );
  assertionCount++;

  freshTracker.addPosition(const Duration(milliseconds: 0), const Offset(10, 10));
  freshTracker.addPosition(const Duration(milliseconds: 2), const Offset(10, 10));
  final lowMovementVelocity = freshTracker.getVelocity();
  print('low movement velocity: ${_formatVelocity(lowMovementVelocity)}');

  _expectCondition(
    lowMovementVelocity.pixelsPerSecond.distance >= 0,
    'low movement velocity call returns finite result',
    logs,
  );
  assertionCount++;

  final summary = <String>[
    'constructors covered for touch and mouse PointerDeviceKind',
    'properties via runtimeType and estimate access covered',
    'behavior via addPosition/getVelocity/getVelocityEstimate covered',
    'edge cases: empty tracker and minimal movement covered',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== IOSScrollViewFlingVelocityTracker comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('IOSScrollViewFlingVelocityTracker Tests'),
      Text('Assertions: $assertionCount'),
      Text('Touch velocity: ${_formatVelocity(velocityTouch)}'),
      Text('Mouse velocity: ${_formatVelocity(velocityMouse)}'),
      Text('Fresh estimate null: ${freshEstimate == null}'),
      Text('Logs: ${logs.length} entries'),
      const Text('Summary widget generated successfully'),
    ],
  );
}// D4rt test script: Tests IOSScrollViewFlingVelocityTracker
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSScrollViewFlingVelocityTracker test executing');

  final tracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('IOSScrollViewFlingVelocityTracker: ${tracker.runtimeType}');
  print('is VelocityTracker: ${tracker is VelocityTracker}');

  // Add sample points
  tracker.addPosition(Duration(milliseconds: 0), Offset(0, 0));
  tracker.addPosition(Duration(milliseconds: 16), Offset(0, 10));
  tracker.addPosition(Duration(milliseconds: 32), Offset(0, 25));
  tracker.addPosition(Duration(milliseconds: 48), Offset(0, 45));

  final estimate = tracker.getVelocityEstimate();
  print('Velocity estimate: $estimate');
  if (estimate != null) {
    print('pixelsPerSecond: ${estimate.pixelsPerSecond}');
    print('confidence: ${estimate.confidence}');
  }

  print('IOSScrollViewFlingVelocityTracker test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('IOSScrollViewFlingVelocityTracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    Text('iOS-like fling physics'),
    Text('estimate: ${estimate?.pixelsPerSecond}'),
  ]);
}
