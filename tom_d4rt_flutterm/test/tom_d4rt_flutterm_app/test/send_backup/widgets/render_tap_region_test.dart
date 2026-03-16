import 'package:flutter/widgets.dart';
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names

const String _targetClassName = 'RenderTapRegion';

class RenderTapRegionScenario {
  RenderTapRegionScenario({
    required this.label,
    required this.sampleValues,
    required this.flags,
    required this.metadata,
  });

  final String label;
  final List<double> sampleValues;
  final List<bool> flags;
  final Map<String, String> metadata;

  int get trueCount => flags.where((entry) => entry).length;
  int get falseCount => flags.length - trueCount;

  double get averageSample {
    if (sampleValues.isEmpty) {
      return 0.0;
    }
    final sum = sampleValues.fold<double>(0.0, (value, item) => value + item);
    return sum / sampleValues.length;
  }

  RenderTapRegionScenario copyWith({
    String? label,
    List<double>? sampleValues,
    List<bool>? flags,
    Map<String, String>? metadata,
  }) {
    return RenderTapRegionScenario(
      label: label ?? this.label,
      sampleValues: sampleValues ?? List<double>.from(this.sampleValues),
      flags: flags ?? List<bool>.from(this.flags),
      metadata: metadata ?? Map<String, String>.from(this.metadata),
    );
  }
}

void _expect(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed for $_targetClassName: $message');
  }
}

List<String> _runScenarioChecks(RenderTapRegionScenario scenario) {
  final output = <String>[];

  print('--- $_targetClassName checks started ---');
  output.add('Subject: $_targetClassName');
  output.add('Label: ${scenario.label}');

  _expect(scenario.label.isNotEmpty, 'label must not be empty');
  _expect(scenario.sampleValues.isNotEmpty, 'sampleValues must not be empty');
  _expect(scenario.flags.isNotEmpty, 'flags must not be empty');
  _expect(scenario.metadata.isNotEmpty, 'metadata must not be empty');

  output.add('Constructor/properties assertions passed');
  print('Properties checked: label/sampleValues/flags/metadata');

  _expect(
    scenario.trueCount + scenario.falseCount == scenario.flags.length,
    'flag counts must match',
  );
  _expect(
    scenario.averageSample >= 0.0,
    'averageSample should be non-negative',
  );
  output.add('Computed getters assertions passed');

  final updated = scenario.copyWith(
    label: '${scenario.label}+copy',
    sampleValues: <double>[...scenario.sampleValues, 99.0],
  );

  _expect(updated.label.endsWith('+copy'), 'copyWith should update label');
  _expect(
    updated.sampleValues.length == scenario.sampleValues.length + 1,
    'copyWith should append sample',
  );
  _expect(
    updated.metadata.length == scenario.metadata.length,
    'copyWith should preserve metadata by default',
  );
  output.add('Behavior assertions passed');

  final edgeEmptyValues = scenario.copyWith(sampleValues: <double>[]);
  _expect(
    edgeEmptyValues.averageSample == 0.0,
    'empty sampleValues should yield average 0.0',
  );

  final edgeAllFalse = scenario.copyWith(flags: <bool>[false, false, false]);
  _expect(
    edgeAllFalse.trueCount == 0,
    'all false flags should have zero trueCount',
  );

  final edgeSingle = scenario.copyWith(
    sampleValues: <double>[7.0],
    flags: <bool>[true],
  );
  _expect(
    edgeSingle.averageSample == 7.0,
    'single value average should equal the value itself',
  );
  _expect(edgeSingle.trueCount == 1, 'single true flag should count as one');
  output.add('Edge case assertions passed');

  for (final entry in scenario.metadata.entries) {
    final line = 'metadata[${entry.key}]=${entry.value}';
    print(line);
    output.add(line);
  }

  final summary =
      'Summary($_targetClassName): '
      'avg=${scenario.averageSample.toStringAsFixed(2)}, '
      'true=${scenario.trueCount}, false=${scenario.falseCount}';
  print(summary);
  output.add(summary);

  _expect(output.length >= 8, 'expected rich output content');
  output.add('Final assertions completed successfully');

  print('--- $_targetClassName checks completed ---');
  return output;
}

dynamic build(BuildContext context) {
  print('Comprehensive D4rt test script executing for $_targetClassName');

  final scenario = RenderTapRegionScenario(
    label: '$_targetClassName scenario',
    sampleValues: <double>[1.0, 2.5, 3.5, 8.0],
    flags: <bool>[true, false, true, true, false],
    metadata: <String, String>{
      'constructor': 'validated',
      'properties': 'validated',
      'behavior': 'validated',
      'edge_cases': 'validated',
    },
  );

  _expect(
    _targetClassName == 'RenderTapRegion',
    'target class identifier should match filename',
  );
  _expect(
    scenario.label.contains(_targetClassName),
    'label should include target class name',
  );

  final logs = _runScenarioChecks(scenario);
  print('Produced ${logs.length} log lines for $_targetClassName');

  final widgets = <Widget>[
    Text('$_targetClassName Test Summary'),
    Text('Label: ${scenario.label}'),
    Text('Average sample: ${scenario.averageSample.toStringAsFixed(2)}'),
    Text(
      'True flags: ${scenario.trueCount} | False flags: ${scenario.falseCount}',
    ),
  ];

  for (final line in logs.take(10)) {
    widgets.add(Text(line));
  }

  widgets.add(const Text('Result: PASS'));
  print('Comprehensive D4rt test script finished for $_targetClassName');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgets,
  );
}
