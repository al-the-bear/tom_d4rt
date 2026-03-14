// D4rt test script: Tests ClearSelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClearSelectionEvent test executing');
  print('=' * 50);

  // ClearSelectionEvent for clearing selection
  print('\nClearSelectionEvent:');
  print('Selection event to clear all selection');
  print('Tap outside selected area');

  // Create instance
  final event = ClearSelectionEvent();
  print('\nInstance created:');
  print('runtimeType: ${event.runtimeType}');

  // Extends SelectionEvent
  print('\nExtends SelectionEvent:');
  print('is SelectionEvent: ${event is SelectionEvent}');

  // When triggered
  print('\nWhen triggered:');
  print('- Tap outside selection');
  print('- Escape key press');
  print('- Focus lost');
  print('- New selection started elsewhere');

  // Selection flow
  print('\nSelection flow:');
  print('1. User taps outside selection');
  print('2. Gesture recognizer detects');
  print('3. ClearSelectionEvent created');
  print('4. Dispatched to selectables');
  print('5. Each clears its selection');

  // ClearSelectionEvent vs other events
  print('\nClearSelectionEvent vs others:');
  print('');
  print('ClearSelectionEvent:');
  print('  - Clears ALL selection');
  print('  - No position parameter');
  print('');
  print('SelectWordSelectionEvent:');
  print('  - Selects word at position');
  print('  - globalPosition parameter');

  // Related events
  print('\nRelated selection events:');
  print('- SelectWordSelectionEvent (double-tap)');
  print('- SelectParagraphSelectionEvent (triple-tap)');
  print('- SelectAllSelectionEvent (Ctrl+A)');
  print('- DirectionallyExtendSelectionEvent');

  // Type hierarchy
  print('\nType hierarchy:');
  print('SelectionEvent');
  print('  \u2514\u2500 ClearSelectionEvent');

  // Explain purpose
  print('\nClearSelectionEvent purpose:');
  print('- Clear all text selection');
  print('- No position required');
  print('- Tap outside trigger');
  print('- Extends SelectionEvent');
  print('- Part of selection system');

  print('\n' + '=' * 50);
  print('ClearSelectionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClearSelectionEvent Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Is SelectionEvent: ${event is SelectionEvent}'),
      Text('Trigger: Tap outside'),
      Text('Effect: Clear all'),
      Text('Purpose: Clear selection'),
    ],
  );
}
