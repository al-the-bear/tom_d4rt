// D4rt test script: Tests TextEditingDeltaReplacement from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextEditingDeltaReplacement test executing');
  print('=' * 50);

  // Create TextEditingDeltaReplacement
  final replacement = TextEditingDeltaReplacement(
    oldText: 'Hello World',
    replacementText: 'Flutter',
    replacedRange: TextRange(start: 6, end: 11), // Replace "World"
    selection: TextSelection.collapsed(offset: 13),
    composing: TextRange.empty,
  );
  print('\nTextEditingDeltaReplacement created:');
  print('runtimeType: ${replacement.runtimeType}');

  // Delta properties
  print('\nReplacement delta properties:');
  print('oldText: "${replacement.oldText}"');
  print('replacementText: "${replacement.replacementText}"');
  print('replacedRange: ${replacement.replacedRange}');
  print('selection: ${replacement.selection}');
  print('composing: ${replacement.composing}');

  // Apply replacement
  print('\nApplying replacement:');
  final oldValue = TextEditingValue(text: 'Hello World');
  print('Before: "${oldValue.text}"');
  final newValue = replacement.apply(oldValue);
  print('After: "${newValue.text}"');

  // Autocorrect example
  print('\nAutocorrect example:');
  final autocorrect = TextEditingDeltaReplacement(
    oldText: 'teh',
    replacementText: 'the',
    replacedRange: TextRange(start: 0, end: 3),
    selection: TextSelection.collapsed(offset: 3),
    composing: TextRange.empty,
  );
  print('Replacing "teh" with "the"');
  print('replacementText: "${autocorrect.replacementText}"');

  // Selection replacement
  print('\nSelection replacement:');
  // ignore: unused_local_variable
  final _selReplace = TextEditingDeltaReplacement(
    oldText: 'Hello World',
    replacementText: 'Everyone',
    replacedRange: TextRange(start: 6, end: 11), // Select "World"
    selection: TextSelection.collapsed(offset: 14),
    composing: TextRange.empty,
  );
  print('Replace selection "World" -> "Everyone"');

  // IME composition replacement
  print('\nIME composition replacement:');
  print('- Japanese: kana -> kanji conversion');
  print('- Chinese: pinyin -> character conversion');
  print('- composing range shows uncommitted text');

  // Type hierarchy
  print('\nType hierarchy:');
  print('TextEditingDelta (abstract base)');
  print('  \u251c\u2500 TextEditingDeltaInsertion');
  print('  \u251c\u2500 TextEditingDeltaDeletion');
  print('  \u251c\u2500 TextEditingDeltaReplacement');
  print('  \u2514\u2500 TextEditingDeltaNonTextUpdate');

  // Explain purpose
  print('\nTextEditingDeltaReplacement purpose:');
  print('- Represents text replacement operation');
  print('- oldText: Original text');
  print('- replacementText: New text to insert');
  print('- replacedRange: Range being replaced');
  print('- Used for autocorrect, IME, paste');

  print('\n' + '=' * 50);
  print('TextEditingDeltaReplacement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextEditingDeltaReplacement Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${replacement.runtimeType}'),
      Text('replacementText: "${replacement.replacementText}"'),
      Text('Result: "${newValue.text}"'),
      Text('Purpose: Text replacement delta'),
    ],
  );
}
