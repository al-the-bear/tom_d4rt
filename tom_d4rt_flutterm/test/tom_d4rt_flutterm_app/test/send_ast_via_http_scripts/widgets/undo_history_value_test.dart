// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UndoHistoryValue from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UndoHistoryValue test executing');
  print('=' * 50);

  // UndoHistoryValue is immutable state
  print('UndoHistoryValue overview:');
  print('  - Immutable class');
  print('  - Represents undo/redo capability');
  print('  - Used by UndoHistoryController');
  print('  - Contains canUndo and canRedo bools');

  // Create instances
  print('\nCreating instances:');
  final value1 = UndoHistoryValue.empty;
  print('  empty: $value1');
  print('  canUndo: ${value1.canUndo}');
  print('  canRedo: ${value1.canRedo}');

  // With values
  print('\nWith explicit values:');
  final value2 = UndoHistoryValue(canUndo: true, canRedo: false);
  print('  canUndo=true, canRedo=false');
  print('  canUndo: ${value2.canUndo}');
  print('  canRedo: ${value2.canRedo}');

  final value3 = UndoHistoryValue(canUndo: true, canRedo: true);
  print('  canUndo=true, canRedo=true');
  print('  canUndo: ${value3.canUndo}');
  print('  canRedo: ${value3.canRedo}');

  // Empty constant
  print('\nUndoHistoryValue.empty:');
  print('  - Static const instance');
  print('  - canUndo: false');
  print('  - canRedo: false');
  print('  - Default initial value');

  // Immutability
  print('\nImmutability:');
  print('  - Both properties are final');
  print('  - No setters available');
  print('  - Create new instance to change');
  print('  - Safe for ValueNotifier');

  // Usage pattern
  print('\nUsage pattern:');
  print('  - UndoHistoryController holds value');
  print('  - UndoHistoryState updates value');
  print('  - UI reads canUndo/canRedo');
  print('  - Enable/disable undo/redo buttons');

  // Equality
  print('\nEquality considerations:');
  print('  - Two values with same flags are ==');
  print('  - value == UndoHistoryValue.empty');
  print('  - Enables efficient change detection');
  print('  - ValueNotifier compares before notify');

  print('\n' + '=' * 50);
  print('UndoHistoryValue test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UndoHistoryValue Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable class'),
      Text('Properties: canUndo, canRedo'),
      Text('Static: UndoHistoryValue.empty'),
    ],
  );
}
