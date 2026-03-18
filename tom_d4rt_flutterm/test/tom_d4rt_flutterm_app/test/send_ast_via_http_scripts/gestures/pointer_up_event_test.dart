// D4rt test script: Tests PointerUpEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerUpEvent test executing');

  // Create PointerUpEvent
  final event = PointerUpEvent(
    pointer: 1,
    position: Offset(150.0, 250.0),
    device: 0,
    kind: ui.PointerDeviceKind.touch,
    pressure: 0.0, // Typically 0 when released
    timeStamp: Duration(milliseconds: 500),
  );

  print('Created: ${event.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('position: ${event.position}');
  print('delta: ${event.delta}');

  // Test pointer identification
  print('\nPointer identification:');
  print('pointer: ${event.pointer}');
  print('device: ${event.device}');
  print('kind: ${event.kind}');

  // Test button state
  print('\nButton state:');
  print('buttons: ${event.buttons}');
  print('down: ${event.down}');

  // Test pressure
  print('\nPressure:');
  print('pressure: ${event.pressure}');

  // Test timing
  print('\nTiming:');
  print('timeStamp: ${event.timeStamp}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is PointerEvent: ${event is PointerEvent}');
  print('PointerUpEvent extends PointerEvent');

  // Pointer event sequence
  print('\nPointer event sequence:');
  print('1. PointerDownEvent (press)');
  print('2. PointerMoveEvent (drag)');
  print('3. PointerUpEvent (release) <- this one');

  // Explain purpose
  print('\nPointerUpEvent purpose:');
  print('- Pointer released (finger lifted, click released)');
  print('- Marks end of touch/click interaction');
  print('- down property is always false');
  print('- Triggers tap/click recognition');

  // Usage context
  print('\nUsage context:');
  print('- GestureDetector.onTapUp');
  print('- Listener.onPointerUp');
  print('- End of drag operations');
  print('- Button release detection');

  print('\nPointerUpEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerUpEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Pointer released'),
      Text('position: ${event.position}'),
      Text('down: ${event.down} (always false)'),
      Text('Sequence: Down -> Move -> Up'),
    ],
  );
}
