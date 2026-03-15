import 'package:flutter/material.dart';
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';

class _EnumHolder<T> {
  const _EnumHolder({required this.value, required this.label});

  final T value;
  final String label;

  String get pair => '$label:$value';
}

class _RunStats {
  const _RunStats({required this.checks, required this.failures});

  final int checks;
  final int failures;
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

  logs.add('Starting BorderStyle checks');

  final values = BorderStyle.values;
  _check(
    condition: values.isNotEmpty,
    message: 'values list is not empty',
    logs: logs,
    failures: failures,
  );
  checks++;

  final holders = values
      .map((value) => _EnumHolder<BorderStyle>(value: value, label: value.name))
      .toList(growable: false);

  _check(
    condition: holders.length == values.length,
    message: 'holder count matches enum value count',
    logs: logs,
    failures: failures,
  );
  checks++;

  final first = values.first;
  final last = values.last;

  _check(
    condition: first.index == 0,
    message: 'first enum index is 0',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: last.index == values.length - 1,
    message: 'last enum index is values.length - 1',
    logs: logs,
    failures: failures,
  );
  checks++;

  final uniqueNames = values.map((value) => value.name).toSet();
  _check(
    condition: uniqueNames.length == values.length,
    message: 'enum names are unique',
    logs: logs,
    failures: failures,
  );
  checks++;

  final allRoundTrips = values
      .map((value) => BorderStyle.values.byName(value.name) == value)
      .every((isMatch) => isMatch);
  _check(
    condition: allRoundTrips,
    message: 'all names round-trip with byName',
    logs: logs,
    failures: failures,
  );
  checks++;

  var invalidNameThrows = false;
  try {
    BorderStyle.values.byName('__BorderStyle_invalid__');
  } catch (_) {
    invalidNameThrows = true;
  }

  _check(
    condition: invalidNameThrows,
    message: 'invalid byName lookup throws',
    logs: logs,
    failures: failures,
  );
  checks++;

  final namesFromHolders = holders.map((holder) => holder.label).toList();
  _check(
    condition: namesFromHolders.first == first.name,
    message: 'holder label reflects first enum name',
    logs: logs,
    failures: failures,
  );
  checks++;

  final pairPreview = holders.map((holder) => holder.pair).join(' | ');
  _check(
    condition: pairPreview.contains(first.name),
    message: 'pair preview includes first enum name',
    logs: logs,
    failures: failures,
  );
  checks++;

  final sortedByIndex = [...values]..sort((a, b) => a.index.compareTo(b.index));
  _check(
    condition: sortedByIndex.first == first && sortedByIndex.last == last,
    message: 'sorting by index keeps first/last boundaries',
    logs: logs,
    failures: failures,
  );
  checks++;

  final stats = _RunStats(checks: checks, failures: failures.length);
  final summary =
      'BorderStyle summary: checks=${stats.checks}, failures=${stats.failures}, values=${values.length}';

  print(summary);
  for (final line in logs) {
    print(line);
  }

  return ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const Text(
        'BorderStyle Test Summary',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(summary),
      Text('Context: ${context.runtimeType}'),
      Text('First: ${first.name} (${first.index})'),
      Text('Last: ${last.name} (${last.index})'),
      Text('Pairs: $pairPreview'),
      const SizedBox(height: 8),
      ...logs.map(Text.new),
    ],
  );
}
