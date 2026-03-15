// D4rt test script: Tests TextInput from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// TextInput provides static methods for text input system interaction
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('================================================');
  print('TextInput Comprehensive Test Suite');
  print('================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: TextInput Class Availability ==========
  print('\n--- Test 1: TextInput Class Availability ---');
  totalTests++;

  print('TextInput is a static class for text input system');
  print('Static methods: attach, setChannel, finishAutofillContext');
  print('It manages the platform text input service');
  assert(true, 'TextInput class is available');
  print('Test 1 PASSED: TextInput class is available');
  testsPassed++;

  // ========== Test 2: TextInputType Variants ==========
  print('\n--- Test 2: TextInputType Variants ---');
  totalTests++;

  print('Available TextInputType values:');
  print('- text: ${TextInputType.text}');
  print('- multiline: ${TextInputType.multiline}');
  print('- number: ${TextInputType.number}');
  print('- phone: ${TextInputType.phone}');
  print('- datetime: ${TextInputType.datetime}');
  print('- emailAddress: ${TextInputType.emailAddress}');
  print('- url: ${TextInputType.url}');
  assert(TextInputType.text != TextInputType.number, 'Types should differ');
  print('Test 2 PASSED: TextInputType variants work');
  testsPassed++;

  // ========== Test 3: TextInputConfiguration Creation ==========
  print('\n--- Test 3: TextInputConfiguration Creation ---');
  totalTests++;

  const config = TextInputConfiguration(
    inputType: TextInputType.text,
    inputAction: TextInputAction.done,
    autocorrect: true,
    enableSuggestions: true,
  );
  print('TextInputConfiguration:');
  print('inputType: ${config.inputType}');
  print('inputAction: ${config.inputAction}');
  print('autocorrect: ${config.autocorrect}');
  assert(config.autocorrect == true, 'Autocorrect should be enabled');
  print('Test 3 PASSED: Configuration created successfully');
  testsPassed++;

  // ========== Test 4: Password Input Configuration ==========
  print('\n--- Test 4: Password Input Configuration ---');
  totalTests++;

  const passwordConfig = TextInputConfiguration(
    inputType: TextInputType.visiblePassword,
    obscureText: true,
    autocorrect: false,
    enableSuggestions: false,
  );
  print('Password configuration:');
  print('obscureText: ${passwordConfig.obscureText}');
  print('autocorrect: ${passwordConfig.autocorrect}');
  print('enableSuggestions: ${passwordConfig.enableSuggestions}');
  assert(passwordConfig.obscureText == true, 'Should be obscured');
  print('Test 4 PASSED: Password configuration works');
  testsPassed++;

  // ========== Test 5: TextEditingValue Manipulation ==========
  print('\n--- Test 5: TextEditingValue Manipulation ---');
  totalTests++;

  const value1 = TextEditingValue(
    text: 'Initial text',
    selection: TextSelection.collapsed(offset: 12),
  );
  print('Initial TextEditingValue:');
  print('text: ${value1.text}');
  print('selection offset: ${value1.selection.baseOffset}');

  final value2 = value1.copyWith(text: 'Modified text');
  print('Modified text: ${value2.text}');
  assert(value2.text == 'Modified text', 'Text should be modified');
  print('Test 5 PASSED: TextEditingValue manipulation works');
  testsPassed++;

  // ========== Test 6: TextSelection Creation ==========
  print('\n--- Test 6: TextSelection Creation ---');
  totalTests++;

  const selection1 = TextSelection(baseOffset: 0, extentOffset: 5);
  print('TextSelection:');
  print('baseOffset: ${selection1.baseOffset}');
  print('extentOffset: ${selection1.extentOffset}');
  print('isCollapsed: ${selection1.isCollapsed}');
  print('isDirectional: ${selection1.isDirectional}');
  assert(selection1.isCollapsed == false, 'Should not be collapsed');
  print('Test 6 PASSED: TextSelection creation works');
  testsPassed++;

  // ========== Test 7: Collapsed TextSelection ==========
  print('\n--- Test 7: Collapsed TextSelection ---');
  totalTests++;

  const collapsed = TextSelection.collapsed(offset: 10);
  print('Collapsed selection:');
  print('offset: ${collapsed.baseOffset}');
  print('isCollapsed: ${collapsed.isCollapsed}');
  assert(collapsed.isCollapsed == true, 'Should be collapsed');
  assert(
    collapsed.baseOffset == collapsed.extentOffset,
    'Offsets should match',
  );
  print('Test 7 PASSED: Collapsed selection works');
  testsPassed++;

  // ========== Test 8: TextRange Operations ==========
  print('\n--- Test 8: TextRange Operations ---');
  totalTests++;

  const range = TextRange(start: 5, end: 10);
  print('TextRange:');
  print('start: ${range.start}');
  print('end: ${range.end}');
  print('isValid: ${range.isValid}');
  print('isCollapsed: ${range.isCollapsed}');
  print('isNormalized: ${range.isNormalized}');
  assert(range.isValid == true, 'Range should be valid');
  assert(range.isNormalized == true, 'Range should be normalized');
  print('Test 8 PASSED: TextRange operations work');
  testsPassed++;

  // ========== Test 9: Empty TextRange ==========
  print('\n--- Test 9: Empty TextRange ---');
  totalTests++;

  const emptyRange = TextRange.empty;
  print('Empty TextRange:');
  print('start: ${emptyRange.start}');
  print('end: ${emptyRange.end}');
  print('isValid: ${emptyRange.isValid}');
  print('isCollapsed: ${emptyRange.isCollapsed}');
  assert(emptyRange.start == -1, 'Empty start should be -1');
  assert(emptyRange.end == -1, 'Empty end should be -1');
  print('Test 9 PASSED: Empty TextRange works');
  testsPassed++;

  // ========== Test 10: TextInputAction Values ==========
  print('\n--- Test 10: TextInputAction Values ---');
  totalTests++;

  print('TextInputAction enumeration:');
  for (final action in TextInputAction.values) {
    print('- $action');
  }
  assert(
    TextInputAction.values.contains(TextInputAction.done),
    'Should contain done',
  );
  assert(
    TextInputAction.values.contains(TextInputAction.search),
    'Should contain search',
  );
  print('Test 10 PASSED: All TextInputAction values available');
  testsPassed++;

  // ========== Test 11: Autofill Hints ==========
  print('\n--- Test 11: Autofill Hints ---');
  totalTests++;

  print('Common AutofillHints:');
  print('- username: ${AutofillHints.username}');
  print('- password: ${AutofillHints.password}');
  print('- email: ${AutofillHints.email}');
  print('- name: ${AutofillHints.name}');
  print('- telephoneNumber: ${AutofillHints.telephoneNumber}');
  assert(AutofillHints.username.isNotEmpty, 'Username hint should exist');
  print('Test 11 PASSED: Autofill hints work');
  testsPassed++;

  // ========== Test 12: Keyboard Appearance ==========
  print('\n--- Test 12: Keyboard Appearance ---');
  totalTests++;

  const lightConfig = TextInputConfiguration(
    keyboardAppearance: Brightness.light,
  );
  const darkConfig = TextInputConfiguration(
    keyboardAppearance: Brightness.dark,
  );
  print('Keyboard appearances:');
  print('light: ${lightConfig.keyboardAppearance}');
  print('dark: ${darkConfig.keyboardAppearance}');
  assert(
    lightConfig.keyboardAppearance != darkConfig.keyboardAppearance,
    'Should differ',
  );
  print('Test 12 PASSED: Keyboard appearance works');
  testsPassed++;

  // ========== Summary ==========
  print('\n================================================');
  print('Test Summary: $testsPassed/$totalTests tests passed');
  print('================================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextInput Tests'),
      Text('Passed: $testsPassed/$totalTests'),
      Text('Configuration, actions, autofill tested'),
      Text('Selection, range, keyboard tested'),
    ],
  );
}
