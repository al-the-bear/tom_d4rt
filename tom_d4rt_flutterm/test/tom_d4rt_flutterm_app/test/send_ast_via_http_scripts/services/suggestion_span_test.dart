// D4rt test script: Tests SuggestionSpan from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SuggestionSpan test executing');
  print('=' * 50);

  // Create SuggestionSpan
  final span = SuggestionSpan(TextRange(start: 0, end: 4), [
    'their',
    'there',
    'they\'re',
  ]);
  print('\nSuggestionSpan created:');
  print('runtimeType: ${span.runtimeType}');

  // SuggestionSpan properties
  print('\nSuggestionSpan properties:');
  print('range: ${span.range}');
  print('suggestions: ${span.suggestions}');

  // Multiple misspellings
  print('\nMultiple SuggestionSpans:');
  final spans = [
    SuggestionSpan(TextRange(start: 0, end: 4), ['This', 'Thus']),
    SuggestionSpan(TextRange(start: 8, end: 12), ['test', 'text']),
    SuggestionSpan(TextRange(start: 16, end: 23), ['example', 'examine']),
  ];
  for (final s in spans) {
    print('Range ${s.range}: ${s.suggestions.join(", ")}');
  }

  // Common misspelling examples
  print('\nCommon misspelling examples:');
  final common = SuggestionSpan(TextRange(start: 0, end: 8), [
    'separate',
    'desperate',
  ]);
  print('"seperate" -> ${common.suggestions}');

  // Empty suggestions
  print('\nEmpty suggestions (no corrections):');
  final noSuggestions = SuggestionSpan(
    TextRange(start: 0, end: 10),
    [], // Word not in dictionary, no suggestions
  );
  print('suggestions.isEmpty: ${noSuggestions.suggestions.isEmpty}');

  // Usage with SpellCheckService
  print('\nUsage with SpellCheckService:');
  print('final results = await service.fetchSpellCheckSuggestions(');
  print('  Locale("en", "US"),');
  print('  "Ths is a tset",');
  print(');');
  print('// Returns List<SuggestionSpan>');

  // Applying corrections
  print('\nApplying corrections:');
  print('1. Get SuggestionSpan from spell check');
  print('2. Show suggestions to user');
  print('3. Replace range with selected suggestion');

  // Type hierarchy
  print('\nType hierarchy:');
  print('SuggestionSpan (immutable class)');
  print('  - Used by SpellCheckService');
  print('  - Used by SpellCheckConfiguration');

  // Explain purpose
  print('\nSuggestionSpan purpose:');
  print('- Represents a misspelled word');
  print('- range: Where misspelling is in text');
  print('- suggestions: Possible corrections');
  print('- Returned by SpellCheckService');
  print('- Enables spell check UI');

  print('\n' + '=' * 50);
  print('SuggestionSpan test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SuggestionSpan Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${span.runtimeType}'),
      Text('range: ${span.range}'),
      Text('suggestions: ${span.suggestions.length} items'),
      Text('Purpose: Spell check results'),
    ],
  );
}
