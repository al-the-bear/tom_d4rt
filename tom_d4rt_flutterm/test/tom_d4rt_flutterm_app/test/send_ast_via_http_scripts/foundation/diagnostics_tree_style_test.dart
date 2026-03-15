import 'package:flutter/foundation.dart';
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/widgets.dart';

void _expectCondition(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed: $message');
  }
  print('✅ $message');
}

String _formatEnumValues<T extends Enum>(List<T> values) {
  final buffer = StringBuffer();
  for (final value in values) {
    buffer.writeln(' - ${value.index}: ${value.name} => $value');
  }
  return buffer.toString();
}

Map<int, T> _buildIndexMap<T extends Enum>(List<T> values) {
  final map = <int, T>{};
  for (final value in values) {
    map[value.index] = value;
  }
  return map;
}

void _validateRoundTripByIndex<T extends Enum>(List<T> values) {
  for (var index = 0; index < values.length; index++) {
    _expectCondition(
      values[index].index == index,
      'Contiguous index at $index',
    );
  }
}

dynamic build(BuildContext context) {
  print('--- DiagnosticsTreeStyle comprehensive test start ---');

  final values = DiagnosticsTreeStyle.values;
  final names = values.map((value) => value.name).toList(growable: false);
  final indexes = values.map((value) => value.index).toList(growable: false);
  final indexMap = _buildIndexMap(values);

  print('DiagnosticsTreeStyle values count: ${values.length}');
  print('DiagnosticsTreeStyle names: $names');
  print('DiagnosticsTreeStyle indexes: $indexes');
  print('DiagnosticsTreeStyle details:\n${_formatEnumValues(values)}');

  _expectCondition(
    values.isNotEmpty,
    'DiagnosticsTreeStyle has at least one value',
  );
  _expectCondition(
    names.length == values.length,
    'Names length matches values length',
  );
  _expectCondition(
    indexes.length == values.length,
    'Indexes length matches values length',
  );
  _expectCondition(
    indexMap.length == values.length,
    'Index map covers all DiagnosticsTreeStyle values',
  );
  _expectCondition(
    names.toSet().length == names.length,
    'DiagnosticsTreeStyle names are unique',
  );
  _expectCondition(
    indexes.toSet().length == indexes.length,
    'DiagnosticsTreeStyle indexes are unique',
  );
  _expectCondition(indexes.first == 0, 'First DiagnosticsTreeStyle index is 0');
  _expectCondition(
    indexes.last == values.length - 1,
    'Last DiagnosticsTreeStyle index is values.length - 1',
  );

  _validateRoundTripByIndex(values);

  final first = values.first;
  final last = values.last;

  print('First DiagnosticsTreeStyle: $first (${first.name}, ${first.index})');
  print('Last DiagnosticsTreeStyle: $last (${last.name}, ${last.index})');

  _expectCondition(
    DiagnosticsTreeStyle.values.byName(first.name) == first,
    'byName resolves first DiagnosticsTreeStyle',
  );
  _expectCondition(
    DiagnosticsTreeStyle.values.byName(last.name) == last,
    'byName resolves last DiagnosticsTreeStyle',
  );
  _expectCondition(
    indexMap[first.index] == first,
    'Index map resolves first DiagnosticsTreeStyle',
  );
  _expectCondition(
    indexMap[last.index] == last,
    'Index map resolves last DiagnosticsTreeStyle',
  );
  _expectCondition(
    first == DiagnosticsTreeStyle.values[first.index],
    'First DiagnosticsTreeStyle round-trips from index',
  );
  _expectCondition(
    last == DiagnosticsTreeStyle.values[last.index],
    'Last DiagnosticsTreeStyle round-trips from index',
  );
  _expectCondition(
    first.toString().contains(first.name),
    'first.toString contains name',
  );
  _expectCondition(
    last.toString().contains(last.name),
    'last.toString contains name',
  );
  _expectCondition(
    first == first,
    'Reflexive equality for first DiagnosticsTreeStyle',
  );
  _expectCondition(
    last == last,
    'Reflexive equality for last DiagnosticsTreeStyle',
  );

  bool invalidNameThrows = false;
  try {
    DiagnosticsTreeStyle.values.byName('__invalid_diagnostics_tree_style__');
  } catch (error) {
    invalidNameThrows = true;
    print('Expected DiagnosticsTreeStyle byName failure: $error');
  }
  _expectCondition(
    invalidNameThrows,
    'Invalid byName throws for DiagnosticsTreeStyle',
  );

  final sortedByIndex = [...values]..sort((a, b) => a.index.compareTo(b.index));
  _expectCondition(
    sortedByIndex.join('|') == values.join('|'),
    'Sorting by index preserves DiagnosticsTreeStyle order',
  );

  final summary =
      'DiagnosticsTreeStyle summary -> count=${values.length}, first=${first.name}, last=${last.name}, invalidLookupThrows=$invalidNameThrows';
  print(summary);
  print('--- DiagnosticsTreeStyle comprehensive test complete ---');

  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DiagnosticsTreeStyle Comprehensive Tests'),
        Text('Count: ${values.length}'),
        Text('First: ${first.name} (${first.index})'),
        Text('Last: ${last.name} (${last.index})'),
        Text('Unique names: ${names.toSet().length}'),
        Text('Unique indexes: ${indexes.toSet().length}'),
        Text('Invalid lookup throws: $invalidNameThrows'),
        Text(summary),
        for (final value in values)
          Text('${value.index}: ${value.name} -> $value'),
      ],
    ),
  );
}
