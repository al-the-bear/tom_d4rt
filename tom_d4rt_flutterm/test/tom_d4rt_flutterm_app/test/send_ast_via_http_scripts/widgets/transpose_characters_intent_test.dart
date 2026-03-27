// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TransposeCharactersIntent from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TransposeCharactersIntent test executing');
  print('=' * 50);

  // TransposeCharactersIntent is for text editing
  print('TransposeCharactersIntent overview:');
  print('  - Extends Intent');
  print('  - Swaps characters around cursor');
  print('  - Traditional Unix/Emacs feature');
  print('  - Ctrl+T keyboard shortcut');

  // Create instance
  print('\nCreating instance:');
  const intent = TransposeCharactersIntent();
  print('  Created: $intent');
  print('  runtimeType: ${intent.runtimeType}');

  // Behavior
  print('\nTranspose behavior:');
  print('  - Swaps char before and after cursor');
  print('  - Moves cursor forward one position');
  print('  - At line end: swaps last two chars');
  print('  - Requires at least 2 characters');

  // Examples
  print('\nExamples:');
  print('  "ab|cd" -> "acb|d" (| = cursor)');
  print('  "abc|" -> "acb|" (at end)');
  print('  "|ab" -> "ba|" (at start)');
  print('  "a|" -> no change (only 1 char)');

  // Intent/Action system
  print('\nIntent/Action system:');
  print('  - Intent class: describes action');
  print('  - Action class: executes intent');
  print('  - Actions.of(context) finds handler');
  print('  - invoke() performs the action');

  // Text editing intents family
  print('\nRelated text editing intents:');
  print('  - DeleteCharacterIntent');
  print('  - DeleteToLineBreakIntent');
  print('  - DeleteToNextWordBoundaryIntent');
  print('  - ExtendSelectionByCharacterIntent');
  print('  - MoveCursorIntent');

  // Keyboard shortcut binding
  print('\nKeyboard shortcut binding:');
  print('  - DefaultTextEditingShortcuts');
  print('  - SingleActivator(LogicalKeyboardKey.keyT, control: true)');
  print('  - Platform-specific mappings');
  print('  - macOS: Ctrl+T (not Cmd)');

  // EditableText support
  print('\nEditableText support:');
  print('  - Handled by _TransposeCharactersAction');
  print('  - Modifies TextEditingValue');
  print('  - Updates selection after transpose');
  print('  - Respects text direction');

  // Undo integration
  print('\nUndo integration:');
  print('  - Creates undo history entry');
  print('  - Can be reverted with Ctrl+Z');
  print('  - Groups with adjacent edits');

  // Platform availability
  print('\nPlatform availability:');
  print('  - Desktop: full support');
  print('  - Mobile: may lack shortcut');
  print('  - Web: browser may intercept key');

  print('\n' + '=' * 50);
  print('TransposeCharactersIntent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TransposeCharactersIntent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Intent subclass'),
      Text('Purpose: Swap adjacent characters'),
      Text('Shortcut: Ctrl+T'),
    ],
  );
}
