import 'dart:ui' as ui;
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('SemanticsFlags test failed: $message');
  }
  logs.add('PASS: $message');
}

String _describe(ui.SemanticsFlag flag) {
  return '${flag.name}(index=${flag.index}, toString=$flag)';
}

dynamic build(BuildContext context) {
  print('=== SemanticsFlags comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final values = ui.SemanticsFlag.values;
  final names = values.map((value) => value.name).toList();
  final indices = values.map((value) => value.index).toList();

  _expectCondition(
    values.isNotEmpty,
    'SemanticsFlag values are available',
    logs,
  );
  assertionCount++;

  _expectCondition(
    names.toSet().length == names.length,
    'SemanticsFlag names are unique',
    logs,
  );
  assertionCount++;

  _expectCondition(
    indices.toSet().length == indices.length,
    'SemanticsFlag indices are unique',
    logs,
  );
  assertionCount++;

  for (final value in values) {
    print('flag: ${_describe(value)}');

    final roundTrip = ui.SemanticsFlag.values.byName(value.name);
    _expectCondition(
      identical(roundTrip, value),
      'byName round-trip for ${value.name}',
      logs,
    );
    assertionCount++;

    _expectCondition(
      value.toString().contains(value.name),
      'toString includes enum name for ${value.name}',
      logs,
    );
    assertionCount++;
  }

  final hasButton = values.contains(ui.SemanticsFlag.isButton);
  final hasTextField = values.contains(ui.SemanticsFlag.isTextField);

  _expectCondition(hasButton, 'contains SemanticsFlag.isButton', logs);
  assertionCount++;

  _expectCondition(hasTextField, 'contains SemanticsFlag.isTextField', logs);
  assertionCount++;

  final first = values.first;
  final last = values.last;

  _expectCondition(first.index == 0, 'first SemanticsFlag index is zero', logs);
  assertionCount++;

  _expectCondition(
    last.index == values.length - 1,
    'last SemanticsFlag index is values.length - 1',
    logs,
  );
  assertionCount++;

  var invalidNameThrows = false;
  try {
    ui.SemanticsFlag.values.byName('__invalid_semantics_flag_name__');
  } catch (error) {
    invalidNameThrows = true;
    print('expected byName error: $error');
  }

  _expectCondition(
    invalidNameThrows,
    'invalid byName throws for SemanticsFlag',
    logs,
  );
  assertionCount++;

  final indexSum = indices.fold<int>(0, (sum, index) => sum + index);
  final expectedSum = values.length * (values.length - 1) ~/ 2;
  _expectCondition(
    indexSum == expectedSum,
    'indices are contiguous and cover 0..n-1',
    logs,
  );
  assertionCount++;

  // File name uses SemanticsFlags (plural). Flutter API exposes SemanticsFlag.
  final semanticsFlagsNameAlignment = 'SemanticsFlags -> SemanticsFlag';
  print('naming alignment: $semanticsFlagsNameAlignment');

  final summary = <String>[
    'constructors/enum values path covered via SemanticsFlag.values',
    'properties covered: name, index, toString',
    'behavior covered: byName and contains lookups',
    'edge case covered: invalid byName throws',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== SemanticsFlags comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('SemanticsFlags Tests'),
      Text('Resolved API: $semanticsFlagsNameAlignment'),
      Text('Values: ${values.length}'),
      Text('First: ${first.name} (${first.index})'),
      Text('Last: ${last.name} (${last.index})'),
      Text('Invalid byName throws: $invalidNameThrows'),
      Text('Assertions: $assertionCount'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
