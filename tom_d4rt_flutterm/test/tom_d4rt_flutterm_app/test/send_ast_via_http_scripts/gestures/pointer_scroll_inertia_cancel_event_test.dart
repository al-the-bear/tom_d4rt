// D4rt test script: Tests PointerScrollInertiaCancelEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScrollInertiaCancelEvent test executing');

  // Create PointerScrollInertiaCancelEvent
  final event = PointerScrollInertiaCancelEvent(
    pointer: 0,
    position: Offset(100.0, 200.0),
    device: 0,
    kind: ui.PointerDeviceKind.trackpad,
    timeStamp: Duration.zero,
  );

  print('Created: ${event.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('position: ${event.position}');
  print('localPosition: ${event.localPosition}');

  // Test pointer identification
  print('\nPointer identification:');
  print('pointer: ${event.pointer}');
  print('device: ${event.device}');
  print('kind: ${event.kind}');

  // Test event state
  print('\nEvent state:');
  print('down: ${event.down}');
  print('timeStamp: ${event.timeStamp}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is PointerEvent: ${event is PointerEvent}');
  print('is PointerSignalEvent: ${event is PointerSignalEvent}');
  print('PointerScrollInertiaCancelEvent extends PointerSignalEvent');

  // Signal events family
  print('\nPointerSignalEvent family:');
  print('- PointerScrollEvent: wheel scroll');
  print('- PointerScaleEvent: pinch zoom');
  print('- PointerScrollInertiaCancelEvent: cancel momentum (this one)');

  // Explain purpose
  print('\nPointerScrollInertiaCancelEvent purpose:');
  print('- Cancels ongoing scroll inertia/momentum');
  print('- Sent when user touches trackpad during momentum');
  print('- Stops kinetic scrolling immediately');
  print('- Platform signal for scroll interrupt');

  // Usage context
  print('\nUsage context:');
  print('- User touches scrolling list mid-momentum');
  print('- Prevents content flying past target');
  print('- Trackpad gesture interruption');
  print('- Native scroll behavior integration');

  print('\nPointerScrollInertiaCancelEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerScrollInertiaCancelEvent',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      Text('Cancels scroll momentum'),
      Text('position: ${event.position}'),
      Text('kind: ${event.kind}'),
      Text('Extends: PointerSignalEvent'),
    ],
  );
}
