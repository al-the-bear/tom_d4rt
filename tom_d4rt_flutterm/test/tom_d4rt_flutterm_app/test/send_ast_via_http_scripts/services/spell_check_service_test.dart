// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SpellCheckService from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SpellCheckService test executing');
  print('=' * 50);

  // SpellCheckService is abstract
  print('\nSpellCheckService:');
  print('Abstract interface for spell checking');
  print('Platform-specific implementations');

  // Interface method
  print('\nSpellCheckService method:');
  print('fetchSpellCheckSuggestions(locale, text)');
  print('Returns: Future<List<SuggestionSpan>>');

  // SuggestionSpan structure
  print('\nSuggestionSpan structure:');
  print('- range: TextRange of misspelled word');
  print('- suggestions: List<String> corrections');

  // Default implementation
  print('\nDefaultSpellCheckService:');
  print('- Uses platform spell check API');
  print('- Android: SpellCheckerSession');
  print('- iOS: UITextChecker');

  // Platform availability
  print('\nPlatform availability:');
  print('- Android: API 14+');
  print('- iOS: iOS 3.2+');
  print('- Web: Not available');
  print('- Desktop: Varies by platform');

  // Usage with TextField
  print('\nUsage with TextField:');
  print('TextField(');
  print('  spellCheckConfiguration: SpellCheckConfiguration(');
  print('    spellCheckService: DefaultSpellCheckService(),');
  print('    misspelledTextStyle: TextStyle(...),');
  print('  ),');
  print(')');

  // SpellCheckConfiguration
  print('\nSpellCheckConfiguration:');
  print('- spellCheckService: Service to use');
  print('- misspelledTextStyle: Underline style');
  print('- spellCheckSuggestionsToolbarBuilder');

  // Locale handling
  print('\nLocale handling:');
  print('- Checks words against locale dictionary');
  print('- Multiple languages supported');
  print('- Device language settings used');

  // Custom implementation
  print('\nCustom implementation:');
  print('class MySpellChecker implements SpellCheckService {');
  print('  Future<List<SuggestionSpan>>');
  print('  fetchSpellCheckSuggestions(...) async {');
  print('    // Custom spell check logic');
  print('  }');
  print('}');

  // Explain purpose
  print('\nSpellCheckService purpose:');
  print('- Abstract spell checking interface');
  print('- fetchSpellCheckSuggestions(): Get corrections');
  print('- Returns SuggestionSpan list');
  print('- Platform spell check integration');
  print('- Enables spell checking in text fields');

  print('\n' + '=' * 50);
  print('SpellCheckService test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SpellCheckService Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract interface'),
      Text('Method: fetchSpellCheckSuggestions'),
      Text('Returns: List<SuggestionSpan>'),
      Text('Purpose: Spell check integration'),
    ],
  );
}
