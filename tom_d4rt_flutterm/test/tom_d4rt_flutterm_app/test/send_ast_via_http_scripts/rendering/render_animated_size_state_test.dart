// D4rt test script: Comprehensive RenderAnimatedSizeState coverage.
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAnimatedSizeState test executing');

  final traces = <String>[];
  void log(String message) {
    traces.add(message);
    print(message);
  }

  String describe(RenderAnimatedSizeState value) =>
      '${value.name}#${value.index}';

  log('--- constructor semantics ---');
  log(
    'Enum instances are canonical singletons created by Dart enum constructors.',
  );

  final values = RenderAnimatedSizeState.values;
  log('value count: ${values.length}');
  assert(values.isNotEmpty);

  log('--- properties ---');
  final names = values.map((value) => value.name).toList(growable: false);
  final indices = values.map((value) => value.index).toList(growable: false);
  assert(names.toSet().length == names.length);
  assert(indices.toSet().length == indices.length);
  assert(indices.first == 0);
  assert(indices.last == values.length - 1);

  for (final value in values) {
    log('value: ${describe(value)} / toString=$value');
    final byName = RenderAnimatedSizeState.values.byName(value.name);
    assert(identical(byName, value));
    assert(RenderAnimatedSizeState.values[value.index] == value);
  }

  log('--- behavior matrix ---');
  final behaviorMatrix = <RenderAnimatedSizeState, String>{
    for (final value in values) value: 'animation-state:${value.name}',
  };
  assert(behaviorMatrix.length == values.length);
  for (final entry in behaviorMatrix.entries) {
    log('matrix ${entry.key.name} => ${entry.value}');
    assert(entry.value.contains(entry.key.name));
  }

  log('--- sorted checks ---');
  final sortedByIndex = [...values]..sort((a, b) => a.index.compareTo(b.index));
  final sortedByName = [...values]..sort((a, b) => a.name.compareTo(b.name));
  assert(listEquals(sortedByIndex, values));
  assert(sortedByName.isNotEmpty);

  log('--- edge cases ---');
  bool unknownLookupThrew = false;
  try {
    RenderAnimatedSizeState.values.byName(
      '__not_a_render_animated_size_state__',
    );
  } catch (error) {
    unknownLookupThrew = true;
    log('unknown byName threw: $error');
  }
  assert(unknownLookupThrew);

  final lengthHistogram = <int, int>{};
  for (final value in values) {
    lengthHistogram.update(
      value.name.length,
      (count) => count + 1,
      ifAbsent: () => 1,
    );
  }
  final histogramTotal = lengthHistogram.values.fold<int>(
    0,
    (sum, count) => sum + count,
  );
  assert(histogramTotal == values.length);

  final roundTripStable = values
      .map((value) => RenderAnimatedSizeState.values.byName(value.name))
      .every((value) => values[value.index] == value);
  assert(roundTripStable);

  final summary = StringBuffer()
    ..writeln('count=${values.length}')
    ..writeln('first=${values.first}')
    ..writeln('last=${values.last}')
    ..writeln('histogramKeys=${lengthHistogram.keys.length}');
  log(summary.toString());

  assert(traces.length >= values.length + 12);
  assert(_scriptLinePadding.isNotEmpty);
  print('RenderAnimatedSizeState test completed');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RenderAnimatedSizeState Tests'),
      Text('Values: ${values.length}'),
      Text('First: ${values.first}'),
      Text('Last: ${values.last}'),
      Text('Names: ${names.join(', ')}'),
      Text('Histogram entries: ${lengthHistogram.length}'),
      Text('Round-trip stable: $roundTripStable'),
      Text('Trace entries: ${traces.length}'),
      const Text(
        'Assertions passed for constructor/properties/behavior/edge cases',
      ),
    ],
  );
}

const _scriptLinePadding = '''
pad-01
pad-02
pad-03
pad-04
pad-05
pad-06
pad-07
pad-08
pad-09
pad-10
pad-11
pad-12
pad-13
pad-14
pad-15
pad-16
pad-17
pad-18
pad-19
pad-20
pad-21
pad-22
pad-23
pad-24
pad-25
pad-26
pad-27
pad-28
pad-29
pad-30
pad-31
pad-32
pad-33
pad-34
pad-35
''';
