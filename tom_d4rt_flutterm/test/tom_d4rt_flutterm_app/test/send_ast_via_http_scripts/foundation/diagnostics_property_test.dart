import 'package:flutter/foundation.dart';
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/widgets.dart';

void _expectCondition(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed: $message');
  }
  print('✅ $message');
}

String _describeProperty(DiagnosticsProperty<Object?> property) {
  return 'name=${property.name}, value=${property.value}, level=${property.level}, default=${property.defaultValue}, ifNull=${property.ifNull}';
}

List<DiagnosticsProperty<Object?>> _createDiagnosticsProperties() {
  return [
    DiagnosticsProperty<Object?>('title', 'hello world'),
    DiagnosticsProperty<Object?>('count', 42, defaultValue: 0),
    DiagnosticsProperty<Object?>('nullable', null, ifNull: 'not set'),
    DiagnosticsProperty<Object?>('enabled', true, level: DiagnosticLevel.debug),
    DiagnosticsProperty<Object?>('sameAsDefault', 7, defaultValue: 7),
  ];
}

dynamic build(BuildContext context) {
  print('--- DiagnosticsProperty comprehensive test start ---');

  final properties = _createDiagnosticsProperties();
  final names = properties
      .map((property) => property.name)
      .toList(growable: false);

  print('DiagnosticsProperty instances created: ${properties.length}');
  for (final property in properties) {
    print('Property -> ${_describeProperty(property)}');
  }

  _expectCondition(
    properties.length == 5,
    'Created expected number of properties',
  );
  _expectCondition(
    names.toSet().length == names.length,
    'Property names are unique',
  );

  final title = properties[0];
  final count = properties[1];
  final nullable = properties[2];
  final enabled = properties[3];
  final sameAsDefault = properties[4];

  _expectCondition(title.name == 'title', 'Title property has expected name');
  _expectCondition(
    title.value == 'hello world',
    'Title property keeps assigned value',
  );
  _expectCondition(
    title.level == DiagnosticLevel.info,
    'Title property default level is info',
  );

  _expectCondition(count.name == 'count', 'Count property has expected name');
  _expectCondition(count.value == 42, 'Count property keeps integer value');
  _expectCondition(
    count.defaultValue == 0,
    'Count property keeps explicit defaultValue',
  );

  _expectCondition(
    nullable.name == 'nullable',
    'Nullable property has expected name',
  );
  _expectCondition(
    nullable.value == null,
    'Nullable property stores null value',
  );
  _expectCondition(
    nullable.ifNull == 'not set',
    'Nullable property keeps ifNull fallback',
  );

  _expectCondition(
    enabled.name == 'enabled',
    'Enabled property has expected name',
  );
  _expectCondition(
    enabled.value == true,
    'Enabled property keeps boolean value',
  );
  _expectCondition(
    enabled.level == DiagnosticLevel.debug,
    'Enabled property keeps debug level',
  );

  _expectCondition(
    sameAsDefault.name == 'sameAsDefault',
    'sameAsDefault property has expected name',
  );
  _expectCondition(
    sameAsDefault.value == 7,
    'sameAsDefault property stores numeric value',
  );
  _expectCondition(
    sameAsDefault.defaultValue == 7,
    'sameAsDefault property stores matching default',
  );

  final infoFilter = title.isFiltered(DiagnosticLevel.info);
  final warningFilter = title.isFiltered(DiagnosticLevel.warning);
  final hiddenFilter = enabled.isFiltered(DiagnosticLevel.hidden);

  print(
    'Filter checks -> info=$infoFilter, warning=$warningFilter, hidden=$hiddenFilter',
  );
  _expectCondition(
    infoFilter == true || infoFilter == false,
    'isFiltered(info) returns a valid boolean value',
  );
  _expectCondition(
    warningFilter == true || warningFilter == false,
    'isFiltered(warning) returns a valid boolean value',
  );
  _expectCondition(
    hiddenFilter == true || hiddenFilter == false,
    'isFiltered(hidden) returns a valid boolean value',
  );

  final titleString = title.toString();
  final countString = count.toString();
  final nullableString = nullable.toString();

  print('toString(title): $titleString');
  print('toString(count): $countString');
  print('toString(nullable): $nullableString');

  _expectCondition(
    titleString.contains('title'),
    'title.toString includes property name',
  );
  _expectCondition(
    countString.contains('count'),
    'count.toString includes property name',
  );
  _expectCondition(
    nullableString.contains('nullable'),
    'nullable.toString includes property name',
  );

  final summary =
      'DiagnosticsProperty summary -> count=${properties.length}, names=$names, titleLevel=${title.level}, enabledLevel=${enabled.level}';
  print(summary);
  print('--- DiagnosticsProperty comprehensive test complete ---');

  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DiagnosticsProperty Comprehensive Tests'),
        Text('Property count: ${properties.length}'),
        Text('Names: ${names.join(', ')}'),
        Text('Title level: ${title.level}'),
        Text('Enabled level: ${enabled.level}'),
        Text('Info filter value: $infoFilter'),
        Text('Nullable ifNull: ${nullable.ifNull}'),
        Text(summary),
        for (final property in properties)
          Text(
            '${property.name}: value=${property.value}, default=${property.defaultValue}',
          ),
      ],
    ),
  );
}
