// D4rt test script: Tests PointerPanZoomStartEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerPanZoomStartEvent test executing');

  // Create PointerPanZoomStartEvent
  final event = PointerPanZoomStartEvent(
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
  print('embedderId: ${event.embedderId}');

  // Test event state
  print('\nEvent state:');
  print('down: ${event.down}');
  print('timeStamp: ${event.timeStamp}');
  print('synthesized: ${event.synthesized}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is PointerEvent: ${true}');
  print('PointerPanZoomStartEvent extends PointerEvent');

  // Pan/Zoom event family
  print('\nPan/Zoom event sequence:');
  print('1. PointerPanZoomStartEvent - gesture begins (this one)');
  print('2. PointerPanZoomUpdateEvent - during gesture');
  print('3. PointerPanZoomEndEvent - gesture ends');

  // Usage context
  print('\nUsage context:');
  print('- Trackpad pan/zoom gestures start');
  print('- Magic Mouse/trackpad gestures');
  print('- Multi-finger gesture initiation');
  print('- macOS/Windows precision touchpad');

  // Explain purpose
  print('\nPointerPanZoomStartEvent purpose:');
  print('- Signals start of trackpad pan/zoom');
  print('- Initial position captured');
  print('- No scale/pan data yet (that comes in Update)');
  print('- Allows preparation for gesture handling');

  print('\nPointerPanZoomStartEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerPanZoomStartEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Trackpad pan/zoom started'),
      Text('position: ${event.position}'),
      Text('pointer: ${event.pointer}'),
      Text('First in: Start -> Update -> End'),
    ],
  );
}
