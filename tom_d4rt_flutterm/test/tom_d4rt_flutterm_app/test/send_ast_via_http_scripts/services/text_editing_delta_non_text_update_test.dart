// D4rt test script: Tests TextEditingDeltaNonTextUpdate from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextEditingDeltaNonTextUpdate test executing');
  print('=' * 50);

  // Create TextEditingDeltaNonTextUpdate
  final nonTextUpdate = TextEditingDeltaNonTextUpdate(
    oldText: 'Hello World',
    selection: TextSelection(baseOffset: 0, extentOffset: 5), // Select "Hello"
    composing: TextRange.empty,
  );
  print('\nTextEditingDeltaNonTextUpdate created:');
  print('runtimeType: ${nonTextUpdate.runtimeType}');

  // Delta properties
  print('\nNon-text update delta properties:');
  print('oldText: "${nonTextUpdate.oldText}"');
  print('selection: ${nonTextUpdate.selection}');
  print('composing: ${nonTextUpdate.composing}');

  // Apply non-text update
  print('\nApplying non-text update:');
  final oldValue = TextEditingValue(
    text: 'Hello World',
    selection: TextSelection.collapsed(offset: 0),
  );
  print('Before selection: ${oldValue.selection}');
  final newValue = nonTextUpdate.apply(oldValue);
  print('After selection: ${newValue.selection}');
  print('Text unchanged: ${oldValue.text == newValue.text}');

  // Selection change example
  print('\nSelection change example:');
  final selectionChange = TextEditingDeltaNonTextUpdate(
    oldText: 'Example text',
    selection: TextSelection(baseOffset: 8, extentOffset: 12),
    composing: TextRange.empty,
  );
  print('New selection: ${selectionChange.selection}');
  print('Selected text would be: "text"');

  // Composing region change
  print('\nComposing region change:');
  final composingChange = TextEditingDeltaNonTextUpdate(
    oldText: 'Hello',
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange(start: 0, end: 5),
  );
  print('composing: ${composingChange.composing}');
  print('Shows IME composition region');

  // When non-text update occurs
  print('\nWhen non-text update occurs:');
  print('- Selection changed by tap');
  print('- Selection changed by keyboard');
  print('- Composing region updated');
  print('- Cursor position moved');
  print('- No actual text modification');

  // Type hierarchy
  print('\nType hierarchy:');
  print('TextEditingDelta (abstract base)');
  print('  \u251c\u2500 TextEditingDeltaInsertion');
  print('  \u251c\u2500 TextEditingDeltaDeletion');
  print('  \u251c\u2500 TextEditingDeltaReplacement');
  print('  \u2514\u2500 TextEditingDeltaNonTextUpdate');

  // Explain purpose
  print('\nTextEditingDeltaNonTextUpdate purpose:');
  print('- Represents non-text changes');
  print('- Selection or composing updates only');
  print('- Text content remains unchanged');
  print('- Used with DeltaTextInputClient');
  print('- Tracks selection/cursor changes');

  print('\n' + '=' * 50);
  print('TextEditingDeltaNonTextUpdate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextEditingDeltaNonTextUpdate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${nonTextUpdate.runtimeType}'),
      Text('selection: ${nonTextUpdate.selection}'),
      Text('Text changed: false'),
      Text('Purpose: Selection/cursor delta'),
    ],
  );
}
