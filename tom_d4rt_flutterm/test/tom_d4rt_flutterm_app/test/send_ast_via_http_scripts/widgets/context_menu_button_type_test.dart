// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// D4rt comprehensive test script for ContextMenuButtonType
import 'package:flutter/widgets.dart';

void expectCondition(
  bool condition,
  String message,
  List<String> logs,
  Map<String, int> counters,
) {
  if (condition) {
    counters['passed'] = (counters['passed'] ?? 0) + 1;
    logs.add('PASS: ' + message);
    print('PASS: ' + message);
  } else {
    counters['failed'] = (counters['failed'] ?? 0) + 1;
    logs.add('FAIL: ' + message);
    print('FAIL: ' + message);
    assert(condition, message);
  }
}

dynamic build(BuildContext context) {
  final List<String> logs = <String>[];
  final Map<String, int> counters = <String, int>{'passed': 0, 'failed': 0};

  print('========== ContextMenuButtonType comprehensive test ==========');

  final List<ContextMenuButtonType> values = ContextMenuButtonType.values;
  expectCondition(
    values.isNotEmpty,
    'ContextMenuButtonType.values should not be empty',
    logs,
    counters,
  );
  expectCondition(
    values.length >= 2,
    'ContextMenuButtonType should provide multiple values',
    logs,
    counters,
  );

  final ContextMenuButtonType first = values.first;
  final ContextMenuButtonType last = values.last;
  print('First value: ${first.name} / ${first.index}');
  print('Last value: ${last.name} / ${last.index}');

  expectCondition(first.index == 0, 'First index is zero', logs, counters);
  expectCondition(
    last.index == values.length - 1,
    'Last index matches length - 1',
    logs,
    counters,
  );
  expectCondition(
    first != last,
    'First and last should differ when length > 1',
    logs,
    counters,
  );

  final Set<int> uniqueIndexes = <int>{};
  final Set<String> uniqueNames = <String>{};
  final List<String> serializedValues = <String>[];

  for (final ContextMenuButtonType value in values) {
    print(
      'Inspect value: name=${value.name}, index=${value.index}, str=${value.toString()}',
    );
    uniqueIndexes.add(value.index);
    uniqueNames.add(value.name);
    serializedValues.add(value.toString());

    expectCondition(
      value.name.isNotEmpty,
      'Name should not be empty for ${value.toString()}',
      logs,
      counters,
    );
    expectCondition(
      value.toString().contains(value.name),
      'toString contains enum name for ${value.name}',
      logs,
      counters,
    );
    expectCondition(
      values[value.index] == value,
      'Index round-trip works for ${value.name}',
      logs,
      counters,
    );

    final ContextMenuButtonType byName = ContextMenuButtonType.values.byName(
      value.name,
    );
    expectCondition(
      byName == value,
      'byName resolves ${value.name}',
      logs,
      counters,
    );
  }

  expectCondition(
    uniqueIndexes.length == values.length,
    'Indexes should be unique',
    logs,
    counters,
  );
  expectCondition(
    uniqueNames.length == values.length,
    'Names should be unique',
    logs,
    counters,
  );
  expectCondition(
    serializedValues.length == values.length,
    'Serialized values count matches values',
    logs,
    counters,
  );

  final List<String> indexNamePairs = values
      .map((v) => '${v.index}:${v.name}')
      .toList(growable: false);
  print('Index/name pairs: ${indexNamePairs.join(', ')}');

  expectCondition(
    indexNamePairs.every((pair) => pair.contains(':')),
    'All index/name pairs contain separator',
    logs,
    counters,
  );

  final List<ContextMenuButtonType> copied = List<ContextMenuButtonType>.from(
    values,
  );
  expectCondition(
    copied.length == values.length,
    'Copied list has same length',
    logs,
    counters,
  );
  expectCondition(
    copied.first == first,
    'Copied first equals original first',
    logs,
    counters,
  );
  expectCondition(
    copied.last == last,
    'Copied last equals original last',
    logs,
    counters,
  );

  final List<ContextMenuButtonType> reversed = values.reversed.toList(
    growable: false,
  );
  expectCondition(
    reversed.first == last,
    'Reversed first equals original last',
    logs,
    counters,
  );
  expectCondition(
    reversed.last == first,
    'Reversed last equals original first',
    logs,
    counters,
  );

  final int indexSum = values.fold<int>(0, (sum, v) => sum + v.index);
  expectCondition(indexSum >= 0, 'Index sum is non-negative', logs, counters);
  print('Index sum: $indexSum');

  final String edgeName = values.first.name;
  final ContextMenuButtonType edgeByName = ContextMenuButtonType.values.byName(
    edgeName,
  );
  expectCondition(
    edgeByName == values.first,
    'Edge case byName(first.name) works',
    logs,
    counters,
  );

  final int passCount = counters['passed'] ?? 0;
  final int failCount = counters['failed'] ?? 0;
  print(
    'Summary: passed=$passCount failed=$failCount total=${passCount + failCount}',
  );

  return Container(
    padding: const EdgeInsets.all(12),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('ContextMenuButtonType Comprehensive Tests'),
        Text('Values count: ${values.length}'),
        Text('Passed: $passCount'),
        Text('Failed: $failCount'),
        Text('First: ${first.name} (#${first.index})'),
        Text('Last: ${last.name} (#${last.index})'),
        Text('Unique names: ${uniqueNames.length}'),
        Text('Unique indexes: ${uniqueIndexes.length}'),
        Text('Index sum: $indexSum'),
        Text('Logs captured: ${logs.length}'),
        const SizedBox(height: 8),
        Text('Result: ${failCount == 0 ? 'SUCCESS' : 'FAILURE'}'),
      ],
    ),
  );
}
