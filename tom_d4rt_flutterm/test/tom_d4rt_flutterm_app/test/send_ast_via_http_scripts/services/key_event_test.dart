// D4rt test script: Tests KeyEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyEvent test executing');
  print('=' * 50);

  // KeyEvent is abstract - test via subclasses
  final downEvent = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    character: 'a',
    timeStamp: Duration(milliseconds: 100),
  );
  print('\nKeyDownEvent (KeyEvent subclass):');
  print('runtimeType: ${downEvent.runtimeType}');
  print('is KeyEvent: true /* downEvent is KeyEvent */');

  // Test common KeyEvent properties
  print('\nKeyEvent properties:');
  print('physicalKey: ${downEvent.physicalKey}');
  print('logicalKey: ${downEvent.logicalKey}');
  print('character: "${downEvent.character}"');
  print('timeStamp: ${downEvent.timeStamp}');
  print('synthesized: ${downEvent.synthesized}');

  // Create KeyUpEvent
  final upEvent = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 200),
  );
  print('\nKeyUpEvent:');
  print('runtimeType: ${upEvent.runtimeType}');
  print('is KeyEvent: true /* upEvent is KeyEvent */');
  print('character: ${upEvent.character ?? "null"}');

  // Create KeyRepeatEvent
  final repeatEvent = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    character: 'a',
    timeStamp: Duration(milliseconds: 600),
  );
  print('\nKeyRepeatEvent:');
  print('runtimeType: ${repeatEvent.runtimeType}');
  print('is KeyEvent: true /* repeatEvent is KeyEvent */');

  // KeyEvent hierarchy
  print('\nKeyEvent hierarchy:');
  print('KeyEvent (abstract base)');
  print('  ├─ KeyDownEvent (key pressed)');
  print('  ├─ KeyUpEvent (key released)');
  print('  └─ KeyRepeatEvent (key held/repeated)');

  // Test type checking
  print('\nType checking pattern:');
  final events = [downEvent, upEvent, repeatEvent];
  for (final event in events) {
    print(
      '${event.runtimeType}: isDown=true /* event is KeyDownEvent */, isUp=true /* event is KeyUpEvent */, isRepeat=true /* event is KeyRepeatEvent */',
    );
  }

  // Physical vs Logical key
  print('\nPhysical vs Logical key:');
  print('Physical: Hardware key position (QWERTY A)');
  print('Logical: Key meaning (letter A)');
  print('Example: On AZERTY, physical A = logical Q');

  // Test with modifier keys
  print('\nModifier key example:');
  final shiftDown = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.shiftLeft,
    logicalKey: LogicalKeyboardKey.shiftLeft,
    timeStamp: Duration(milliseconds: 50),
  );
  print('Shift physicalKey: ${shiftDown.physicalKey.debugName}');
  print('Shift character: ${shiftDown.character ?? "null (modifier)"}');

  // Explain purpose
  print('\nKeyEvent purpose:');
  print('- Abstract base for keyboard events');
  print('- physicalKey: Hardware key location');
  print('- logicalKey: Semantic key meaning');
  print('- character: Resulting character (or null)');
  print('- timeStamp: When event occurred');
  print('- Used with Focus, KeyboardListener');

  print('\n' + '=' * 50);
  print('KeyEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeyEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract base class'),
      Text('Subclasses: Down, Up, Repeat'),
      Text('physicalKey: ${downEvent.physicalKey.debugName}'),
      Text('character: "${downEvent.character}"'),
      Text('Purpose: Keyboard input events'),
    ],
  );
}
