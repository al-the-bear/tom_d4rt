// D4rt test script: Tests SelectParagraphSelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectParagraphSelectionEvent test executing');
  print('=' * 50);

  // SelectParagraphSelectionEvent for paragraph selection
  print('\nSelectParagraphSelectionEvent:');
  print('Selection event for paragraph selection');
  print('Triple-tap to select paragraph');

  // Create instance
  final event = SelectParagraphSelectionEvent(
    globalPosition: Offset(100.0, 200.0),
  );
  print('\nInstance created:');
  print('globalPosition: ${event.globalPosition}');

  // Properties
  print('\nProperties:');
  print('globalPosition: ${event.globalPosition}');

  // Extends SelectionEvent
  print('\nExtends SelectionEvent:');
  print('is SelectionEvent: ${event is SelectionEvent}');

  // When triggered
  print('\nWhen triggered:');
  print('- Triple-tap on text');
  print('- Keyboard shortcut: Ctrl+Shift+Up/Down');
  print('- Select paragraph action');

  // Selection flow
  print('\nSelection flow:');
  print('1. User triple-taps');
  print('2. Gesture recognizer detects');
  print('3. SelectParagraphSelectionEvent created');
  print('4. Dispatched to selectables');
  print('5. Each expands selection to paragraph');

  // Related events
  print('\nRelated selection events:');
  print('- SelectWordSelectionEvent (double-tap)');
  print('- SelectAllSelectionEvent (Ctrl+A)');
  print('- ClearSelectionEvent (tap away)');
  print('- DirectionallyExtendSelectionEvent');

  // SelectionEvent types
  print('\nSelectionEvent type hierarchy:');
  print('SelectionEvent');
  print('  \u251c\u2500 SelectWordSelectionEvent');
  print('  \u251c\u2500 SelectParagraphSelectionEvent');
  print('  \u251c\u2500 SelectAllSelectionEvent');
  print('  \u2514\u2500 ClearSelectionEvent');

  // Explain purpose
  print('\nSelectParagraphSelectionEvent purpose:');
  print('- Paragraph selection event');
  print('- globalPosition for location');
  print('- Triple-tap trigger');
  print('- Extends SelectionEvent');
  print('- Part of selection system');

  print('\n' + '=' * 50);
  print('SelectParagraphSelectionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectParagraphSelectionEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Position: ${event.globalPosition}'),
      Text('Trigger: Triple-tap'),
      Text('Extends: SelectionEvent'),
      Text('Purpose: Paragraph selection'),
    ],
  );
}
