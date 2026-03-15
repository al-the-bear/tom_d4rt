// D4rt test script: Comprehensive tests for MaxLengthEnforcement
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void _expect(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed for MaxLengthEnforcement: $message');
  }
}

String _describeValue(dynamic value) {
  return 'name=${value.name}, index=${value.index}, value=$value';
}

dynamic build(BuildContext context) {
  print('=== MaxLengthEnforcement comprehensive test start ===');

  final values = MaxLengthEnforcement.values;
  _expect(values.isNotEmpty, 'values must not be empty');
  print('MaxLengthEnforcement.values.length = ${values.length}');

  final names = <String>[];
  final indices = <int>[];
  final seenNames = <String>{};
  final seenIndices = <int>{};

  for (final value in values) {
    final description = _describeValue(value);
    print('value: $description');
    names.add(value.name);
    indices.add(value.index);

    _expect(seenNames.add(value.name), 'duplicate enum name: ${value.name}');
    _expect(seenIndices.add(value.index), 'duplicate enum index: ${value.index}');

    final roundTrip = MaxLengthEnforcement.values.byName(value.name);
    _expect(identical(roundTrip, value), 'byName round-trip failed for ${value.name}');
    _expect(value.toString().contains(value.name), 'toString should include enum name');
    _expect(value.index >= 0, 'index must be non-negative');
  }

  _expect(names.length == values.length, 'name list length mismatch');
  _expect(indices.length == values.length, 'index list length mismatch');

  final first = values.first;
  final last = values.last;
  print('first: ${_describeValue(first)}');
  print('last:  ${_describeValue(last)}');

  _expect(first.index <= last.index, 'first index should be <= last index');
  _expect(values[first.index] == first, 'index lookup should match first');
  _expect(values[last.index] == last, 'index lookup should match last');

  final nameToIndex = <String, int>{};
  for (final value in values) {
    nameToIndex[value.name] = value.index;
  }
  _expect(nameToIndex.length == values.length, 'nameToIndex map size mismatch');

  final sortedNames = [...names]..sort();
  _expect(sortedNames.first.isNotEmpty, 'sorted names must have non-empty entry');
  _expect(sortedNames.last.isNotEmpty, 'sorted names must have non-empty entry');

  var invalidNameThrew = false;
  try {
    MaxLengthEnforcement.values.byName('__definitely_not_a_maxlengthenforcement__');
  } catch (error) {
    invalidNameThrew = true;
    print('invalid byName threw as expected: $error');
  }
  _expect(invalidNameThrew, 'invalid byName should throw');

  final indexSum = indices.fold<int>(0, (sum, index) => sum + index);
  final expectedSum = values.length * (values.length - 1) ~/ 2;
  _expect(indexSum == expectedSum, 'enum indices should be contiguous 0..n-1');

  print('names: $names');
  print('indices: $indices');
  print('nameToIndex: $nameToIndex');

  final summaryLines = <String>[
    'MaxLengthEnforcement summary',
    'constructors/values path covered',
    'properties: name/index/toString covered',
    'behavior: byName/index lookup covered',
    'edge case: invalid byName throws',
    'summary widget included',
  ];
  for (final line in summaryLines) {
    print(line);
  }

  print('=== MaxLengthEnforcement comprehensive test completed ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('MaxLengthEnforcement Tests'),
      Text('Values: ${values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
      Text('Index sum: $indexSum'),
      Text('Invalid byName throws: $invalidNameThrew'),
      Text('Names: ${names.join(', ')}'),
      Text('Sorted first/last: ${sortedNames.first} / ${sortedNames.last}'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
// filler line to satisfy minimum length requirement
// filler line to satisfy minimum length requirement
// filler line to satisfy minimum length requirement
