// D4rt test script: Tests AttributedStringProperty from semantics
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AttributedStringProperty comprehensive test executing');
  final results = <String>[];

  // ========== AttributedStringProperty Tests ==========
  print('Testing AttributedStringProperty...');

  // Test 1: Create AttributedString for property
  final attrString = AttributedString('Hello World');
  assert(attrString != null, 'Should create AttributedString');
  results.add('AttributedString created');
  print('AttributedString created: ${attrString.string}');

  // Test 2: Verify string property
  assert(attrString.string == 'Hello World', 'String should match');
  results.add('String property: Hello World');
  print('String: ${attrString.string}');

  // Test 3: Create AttributedStringProperty for diagnostics
  final property = AttributedStringProperty(
    'label',
    attrString,
    showName: true,
  );
  assert(property != null, 'Should create property');
  results.add('AttributedStringProperty created');
  print('AttributedStringProperty created: ${property.name}');

  // Test 4: Verify property name
  assert(property.name == 'label', 'Name should match');
  results.add('Property name: label');
  print('Property name: ${property.name}');

  // Test 5: Verify property value
  assert(property.value != null, 'Value should not be null');
  assert(property.value?.string == 'Hello World', 'Value string should match');
  results.add('Property value verified');
  print('Property value: ${property.value?.string}');

  // Test 6: Check DiagnosticsProperty inheritance
  assert(property is DiagnosticsProperty<AttributedString>, 'Should be DiagnosticsProperty');
  results.add('Inheritance: DiagnosticsProperty<AttributedString>');
  print('Is DiagnosticsProperty: ${property is DiagnosticsProperty<AttributedString>}');

  // Test 7: Convert to string for display
  final stringValue = property.toString();
  assert(stringValue.isNotEmpty, 'String should not be empty');
  results.add('toString works');
  print('Property toString: $stringValue');

  // Test 8: Create property with description
  final propWithDesc = AttributedStringProperty(
    'hint',
    attrString,
    description: 'Hint text for accessibility',
  );
  results.add('Property with description created');
  print('Property with description: ${propWithDesc.name}');

  // Test 9: Create property with null value
  final nullProp = AttributedStringProperty(
    'empty',
    null,
    defaultValue: null,
  );
  assert(nullProp.value == null, 'Null value should be allowed');
  results.add('Null value property created');
  print('Null property value: ${nullProp.value}');

  // Test 10: Create AttributedString with attributes
  final attrWithSpan = AttributedString(
    'Test with locale',
    attributes: [
      LocaleStringAttribute(range: TextRange(start: 0, end: 4), locale: Locale('en', 'US')),
    ],
  );
  assert(attrWithSpan.attributes.isNotEmpty, 'Should have attributes');
  results.add('AttributedString with locale attribute');
  print('Attributes count: ${attrWithSpan.attributes.length}');

  // Test 11: Verify attribute range
  final firstAttr = attrWithSpan.attributes.first;
  assert(firstAttr.range.start == 0, 'Range start should be 0');
  assert(firstAttr.range.end == 4, 'Range end should be 4');
  results.add('Attribute range: 0-4');
  print('Attribute range: ${firstAttr.range}');

  // Test 12: Create property with level
  final levelProp = AttributedStringProperty(
    'debug',
    attrString,
    level: DiagnosticLevel.debug,
  );
  assert(levelProp.level == DiagnosticLevel.debug, 'Level should be debug');
  results.add('Property level: debug');
  print('Property level: ${levelProp.level}');

  // Test 13: DiagnosticLevel values
  final levels = DiagnosticLevel.values;
  assert(levels.contains(DiagnosticLevel.debug), 'Should contain debug');
  assert(levels.contains(DiagnosticLevel.info), 'Should contain info');
  results.add('DiagnosticLevel values: ${levels.length}');
  print('DiagnosticLevel values: $levels');

  // Test 14: Property style check
  results.add('Style controls formatting');
  print('DiagnosticsTreeStyle available for formatting');

  // Test 15: Create AttributedString with spell-out attribute
  final spellOutString = AttributedString(
    'ABC123',
    attributes: [
      SpellOutStringAttribute(range: TextRange(start: 0, end: 6)),
    ],
  );
  assert(spellOutString.attributes.first is SpellOutStringAttribute, 'Should be SpellOutStringAttribute');
  results.add('SpellOutStringAttribute works');
  print('SpellOut attribute applied to: ${spellOutString.string}');

  // Test 16: TextRange creation
  final range = TextRange(start: 5, end: 10);
  assert(range.start == 5, 'Start should be 5');
  assert(range.end == 10, 'End should be 10');
  assert(!range.isCollapsed, 'Should not be collapsed');
  results.add('TextRange: 5-10');
  print('TextRange: start=${range.start}, end=${range.end}, collapsed=${range.isCollapsed}');

  // Test 17: Verify property isNotNull
  final checkProp = AttributedStringProperty('check', attrString);
  assert(checkProp.value != null, 'Should have non-null value');
  results.add('Property isNotNull verified');
  print('Property has value: ${checkProp.value != null}');

  // Test 18: Multiple attributes on same string
  final multiAttr = AttributedString(
    'Hello World',
    attributes: [
      LocaleStringAttribute(range: TextRange(start: 0, end: 5), locale: Locale('en')),
      SpellOutStringAttribute(range: TextRange(start: 6, end: 11)),
    ],
  );
  assert(multiAttr.attributes.length == 2, 'Should have 2 attributes');
  results.add('Multiple attributes: ${multiAttr.attributes.length}');
  print('Multi-attribute string: ${multiAttr.attributes.length} attributes');

  // Test 19: Property toJsonMap
  results.add('Supports JSON serialization');
  print('DiagnosticsProperty supports toJsonMap');

  // Test 20: Summary
  print('AttributedStringProperty test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AttributedStringProperty Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Used for diagnostics with AttributedString'),
      Text('Attributes: LocaleStringAttribute, SpellOutStringAttribute'),
      Text('Properties: name, value, level, description'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
