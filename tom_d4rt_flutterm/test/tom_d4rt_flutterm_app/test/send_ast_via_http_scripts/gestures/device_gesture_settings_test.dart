import 'package:flutter/gestures.dart';
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/widgets.dart';

void _expectCondition(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed: $message');
  }
  print('✅ $message');
}

String _describeSettings(DeviceGestureSettings settings) {
  return 'touchSlop=${settings.touchSlop}, hashCode=${settings.hashCode}';
}

double _average(List<double> values) {
  if (values.isEmpty) {
    return 0;
  }
  final sum = values.reduce((left, right) => left + right);
  return sum / values.length;
}

List<DeviceGestureSettings> _createSamples() {
  return const [
    DeviceGestureSettings(touchSlop: 18.0),
    DeviceGestureSettings(touchSlop: 24.0),
    DeviceGestureSettings(touchSlop: null),
    DeviceGestureSettings(touchSlop: 0.0),
    DeviceGestureSettings(touchSlop: -0.5),
    DeviceGestureSettings(touchSlop: 10000.0),
  ];
}

dynamic build(BuildContext context) {
  print('--- DeviceGestureSettings comprehensive test start ---');

  final samples = _createSamples();
  print('DeviceGestureSettings sample count: ${samples.length}');
  for (final sample in samples) {
    print('Sample -> ${_describeSettings(sample)}');
  }

  _expectCondition(
    samples.length == 6,
    'Created expected number of settings samples',
  );

  final baseA = const DeviceGestureSettings(touchSlop: 18.0);
  final baseB = const DeviceGestureSettings(touchSlop: 18.0);
  final variant = const DeviceGestureSettings(touchSlop: 24.0);
  final nullable = const DeviceGestureSettings(touchSlop: null);

  _expectCondition(baseA.touchSlop == 18.0, 'baseA stores touchSlop 18.0');
  _expectCondition(baseB.touchSlop == 18.0, 'baseB stores touchSlop 18.0');
  _expectCondition(variant.touchSlop == 24.0, 'variant stores touchSlop 24.0');
  _expectCondition(
    nullable.touchSlop == null,
    'nullable settings store null touchSlop',
  );

  _expectCondition(baseA == baseB, 'Equal values compare equal');
  _expectCondition(
    baseA.hashCode == baseB.hashCode,
    'Equal values have same hashCode',
  );
  _expectCondition(baseA != variant, 'Different values compare unequal');
  _expectCondition(
    baseA.toString().contains('18'),
    'toString includes touchSlop value',
  );

  final touchSlopValues = samples
      .map((sample) => sample.touchSlop)
      .toList(growable: false);
  final nonNullValues = touchSlopValues.whereType<double>().toList(
    growable: false,
  );

  print('touchSlop values: $touchSlopValues');
  print('non-null touchSlop values: $nonNullValues');

  _expectCondition(
    touchSlopValues.length == samples.length,
    'touchSlop extraction keeps sample count',
  );
  _expectCondition(
    nonNullValues.length == samples.length - 1,
    'Exactly one sample has null touchSlop',
  );
  _expectCondition(
    nonNullValues.contains(0.0),
    'Edge case 0.0 touchSlop is represented',
  );
  _expectCondition(
    nonNullValues.any((value) => value < 0),
    'Negative touchSlop sample is represented',
  );
  _expectCondition(
    nonNullValues.any((value) => value > 1000),
    'Large touchSlop sample is represented',
  );

  final sorted = [...nonNullValues]..sort();
  _expectCondition(
    sorted.first == -0.5,
    'Sorted non-null values start with negative edge',
  );
  _expectCondition(
    sorted.last == 10000.0,
    'Sorted non-null values end with large edge',
  );

  final average = _average(nonNullValues);
  final median = sorted[sorted.length ~/ 2];
  print('touchSlop average: $average');
  print('touchSlop median candidate: $median');
  _expectCondition(
    average > 0,
    'Average remains positive with one negative sample',
  );
  _expectCondition(median == 18.0, 'Median candidate reflects central value');

  final mediaQuery = MediaQueryData(gestureSettings: baseA);
  _expectCondition(
    mediaQuery.gestureSettings == baseA,
    'MediaQueryData stores gestureSettings value',
  );

  final reconstructed = DeviceGestureSettings(touchSlop: baseA.touchSlop);
  _expectCondition(
    reconstructed == baseA,
    'Reconstructed settings match original by value',
  );
  _expectCondition(
    reconstructed.hashCode == baseA.hashCode,
    'Reconstructed settings keep matching hashCode',
  );

  final summary =
      'DeviceGestureSettings summary -> count=${samples.length}, nonNull=${nonNullValues.length}, min=${sorted.first}, max=${sorted.last}, avg=$average, median=$median, hasNull=${touchSlopValues.contains(null)}';
  print(summary);
  print('--- DeviceGestureSettings comprehensive test complete ---');

  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DeviceGestureSettings Comprehensive Tests'),
        Text('Sample count: ${samples.length}'),
        Text('Touch slops: $touchSlopValues'),
        Text('Non-null count: ${nonNullValues.length}'),
        Text('Min non-null: ${sorted.first}'),
        Text('Max non-null: ${sorted.last}'),
        Text('Average non-null: $average'),
        Text('Median candidate: $median'),
        Text('Contains null: ${touchSlopValues.contains(null)}'),
        Text('baseA == baseB: ${baseA == baseB}'),
        Text('baseA != variant: ${baseA != variant}'),
        Text(summary),
      ],
    ),
  );
}
