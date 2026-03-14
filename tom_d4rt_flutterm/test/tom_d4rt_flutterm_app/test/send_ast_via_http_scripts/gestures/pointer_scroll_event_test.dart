// D4rt test script: Tests PointerScrollEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScrollEvent test executing');

  // Create PointerScrollEvent
  final event = PointerScrollEvent(
    pointer: 0,
    position: Offset(100.0, 200.0),
    scrollDelta: Offset(0.0, -50.0), // Scroll up
    device: 0,
    kind: ui.PointerDeviceKind.mouse,
    timeStamp: Duration.zero,
  );

  print('Created: ${event.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('position: ${event.position}');
  print('localPosition: ${event.localPosition}');

  // Test scroll delta (unique to this event)
  print('\nScroll delta:');
  print('scrollDelta: ${event.scrollDelta}');
  print('scrollDelta.dx: ${event.scrollDelta.dx} (horizontal)');
  print('scrollDelta.dy: ${event.scrollDelta.dy} (vertical)');
  print('Negative dy = scroll up');
  print('Positive dy = scroll down');

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
  print('PointerScrollEvent extends PointerSignalEvent');

  // Signal events family
  print('\nPointerSignalEvent family:');
  print('- PointerScrollEvent: wheel scroll (this one)');
  print('- PointerScaleEvent: pinch zoom');
  print('- PointerScrollInertiaCancelEvent: cancel momentum');

  // Explain purpose
  print('\nPointerScrollEvent purpose:');
  print('- Mouse wheel scrolling');
  print('- Trackpad two-finger scroll');
  print('- scrollDelta: distance scrolled');
  print('- Used for ScrollView, ListView, etc.');

  // Usage context
  print('\nUsage context:');
  print('- Listener.onPointerSignal callback');
  print('- Scrollable widgets automatically handle');
  print('- Custom scroll implementations');
  print('- Zoom on scroll with ctrl/cmd key');

  print('\nPointerScrollEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerScrollEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Mouse/trackpad scroll'),
      Text('scrollDelta: ${event.scrollDelta}'),
      Text('position: ${event.position}'),
      Text('kind: ${event.kind}'),
      Text('Extends: PointerSignalEvent'),
    ],
  );
}
