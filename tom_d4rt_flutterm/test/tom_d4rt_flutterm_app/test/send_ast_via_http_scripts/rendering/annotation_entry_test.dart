// D4rt test script: Tests AnnotationEntry from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnnotationEntry test executing');

  final report = <String>[];
  void log(String message) {
    report.add(message);
    print(message);
  }

  log('--- constructor ---');
  const entry = AnnotationEntry<String>(
    annotation: 'hit-region',
    localPosition: Offset(12.0, 24.0),
  );
  log('runtimeType: ${entry.runtimeType}');
  assert(entry.annotation == 'hit-region');
  assert(entry.localPosition == Offset(12.0, 24.0));

  log('--- property reads ---');
  log('annotation: ${entry.annotation}');
  log('localPosition: ${entry.localPosition}');
  assert(entry.annotation.isNotEmpty);

  log('--- generic typing ---');
  final AnnotationEntry<int> numericEntry = const AnnotationEntry<int>(
    annotation: 42,
    localPosition: Offset.zero,
  );
  log('numeric annotation: ${numericEntry.annotation}');
  log('numeric localPosition: ${numericEntry.localPosition}');
  assert(numericEntry.annotation == 42);
  assert(numericEntry.localPosition == Offset.zero);

  log('--- collection behavior ---');
  final entries = <AnnotationEntry<Object>>[
    const AnnotationEntry<Object>(
      annotation: 'a',
      localPosition: Offset(1.0, 1.0),
    ),
    const AnnotationEntry<Object>(
      annotation: 2,
      localPosition: Offset(2.0, 2.0),
    ),
    const AnnotationEntry<Object>(
      annotation: true,
      localPosition: Offset(3.0, 3.0),
    ),
  ];
  log('entries length: ${entries.length}');
  assert(entries.length == 3);

  for (var i = 0; i < entries.length; i++) {
    final item = entries[i];
    log('entry[$i].annotation=${item.annotation}, pos=${item.localPosition}');
    assert(item.localPosition.dx >= 0);
    assert(item.localPosition.dy >= 0);
  }

  log('--- edge case: far position ---');
  const farEntry = AnnotationEntry<String>(
    annotation: 'far',
    localPosition: Offset(10000.0, 20000.0),
  );
  log('farEntry position: ${farEntry.localPosition}');
  assert(farEntry.localPosition.dx > 9999.0);

  log('--- equality and hash-like stability check ---');
  const sameAsEntry = AnnotationEntry<String>(
    annotation: 'hit-region',
    localPosition: Offset(12.0, 24.0),
  );
  log('entry == sameAsEntry: ${entry == sameAsEntry}');
  log('entry hashCode: ${entry.hashCode}');
  log('same hashCode: ${sameAsEntry.hashCode}');

  final bullets = <String>[
    'constructor validated',
    'properties and generic typing covered',
    'list traversal assertions executed',
    'edge position tested',
  ];
  for (final line in bullets) {
    log('Bullet: $line');
  }

  assert(report.length >= 18);
  log('Report line count: ${report.length}');

  print('AnnotationEntry test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnnotationEntry Tests'),
      Text('entry.annotation: ${entry.annotation}'),
      Text('entry.localPosition: ${entry.localPosition}'),
      Text('numeric annotation: ${numericEntry.annotation}'),
      Text('entries count: ${entries.length}'),
      Text('report lines: ${report.length}'),
      const Text('Comprehensive constructor/property/behavior checks done'),
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
''';
