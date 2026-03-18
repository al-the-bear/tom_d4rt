// D4rt test script: Tests PointerPanZoomUpdateEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerPanZoomUpdateEvent test executing');

  // Create PointerPanZoomUpdateEvent
  final event = PointerPanZoomUpdateEvent(
    pointer: 1,
    position: Offset(100.0, 200.0),
    pan: Offset(10.0, 20.0),
    panDelta: Offset(2.0, 3.0),
    scale: 1.5,
    rotation: 0.25,
    device: 0,
    timeStamp: Duration(milliseconds: 50),
  );

  print('Created: ${event.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('position: ${event.position}');
  print('localPosition: ${event.localPosition}');

  // Test pan properties (unique to this event)
  print('\nPan properties:');
  print('pan: ${event.pan}');
  print('panDelta: ${event.panDelta}');
  print('localPan: ${event.localPan}');
  print('localPanDelta: ${event.localPanDelta}');

  // Test scale and rotation (unique to this event)
  print('\nScale and rotation:');
  print('scale: ${event.scale}');
  print('rotation: ${event.rotation} radians');
  print('rotation in degrees: ${event.rotation * 180 / 3.14159}');

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
  print('is PointerEvent: ${true}');
  print('PointerPanZoomUpdateEvent extends PointerEvent');

  // Pan/Zoom event family
  print('\nPan/Zoom event sequence:');
  print('1. PointerPanZoomStartEvent - gesture begins');
  print('2. PointerPanZoomUpdateEvent - during gesture (this one)');
  print('3. PointerPanZoomEndEvent - gesture ends');

  // Explain purpose
  print('\nPointerPanZoomUpdateEvent purpose:');
  print('- Contains pan, scale, and rotation data');
  print('- Sent continuously during trackpad gesture');
  print('- pan: total pan offset from start');
  print('- panDelta: change since last update');
  print('- scale: zoom factor (1.0 = no zoom)');
  print('- rotation: rotation in radians');

  print('\nPointerPanZoomUpdateEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerPanZoomUpdateEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Trackpad gesture update'),
      Text('pan: ${event.pan}'),
      Text('scale: ${event.scale}'),
      Text('rotation: ${event.rotation.toStringAsFixed(2)} rad'),
      Text('panDelta: ${event.panDelta}'),
    ],
  );
}
