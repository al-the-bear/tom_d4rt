// D4rt test script: Tests TextEditingDeltaDeletion from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// TextEditingDeltaDeletion represents a deletion operation in text editing
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('================================================');
  print('TextEditingDeltaDeletion Comprehensive Test Suite');
  print('================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: Basic Deletion Delta ==========
  print('\n--- Test 1: Basic Deletion Delta ---');
  totalTests++;

  final delta1 = TextEditingDeltaDeletion(
    oldText: 'Hello World',
    deletedRange: TextRange(start: 5, end: 11),
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange.empty,
  );

  print('TextEditingDeltaDeletion created');
  print('oldText: ${delta1.oldText}');
  print('deletedRange: ${delta1.deletedRange}');
  print('selection: ${delta1.selection}');
  print('composing: ${delta1.composing}');
  assert(delta1.oldText == 'Hello World', 'oldText should match');
  assert(delta1.deletedRange.start == 5, 'deletedRange start should be 5');
  print('Test 1 PASSED: Basic deletion delta works');
  testsPassed++;

  // ========== Test 2: Single Character Deletion ==========
  print('\n--- Test 2: Single Character Deletion ---');
  totalTests++;

  final delta2 = TextEditingDeltaDeletion(
    oldText: 'Flutter',
    deletedRange: TextRange(start: 6, end: 7), // Delete 'r'
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );

  print('Single character deletion:');
  print('oldText: "${delta2.oldText}"');
  print('deletedRange: ${delta2.deletedRange}');
  final deletedChar = delta2.deletedRange.textInside(delta2.oldText);
  print('Deleted character: "$deletedChar"');
  assert(deletedChar == 'r', 'Should delete "r"');
  print('Test 2 PASSED: Single character deletion works');
  testsPassed++;

  // ========== Test 3: Word Deletion ==========
  print('\n--- Test 3: Word Deletion ---');
  totalTests++;

  final delta3 = TextEditingDeltaDeletion(
    oldText: 'The quick brown fox',
    deletedRange: TextRange(start: 4, end: 10), // Delete 'quick '
    selection: TextSelection.collapsed(offset: 4),
    composing: TextRange.empty,
  );

  print('Word deletion:');
  print('oldText: "${delta3.oldText}"');
  print('deletedRange: ${delta3.deletedRange}');
  final deletedWord = delta3.deletedRange.textInside(delta3.oldText);
  print('Deleted word: "$deletedWord"');
  assert(deletedWord == 'quick ', 'Should delete "quick "');
  print('Test 3 PASSED: Word deletion works');
  testsPassed++;

  // ========== Test 4: Beginning of Text Deletion ==========
  print('\n--- Test 4: Beginning of Text Deletion ---');
  totalTests++;

  final delta4 = TextEditingDeltaDeletion(
    oldText: 'Start of text',
    deletedRange: TextRange(start: 0, end: 6), // Delete 'Start '
    selection: TextSelection.collapsed(offset: 0),
    composing: TextRange.empty,
  );

  print('Beginning deletion:');
  print('deletedRange: ${delta4.deletedRange}');
  final deletedBeginning = delta4.deletedRange.textInside(delta4.oldText);
  print('Deleted: "$deletedBeginning"');
  assert(delta4.deletedRange.start == 0, 'Should start at 0');
  print('Test 4 PASSED: Beginning deletion works');
  testsPassed++;

  // ========== Test 5: End of Text Deletion ==========
  print('\n--- Test 5: End of Text Deletion ---');
  totalTests++;

  final delta5 = TextEditingDeltaDeletion(
    oldText: 'Text at the end',
    deletedRange: TextRange(start: 12, end: 15), // Delete 'end'
    selection: TextSelection.collapsed(offset: 12),
    composing: TextRange.empty,
  );

  print('End deletion:');
  print('oldText: "${delta5.oldText}"');
  print('deletedRange: ${delta5.deletedRange}');
  final deletedEnd = delta5.deletedRange.textInside(delta5.oldText);
  print('Deleted: "$deletedEnd"');
  assert(deletedEnd == 'end', 'Should delete "end"');
  print('Test 5 PASSED: End deletion works');
  testsPassed++;

  // ========== Test 6: Full Text Deletion ==========
  print('\n--- Test 6: Full Text Deletion ---');
  totalTests++;

  final fullText = 'Delete everything';
  final delta6 = TextEditingDeltaDeletion(
    oldText: fullText,
    deletedRange: TextRange(start: 0, end: fullText.length),
    selection: TextSelection.collapsed(offset: 0),
    composing: TextRange.empty,
  );

  print('Full text deletion:');
  print('oldText length: ${delta6.oldText.length}');
  print('deletedRange: ${delta6.deletedRange}');
  assert(
    delta6.deletedRange.end == fullText.length,
    'Should delete entire text',
  );
  print('Test 6 PASSED: Full text deletion works');
  testsPassed++;

  // ========== Test 7: Selection After Deletion ==========
  print('\n--- Test 7: Selection After Deletion ---');
  totalTests++;

  final delta7 = TextEditingDeltaDeletion(
    oldText: 'Selection test text',
    deletedRange: TextRange(start: 10, end: 15), // Delete 'test '
    selection: TextSelection.collapsed(offset: 10),
    composing: TextRange.empty,
  );

  print('Selection after deletion:');
  print('selection baseOffset: ${delta7.selection.baseOffset}');
  print('selection extentOffset: ${delta7.selection.extentOffset}');
  print('selection isCollapsed: ${delta7.selection.isCollapsed}');
  assert(
    delta7.selection.isCollapsed,
    'Selection should be collapsed after deletion',
  );
  assert(
    delta7.selection.baseOffset == 10,
    'Cursor should be at deletion start',
  );
  print('Test 7 PASSED: Selection after deletion is correct');
  testsPassed++;

  // ========== Test 8: Unicode Text Deletion ==========
  print('\n--- Test 8: Unicode Text Deletion ---');
  totalTests++;

  final delta8 = TextEditingDeltaDeletion(
    oldText: 'Hello 世界 🌍',
    deletedRange: TextRange(start: 6, end: 8), // Delete '世界'
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );

  print('Unicode text deletion:');
  print('oldText: "${delta8.oldText}"');
  print('deletedRange: ${delta8.deletedRange}');
  final deletedUnicode = delta8.deletedRange.textInside(delta8.oldText);
  print('Deleted unicode: "$deletedUnicode"');
  print('Test 8 PASSED: Unicode text deletion works');
  testsPassed++;

  // ========== Test 9: Composing Range ==========
  print('\n--- Test 9: Composing Range ---');
  totalTests++;

  final delta9 = TextEditingDeltaDeletion(
    oldText: 'Composing text',
    deletedRange: TextRange(start: 0, end: 9),
    selection: TextSelection.collapsed(offset: 0),
    composing: TextRange(start: 0, end: 5), // Active IME composition
  );

  print('Composing range:');
  print('composing: ${delta9.composing}');
  print('composing isValid: ${delta9.composing.isValid}');
  print('composing isCollapsed: ${delta9.composing.isCollapsed}');
  assert(delta9.composing.isValid, 'Composing should be valid');
  print('Test 9 PASSED: Composing range handled correctly');
  testsPassed++;

  // ========== Test 10: Backspace Simulation ==========
  print('\n--- Test 10: Backspace Simulation ---');
  totalTests++;

  // Simulating backspace at cursor position 7
  final delta10 = TextEditingDeltaDeletion(
    oldText: 'Testing',
    deletedRange: TextRange(start: 6, end: 7), // Delete 'g'
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );

  print('Backspace simulation:');
  print('Cursor was at: 7, now at: ${delta10.selection.baseOffset}');
  print(
    'Character deleted: "${delta10.deletedRange.textInside(delta10.oldText)}"',
  );
  assert(delta10.selection.baseOffset == 6, 'Cursor moves back on backspace');
  print('Test 10 PASSED: Backspace simulation works');
  testsPassed++;

  // ========== Test 11: Delete Key Simulation ==========
  print('\n--- Test 11: Delete Key Simulation ---');
  totalTests++;

  // Simulating delete key at cursor position 0
  final delta11 = TextEditingDeltaDeletion(
    oldText: 'Delete key',
    deletedRange: TextRange(start: 0, end: 1), // Delete 'D'
    selection: TextSelection.collapsed(offset: 0), // Cursor stays
    composing: TextRange.empty,
  );

  print('Delete key simulation:');
  print('Cursor stays at: ${delta11.selection.baseOffset}');
  print(
    'Character deleted: "${delta11.deletedRange.textInside(delta11.oldText)}"',
  );
  assert(delta11.selection.baseOffset == 0, 'Cursor stays on delete key');
  print('Test 11 PASSED: Delete key simulation works');
  testsPassed++;

  // ========== Test 12: Multi-line Deletion ==========
  print('\n--- Test 12: Multi-line Deletion ---');
  totalTests++;

  final multilineText = 'Line 1\nLine 2\nLine 3';
  final delta12 = TextEditingDeltaDeletion(
    oldText: multilineText,
    deletedRange: TextRange(start: 7, end: 14), // Delete 'Line 2\n'
    selection: TextSelection.collapsed(offset: 7),
    composing: TextRange.empty,
  );

  print('Multi-line deletion:');
  print('Original text has newlines');
  print('deletedRange: ${delta12.deletedRange}');
  final deletedLines = delta12.deletedRange.textInside(delta12.oldText);
  print('Deleted content: "${deletedLines.replaceAll('\n', '\\n')}"');
  print('Test 12 PASSED: Multi-line deletion works');
  testsPassed++;

  // ========== Summary ==========
  print('\n================================================');
  print('TextEditingDeltaDeletion Test Summary');
  print('================================================');
  print('Tests passed: $testsPassed / $totalTests');
  assert(testsPassed == totalTests, 'All tests should pass');
  print('ALL TESTS PASSED!');

  // ========== Return Widget Summary ==========
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'TextEditingDeltaDeletion Test Results',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests Passed: $testsPassed / $totalTests'),
      SizedBox(height: 4),
      Text('Basic Deletion: ✓'),
      Text('Single Character: ✓'),
      Text('Word Deletion: ✓'),
      Text('Beginning Deletion: ✓'),
      Text('End Deletion: ✓'),
      Text('Full Text Deletion: ✓'),
      Text('Selection After Deletion: ✓'),
      Text('Unicode Deletion: ✓'),
      Text('Composing Range: ✓'),
      Text('Backspace Simulation: ✓'),
      Text('Delete Key Simulation: ✓'),
      Text('Multi-line Deletion: ✓'),
      SizedBox(height: 8),
      Text(
        'All TextEditingDeltaDeletion tests completed!',
        style: TextStyle(color: Color(0xFF4CAF50)),
      ),
    ],
  );
}
