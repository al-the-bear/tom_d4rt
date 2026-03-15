// D4rt test script: Tests TextInputConfiguration from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// TextInputConfiguration defines input field behavior and keyboard appearance
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('================================================');
  print('TextInputConfiguration Comprehensive Test Suite');
  print('================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: Default Configuration ==========
  print('\n--- Test 1: Default Configuration ---');
  totalTests++;

  const config1 = TextInputConfiguration();
  print('Default TextInputConfiguration created');
  print('inputType: ${config1.inputType}');
  print('obscureText: ${config1.obscureText}');
  print('autocorrect: ${config1.autocorrect}');
  print('enableSuggestions: ${config1.enableSuggestions}');
  assert(config1.obscureText == false, 'Default obscureText should be false');
  assert(config1.autocorrect == true, 'Default autocorrect should be true');
  print('Test 1 PASSED: Default configuration has correct defaults');
  testsPassed++;

  // ========== Test 2: Password Configuration ==========
  print('\n--- Test 2: Password Configuration ---');
  totalTests++;

  const config2 = TextInputConfiguration(
    inputType: TextInputType.visiblePassword,
    obscureText: true,
    autocorrect: false,
    enableSuggestions: false,
  );
  print('Password configuration:');
  print('inputType: ${config2.inputType}');
  print('obscureText: ${config2.obscureText}');
  print('autocorrect: ${config2.autocorrect}');
  assert(config2.obscureText == true, 'Password should be obscured');
  assert(config2.autocorrect == false, 'Password should not autocorrect');
  print('Test 2 PASSED: Password configuration works correctly');
  testsPassed++;

  // ========== Test 3: Email Input Configuration ==========
  print('\n--- Test 3: Email Input Configuration ---');
  totalTests++;

  const config3 = TextInputConfiguration(
    inputType: TextInputType.emailAddress,
    keyboardAppearance: Brightness.light,
    textCapitalization: TextCapitalization.none,
  );
  print('Email configuration:');
  print('inputType: ${config3.inputType}');
  print('keyboardAppearance: ${config3.keyboardAppearance}');
  print('textCapitalization: ${config3.textCapitalization}');
  assert(
    config3.textCapitalization == TextCapitalization.none,
    'Email should not capitalize',
  );
  print('Test 3 PASSED: Email configuration works correctly');
  testsPassed++;

  // ========== Test 4: Multiline Configuration ==========
  print('\n--- Test 4: Multiline Configuration ---');
  totalTests++;

  const config4 = TextInputConfiguration(
    inputType: TextInputType.multiline,
    inputAction: TextInputAction.newline,
    textCapitalization: TextCapitalization.sentences,
  );
  print('Multiline configuration:');
  print('inputType: ${config4.inputType}');
  print('inputAction: ${config4.inputAction}');
  print('textCapitalization: ${config4.textCapitalization}');
  assert(
    config4.inputAction == TextInputAction.newline,
    'Multiline should use newline action',
  );
  print('Test 4 PASSED: Multiline configuration works correctly');
  testsPassed++;

  // ========== Test 5: Number Input Configuration ==========
  print('\n--- Test 5: Number Input Configuration ---');
  totalTests++;

  const config5 = TextInputConfiguration(
    inputType: TextInputType.number,
    inputAction: TextInputAction.done,
  );
  print('Number input configuration:');
  print('inputType: ${config5.inputType}');
  print('inputAction: ${config5.inputAction}');
  assert(config5.inputType == TextInputType.number, 'Should be number type');
  print('Test 5 PASSED: Number configuration works correctly');
  testsPassed++;

  // ========== Test 6: Phone Input Configuration ==========
  print('\n--- Test 6: Phone Input Configuration ---');
  totalTests++;

  const config6 = TextInputConfiguration(
    inputType: TextInputType.phone,
    inputAction: TextInputAction.call,
  );
  print('Phone configuration:');
  print('inputType: ${config6.inputType}');
  print('inputAction: ${config6.inputAction}');
  assert(config6.inputType == TextInputType.phone, 'Should be phone type');
  print('Test 6 PASSED: Phone configuration works correctly');
  testsPassed++;

  // ========== Test 7: Search Configuration ==========
  print('\n--- Test 7: Search Configuration ---');
  totalTests++;

  const config7 = TextInputConfiguration(
    inputType: TextInputType.text,
    inputAction: TextInputAction.search,
    autocorrect: true,
    enableSuggestions: true,
  );
  print('Search configuration:');
  print('inputType: ${config7.inputType}');
  print('inputAction: ${config7.inputAction}');
  print('autocorrect: ${config7.autocorrect}');
  assert(
    config7.inputAction == TextInputAction.search,
    'Should use search action',
  );
  print('Test 7 PASSED: Search configuration works correctly');
  testsPassed++;

  // ========== Test 8: URL Input Configuration ==========
  print('\n--- Test 8: URL Input Configuration ---');
  totalTests++;

  const config8 = TextInputConfiguration(
    inputType: TextInputType.url,
    inputAction: TextInputAction.go,
    autocorrect: false,
  );
  print('URL configuration:');
  print('inputType: ${config8.inputType}');
  print('inputAction: ${config8.inputAction}');
  assert(config8.inputType == TextInputType.url, 'Should be URL type');
  assert(config8.autocorrect == false, 'URL should not autocorrect');
  print('Test 8 PASSED: URL configuration works correctly');
  testsPassed++;

  // ========== Test 9: Dark Keyboard Appearance ==========
  print('\n--- Test 9: Dark Keyboard Appearance ---');
  totalTests++;

  const config9 = TextInputConfiguration(keyboardAppearance: Brightness.dark);
  print('Dark keyboard configuration:');
  print('keyboardAppearance: ${config9.keyboardAppearance}');
  assert(config9.keyboardAppearance == Brightness.dark, 'Should be dark');
  print('Test 9 PASSED: Dark keyboard appearance works');
  testsPassed++;

  // ========== Test 10: Autofill Configuration ==========
  print('\n--- Test 10: Autofill Configuration ---');
  totalTests++;

  const config10 = TextInputConfiguration(
    inputType: TextInputType.text,
    autofillConfiguration: AutofillConfiguration(
      uniqueIdentifier: 'username_field',
      autofillHints: [AutofillHints.username],
      currentEditingValue: TextEditingValue.empty,
    ),
  );
  print('Autofill configuration:');
  print('autofillConfiguration: ${config10.autofillConfiguration}');
  assert(
    config10.autofillConfiguration != AutofillConfiguration.disabled,
    'Should have autofill',
  );
  print('Test 10 PASSED: Autofill configuration works');
  testsPassed++;

  // ========== Test 11: Copy Configuration ==========
  print('\n--- Test 11: Copy Configuration ---');
  totalTests++;

  final config11 = config1.copyWith(
    inputType: TextInputType.name,
    obscureText: true,
  );
  print('Copied configuration:');
  print('inputType: ${config11.inputType}');
  print('obscureText: ${config11.obscureText}');
  assert(config11.inputType == TextInputType.name, 'Should be name type');
  assert(config11.obscureText == true, 'Should be obscured');
  print('Test 11 PASSED: Copy configuration works');
  testsPassed++;

  // ========== Test 12: toJson/fromJson ==========
  print('\n--- Test 12: Configuration toJson ---');
  totalTests++;

  const config12 = TextInputConfiguration(
    inputType: TextInputType.text,
    inputAction: TextInputAction.done,
    obscureText: false,
  );
  final json = config12.toJson();
  print('Configuration toJson:');
  print('json keys: ${json.keys.toList()}');
  assert(json.containsKey('inputType'), 'Should have inputType key');
  print('Test 12 PASSED: toJson works correctly');
  testsPassed++;

  // ========== Summary ==========
  print('\n================================================');
  print('Test Summary: $testsPassed/$totalTests tests passed');
  print('================================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextInputConfiguration Tests'),
      Text('Passed: $testsPassed/$totalTests'),
      Text('inputType, obscureText, autocorrect tested'),
      Text('autofill, keyboard appearance tested'),
    ],
  );
}
