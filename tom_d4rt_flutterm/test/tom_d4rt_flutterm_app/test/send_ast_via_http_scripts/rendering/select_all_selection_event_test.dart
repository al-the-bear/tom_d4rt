// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectAllSelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectAllSelectionEvent test executing');
  print('=' * 50);

  // SelectAllSelectionEvent extends SelectionEvent
  print('\nSelectAllSelectionEvent:');
  print('Purpose: Event to select all content in a Selectable');
  print('Extends: SelectionEvent');
  print('Type discriminator: SelectionEventType.selectAll');

  // Create an instance
  const event = SelectAllSelectionEvent();
  print('\nCreated SelectAllSelectionEvent:');
  print('  runtimeType: ${event.runtimeType}');
  print('  type: ${event.type}');

  // SelectionEventType enum
  print('\nSelectionEventType values:');
  for (final t in SelectionEventType.values) {
    print('  ${t.name}');
  }

  // Verify this is selectAll type
  print('\nType check:');
  print('  event.type == SelectionEventType.selectAll: ${event.type == SelectionEventType.selectAll}');
  print('  event.type.name: ${event.type.name}');

  // Other selection event types for context
  print('\nRelated SelectionEvent subclasses:');
  print('  SelectAllSelectionEvent - select all content');
  print('  ClearSelectionEvent - clear selection');
  print('  SelectWordSelectionEvent - select word at position');
  print('  SelectionEdgeUpdateEvent - update start/end edge');
  print('  GranularlyExtendSelectionEvent - extend by granularity');
  print('  DirectionallyExtendSelectionEvent - extend by direction');

  // Dispatching pattern
  print('\nDispatch pattern:');
  print('  handler.dispatchSelectionEvent(const SelectAllSelectionEvent())');
  print('  Returns SelectionResult indicating what happened');

  // SelectionResult enum
  print('\nSelectionResult values:');
  for (final r in SelectionResult.values) {
    print('  ${r.name}');
  }

  // Typical widget usage
  print('\nTypical widget-level usage:');
  print('  SelectableRegion dispatches SelectAllSelectionEvent');
  print('  on Ctrl+A / Cmd+A keyboard shortcut');
  print('  or via context menu "Select All" action');

  // Const constructor
  print('\nConst constructor:');
  print('  const SelectAllSelectionEvent() - no parameters needed');
  print('  Always represents the same intent: select everything');
  print('  Singleton-like: identical(event, const SelectAllSelectionEvent()): ${identical(event, const SelectAllSelectionEvent())}');

  print('\n==================================================');
  print('SelectAllSelectionEvent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectAllSelectionEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('Extends: SelectionEvent'),
      Text('event.type: ${event.type}'),
      Text('Purpose: Select all content'),
    ],
  );
}
