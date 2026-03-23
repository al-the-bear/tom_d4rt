// ignore_for_file: avoid_print
// D4rt test script: Tests AndroidMotionEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AndroidMotionEvent test executing');

  // Create AndroidMotionEvent
  final event = AndroidMotionEvent(
    downTime: 100,
    eventTime: 150,
    action: 0, // ACTION_DOWN
    pointerCount: 1,
    pointerProperties: [AndroidPointerProperties(id: 0, toolType: 1)],
    pointerCoords: [
      AndroidPointerCoords(
        orientation: 0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 10.0,
        touchMinor: 10.0,
        x: 100.0,
        y: 200.0,
      ),
    ],
    metaState: 0,
    buttonState: 0,
    xPrecision: 1.0,
    yPrecision: 1.0,
    deviceId: 0,
    edgeFlags: 0,
    source: 4098,
    flags: 0,
    motionEventId: 1,
  );

  print('Created: ${event.runtimeType}');

  // Test properties
  print('\nEvent properties:');
  print('downTime: ${event.downTime}');
  print('eventTime: ${event.eventTime}');
  print('action: ${event.action}');
  print('pointerCount: ${event.pointerCount}');

  // Test pointer coords
  print('\nPointer coordinates:');
  final coords = event.pointerCoords[0];
  print('x: ${coords.x}');
  print('y: ${coords.y}');
  print('pressure: ${coords.pressure}');

  // Action constants
  print('\nAction constants:');
  print('ACTION_DOWN: 0');
  print('ACTION_UP: 1');
  print('ACTION_MOVE: 2');
  print('ACTION_CANCEL: 3');

  // Purpose
  print('\nAndroidMotionEvent purpose:');
  print('- Used by AndroidView');
  print('- Forwads touch to native view');
  print('- Matches Android MotionEvent');

  print('\nAndroidMotionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AndroidMotionEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Android touch events'),
      Text('action: ${event.action}'),
      Text('x: ${coords.x}, y: ${coords.y}'),
      Text('Used by: AndroidView'),
    ],
  );
}
