import 'package:flutter/gestures.dart';
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

class _PointerCase {
  const _PointerCase({required this.label, required this.event});

  final String label;
  final PointerEnterEvent event;

  String get digest =>
      '$label@position=${event.position},local=${event.localPosition},device=${event.device},kind=${event.kind}';
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

  logs.add('Starting PointerEnterEvent checks');

  final baseline = PointerEnterEvent(
    position: const Offset(10, 20),
    device: 7,
    kind: PointerDeviceKind.mouse,
  );
  final hover = PointerHoverEvent(
    position: const Offset(33, 44),
    device: 9,
    kind: PointerDeviceKind.mouse,
  );
  final fromMouse = PointerEnterEvent.fromMouseEvent(hover);
  final touchLike = PointerEnterEvent(
    position: const Offset(-5, 99),
    device: 11,
    kind: PointerDeviceKind.touch,
  );

  final cases = <_PointerCase>[
    _PointerCase(label: 'baseline', event: baseline),
    _PointerCase(label: 'fromMouse', event: fromMouse),
    _PointerCase(label: 'touchLike', event: touchLike),
  ];

  _check(
    condition: cases.length == 3,
    message: 'three concrete pointer enter event cases created',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.position == Offset(10, 20),
    message: 'baseline position is preserved',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.localPosition == baseline.position,
    message: 'baseline localPosition defaults to position',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.device == 7,
    message: 'baseline device id is preserved',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: fromMouse.position == hover.position,
    message: 'fromMouseEvent copies position',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: fromMouse.localPosition == fromMouse.position,
    message: 'fromMouseEvent localPosition is available',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: fromMouse.device == hover.device,
    message: 'fromMouseEvent copies device id',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: touchLike.kind == PointerDeviceKind.touch,
    message: 'touch-like case keeps touch pointer kind',
    logs: logs,
    failures: failures,
  );
  checks++;

  final digest = cases.map((item) => item.digest).join(' | ');
  _check(
    condition: digest.contains('fromMouse@position='),
    message: 'digest contains fromMouse case details',
    logs: logs,
    failures: failures,
  );
  checks++;

  final allPointerEvents = cases.every(
    (item) => item.event.runtimeType == PointerEnterEvent,
  );
  _check(
    condition: allPointerEvents,
    message: 'all constructed cases are PointerEnterEvent instances',
    logs: logs,
    failures: failures,
  );
  checks++;

  final summary =
      'PointerEnterEvent summary: checks=$checks, failures=${failures.length}, cases=${cases.length}';
  print(summary);
  for (final line in logs) {
    print(line);
  }

  return ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const Text(
        'PointerEnterEvent Test Summary',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(summary),
      Text('Context: ${context.runtimeType}'),
      Text('Baseline: ${baseline.position}/${baseline.localPosition}'),
      Text('FromMouse: ${fromMouse.position}/${fromMouse.localPosition}'),
      Text('TouchLike kind: ${touchLike.kind}'),
      Text('Digest: $digest'),
      const SizedBox(height: 8),
      ...logs.map(Text.new),
    ],
  );
}
