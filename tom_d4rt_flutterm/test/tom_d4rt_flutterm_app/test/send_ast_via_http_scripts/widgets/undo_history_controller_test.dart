// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UndoHistoryController from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UndoHistoryController test executing');
  print('=' * 50);

  // UndoHistoryController extends ValueNotifier
  print('UndoHistoryController overview:');
  print('  - Extends ValueNotifier<UndoHistoryValue>');
  print('  - Controls undo/redo operations');
  print('  - Used with UndoHistory widget');
  print('  - Notifies when undo state changes');

  // Create controller
  print('\nCreating controller:');
  final controller = UndoHistoryController();
  print('  Created: $controller');
  print('  Initial value: ${controller.value}');
  print('  canUndo: ${controller.value.canUndo}');
  print('  canRedo: ${controller.value.canRedo}');

  // Test with initial value
  print('\nWith initial value:');
  final controller2 = UndoHistoryController(
    value: UndoHistoryValue(canUndo: true, canRedo: false),
  );
  print('  canUndo: ${controller2.value.canUndo}');
  print('  canRedo: ${controller2.value.canRedo}');

  // ChangeNotifier for undo/redo
  print('\nonUndo and onRedo notifiers:');
  print('  - onUndo: ChangeNotifier for undo events');
  print('  - onRedo: ChangeNotifier for redo events');
  print('  - Listen to know when undo/redo called');
  print('  - Triggered by undo()/redo() methods');

  // Methods
  print('\nMethods:');
  print('  - undo(): reverts to previous value');
  print('  - redo(): advances to next value');
  print('  - Both check canUndo/canRedo first');
  print('  - Notify onUndo/onRedo listeners');

  // Value updates
  print('\nValue updates:');
  print('  - UndoHistory widget updates value');
  print('  - Listeners notified automatically');
  print('  - value.canUndo and value.canRedo');
  print('  - UI can react to state changes');

  // Usage with EditableText
  print('\nUsage with EditableText:');
  print('  - Pass to EditableText.undoHistoryController');
  print('  - Ctrl+Z triggers undo()');
  print('  - Ctrl+Shift+Z triggers redo()');
  print('  - UI buttons can call undo()/redo()');

  // Cleanup
  controller.dispose();
  controller2.dispose();

  print('\n' + '=' * 50);
  print('UndoHistoryController test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UndoHistoryController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ValueNotifier<UndoHistoryValue>'),
      Text('Methods: undo(), redo()'),
      Text('Notifiers: onUndo, onRedo'),
    ],
  );
}
