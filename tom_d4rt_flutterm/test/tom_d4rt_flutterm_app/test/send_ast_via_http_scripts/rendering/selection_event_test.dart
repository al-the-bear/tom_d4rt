// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionEvent test executing');
  print('=' * 50);

  // SelectionEvent is the abstract base class
  print('\nSelectionEvent:');
  print('Type: Abstract class');
  print('Purpose: Base class for all selection events');
  print('Each event has a SelectionEventType discriminator');
  print('Cannot be instantiated directly');

  // SelectionEventType enum
  print('\nSelectionEventType values:');
  for (final t in SelectionEventType.values) {
    print('  ${t.name}');
  }

  // Concrete subclasses
  print('\nConcrete subclasses:');
  print('  SelectAllSelectionEvent');
  print('    type: selectAll');
  print('  ClearSelectionEvent');
  print('    type: clear');
  print('  SelectWordSelectionEvent');
  print('    type: selectWord');
  print('  SelectParagraphSelectionEvent');
  print('    type: selectParagraph');
  print('  SelectionEdgeUpdateEvent');
  print('    type: startEdgeUpdate / endEdgeUpdate');
  print('  GranularlyExtendSelectionEvent');
  print('    type: granularlyExtendSelection');
  print('  DirectionallyExtendSelectionEvent');
  print('    type: directionallyExtendSelection');

  // Create concrete instances to demonstrate
  const selectAll = SelectAllSelectionEvent();
  const clear = ClearSelectionEvent();
  print('\nExample instances:');
  print('  selectAll.type: ${selectAll.type}');
  print('  clear.type: ${clear.type}');

  // Dispatch pattern
  print('\nDispatch pattern:');
  print('  SelectionResult result = handler.dispatchSelectionEvent(event)');
  print('  Events flow down the selection tree');
  print('  Each Selectable handles or delegates the event');

  // SelectionResult
  print('\nSelectionResult values:');
  for (final r in SelectionResult.values) {
    print('  ${r.name}');
  }

  // Event creation patterns
  print('\nEvent creation patterns:');
  print('  const SelectAllSelectionEvent() - select all');
  print('  const ClearSelectionEvent() - clear');
  print('  SelectionEdgeUpdateEvent.forStart(...) - start edge');
  print('  SelectionEdgeUpdateEvent.forEnd(...) - end edge');

  print('\n==================================================');
  print('SelectionEvent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectionEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Subclasses: 7 concrete event types'),
      Text('Used with: SelectionHandler.dispatchSelectionEvent'),
      Text('Returns: SelectionResult'),
    ],
  );
}
