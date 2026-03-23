// ignore_for_file: avoid_print
// D4rt test script: Tests UndoHistoryController, UndoHistoryValue
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UndoHistory test executing');

  // ========== UndoHistoryValue ==========
  print('--- UndoHistoryValue Tests ---');
  final undoValue = UndoHistoryValue(canUndo: true, canRedo: false);
  print('UndoHistoryValue created');
  print('  canUndo: ${undoValue.canUndo}');
  print('  canRedo: ${undoValue.canRedo}');

  final redoValue = UndoHistoryValue(canUndo: true, canRedo: true);
  print('UndoHistoryValue with redo');
  print('  canUndo: ${redoValue.canUndo}');
  print('  canRedo: ${redoValue.canRedo}');

  final emptyValue = UndoHistoryValue(canUndo: false, canRedo: false);
  print('Empty UndoHistoryValue');
  print('  canUndo: ${emptyValue.canUndo}');
  print('  canRedo: ${emptyValue.canRedo}');

  // Equality check
  final same1 = UndoHistoryValue(canUndo: true, canRedo: false);
  final same2 = UndoHistoryValue(canUndo: true, canRedo: false);
  print('Equality: ${same1 == same2}');

  // ========== UndoHistoryController ==========
  print('--- UndoHistoryController Tests ---');
  final undoCtrl = UndoHistoryController();
  print('UndoHistoryController created');
  print('  value.canUndo: ${undoCtrl.value.canUndo}');
  print('  value.canRedo: ${undoCtrl.value.canRedo}');

  // Controller with initial value
  final undoCtrl2 = UndoHistoryController(value: undoValue);
  print('UndoHistoryController with value');
  print('  value.canUndo: ${undoCtrl2.value.canUndo}');

  // Dispose
  undoCtrl.dispose();
  undoCtrl2.dispose();
  print('Controllers disposed');

  print('All undo history tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'UndoHistory Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('UndoHistoryValue canUndo=true, canRedo=false'),
            Text('UndoHistoryController created and disposed'),
          ],
        ),
      ),
    ),
  );
}
