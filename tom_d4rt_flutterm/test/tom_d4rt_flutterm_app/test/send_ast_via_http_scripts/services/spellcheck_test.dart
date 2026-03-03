// D4rt test script: Tests SpellCheckResults, SuggestionSpan concepts from services
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services spellcheck test executing');

  // ========== SUGGESTIONSPAN ==========
  print('--- SuggestionSpan Tests ---');

  final span1 = SuggestionSpan(TextRange(start: 0, end: 5), [
    'hello',
    'hallo',
    'hullo',
  ]);
  print('SuggestionSpan created');
  print('  range: ${span1.range}');
  print('  suggestions: ${span1.suggestions}');
  print('  runtimeType: ${span1.runtimeType}');

  final span2 = SuggestionSpan(TextRange(start: 10, end: 15), [
    'world',
    'would',
  ]);
  print('SuggestionSpan 2:');
  print('  range: ${span2.range}');
  print('  suggestions: ${span2.suggestions}');

  // Empty suggestions
  final emptySpan = SuggestionSpan(TextRange(start: 0, end: 3), []);
  print('Empty SuggestionSpan: suggestions=${emptySpan.suggestions}');

  // Single suggestion
  final singleSpan = SuggestionSpan(TextRange(start: 5, end: 10), ['correct']);
  print('Single SuggestionSpan: suggestions=${singleSpan.suggestions}');

  // ========== SPELLCHECKRESULTS ==========
  print('--- SpellCheckResults Tests ---');

  final results = SpellCheckResults('helo wrold', [span1, span2]);
  print('SpellCheckResults created');
  print('  spellCheckedText: "${results.spellCheckedText}"');
  print('  suggestionSpans count: ${results.suggestionSpans.length}');
  print('  runtimeType: ${results.runtimeType}');

  for (int i = 0; i < results.suggestionSpans.length; i++) {
    final s = results.suggestionSpans[i];
    print('  span[$i]: range=${s.range}, suggestions=${s.suggestions}');
  }

  // Empty results
  final emptyResults = SpellCheckResults('correct text', []);
  print('Empty SpellCheckResults:');
  print('  spellCheckedText: "${emptyResults.spellCheckedText}"');
  print('  suggestionSpans count: ${emptyResults.suggestionSpans.length}');

  // ========== SPELLCHECKSERVICE ==========
  print('--- SpellCheckService Notes ---');

  print('SpellCheckService is abstract');
  print('DefaultSpellCheckService is the platform implementation');
  print('  Available via SpellCheckConfiguration');
  print('  Used by EditableText/TextField widgets');

  // ========== SPELLCHECKCONFIGURATION ==========
  print('--- SpellCheckConfiguration Notes ---');

  print('SpellCheckConfiguration properties:');
  print('  spellCheckService - the service implementation');
  print('  misspelledTextStyle - TextStyle for misspelled words');
  print('  spellCheckSuggestionsToolbarBuilder - toolbar builder');
  print('SpellCheckConfiguration.disabled() - disables spell check');

  // ========== RETURN WIDGET ==========
  print('Services spellcheck test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Spellcheck Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• SuggestionSpan - spell check suggestion'),
          Text('• SpellCheckResults - spell check result set'),
          SizedBox(height: 16.0),

          Text(
            'Bridge Availability:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFCE4EC),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SuggestionSpan: available'),
                Text('SpellCheckResults: available'),
                Text('SpellCheckService: abstract (not constructable)'),
                Text('SpellCheckConfiguration: framework-provided'),
                SizedBox(height: 8.0),
                Text('Sample: "${results.spellCheckedText}"'),
                Text('  ${results.suggestionSpans.length} suggestion spans'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
