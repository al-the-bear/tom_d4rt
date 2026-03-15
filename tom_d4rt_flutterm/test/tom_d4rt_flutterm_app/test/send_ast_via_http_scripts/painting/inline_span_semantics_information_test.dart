// D4rt test script: Tests InlineSpanSemanticsInformation from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InlineSpanSemanticsInformation test executing');
  final results = <String>[];

  // ========== InlineSpanSemanticsInformation Tests ==========
  print('Testing InlineSpanSemanticsInformation...');

  // Test 1: Create basic InlineSpanSemanticsInformation
  final info1 = InlineSpanSemanticsInformation('Hello World');
  assert(info1.text == 'Hello World', 'Text should match');
  results.add('InlineSpanSemanticsInformation text: ${info1.text}');
  print('InlineSpanSemanticsInformation created: ${info1.text}');

  // Test 2: InlineSpanSemanticsInformation with semanticsLabel
  final info2 = InlineSpanSemanticsInformation(
    'Icon',
    semanticsLabel: 'Star icon',
  );
  assert(info2.semanticsLabel == 'Star icon', 'Semantics label should match');
  results.add('InlineSpanSemanticsInformation label: ${info2.semanticsLabel}');
  print(
    'InlineSpanSemanticsInformation semanticsLabel: ${info2.semanticsLabel}',
  );

  // Test 3: InlineSpanSemanticsInformation isPlaceholder false
  final info3 = InlineSpanSemanticsInformation('Regular text');
  assert(info3.isPlaceholder == false, 'isPlaceholder should be false');
  results.add(
    'InlineSpanSemanticsInformation isPlaceholder: ${info3.isPlaceholder}',
  );
  print('InlineSpanSemanticsInformation isPlaceholder: ${info3.isPlaceholder}');

  // Test 4: InlineSpanSemanticsInformation placeholder
  final info4 = InlineSpanSemanticsInformation.placeholder;
  assert(info4.isPlaceholder == true, 'Placeholder should be true');
  results.add(
    'InlineSpanSemanticsInformation placeholder: ${info4.isPlaceholder}',
  );
  print('InlineSpanSemanticsInformation placeholder verified');

  // Test 5: InlineSpanSemanticsInformation requiresOwnNode
  final info5 = InlineSpanSemanticsInformation(
    'Link text',
    isPlaceholder: false,
    requiresOwnNode: true,
  );
  assert(info5.requiresOwnNode == true, 'requiresOwnNode should be true');
  results.add(
    'InlineSpanSemanticsInformation requiresOwnNode: ${info5.requiresOwnNode}',
  );
  print(
    'InlineSpanSemanticsInformation requiresOwnNode: ${info5.requiresOwnNode}',
  );

  // Test 6: InlineSpanSemanticsInformation with all parameters
  final info6 = InlineSpanSemanticsInformation(
    'Complex text',
    semanticsLabel: 'Descriptive label',
    isPlaceholder: false,
    requiresOwnNode: false,
  );
  assert(info6.text == 'Complex text', 'Text should match');
  assert(info6.semanticsLabel == 'Descriptive label', 'Label should match');
  results.add('InlineSpanSemanticsInformation full: text=${info6.text}');
  print('InlineSpanSemanticsInformation with all params verified');

  // Test 7: InlineSpanSemanticsInformation text length
  final info7 = InlineSpanSemanticsInformation('Short');
  assert(info7.text.length == 5, 'Text length should be 5');
  results.add('InlineSpanSemanticsInformation length: ${info7.text.length}');
  print('InlineSpanSemanticsInformation text length: ${info7.text.length}');

  // Test 8: InlineSpanSemanticsInformation empty text
  final info8 = InlineSpanSemanticsInformation('');
  assert(info8.text.isEmpty, 'Text should be empty');
  results.add('InlineSpanSemanticsInformation empty: ${info8.text.isEmpty}');
  print('InlineSpanSemanticsInformation empty text verified');

  // Test 9: InlineSpanSemanticsInformation with unicode
  final info9 = InlineSpanSemanticsInformation('Hello 🌍');
  assert(info9.text.contains('🌍'), 'Should contain unicode');
  results.add('InlineSpanSemanticsInformation unicode: ${info9.text}');
  print('InlineSpanSemanticsInformation unicode: ${info9.text}');

  // Test 10: InlineSpanSemanticsInformation only label
  final info10 = InlineSpanSemanticsInformation(
    '',
    semanticsLabel: 'Only label provided',
  );
  assert(info10.semanticsLabel == 'Only label provided', 'Label should match');
  results.add(
    'InlineSpanSemanticsInformation label only: ${info10.semanticsLabel}',
  );
  print('InlineSpanSemanticsInformation label only verified');

  // Test 11: InlineSpanSemanticsInformation toString
  final info11 = InlineSpanSemanticsInformation('Test');
  final str = info11.toString();
  assert(str.isNotEmpty, 'toString should not be empty');
  results.add('InlineSpanSemanticsInformation toString: ${str.length} chars');
  print('InlineSpanSemanticsInformation toString length: ${str.length}');

  // Test 12: InlineSpanSemanticsInformation equality
  final infoA = InlineSpanSemanticsInformation('Same');
  final infoB = InlineSpanSemanticsInformation('Same');
  assert(infoA == infoB, 'Same info should be equal');
  results.add('InlineSpanSemanticsInformation equality: ${infoA == infoB}');
  print('InlineSpanSemanticsInformation equality verified');

  // Test 13: InlineSpanSemanticsInformation hashCode
  final hash1 = infoA.hashCode;
  final hash2 = infoB.hashCode;
  assert(hash1 == hash2, 'Equal objects should have same hash');
  results.add('InlineSpanSemanticsInformation hashCode: $hash1');
  print('InlineSpanSemanticsInformation hashCode: $hash1');

  print(
    'InlineSpanSemanticsInformation test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InlineSpanSemanticsInformation Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
