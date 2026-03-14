// D4rt test script: Tests SelectWordSelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectWordSelectionEvent test executing');

  // SelectWordSelectionEvent - Selection event for selecting a word
  // Triggered by double-tap gesture in text selection
  
  // Create a SelectWordSelectionEvent at a specific position
  final event = SelectWordSelectionEvent(
    globalPosition: const Offset(150.0, 200.0),
  );
  
  print('SelectWordSelectionEvent created: $event');
  print('globalPosition: ${event.globalPosition}');
  print('type: ${event.type}');
  
  // SelectionEventType enum values
  print('\nSelectionEventType values:');
  for (final eventType in SelectionEventType.values) {
    print('- $eventType');
  }
  
  // Test isEnd property (word selection is a discrete event)
  print('\nisEnd: ${event.isEnd}');
  print('Word selection is typically a discrete selection event');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('SelectWordSelectionEvent extends SelectionEvent');
  print('SelectionEvent is the base class for all selection events');
  
  // Compare with other selection events
  print('\nRelated selection events:');
  print('- SelectAllSelectionEvent: Selects all selectable content');
  print('- ClearSelectionEvent: Clears current selection');
  print('- SelectParagraphSelectionEvent: Selects entire paragraph');
  print('- GranularlyExtendSelectionEvent: Extends by granularity');
  print('- DirectionallyExtendSelectionEvent: Extends directionally');
  
  // Use case description
  print('\nUse cases:');
  print('- Double-tap to select word in text');
  print('- Word selection in text editing');
  print('- Smart text selection in documents');

  print('\nSelectWordSelectionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectWordSelectionEvent Tests'),
      Text('Word selection at (150, 200)'),
      Text('type: ${event.type}'),
      Text('Used for double-tap word selection'),
    ],
  );
}
