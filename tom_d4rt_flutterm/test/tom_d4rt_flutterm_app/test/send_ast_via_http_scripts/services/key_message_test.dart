// ignore_for_file: avoid_print
// D4rt test script: Tests KeyMessage from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyMessage test executing');

  // Create a mock KeyEvent first
  final keyEvent = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 100),
  );

  print('KeyEvent created: ${keyEvent.runtimeType}');

  // Create KeyMessage
  final message = KeyMessage([keyEvent], null);

  print('Created: ${message.runtimeType}');

  // Test events property
  print('\nEvents property:');
  print('events length: ${message.events.length}');
  for (var i = 0; i < message.events.length; i++) {
    final event = message.events[i];
    print('event[$i]: ${event.runtimeType}');
  }

  // Test rawEvent
  print('\nRaw event:');
  print('rawEvent: ${message.rawEvent}');

  // Explain KeyMessage
  print('\nKeyMessage purpose:');
  print('- Wraps keyboard events from platform');
  print('- Contains list of KeyEvents');
  print('- Optionally contains raw event data');
  print('- Used by KeyEventManager');

  // Key event types
  print('\nKeyEvent types:');
  print('- KeyDownEvent: key pressed');
  print('- KeyUpEvent: key released');
  print('- KeyRepeatEvent: key held down');

  // Processing flow
  print('\nKey processing flow:');
  print('1. Platform sends raw key event');
  print('2. KeyEventManager creates KeyMessage');
  print('3. KeyEvents dispatched to handlers');
  print('4. Focus system routes to focused widget');

  print('\nKeyMessage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeyMessage Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Wraps platform key events'),
      Text('events: ${message.events.length}'),
      Text('event type: ${keyEvent.runtimeType}'),
      Text('Used by: KeyEventManager'),
    ],
  );
}
