// D4rt test script: Tests PointerSignalEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerSignalEvent test executing');

  // PointerSignalEvent is abstract, use concrete subtype
  final scrollEvent = PointerScrollEvent(
    position: Offset(100.0, 200.0),
    scrollDelta: Offset(0.0, -20.0),
    device: 0,
    kind: ui.PointerDeviceKind.mouse,
    timeStamp: Duration.zero,
  );

  print('PointerSignalEvent is abstract base class');
  print('Using PointerScrollEvent for testing: ${scrollEvent.runtimeType}');

  // Test if it's a PointerSignalEvent
  print('\nType checks:');
  print('is PointerSignalEvent: ${scrollEvent is PointerSignalEvent}');
  print('is PointerEvent: ${scrollEvent is PointerEvent}');

  // Test position properties
  print('\nPosition properties (inherited):');
  print('position: ${scrollEvent.position}');
  print('localPosition: ${scrollEvent.localPosition}');

  // Test pointer identification
  print('\nPointer identification (inherited):');
  print('device: ${scrollEvent.device}');
  print('kind: ${scrollEvent.kind}');

  // PointerSignalEvent hierarchy
  print('\nPointerSignalEvent subclasses:');
  print('- PointerScrollEvent: mouse wheel, trackpad scroll');
  print('- PointerScaleEvent: trackpad pinch zoom');
  print('- PointerScrollInertiaCancelEvent: stop momentum');

  // Explain purpose
  print('\nPointerSignalEvent purpose:');
  print('- Abstract base for pointer signals');
  print('- Signals don\'t have press/release state');
  print('- Handled via Listener.onPointerSignal');
  print('- Bypass gesture recognition system');

  // Difference from regular pointer events
  print('\nSignal vs regular events:');
  print('Regular: down->move->up sequence');
  print('Signal: discrete events, no sequence');
  print('Signal: scrolling, scaling, etc.');

  print('\nPointerSignalEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerSignalEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract base class'),
      Text('Subclasses: Scroll, Scale, InertiaCancl'),
      Text('Discrete events (no sequence)'),
      Text('Handler: Listener.onPointerSignal'),
    ],
  );
}
