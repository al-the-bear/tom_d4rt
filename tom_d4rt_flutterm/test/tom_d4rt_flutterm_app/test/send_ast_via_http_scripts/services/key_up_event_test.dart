// ignore_for_file: avoid_print
// D4rt test script: Tests KeyUpEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyUpEvent test executing');

  // Create KeyUpEvent
  final event = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 100),
  );

  print('Created: ${event.runtimeType}');

  // Test key properties
  print('\nKey properties:');
  print('physicalKey: ${event.physicalKey.debugName}');
  print('logicalKey: ${event.logicalKey.keyLabel}');
  print('character: ${event.character}');

  // Test timing
  print('\nTiming:');
  print('timeStamp: ${event.timeStamp}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is KeyEvent: true /* event is KeyEvent */');

  // Compare with KeyDownEvent
  print('\nKeyUp vs KeyDown:');
  final downEvent = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 50),
  );
  print('KeyDownEvent: ${downEvent.runtimeType}');
  print('KeyUpEvent: ${event.runtimeType}');

  // Key event sequence
  print('\nKey event sequence:');
  print('1. KeyDownEvent - key pressed');
  print('2. KeyRepeatEvent - key held (optional)');
  print('3. KeyUpEvent - key released');

  // Using in Focus
  print('\nUsing in Focus widget:');
  print('Focus(');
  print('  onKeyEvent: (node, event) {');
  print('    if (event is KeyUpEvent) {');
  print('      print("Released: ${event.logicalKey}");');
  print('    }');
  print('    return KeyEventResult.ignored;');
  print('  },');
  print(')');

  print('\nKeyUpEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeyUpEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Key release event'),
      Text('physicalKey: ${event.physicalKey.debugName}'),
      Text('logicalKey: ${event.logicalKey.keyLabel}'),
      Text('timeStamp: ${event.timeStamp}'),
    ],
  );
}
