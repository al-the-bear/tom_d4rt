// D4rt test script: Tests PointerScaleEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScaleEvent test executing');

  // Create PointerScaleEvent
  final event = PointerScaleEvent(
    pointer: 1,
    position: Offset(100.0, 200.0),
    scale: 1.5,
    device: 0,
    kind: ui.PointerDeviceKind.trackpad,
    timeStamp: Duration.zero,
  );

  print('Created: ${event.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('position: ${event.position}');
  print('localPosition: ${event.localPosition}');

  // Test scale property (unique to this event)
  print('\nScale property:');
  print('scale: ${event.scale}');
  print('scale > 1.0: zoom in');
  print('scale < 1.0: zoom out');
  print('scale = 1.0: no change');

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
  print('PointerScaleEvent extends PointerSignalEvent');

  // Signal events family
  print('\nPointerSignalEvent family:');
  print('- PointerScrollEvent: wheel scroll');
  print('- PointerScaleEvent: pinch zoom (this one)');
  print('- PointerScrollInertiaCancelEvent: cancel inertia');

  // Explain purpose
  print('\nPointerScaleEvent purpose:');
  print('- Represents pinch-to-zoom on trackpad');
  print('- scale: relative zoom factor');
  print('- Used with precision trackpads');
  print('- Independent of touch gestures');

  // Usage context
  print('\nUsage context:');
  print('- Trackpad pinch zoom');
  print('- Magic Mouse magnification');
  print('- Map/image zoom controls');
  print('- Canvas zoom operations');

  print('\nPointerScaleEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerScaleEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Trackpad scale/zoom'),
      Text('scale: ${event.scale}'),
      Text('position: ${event.position}'),
      Text('kind: ${event.kind}'),
      Text('Extends: PointerSignalEvent'),
    ],
  );
}
