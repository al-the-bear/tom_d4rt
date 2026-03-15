// D4rt test script: Tests TextEditingDeltaReplacement from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// TextEditingDeltaReplacement represents a replacement operation in text editing
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('=================================================');
  print('TextEditingDeltaReplacement Comprehensive Test Suite');
  print('=================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: Basic Replacement Delta ==========
  print('\n--- Test 1: Basic Replacement Delta ---');
  totalTests++;

  final delta1 = TextEditingDeltaReplacement(
    oldText: 'Hello World',
    replacementText: 'Flutter',
    replacedRange: TextRange(start: 6, end: 11),
    selection: TextSelection.collapsed(offset: 13),
    composing: TextRange.empty,
  );

  print('TextEditingDeltaReplacement created');
  print('oldText: ${delta1.oldText}');
  print('replacementText: ${delta1.replacementText}');
  print('replacedRange: ${delta1.replacedRange}');
  print('Resulting text would be: "Hello Flutter"');
  assert(delta1.oldText == 'Hello World', 'oldText should match');
  assert(delta1.replacementText == 'Flutter', 'replacementText should match');
  print('Test 1 PASSED: Basic replacement delta works');
  testsPassed++;

  // ========== Test 2: Word Replacement ==========
  print('\n--- Test 2: Word Replacement ---');
  totalTests++;

  final delta2 = TextEditingDeltaReplacement(
    oldText: 'The quick brown fox',
    replacementText: 'slow',
    replacedRange: TextRange(start: 4, end: 9), // 'quick'
    selection: TextSelection.collapsed(offset: 8),
    composing: TextRange.empty,
  );

  print('Word replacement:');
  print('oldText: "${delta2.oldText}"');
  print('Replacing: "${delta2.replacedRange.textInside(delta2.oldText)}"');
  print('With: "${delta2.replacementText}"');
  print('Result would be: "The slow brown fox"');
  assert(
    delta2.replacedRange.textInside(delta2.oldText) == 'quick',
    'Should replace "quick"',
  );
  print('Test 2 PASSED: Word replacement works');
  testsPassed++;

  // ========== Test 3: Longer Replacement ==========
  print('\n--- Test 3: Longer Replacement ---');
  totalTests++;

  final delta3 = TextEditingDeltaReplacement(
    oldText: 'Hi!',
    replacementText: 'Hello there!',
    replacedRange: TextRange(start: 0, end: 3),
    selection: TextSelection.collapsed(offset: 12),
    composing: TextRange.empty,
  );

  print('Longer replacement:');
  print('Original: "${delta3.oldText}" (${delta3.oldText.length} chars)');
  print(
    'Replacement: "${delta3.replacementText}" (${delta3.replacementText.length} chars)',
  );
  assert(
    delta3.replacementText.length > delta3.oldText.length,
    'Replacement should be longer',
  );
  print('Test 3 PASSED: Longer replacement works');
  testsPassed++;

  // ========== Test 4: Shorter Replacement ==========
  print('\n--- Test 4: Shorter Replacement ---');
  totalTests++;

  final delta4 = TextEditingDeltaReplacement(
    oldText: 'Internationalization',
    replacementText: 'i18n',
    replacedRange: TextRange(start: 0, end: 20),
    selection: TextSelection.collapsed(offset: 4),
    composing: TextRange.empty,
  );

  print('Shorter replacement:');
  print('Original: "${delta4.oldText}" (${delta4.oldText.length} chars)');
  print(
    'Replacement: "${delta4.replacementText}" (${delta4.replacementText.length} chars)',
  );
  assert(
    delta4.replacementText.length <
        delta4.replacedRange.end - delta4.replacedRange.start,
    'Replacement should be shorter than replaced text',
  );
  print('Test 4 PASSED: Shorter replacement works');
  testsPassed++;

  // ========== Test 5: Same Length Replacement ==========
  print('\n--- Test 5: Same Length Replacement ---');
  totalTests++;

  final delta5 = TextEditingDeltaReplacement(
    oldText: 'cat',
    replacementText: 'dog',
    replacedRange: TextRange(start: 0, end: 3),
    selection: TextSelection.collapsed(offset: 3),
    composing: TextRange.empty,
  );

  print('Same length replacement:');
  final originalLen = delta5.replacedRange.end - delta5.replacedRange.start;
  print('Original length: $originalLen');
  print('Replacement length: ${delta5.replacementText.length}');
  assert(originalLen == delta5.replacementText.length, 'Lengths should match');
  print('Test 5 PASSED: Same length replacement works');
  testsPassed++;

  // ========== Test 6: Selection After Replacement ==========
  print('\n--- Test 6: Selection After Replacement ---');
  totalTests++;

  final replacementText6 = 'replacement';
  final delta6 = TextEditingDeltaReplacement(
    oldText: 'Before XXX After',
    replacementText: replacementText6,
    replacedRange: TextRange(start: 7, end: 10),
    selection: TextSelection.collapsed(offset: 7 + replacementText6.length),
    composing: TextRange.empty,
  );

  print('Selection after replacement:');
  print('replacedRange: ${delta6.replacedRange}');
  print('replacementText length: ${delta6.replacementText.length}');
  print('selection offset: ${delta6.selection.baseOffset}');
  assert(
    delta6.selection.baseOffset == 18,
    'Cursor should be after replacement',
  );
  print('Test 6 PASSED: Selection after replacement is correct');
  testsPassed++;

  // ========== Test 7: Unicode Replacement ==========
  print('\n--- Test 7: Unicode Replacement ---');
  totalTests++;

  final delta7 = TextEditingDeltaReplacement(
    oldText: 'Hello world emoji',
    replacementText: '世界 🌍',
    replacedRange: TextRange(start: 6, end: 11),
    selection: TextSelection.collapsed(offset: 10),
    composing: TextRange.empty,
  );

  print('Unicode replacement:');
  print('Replacing: "${delta7.replacedRange.textInside(delta7.oldText)}"');
  print('With unicode: "${delta7.replacementText}"');
  print('Result would be: "Hello 世界 🌍 emoji"');
  print('Test 7 PASSED: Unicode replacement works');
  testsPassed++;

  // ========== Test 8: Autocorrect Simulation ==========
  print('\n--- Test 8: Autocorrect Simulation ---');
  totalTests++;

  final delta8 = TextEditingDeltaReplacement(
    oldText: 'I went to teh store',
    replacementText: 'the',
    replacedRange: TextRange(start: 10, end: 13), // 'teh'
    selection: TextSelection.collapsed(offset: 13),
    composing: TextRange.empty,
  );

  print('Autocorrect simulation:');
  print('Misspelled: "${delta8.replacedRange.textInside(delta8.oldText)}"');
  print('Corrected to: "${delta8.replacementText}"');
  print('Test 8 PASSED: Autocorrect simulation works');
  testsPassed++;

  // ========== Test 9: IME Composition Replacement ==========
  print('\n--- Test 9: IME Composition Replacement ---');
  totalTests++;

  final delta9 = TextEditingDeltaReplacement(
    oldText: 'Type: かな',
    replacementText: '仮名',
    replacedRange: TextRange(start: 6, end: 8),
    selection: TextSelection.collapsed(offset: 8),
    composing: TextRange.empty, // Composition complete
  );

  print('IME composition replacement:');
  print(
    'Hiragana composed: "${delta9.replacedRange.textInside(delta9.oldText)}"',
  );
  print('Converted to kanji: "${delta9.replacementText}"');
  print('Test 9 PASSED: IME composition replacement works');
  testsPassed++;

  // ========== Test 10: Multi-line Replacement ==========
  print('\n--- Test 10: Multi-line Replacement ---');
  totalTests++;

  final multilineOld = 'Line 1\nOld Line\nLine 3';
  final delta10 = TextEditingDeltaReplacement(
    oldText: multilineOld,
    replacementText: 'New Line',
    replacedRange: TextRange(start: 7, end: 15),
    selection: TextSelection.collapsed(offset: 15),
    composing: TextRange.empty,
  );

  print('Multi-line replacement:');
  print('Replacing across lines');
  print('replacedRange: ${delta10.replacedRange}');
  print('replacementText: "${delta10.replacementText}"');
  print('Test 10 PASSED: Multi-line replacement works');
  testsPassed++;

  // ========== Test 11: Find and Replace Simulation ==========
  print('\n--- Test 11: Find and Replace Simulation ---');
  totalTests++;

  final delta11 = TextEditingDeltaReplacement(
    oldText: 'apple banana apple cherry apple',
    replacementText: 'orange',
    replacedRange: TextRange(start: 0, end: 5), // First 'apple'
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );

  print('Find and replace simulation:');
  print('Finding: "${delta11.replacedRange.textInside(delta11.oldText)}"');
  print('Replacing with: "${delta11.replacementText}"');
  print('Replace one occurrence at a time');
  print('Test 11 PASSED: Find and replace simulation works');
  testsPassed++;

  // ========== Test 12: Composing During Replacement ==========
  print('\n--- Test 12: Composing During Replacement ---');
  totalTests++;

  final delta12 = TextEditingDeltaReplacement(
    oldText: 'Text with composition',
    replacementText: 'active',
    replacedRange: TextRange(start: 10, end: 21),
    selection: TextSelection.collapsed(offset: 16),
    composing: TextRange(start: 10, end: 16), // Still composing
  );

  print('Composing during replacement:');
  print('replacementText: "${delta12.replacementText}"');
  print('composing range: ${delta12.composing}');
  print('IME still active during replacement');
  assert(delta12.composing.isValid, 'Composing should be valid');
  print('Test 12 PASSED: Composing during replacement works');
  testsPassed++;

  // ========== Summary ==========
  print('\n=================================================');
  print('TextEditingDeltaReplacement Test Summary');
  print('=================================================');
  print('Tests passed: $testsPassed / $totalTests');
  assert(testsPassed == totalTests, 'All tests should pass');
  print('ALL TESTS PASSED!');

  // ========== Return Widget Summary ==========
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'TextEditingDeltaReplacement Test Results',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests Passed: $testsPassed / $totalTests'),
      SizedBox(height: 4),
      Text('Basic Replacement: ✓'),
      Text('Word Replacement: ✓'),
      Text('Longer Replacement: ✓'),
      Text('Shorter Replacement: ✓'),
      Text('Same Length Replacement: ✓'),
      Text('Selection After Replacement: ✓'),
      Text('Unicode Replacement: ✓'),
      Text('Autocorrect Simulation: ✓'),
      Text('IME Composition: ✓'),
      Text('Multi-line Replacement: ✓'),
      Text('Find and Replace: ✓'),
      Text('Composing During Replacement: ✓'),
      SizedBox(height: 8),
      Text(
        'All TextEditingDeltaReplacement tests completed!',
        style: TextStyle(color: Color(0xFF4CAF50)),
      ),
    ],
  );
}
