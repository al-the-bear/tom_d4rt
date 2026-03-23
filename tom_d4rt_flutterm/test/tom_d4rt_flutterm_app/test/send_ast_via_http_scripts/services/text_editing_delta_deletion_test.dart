// ignore_for_file: avoid_print
// D4rt test script: Tests TextEditingDeltaDeletion from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextEditingDeltaDeletion test executing');
  print('=' * 50);

  // Create TextEditingDeltaDeletion
  final deletion = TextEditingDeltaDeletion(
    oldText: 'Hello World',
    deletedRange: TextRange(start: 5, end: 11), // Delete " World"
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange.empty,
  );
  print('\nTextEditingDeltaDeletion created:');
  print('runtimeType: ${deletion.runtimeType}');

  // Delta properties
  print('\nDeletion delta properties:');
  print('oldText: "${deletion.oldText}"');
  print('deletedRange: ${deletion.deletedRange}');
  print('selection: ${deletion.selection}');
  print('composing: ${deletion.composing}');

  // Apply deletion
  print('\nApplying deletion:');
  final oldValue = TextEditingValue(text: 'Hello World');
  print('Before: "${oldValue.text}"');
  final newValue = deletion.apply(oldValue);
  print('After: "${newValue.text}"');

  // Backspace deletion example
  print('\nBackspace deletion example:');
  final backspace = TextEditingDeltaDeletion(
    oldText: 'Test',
    deletedRange: TextRange(start: 3, end: 4), // Delete 't'
    selection: TextSelection.collapsed(offset: 3),
    composing: TextRange.empty,
  );
  print('deletedRange: ${backspace.deletedRange}');
  print('Result: "Tes"');

  // Forward delete example
  print('\nForward delete example:');
  final forwardDelete = TextEditingDeltaDeletion(
    oldText: 'Test',
    deletedRange: TextRange(start: 0, end: 1), // Delete 'T'
    selection: TextSelection.collapsed(offset: 0),
    composing: TextRange.empty,
  );
  print('deletedRange: ${forwardDelete.deletedRange}');
  print('Result: "est"');

  // Selection deletion
  print('\nSelection deletion:');
  final selDelete = TextEditingDeltaDeletion(
    oldText: 'Hello World',
    deletedRange: TextRange(start: 2, end: 8), // Delete "llo Wo"
    selection: TextSelection.collapsed(offset: 2),
    composing: TextRange.empty,
  );
  print('Delete selected range: ${selDelete.deletedRange}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('TextEditingDelta (abstract base)');
  print('  \u251c\u2500 TextEditingDeltaInsertion');
  print('  \u251c\u2500 TextEditingDeltaDeletion');
  print('  \u251c\u2500 TextEditingDeltaReplacement');
  print('  \u2514\u2500 TextEditingDeltaNonTextUpdate');

  // Explain purpose
  print('\nTextEditingDeltaDeletion purpose:');
  print('- Represents text deletion operation');
  print('- oldText: Text before deletion');
  print('- deletedRange: Range being deleted');
  print('- Used with DeltaTextInputClient');
  print('- Enables granular text tracking');

  print('\n' + '=' * 50);
  print('TextEditingDeltaDeletion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextEditingDeltaDeletion Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${deletion.runtimeType}'),
      Text('deletedRange: ${deletion.deletedRange}'),
      Text('Result: "${newValue.text}"'),
      Text('Purpose: Text deletion delta'),
    ],
  );
}
