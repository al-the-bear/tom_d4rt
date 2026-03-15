import 'package:flutter/gestures.dart';
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

class _DragCase {
  const _DragCase({
    required this.label,
    required this.details,
  });

  final String label;
  final DragStartDetails details;

  String get digest =>
      '$label@global=${details.globalPosition},local=${details.localPosition},kind=${details.kind}';
}

void _check({
  required bool condition,
  required String message,
  required List<String> logs,
  required List<String> failures,
}) {
  if (condition) {
    logs.add('PASS: $message');
    return;
  }

  logs.add('FAIL: $message');
  failures.add(message);
  assert(condition, message);
}

dynamic build(BuildContext context) {
  final logs = <String>[];
  final failures = <String>[];
  var checks = 0;

  logs.add('Starting DragStartDetails checks');

  final baseline = DragStartDetails(
    globalPosition: const Offset(100, 150),
    sourceTimeStamp: const Duration(milliseconds: 16),
  );
  final localTouch = DragStartDetails(
    globalPosition: const Offset(12, 24),
    localPosition: const Offset(2, 4),
    kind: PointerDeviceKind.touch,
    sourceTimeStamp: const Duration(milliseconds: 32),
  );
  final stylusCase = DragStartDetails(
    globalPosition: const Offset(-1, 99),
    localPosition: const Offset(-3, 11),
    kind: PointerDeviceKind.stylus,
    sourceTimeStamp: const Duration(milliseconds: 64),
  );

  final cases = <_DragCase>[
    _DragCase(label: 'baseline', details: baseline),
    _DragCase(label: 'localTouch', details: localTouch),
    _DragCase(label: 'stylusCase', details: stylusCase),
  ];

  _check(
    condition: cases.length == 3,
    message: 'three concrete drag start cases created',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.localPosition == baseline.globalPosition,
    message: 'localPosition defaults to globalPosition when omitted',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: localTouch.localPosition == Offset(2, 4),
    message: 'explicit localPosition is preserved',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: localTouch.kind == PointerDeviceKind.touch,
    message: 'kind is stored for touch case',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: stylusCase.kind == PointerDeviceKind.stylus,
    message: 'kind is stored for stylus case',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.sourceTimeStamp == const Duration(milliseconds: 16),
    message: 'sourceTimeStamp is preserved on baseline case',
    logs: logs,
    failures: failures,
  );
  checks++;

  final digest = cases.map((item) => item.digest).join(' | ');
  _check(
    condition: digest.contains('baseline@global='),
    message: 'digest contains baseline details',
    logs: logs,
    failures: failures,
  );
  checks++;

  final increasingTimes = cases
      .map((item) => item.details.sourceTimeStamp?.inMilliseconds ?? -1)
      .toList(growable: false);
  _check(
    condition: increasingTimes[0] < increasingTimes[1] &&
        increasingTimes[1] < increasingTimes[2],
    message: 'timestamps are increasing across prepared scenarios',
    logs: logs,
    failures: failures,
  );
  checks++;

  final edgeZero = DragStartDetails(
    globalPosition: Offset.zero,
    localPosition: Offset.zero,
    sourceTimeStamp: Duration.zero,
  );
  _check(
    condition: edgeZero.globalPosition == Offset.zero,
    message: 'edge case with zero offsets is supported',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: edgeZero.sourceTimeStamp == Duration.zero,
    message: 'edge case with zero timestamp is supported',
    logs: logs,
    failures: failures,
  );
  checks++;

  final summary =
      'DragStartDetails summary: checks=$checks, failures=${failures.length}, cases=${cases.length + 1}';
  print(summary);
  for (final line in logs) {
    print(line);
  }

  return ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const Text(
        'DragStartDetails Test Summary',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(summary),
      Text('Context: ${context.runtimeType}'),
      Text('Baseline global: ${baseline.globalPosition}'),
      Text('Local touch local: ${localTouch.localPosition}'),
      Text('Stylus kind: ${stylusCase.kind}'),
      Text('Digest: $digest'),
      const SizedBox(height: 8),
      ...logs.map(Text.new),
    ],
  );
}
