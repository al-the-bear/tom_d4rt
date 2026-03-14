// D4rt test script: Tests SuggestionSpan from services
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
    print('Span $i: range=${spans[i].range}, suggestions=${spans[i].suggestions}');
  }
  assert(spans.length == 3, 'Should have 3 spans');
  print('Test 5 PASSED: Multiple spans work correctly');
  testsPassed++;

  // ========== Test 6: Large Range ==========
  print('\n--- Test 6: Large Range ---');
  totalTests++;

  final largeRange = TextRange(start: 0, end: 1000);
  final largeSpan = SuggestionSpan(largeRange, ['replacement']);

  print('Large range span: start=${largeSpan.range.start}, end=${largeSpan.range.end}');
  assert(largeSpan.range.end - largeSpan.range.start == 1000, 'Range length should be 1000');
  print('Test 6 PASSED: Large range works');
  testsPassed++;

  // ========== Test 7: Unicode Suggestions ==========
  print('\n--- Test 7: Unicode Suggestions ---');
  totalTests++;

  final unicodeRange = TextRange(start: 0, end: 4);
  final unicodeSuggestions = ['カフェ', '咖啡', 'кофе', 'café'];
  final unicodeSpan = SuggestionSpan(unicodeRange, unicodeSuggestions);

  print('Unicode suggestions: ${unicodeSpan.suggestions}');
  assert(unicodeSpan.suggestions.length == 4, 'Should have 4 unicode suggestions');
  print('Test 7 PASSED: Unicode suggestions work');
  testsPassed++;

  // ========== Test 8: Suggestion Span with Special Characters ==========
  print('\n--- Test 8: Special Characters in Suggestions ---');
  totalTests++;

  final specialRange = TextRange(start: 10, end: 20);
  final specialSuggestions = ["don't", "won't", "can't", "it's"];
  final specialSpan = SuggestionSpan(specialRange, specialSuggestions);

  print('Special character suggestions: ${specialSpan.suggestions}');
  assert(specialSpan.suggestions.contains("don't"), 'Should contain apostrophe word');
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
  final wordRange = TextRange(start: 4, end: 9);  // "quick"
  final wordSpan = SuggestionSpan(wordRange, ['fast', 'rapid', 'swift']);

  print('Sample text: "$sampleText"');
  print('Word range: ${wordSpan.range}');
  print('Text before range: "${wordSpan.range.textBefore(sampleText)}"');
  print('Text inside range: "${wordSpan.range.textInside(sampleText)}"');
  print('Text after range: "${wordSpan.range.textAfter(sampleText)}"');
  assert(wordSpan.range.textInside(sampleText) == 'quick', 'Should extract "quick"');
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
      Text('SuggestionSpan Test Results',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
      Text('All SuggestionSpan tests completed successfully!',
          style: TextStyle(color: Color(0xFF4CAF50))),
    ],
  );
}
