// D4rt test script: Tests SpellCheckService from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SpellCheckService test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Test SuggestionSpan creation
  print('\n--- Test 1: Test SuggestionSpan creation ---');
  try {
    final span = SuggestionSpan(const TextRange(start: 0, end: 5), [
      'hello',
      'hallo',
      'hullo',
    ]);
    assert(span is SuggestionSpan);
    print('Created SuggestionSpan successfully');
    print('Range: ${span.range}');
    print('Suggestions: ${span.suggestions}');
    results.add('Test 1 PASSED: SuggestionSpan creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test SpellCheckResults creation
  print('\n--- Test 2: Test SpellCheckResults creation ---');
  try {
    final spans = [
      SuggestionSpan(const TextRange(start: 0, end: 4), ['test', 'text']),
      SuggestionSpan(const TextRange(start: 10, end: 15), ['spell', 'spill']),
    ];
    final checkResults = SpellCheckResults('tset some speel', spans);
    print('SpellCheckResults created');
    print('Text: "${checkResults.spellCheckedText}"');
    print('Suggestions count: ${checkResults.suggestionSpans.length}');
    results.add('Test 2 PASSED: SpellCheckResults creation');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test TextRange for spell check
  print('\n--- Test 3: Test TextRange for spell check ---');
  try {
    final ranges = [
      const TextRange(start: 0, end: 5),
      const TextRange(start: 6, end: 10),
      const TextRange(start: 11, end: 20),
    ];
    for (final range in ranges) {
      print('Range: start=${range.start}, end=${range.end}');
      print('  isValid: ${range.isValid}');
      print('  isCollapsed: ${range.isCollapsed}');
      print('  isNormalized: ${range.isNormalized}');
    }
    results.add('Test 3 PASSED: TextRange handling');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Simulate spell check workflow
  print('\n--- Test 4: Simulate spell check workflow ---');
  try {
    final text = 'Thsi is a tset of speling';
    print('Original text: "$text"');
    final misspellings = [
      {
        'range': const TextRange(start: 0, end: 4),
        'suggestions': ['This'],
      },
      {
        'range': const TextRange(start: 10, end: 14),
        'suggestions': ['test'],
      },
      {
        'range': const TextRange(start: 18, end: 25),
        'suggestions': ['spelling'],
      },
    ];
    print('Detected ${misspellings.length} misspellings:');
    for (final m in misspellings) {
      final range = m['range'] as TextRange;
      final word = text.substring(range.start, range.end);
      print('  "$word" at ${range.start}-${range.end}');
    }
    results.add('Test 4 PASSED: Spell check workflow');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test multiple suggestions per word
  print('\n--- Test 5: Test multiple suggestions per word ---');
  try {
    final misspelledWords = {
      'teh': ['the', 'tea', 'ten'],
      'recieve': ['receive', 'relieve', 'retrieve'],
      'occured': ['occurred', 'occur', 'occurs'],
    };
    for (final entry in misspelledWords.entries) {
      final span = SuggestionSpan(
        const TextRange(start: 0, end: 10),
        entry.value,
      );
      print('Word "${entry.key}":');
      print('  Suggestions: ${span.suggestions}');
      assert(span.suggestions.length >= 2);
    }
    results.add('Test 5 PASSED: Multiple suggestions');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test empty and edge cases
  print('\n--- Test 6: Test empty and edge cases ---');
  try {
    final emptySpan = SuggestionSpan(TextRange.empty, []);
    print('Empty span range: ${emptySpan.range}');
    print('Empty span suggestions: ${emptySpan.suggestions}');
    final singleSuggestion = SuggestionSpan(const TextRange(start: 0, end: 3), [
      'fix',
    ]);
    print('Single suggestion: ${singleSuggestion.suggestions}');
    results.add('Test 6 PASSED: Edge cases');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test SpellCheckResults with no errors
  print('\n--- Test 7: Test SpellCheckResults with no errors ---');
  try {
    final correctText = 'This is correctly spelled';
    final noErrors = SpellCheckResults(correctText, []);
    print('Correct text: "${noErrors.spellCheckedText}"');
    print('Errors found: ${noErrors.suggestionSpans.length}');
    assert(noErrors.suggestionSpans.isEmpty);
    results.add('Test 7 PASSED: No errors case');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Test language/locale awareness concept
  print('\n--- Test 8: Test language/locale awareness ---');
  try {
    final locales = ['en_US', 'en_GB', 'de_DE', 'fr_FR', 'es_ES'];
    print('SpellCheckService supports multiple locales:');
    for (final locale in locales) {
      print('  - $locale');
    }
    print('Locale affects dictionary and suggestions');
    results.add('Test 8 PASSED: Locale awareness');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('SpellCheckService test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'SpellCheckService Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        'Passed: $testsPassed, Failed: $testsFailed',
        style: TextStyle(
          color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000),
        ),
      ),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
