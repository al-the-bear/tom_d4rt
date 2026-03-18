// D4rt test script: Tests PointerMoveEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerMoveEvent test executing');

  // Create PointerMoveEvent
  final event = PointerMoveEvent(
    pointer: 1,
    position: Offset(200.0, 300.0),
    delta: Offset(10.0, 15.0),
    buttons: kPrimaryButton,
    pressure: 0.8,
    pressureMin: 0.0,
    pressureMax: 1.0,
    device: 0,
    kind: ui.PointerDeviceKind.touch,
    timeStamp: Duration(milliseconds: 100),
  );

  print('Created: ${event.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('position: ${event.position}');
  print('delta: ${event.delta}');
  print('localDelta: ${event.localDelta}');

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
  print('\nPressure info:');
  print('pressure: ${event.pressure}');
  print('pressureMin: ${event.pressureMin}');
  print('pressureMax: ${event.pressureMax}');

  // Test timing
  print('\nTiming:');
  print('timeStamp: ${event.timeStamp}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is PointerEvent: ${event is PointerEvent}');
  print('PointerMoveEvent extends PointerEvent');

  // Explain purpose
  print('\nPointerMoveEvent purpose:');
  print('- Pointer moved while pressed (touch) or button held (mouse)');
  print('- Used for drag gesture detection');
  print('- Contains delta of movement');
  print('- down property is always true');

  // Usage context
  print('\nUsage context:');
  print('- GestureDetector.onPanUpdate');
  print('- Listener.onPointerMove');
  print('- Drag and drawing operations');
  print('- Touch/pen stroke tracking');

  print('\nPointerMoveEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerMoveEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Pointer moving, IS pressed'),
      Text('position: ${event.position}'),
      Text('delta: ${event.delta}'),
      Text('down: ${event.down} (always true)'),
      Text('pressure: ${event.pressure}'),
      Text('vs PointerHoverEvent: down=false'),
    ],
  );
}
