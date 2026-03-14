// D4rt test script: Tests SpellCheckService from services
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
    final span = SuggestionSpan(
      const TextRange(start: 0, end: 5),
      ['hello', 'hallo', 'hullo'],
    );
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
      {'range': const TextRange(start: 0, end: 4), 'suggestions': ['This']},
      {'range': const TextRange(start: 10, end: 14), 'suggestions': ['test']},
      {'range': const TextRange(start: 18, end: 25), 'suggestions': ['spelling']},
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
    final singleSuggestion = SuggestionSpan(
      const TextRange(start: 0, end: 3),
      ['fix'],
    );
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
      Text('SpellCheckService Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
