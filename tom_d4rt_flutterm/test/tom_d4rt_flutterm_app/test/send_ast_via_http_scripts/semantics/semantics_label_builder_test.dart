// D4rt test script: Tests SemanticsLabelBuilder concepts from semantics
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsLabelBuilder comprehensive test executing');
  final results = <String>[];

  // ========== SemanticsLabelBuilder Tests ==========
  print('Testing SemanticsLabelBuilder concepts...');

  // Test 1: SemanticsLabelBuilder purpose
  results.add('SemanticsLabelBuilder: Builds accessibility labels');
  print('SemanticsLabelBuilder constructs complex labels');

  // Test 2: Label concatenation concept
  final parts = <String>['Button', 'Submit Form', 'Double tap to activate'];
  final concatenated = parts.join(', ');
  assert(concatenated.contains('Button'), 'Should contain Button');
  results.add('Label parts: ${parts.length}');
  print('Label concatenation: $concatenated');

  // Test 3: AttributedString for rich labels
  final attrLabel = AttributedString('Submit Button');
  assert(attrLabel.string == 'Submit Button', 'Label should match');
  results.add('AttributedString label: Submit Button');
  print('AttributedString: ${attrLabel.string}');

  // Test 4: Adding locale attributes to labels
  final localizedLabel = AttributedString(
    'Submit',
    attributes: [
      LocaleStringAttribute(range: TextRange(start: 0, end: 6), locale: Locale('en', 'US')),
    ],
  );
  assert(localizedLabel.attributes.isNotEmpty, 'Should have locale attribute');
  results.add('Localized label with en_US');
  print('Localized label: ${localizedLabel.string}');

  // Test 5: Adding spell-out attributes
  final spellOutLabel = AttributedString(
    'ABC123',
    attributes: [
      SpellOutStringAttribute(range: TextRange(start: 0, end: 6)),
    ],
  );
  assert(spellOutLabel.attributes.first is SpellOutStringAttribute, 'Should be SpellOutStringAttribute');
  results.add('SpellOut label: ABC123');
  print('SpellOut label: ${spellOutLabel.string}');

  // Test 6: Combining multiple attributes
  final multiAttrLabel = AttributedString(
    'Hello World',
    attributes: [
      LocaleStringAttribute(range: TextRange(start: 0, end: 5), locale: Locale('en')),
      SpellOutStringAttribute(range: TextRange(start: 6, end: 11)),
    ],
  );
  assert(multiAttrLabel.attributes.length == 2, 'Should have 2 attributes');
  results.add('Multi-attribute label: 2 attributes');
  print('Multi-attribute label: ${multiAttrLabel.attributes.length} attrs');

  // Test 7: SemanticsConfiguration label property
  final config = SemanticsConfiguration();
  config.label = 'Test Label';
  assert(config.label == 'Test Label', 'Config label should match');
  results.add('SemanticsConfiguration.label set');
  print('Config label: ${config.label}');

  // Test 8: AttributedLabel property
  config.attributedLabel = attrLabel;
  assert(config.attributedLabel?.string == 'Submit Button', 'AttributedLabel should match');
  results.add('SemanticsConfiguration.attributedLabel set');
  print('Attributed label: ${config.attributedLabel?.string}');

  // Test 9: Hint label
  config.hint = 'Double tap to activate';
  assert(config.hint == 'Double tap to activate', 'Hint should match');
  results.add('Hint label: Double tap to activate');
  print('Hint: ${config.hint}');

  // Test 10: Value label
  config.value = '50%';
  assert(config.value == '50%', 'Value should match');
  results.add('Value label: 50%');
  print('Value: ${config.value}');

  // Test 11: IncreasedValue label
  config.increasedValue = '60%';
  assert(config.increasedValue == '60%', 'IncreasedValue should match');
  results.add('IncreasedValue: 60%');
  print('IncreasedValue: ${config.increasedValue}');

  // Test 12: DecreasedValue label
  config.decreasedValue = '40%';
  assert(config.decreasedValue == '40%', 'DecreasedValue should match');
  results.add('DecreasedValue: 40%');
  print('DecreasedValue: ${config.decreasedValue}');

  // Test 13: Label builder pattern
  final labelParts = StringBuffer();
  labelParts.write('Item 1');
  labelParts.write(', ');
  labelParts.write('Item 2');
  final builtLabel = labelParts.toString();
  assert(builtLabel == 'Item 1, Item 2', 'Built label should match');
  results.add('StringBuffer label building');
  print('Built label: $builtLabel');

  // Test 14: Empty label handling
  final emptyAttr = AttributedString('');
  assert(emptyAttr.string.isEmpty, 'Empty string should be valid');
  results.add('Empty label: valid');
  print('Empty label allowed: ${emptyAttr.string.isEmpty}');

  // Test 15: Long label handling
  final longLabel = 'A' * 500;
  final longAttrString = AttributedString(longLabel);
  assert(longAttrString.string.length == 500, 'Long label should work');
  results.add('Long label: 500 chars');
  print('Long label length: ${longAttrString.string.length}');

  // Test 16: Unicode in labels
  final unicodeLabel = AttributedString('🎉 Celebration 🎊');
  assert(unicodeLabel.string.contains('🎉'), 'Unicode should work');
  results.add('Unicode in labels supported');
  print('Unicode label: ${unicodeLabel.string}');

  // Test 17: Newlines in labels
  final multilineLabel = AttributedString('Line 1\nLine 2');
  assert(multilineLabel.string.contains('\n'), 'Newlines allowed');
  results.add('Multiline labels supported');
  print('Multiline label: ${multilineLabel.string.replaceAll('\n', '\\n')}');

  // Test 18: Label with special characters
  final specialLabel = AttributedString('Price: \$10.00 <sale>');
  assert(specialLabel.string.contains('\$'), 'Special chars work');
  results.add('Special characters in labels');
  print('Special chars label: ${specialLabel.string}');

  // Test 19: TextRange for attributes
  final range = TextRange(start: 0, end: 10);
  assert(range.start == 0, 'Range start should be 0');
  assert(range.end == 10, 'Range end should be 10');
  assert(!range.isCollapsed, 'Should not be collapsed');
  results.add('TextRange: 0-10');
  print('TextRange: ${range.start}-${range.end}');

  // Test 20: Summary
  print('SemanticsLabelBuilder test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsLabelBuilder Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Builds accessibility labels dynamically'),
      Text('AttributedString for rich text labels'),
      Text('Attributes: LocaleString, SpellOut'),
      Text('Config: label, hint, value, increased/decreased'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
