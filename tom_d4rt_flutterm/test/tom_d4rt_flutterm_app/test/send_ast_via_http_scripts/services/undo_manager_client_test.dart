// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UndoManagerClient from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UndoManagerClient test executing');
  print('=' * 50);

  // UndoManagerClient interface
  print('\nUndoManagerClient:');
  print('Interface for receiving undo/redo callbacks');
  print('Works with UndoManager for text undo');

  // Interface methods
  print('\nInterface methods:');
  print('');
  print('handlePlatformUndo():');
  print('  - Called on undo request');
  print('  - Restore previous state');
  print('');
  print('handlePlatformRedo():');
  print('  - Called on redo request');
  print('  - Restore next state');

  // Platform undo triggers
  print('\nPlatform undo triggers:');
  print('');
  print('iOS:');
  print('  - Shake gesture');
  print('  - Three-finger swipe left');
  print('  - Cmd+Z (external keyboard)');
  print('');
  print('Android:');
  print('  - Ctrl+Z keyboard shortcut');
  print('');
  print('Desktop:');
  print('  - Ctrl/Cmd+Z');

  // Platform redo triggers
  print('\nPlatform redo triggers:');
  print('');
  print('iOS:');
  print('  - Three-finger swipe right');
  print('  - Cmd+Shift+Z');
  print('');
  print('Desktop:');
  print('  - Ctrl/Cmd+Shift+Z');
  print('  - Ctrl+Y (Windows)');

  // Implementation example
  print('\nImplementation example:');
  print('class MyEditor implements UndoManagerClient {');
  print('  final _undoStack = <EditorState>[];');
  print('  final _redoStack = <EditorState>[];');
  print('');
  print('  @override');
  print('  void handlePlatformUndo() {');
  print('    if (_undoStack.isNotEmpty) {');
  print('      _redoStack.add(_currentState);');
  print('      _currentState = _undoStack.removeLast();');
  print('    }');
  print('  }');
  print('');
  print('  @override');
  print('  void handlePlatformRedo() {');
  print('    if (_redoStack.isNotEmpty) {');
  print('      _undoStack.add(_currentState);');
  print('      _currentState = _redoStack.removeLast();');
  print('    }');
  print('  }');
  print('}');

  // Registration
  print('\nRegistration:');
  print('Works with UndoManager.instance');
  print('Report undo state via setUndoState()');

  // Type hierarchy
  print('\nType hierarchy:');
  print('UndoManagerClient (interface)');
  print('  \u2514\u2500 Widget implementations');

  // Explain purpose
  print('\nUndoManagerClient purpose:');
  print('- Platform undo/redo callbacks');
  print('- handlePlatformUndo method');
  print('- handlePlatformRedo method');
  print('- Gesture/shortcut handling');
  print('- Text editor undo support');

  print('\n' + '=' * 50);
  print('UndoManagerClient test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UndoManagerClient Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: interface'),
      Text('Methods: handlePlatformUndo/Redo'),
      Text('Triggers: gestures, shortcuts'),
      Text('Purpose: Undo/redo handling'),
    ],
  );
}
