// D4rt test script: Tests RawKeyEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyEvent test executing');

  // RawKeyEvent is deprecated - use KeyEvent instead
  print('RawKeyEvent is DEPRECATED');
  print('Use KeyEvent, KeyDownEvent, KeyUpEvent instead');

  // Show new KeyEvent API
  print('\nNew KeyEvent API:');
  final keyDown = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 100),
  );
  print('KeyDownEvent: ${keyDown.runtimeType}');
  print('physicalKey: ${keyDown.physicalKey.debugName}');
  print('logicalKey: ${keyDown.logicalKey.keyLabel}');
  print('timeStamp: ${keyDown.timeStamp}');

  // KeyUp event
  print('\nKeyUpEvent:');
  final keyUp = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 200),
  );
  print('KeyUpEvent: ${keyUp.runtimeType}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is KeyEvent: ${keyDown is KeyEvent}');

  // Migration guide
  print('\nMigration from RawKeyEvent:');
  print('Old: RawKeyDownEvent -> New: KeyDownEvent');
  print('Old: RawKeyUpEvent -> New: KeyUpEvent');
  print('Old: RawKeyboard -> New: HardwareKeyboard');
  print('Old: RawKeyboardListener -> New: KeyboardListener');

  // Using Focus for key events
  print('\nUsing Focus for key events:');
  print('Focus(');
  print('  onKeyEvent: (node, event) {');
  print('    if (event is KeyDownEvent) { ... }');
  print('    return KeyEventResult.ignored;');
  print('  },');
  print('  child: MyWidget(),');
  print(')');

  print('\nRawKeyEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('DEPRECATED - use KeyEvent'),
      Text('KeyDownEvent: ${keyDown.physicalKey.debugName}'),
      Text('KeyUpEvent: ${keyUp.physicalKey.debugName}'),
      Text('Use: Focus.onKeyEvent'),
    ],
  );
}
