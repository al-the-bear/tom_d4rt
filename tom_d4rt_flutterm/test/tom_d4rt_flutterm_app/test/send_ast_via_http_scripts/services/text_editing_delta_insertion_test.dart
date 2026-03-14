// D4rt test script: Tests TextEditingDeltaInsertion from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextEditingDeltaInsertion test executing');

  // Create TextEditingDeltaInsertion
  final delta = TextEditingDeltaInsertion(
    oldText: 'Hello',
    textInserted: ' World',
    insertionOffset: 5,
    selection: TextSelection.collapsed(offset: 11),
    composing: TextRange.empty,
  );

  print('Created: ${delta.runtimeType}');

  // Test basic properties
  print('\nBasic properties:');
  print('oldText: "${delta.oldText}"');
  print('textInserted: "${delta.textInserted}"');
  print('insertionOffset: ${delta.insertionOffset}');

  // Test resulting selection
  print('\nSelection after insert:');
  print('selection: ${delta.selection}');
  print('baseOffset: ${delta.selection.baseOffset}');
  print('extentOffset: ${delta.selection.extentOffset}');

  // Test composing
  print('\nComposing:');
  print('composing: ${delta.composing}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is TextEditingDelta: ${delta is TextEditingDelta}');

  // Explain delta types
  print('\nTextEditingDelta types:');
  print('- TextEditingDeltaInsertion: text added');
  print('- TextEditingDeltaDeletion: text removed');
  print('- TextEditingDeltaReplacement: text replaced');
  print('- TextEditingDeltaNonTextUpdate: selection only');

  // Use case
  print('\nUse case:');
  print('- IME sends deltas to Flutter');
  print('- DeltaTextInputClient receives deltas');
  print('- More efficient than full text updates');
  print('- Better for complex text editing');

  print('\nTextEditingDeltaInsertion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextEditingDeltaInsertion Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Text insertion delta'),
      Text('oldText: "${delta.oldText}"'),
      Text('inserted: "${delta.textInserted}"'),
      Text('at offset: ${delta.insertionOffset}'),
    ],
  );
}
