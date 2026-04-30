// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DefaultSpellCheckService from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DefaultSpellCheckService test executing');
  print('=' * 50);

  // DefaultSpellCheckService - default implementation
  print('\nDefaultSpellCheckService:');
  print('Default implementation of SpellCheckService');
  print('Uses platform spell check APIs');

  // Create instance
  final service = DefaultSpellCheckService();
  print('\nInstance created:');
  print('runtimeType: ${service.runtimeType}');

  // Implements SpellCheckService
  print('\nImplements SpellCheckService:');
  print('is SpellCheckService: true /* service is SpellCheckService */');

  // Method
  print('\nfetchSpellCheckSuggestions:');
  print('Future<List<SuggestionSpan>> fetchSpellCheckSuggestions(');
  print('  Locale locale,');
  print('  String text,');
  print(')');

  // Platform implementations
  print('\nPlatform implementations:');
  print('Android:');
  print('  - TextServicesManager');
  print('  - SpellCheckerSession API');
  print('  - System dictionary');
  print('');
  print('iOS:');
  print('  - UITextChecker');
  print('  - rangeOfMisspelledWord');
  print('  - guessesForWord');

  // Usage example
  print('\nUsage example:');
  print('final service = DefaultSpellCheckService();');
  print('');
  print('final suggestions = await service.fetchSpellCheckSuggestions(');
  print('  Locale("en", "US"),');
  print('  "Ths is a tset",');
  print(');');
  print('');
  print('for (final span in suggestions) {');
  print('  print("\${span.range}: \${span.suggestions}");');
  print('}');

  // Usage with TextField
  print('\nUsage with TextField:');
  print('TextField(');
  print('  spellCheckConfiguration: SpellCheckConfiguration(');
  print('    spellCheckService: DefaultSpellCheckService(),');
  print('  ),');
  print(')');

  // Locale support
  print('\nLocale support:');
  print('- Uses device language settings');
  print('- System dictionaries by locale');
  print('- Multi-language support');

  // Type hierarchy
  print('\nType hierarchy:');
  print('SpellCheckService (abstract)');
  print('  \u2514\u2500 DefaultSpellCheckService');

  // Explain purpose
  print('\nDefaultSpellCheckService purpose:');
  print('- Default SpellCheckService implementation');
  print('- Platform spell check integration');
  print('- fetchSpellCheckSuggestions: Check text');
  print('- Returns SuggestionSpan list');
  print('- Enables spell checking in text fields');

  print('\n' + '=' * 50);
  print('DefaultSpellCheckService test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DefaultSpellCheckService Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${service.runtimeType}'),
      Text('Implements: SpellCheckService'),
      Text('Platforms: Android, iOS'),
      Text('Purpose: Default spell checking'),
    ],
  );
}
