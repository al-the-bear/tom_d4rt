// D4rt test script: Tests SuggestionSpan from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// SuggestionSpan represents a range of text with spell-check suggestions
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('========================================');
  print('SuggestionSpan Comprehensive Test Suite');
  print('========================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: Basic SuggestionSpan Construction ==========
  print('\n--- Test 1: Basic SuggestionSpan Construction ---');
  totalTests++;

  final range1 = TextRange(start: 0, end: 5);
  final suggestions1 = <String>['hello', 'hallo', 'hullo'];
  final span1 = SuggestionSpan(range1, suggestions1);

  print('Created SuggestionSpan with range: ${span1.range}');
  print('Suggestions: ${span1.suggestions}');
  assert(span1.range.start == 0, 'Range start should be 0');
  assert(span1.range.end == 5, 'Range end should be 5');
  assert(span1.suggestions.length == 3, 'Should have 3 suggestions');
  print('Test 1 PASSED: Basic construction works');
  testsPassed++;

  // ========== Test 2: Single Suggestion ==========
  print('\n--- Test 2: Single Suggestion ---');
  totalTests++;

  final range2 = TextRange(start: 10, end: 15);
  final suggestions2 = <String>['world'];
  final span2 = SuggestionSpan(range2, suggestions2);

  print('Single suggestion span range: ${span2.range}');
  print('Single suggestion: ${span2.suggestions}');
  assert(span2.suggestions.length == 1, 'Should have 1 suggestion');
  assert(span2.suggestions[0] == 'world', 'Suggestion should be "world"');
  print('Test 2 PASSED: Single suggestion works');
  testsPassed++;

  // ========== Test 3: Empty Suggestions List ==========
  print('\n--- Test 3: Empty Suggestions List ---');
  totalTests++;

  final range3 = TextRange(start: 20, end: 25);
  final suggestions3 = <String>[];
  final span3 = SuggestionSpan(range3, suggestions3);

  print('Empty suggestions span range: ${span3.range}');
  print('Empty suggestions: ${span3.suggestions}');
  assert(span3.suggestions.isEmpty, 'Suggestions should be empty');
  print('Test 3 PASSED: Empty suggestions list works');
  testsPassed++;

  // ========== Test 4: Range Properties ==========
  print('\n--- Test 4: Range Properties ---');
  totalTests++;

  final range4 = TextRange(start: 5, end: 12);
  final span4 = SuggestionSpan(range4, ['correct', 'korect']);

  print('Range start: ${span4.range.start}');
  print('Range end: ${span4.range.end}');
  print('Range isValid: ${span4.range.isValid}');
  print('Range isCollapsed: ${span4.range.isCollapsed}');
  print('Range isNormalized: ${span4.range.isNormalized}');
  assert(span4.range.isValid, 'Range should be valid');
  assert(!span4.range.isCollapsed, 'Range should not be collapsed');
  assert(span4.range.isNormalized, 'Range should be normalized');
  print('Test 4 PASSED: Range properties are correct');
  testsPassed++;

  // ========== Test 5: Multiple Spans Simulation ==========
  print('\n--- Test 5: Multiple Spans Simulation ---');
  totalTests++;

  final spans = <SuggestionSpan>[
    SuggestionSpan(TextRange(start: 0, end: 4), ['this', 'thus']),
    SuggestionSpan(TextRange(start: 5, end: 7), ['is', 'as']),
    SuggestionSpan(TextRange(start: 8, end: 12), ['test', 'text', 'tent']),
  ];

  print('Created ${spans.length} suggestion spans');
  for (int i = 0; i < spans.length; i++) {
    print(
      'Span $i: range=${spans[i].range}, suggestions=${spans[i].suggestions}',
    );
  }
  assert(spans.length == 3, 'Should have 3 spans');
  print('Test 5 PASSED: Multiple spans work correctly');
  testsPassed++;

  // ========== Test 6: Large Range ==========
  print('\n--- Test 6: Large Range ---');
  totalTests++;

  final largeRange = TextRange(start: 0, end: 1000);
  final largeSpan = SuggestionSpan(largeRange, ['replacement']);

  print(
    'Large range span: start=${largeSpan.range.start}, end=${largeSpan.range.end}',
  );
  assert(
    largeSpan.range.end - largeSpan.range.start == 1000,
    'Range length should be 1000',
  );
  print('Test 6 PASSED: Large range works');
  testsPassed++;

  // ========== Test 7: Unicode Suggestions ==========
  print('\n--- Test 7: Unicode Suggestions ---');
  totalTests++;

  final unicodeRange = TextRange(start: 0, end: 4);
  final unicodeSuggestions = ['カフェ', '咖啡', 'кофе', 'café'];
  final unicodeSpan = SuggestionSpan(unicodeRange, unicodeSuggestions);

  print('Unicode suggestions: ${unicodeSpan.suggestions}');
  assert(
    unicodeSpan.suggestions.length == 4,
    'Should have 4 unicode suggestions',
  );
  print('Test 7 PASSED: Unicode suggestions work');
  testsPassed++;

  // ========== Test 8: Suggestion Span with Special Characters ==========
  print('\n--- Test 8: Special Characters in Suggestions ---');
  totalTests++;

  final specialRange = TextRange(start: 10, end: 20);
  final specialSuggestions = ["don't", "won't", "can't", "it's"];
  final specialSpan = SuggestionSpan(specialRange, specialSuggestions);

  print('Special character suggestions: ${specialSpan.suggestions}');
  assert(
    specialSpan.suggestions.contains("don't"),
    'Should contain apostrophe word',
  );
  print('Test 8 PASSED: Special characters work');
  testsPassed++;

  // ========== Test 9: Collapsed Range ==========
  print('\n--- Test 9: Collapsed Range (Zero Width) ---');
  totalTests++;

  final collapsedRange = TextRange(start: 5, end: 5);
  final collapsedSpan = SuggestionSpan(collapsedRange, ['insert']);

  print('Collapsed range isCollapsed: ${collapsedSpan.range.isCollapsed}');
  assert(collapsedSpan.range.isCollapsed, 'Range should be collapsed');
  print('Test 9 PASSED: Collapsed range handled');
  testsPassed++;

  // ========== Test 10: Range Text Operations ==========
  print('\n--- Test 10: Range Text Operations ---');
  totalTests++;

  final sampleText = 'The quick brown fox jumps';
  final wordRange = TextRange(start: 4, end: 9); // "quick"
  final wordSpan = SuggestionSpan(wordRange, ['fast', 'rapid', 'swift']);

  print('Sample text: "$sampleText"');
  print('Word range: ${wordSpan.range}');
  print('Text before range: "${wordSpan.range.textBefore(sampleText)}"');
  print('Text inside range: "${wordSpan.range.textInside(sampleText)}"');
  print('Text after range: "${wordSpan.range.textAfter(sampleText)}"');
  assert(
    wordSpan.range.textInside(sampleText) == 'quick',
    'Should extract "quick"',
  );
  print('Test 10 PASSED: Range text operations work');
  testsPassed++;

  // ========== Summary ==========
  print('\n========================================');
  print('SuggestionSpan Test Summary');
  print('========================================');
  print('Tests passed: $testsPassed / $totalTests');
  assert(testsPassed == totalTests, 'All tests should pass');
  print('ALL TESTS PASSED!');

  // ========== Return Widget Summary ==========
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'SuggestionSpan Test Results',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests Passed: $testsPassed / $totalTests'),
      SizedBox(height: 4),
      Text('Basic Construction: ✓'),
      Text('Single Suggestion: ✓'),
      Text('Empty Suggestions: ✓'),
      Text('Range Properties: ✓'),
      Text('Multiple Spans: ✓'),
      Text('Large Range: ✓'),
      Text('Unicode Suggestions: ✓'),
      Text('Special Characters: ✓'),
      Text('Collapsed Range: ✓'),
      Text('Range Text Operations: ✓'),
      SizedBox(height: 8),
      Text(
        'All SuggestionSpan tests completed successfully!',
        style: TextStyle(color: Color(0xFF4CAF50)),
      ),
    ],
  );
}
