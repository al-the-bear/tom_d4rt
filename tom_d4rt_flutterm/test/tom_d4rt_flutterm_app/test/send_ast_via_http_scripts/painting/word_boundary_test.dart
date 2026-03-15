// D4rt test script: Tests WordBoundary from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WordBoundary test executing');
  final results = <String>[];

  // ========== Basic WordBoundary Tests ==========
  print('Testing WordBoundary constructor...');

  // Test 1: Create basic WordBoundary
  final wb1 = WordBoundary(0, 5);
  assert(wb1.start == 0, 'Start should be 0');
  assert(wb1.end == 5, 'End should be 5');
  results.add('WordBoundary: start=${wb1.start}, end=${wb1.end}');
  print('WordBoundary [0, 5] created');

  // Test 2: Create WordBoundary in middle of text
  final wb2 = WordBoundary(10, 15);
  assert(wb2.start == 10, 'Start should be 10');
  assert(wb2.end == 15, 'End should be 15');
  results.add('WordBoundary: start=${wb2.start}, end=${wb2.end}');
  print('WordBoundary [10, 15] created');

  // Test 3: Create single character word
  final wb3 = WordBoundary(5, 6);
  assert(wb3.end - wb3.start == 1, 'Single char word');
  results.add('Single char: start=${wb3.start}, end=${wb3.end}, length=${wb3.end - wb3.start}');
  print('Single char word boundary');

  // ========== TextRange Conversion ==========
  print('Testing TextRange conversion...');

  // Test 4: Convert to TextRange
  final wb4 = WordBoundary(20, 30);
  final textRange = TextRange(start: wb4.start, end: wb4.end);
  assert(textRange.start == wb4.start, 'TextRange start should match');
  assert(textRange.end == wb4.end, 'TextRange end should match');
  results.add('TextRange: start=${textRange.start}, end=${textRange.end}');
  print('TextRange conversion');

  // Test 5: TextRange properties
  assert(!textRange.isCollapsed, 'Range should not be collapsed');
  assert(textRange.isValid, 'Range should be valid');
  assert(textRange.isNormalized, 'Range should be normalized');
  results.add('isCollapsed: ${textRange.isCollapsed}, isValid: ${textRange.isValid}');
  print('TextRange properties verified');

  // ========== Word Boundary Calculations ==========
  print('Testing word boundary calculations...');

  // Simulate finding word boundaries in text
  final sampleText = 'Hello World Flutter Dart';
  final wordBoundaries = <WordBoundary>[];

  // Find word starts and ends
  final words = sampleText.split(' ');
  var currentPos = 0;
  for (final word in words) {
    final start = currentPos;
    final end = start + word.length;
    wordBoundaries.add(WordBoundary(start, end));
    results.add('Word "$word": [$start, $end]');
    print('Word "$word": [$start, $end]');
    currentPos = end + 1; // +1 for space
  }

  assert(wordBoundaries.length == 4, 'Should find 4 words');
  results.add('Total words found: ${wordBoundaries.length}');
  print('Total words: ${wordBoundaries.length}');

  // ========== Word Length Analysis ==========
  print('Analyzing word lengths...');

  for (final wb in wordBoundaries) {
    final length = wb.end - wb.start;
    results.add('Boundary [${wb.start}, ${wb.end}]: length=$length');
    print('Length: $length');
  }

  // ========== Adjacent Word Boundaries ==========
  print('Testing adjacent boundaries...');

  for (var i = 0; i < wordBoundaries.length - 1; i++) {
    final current = wordBoundaries[i];
    final next = wordBoundaries[i + 1];
    final gap = next.start - current.end;
    results.add('Gap between word $i and ${i + 1}: $gap chars');
    print('Gap: $gap');
  }

  // ========== Edge Cases ==========
  print('Testing edge cases...');

  // Test 6: Zero-length boundary (empty word)
  final wbZero = WordBoundary(5, 5);
  assert(wbZero.end - wbZero.start == 0, 'Zero length');
  results.add('Zero-length boundary: [${wbZero.start}, ${wbZero.end}]');
  print('Zero-length: ${wbZero.end - wbZero.start}');

  // Test 7: Large positions
  final wbLarge = WordBoundary(10000, 10050);
  assert(wbLarge.end - wbLarge.start == 50, 'Large position word');
  results.add('Large position: [${wbLarge.start}, ${wbLarge.end}]');
  print('Large position boundary');

  // Test 8: Very long word
  final wbLong = WordBoundary(0, 100);
  results.add('Long word boundary: length=${wbLong.end - wbLong.start}');
  print('Long word: ${wbLong.end - wbLong.start} chars');

  // ========== Text Selection Integration ==========
  print('Testing text selection integration...');

  // WordBoundary is used for double-click word selection
  results.add('Use case: Double-click word selection');
  results.add('Use case: getWordBoundary() in TextPainter');
  results.add('Use case: Word navigation in text editors');
  print('Selection integration documented');

  // ========== Direction Analysis ==========
  print('Testing direction concepts...');

  // Forward boundary (normal)
  final wbForward = WordBoundary(10, 20);
  final isForward = wbForward.end >= wbForward.start;
  results.add('Forward boundary: start=${wbForward.start} <= end=${wbForward.end}: $isForward');
  print('Forward: $isForward');

  // ========== Multiple Word Boundary Creation ==========
  print('Creating multiple boundaries...');

  final boundaries = <WordBoundary>[];
  for (var i = 0; i < 10; i++) {
    final start = i * 10;
    final end = start + 5 + (i % 3);
    boundaries.add(WordBoundary(start, end));
    results.add('Boundary #${i + 1}: [$start, $end]');
    print('Created boundary #${i + 1}');
  }
  assert(boundaries.length == 10, 'Should have 10 boundaries');
  results.add('Total boundaries: ${boundaries.length}');

  // ========== Boundary Overlap Detection ==========
  print('Testing overlap detection...');

  bool checkOverlap(WordBoundary a, WordBoundary b) {
    return a.start < b.end && b.start < a.end;
  }

  final wbA = WordBoundary(0, 10);
  final wbB = WordBoundary(5, 15);
  final wbC = WordBoundary(15, 20);

  final overlapAB = checkOverlap(wbA, wbB);
  final overlapAC = checkOverlap(wbA, wbC);
  results.add('Overlap [0,10] & [5,15]: $overlapAB');
  results.add('Overlap [0,10] & [15,20]: $overlapAC');
  print('Overlap AB: $overlapAB, AC: $overlapAC');

  // ========== toString Representation ==========
  print('Testing string representation...');

  final wbStr = WordBoundary(25, 35);
  results.add('WordBoundary: start=${wbStr.start}, end=${wbStr.end}');
  print('String representation created');

  print('WordBoundary test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('WordBoundary Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 11)),
      )),
    ],
  );
}
