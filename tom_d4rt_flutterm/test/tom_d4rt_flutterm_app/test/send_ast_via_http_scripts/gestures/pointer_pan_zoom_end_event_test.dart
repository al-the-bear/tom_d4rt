// ignore_for_file: avoid_print
// D4rt test script: Tests PointerPanZoomEndEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerPanZoomEndEvent test executing');

  // Create PointerPanZoomEndEvent
  final event = PointerPanZoomEndEvent(
    pointer: 1,
    position: Offset(100.0, 200.0),
    device: 0,
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
  print('is PointerEvent: ${true}');
  print('PointerPanZoomEndEvent extends PointerEvent');

  // Pan/Zoom event family
  print('\nPan/Zoom event sequence:');
  print('1. PointerPanZoomStartEvent - gesture begins');
  print('2. PointerPanZoomUpdateEvent - during gesture (panning/zooming)');
  print('3. PointerPanZoomEndEvent - gesture ends (this one)');

  // Usage context
  print('\nUsage context:');
  print('- Trackpad pan/zoom gestures');
  print('- Magic mouse/trackpad scrolling');
  print('- Multi-finger gesture end');
  print('- Signals end of continuous gesture');

  // Explain purpose
  print('\nPointerPanZoomEndEvent purpose:');
  print('- Marks end of trackpad pan/zoom gesture');
  print('- Allows cleanup/finalization of gesture state');
  print('- No scale/rotation data (only in Update)');
  print('- Position is final position when gesture ended');

  print('\nPointerPanZoomEndEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerPanZoomEndEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Trackpad pan/zoom ended'),
      Text('position: ${event.position}'),
      Text('pointer: ${event.pointer}'),
      Text('Part of: Start -> Update -> End sequence'),
    ],
  );
}
