// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UndoTextIntent from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('UndoTextIntent test executing');
  print('=' * 50);

  // UndoTextIntent triggers undo operation
  print('UndoTextIntent overview:');
  print('  - Extends Intent');
  print('  - Triggers text undo operation');
  print('  - Has cause property');
  print('  - Mapped to Ctrl+Z shortcut');

  // Create intent
  print('\nCreating intent:');
  const intent = UndoTextIntent(SelectionChangedCause.keyboard);
  print('  Created: $intent');
  print('  cause: ${intent.cause}');

  // SelectionChangedCause values
  print('\nSelectionChangedCause values:');
  print('  - tap: user tapped');
  print('  - doubleTap: user double-tapped');
  print('  - longPress: user long-pressed');
  print('  - keyboard: keyboard navigation');
  print('  - drag: user dragged selection');
  print('  - forcePress: force press gesture');

  // Keyboard shortcuts
  print('\nKeyboard shortcut mapping:');
  print('  - Ctrl+Z on Windows/Linux');
  print('  - Cmd+Z on macOS');
  print('  - Bound in DefaultTextEditingShortcuts');
  print('  - UndoTextIntent(SelectionChangedCause.keyboard)');

  // Action handling
  print('\nAction handling:');
  print('  - UndoHistory provides action');
  print('  - Action pops from undo stack');
  print('  - Pushes to redo stack');
  print('  - Updates UndoHistoryController');

  // Cause significance
  print('\nCause significance:');
  print('  - Indicates source of intent');
  print('  - Usually SelectionChangedCause.keyboard');
  print('  - Could be programmatic');
  print('  - For analytics or logging');

  // Related intents
  print('\nRelated intents:');
  print('  - RedoTextIntent: for redo');
  print('  - UpdateSelectionIntent: selection change');
  print('  - ReplaceTextIntent: text replacement');
  print('  - DeleteCharacterIntent: deletion');

  // Implementation
  print('\nImplementation:');
  print('  - const constructor');
  print('  - cause is final property');
  print('  - Required parameter');
  print('  - Type: SelectionChangedCause');

  print('\n' + '=' * 50);
  print('UndoTextIntent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UndoTextIntent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Intent subclass'),
      Text('Property: cause (SelectionChangedCause)'),
      Text('Shortcut: Ctrl+Z / Cmd+Z'),
    ],
  );
}
