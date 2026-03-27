// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SpellCheckConfiguration from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SpellCheckConfiguration test executing');
  print('=' * 50);

  // Test disabled configuration
  print('Testing SpellCheckConfiguration.disabled():');
  final disabled = SpellCheckConfiguration.disabled();
  print('  spellCheckEnabled: ${disabled.spellCheckEnabled}');
  print('  spellCheckService: ${disabled.spellCheckService}');
  print('  misspelledTextStyle: ${disabled.misspelledTextStyle}');
  print('  misspelledSelectionColor: ${disabled.misspelledSelectionColor}');

  // Test enabled configuration
  print('\nTesting SpellCheckConfiguration() constructor:');
  final enabled = SpellCheckConfiguration(
    misspelledTextStyle: TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: Colors.red,
      decorationStyle: TextDecorationStyle.wavy,
    ),
    misspelledSelectionColor: Colors.red.withValues(alpha: 0.3),
  );
  print('  spellCheckEnabled: ${enabled.spellCheckEnabled}');
  print('  misspelledTextStyle: ${enabled.misspelledTextStyle}');
  print('  misspelledSelectionColor: ${enabled.misspelledSelectionColor}');

  // Test immutability (class is @immutable)
  print('\nSpellCheckConfiguration properties:');
  print('  - @immutable annotation');
  print('  - spellCheckService: SpellCheckService?');
  print('  - misspelledSelectionColor: Color?');
  print('  - misspelledTextStyle: TextStyle?');
  print('  - spellCheckSuggestionsToolbarBuilder: Function?');
  print('  - spellCheckEnabled: bool (computed)');

  // Test copyWith
  print('\nTesting copyWith:');
  final copied = enabled.copyWith(
    misspelledSelectionColor: Colors.orange,
  );
  print('  Original color: ${enabled.misspelledSelectionColor}');
  print('  Copied color: ${copied.misspelledSelectionColor}');
  print('  Same style: ${copied.misspelledTextStyle == enabled.misspelledTextStyle}');

  // Test copyWith on disabled
  print('\ncopyWith on disabled config:');
  final copiedDisabled = disabled.copyWith();
  print('  Still disabled: ${!copiedDisabled.spellCheckEnabled}');

  // Test toString
  print('\ntoString output:');
  print('  ${disabled.toString().substring(0, 60)}...');

  // Platform behavior notes
  print('\nPlatform behavior:');
  print('  - iOS: Uses native UITextChecker');
  print('  - Android: Uses native SpellChecker');
  print('  - Desktop: Platform-specific');

  // runtimeType
  print('\nType verification:');
  print('  runtimeType: ${enabled.runtimeType}');

  print('\n' + '=' * 50);
  print('SpellCheckConfiguration test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SpellCheckConfiguration Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable configuration'),
      Text('Constructors: (), disabled()'),
      Text('Methods: copyWith()'),
    ],
  );
}
