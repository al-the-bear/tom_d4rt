// D4rt test script: Tests ListTileStyle from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

List<String> _collectValueNames(List<ListTileStyle> values) {
  final names = <String>[];
  for (final value in values) {
    names.add(value.name);
  }
  return names;
}

Map<String, dynamic> _analyzeListTileStyle() {
  print('ListTileStyle: starting deep analysis');

  final values = ListTileStyle.values;
  assert(
    values.isNotEmpty,
    'ListTileStyle should expose at least one enum value',
  );

  final names = _collectValueNames(values);
  final indexes = <int>[];
  final orderChecks = <bool>[];

  for (final value in values) {
    print('ListTileStyle: value=${value.name} index=${value.index} raw=$value');
    indexes.add(value.index);

    final fromIndex = ListTileStyle.values[value.index];
    assert(
      fromIndex == value,
      'Index lookup must resolve the same value for ListTileStyle',
    );

    final fromName = ListTileStyle.values.byName(value.name);
    assert(
      fromName == value,
      'byName must resolve the same value for ListTileStyle',
    );

    final toStringContainsName = value.toString().contains(value.name);
    orderChecks.add(toStringContainsName);
    assert(
      toStringContainsName,
      'toString should contain the enum name for ListTileStyle',
    );
  }

  final uniqueNames = names.toSet();
  final uniqueIndexes = indexes.toSet();
  assert(
    uniqueNames.length == names.length,
    'ListTileStyle enum names must be unique',
  );
  assert(
    uniqueIndexes.length == indexes.length,
    'ListTileStyle enum indexes must be unique',
  );

  final isContiguousIndexing =
      indexes.first == 0 && indexes.last == values.length - 1;
  assert(
    isContiguousIndexing,
    'ListTileStyle enum indexes should be contiguous and zero-based',
  );

  var invalidNameThrows = false;
  try {
    ListTileStyle.values.byName('__invalid_listtilestyle__');
  } catch (error) {
    invalidNameThrows = true;
    print(
      'ListTileStyle: expected edge-case failure for invalid name -> $error',
    );
  }
  assert(
    invalidNameThrows,
    'ListTileStyle.values.byName should throw for invalid names',
  );

  final first = values.first;
  final last = values.last;
  final middle = values.length > 2 ? values[values.length ~/ 2] : first;

  print(
    'ListTileStyle: first=$first middle=$middle last=$last total=${values.length}',
  );

  return <String, dynamic>{
    'enumType': 'ListTileStyle',
    'valueCount': values.length,
    'first': first.name,
    'middle': middle.name,
    'last': last.name,
    'namesJoined': names.join(','),
    'orderChecksPassed': orderChecks.every((entry) => entry),
    'invalidNameThrows': invalidNameThrows,
    'indexRange': '${indexes.first}..${indexes.last}',
    'constructorCoverage':
        'ListTileStyle has implicit enum constructors; instance creation is validated via values traversal',
    'propertyCoverage': 'name, index, values, byName, toString',
    'behaviorCoverage': 'lookup, ordering, identity, uniqueness',
    'edgeCoverage': 'invalid byName path throws as expected',
  };
}

Widget _buildSummaryWidget(Map<String, dynamic> summary) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Summary for ${summary['enumType']}'),
      Text('Values: ${summary['valueCount']}'),
      Text('First: ${summary['first']}'),
      Text('Middle: ${summary['middle']}'),
      Text('Last: ${summary['last']}'),
      Text('Index range: ${summary['indexRange']}'),
      Text('Order checks passed: ${summary['orderChecksPassed']}'),
      Text('Invalid name throws: ${summary['invalidNameThrows']}'),
      Text('Constructor coverage: ${summary['constructorCoverage']}'),
      Text('Property coverage: ${summary['propertyCoverage']}'),
      Text('Behavior coverage: ${summary['behaviorCoverage']}'),
      Text('Edge coverage: ${summary['edgeCoverage']}'),
      Text('Names: ${summary['namesJoined']}'),
    ],
  );
}

dynamic build(BuildContext context) {
  print('ListTileStyle test executing');

  final summary = _analyzeListTileStyle();

  assert(
    summary['valueCount'] is int,
    'ListTileStyle summary must expose integer valueCount',
  );
  assert(
    (summary['valueCount'] as int) > 0,
    'ListTileStyle must have one or more values',
  );
  assert(
    summary['orderChecksPassed'] == true,
    'ListTileStyle order checks must pass',
  );
  assert(
    summary['invalidNameThrows'] == true,
    'ListTileStyle invalid-name edge case must throw',
  );

  print('ListTileStyle summary -> $summary');
  print('ListTileStyle test completed');

  return _buildSummaryWidget(summary);
}
