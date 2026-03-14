// D4rt test script: Tests PointerEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEvent test executing');

  // Create a concrete PointerEvent (using PointerDownEvent)
  final event = PointerDownEvent(
    pointer: 1,
    position: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    buttons: kPrimaryButton,
    pressure: 1.0,
    pressureMin: 0.0,
    pressureMax: 1.0,
    device: 0,
    kind: ui.PointerDeviceKind.touch,
  );

  print('Created PointerDownEvent (subtype of PointerEvent)');
  print('Type: ${event.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('position: ${event.position}');
  print('localPosition: ${event.localPosition}');
  print('delta: ${event.delta}');
  print('localDelta: ${event.localDelta}');

  // Test pointer identification
  print('\nPointer identification:');
  print('pointer: ${event.pointer}');
  print('device: ${event.device}');
  print('kind: ${event.kind}');
  print('embedderId: ${event.embedderId}');

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

  // Test transform
  print('\nTransform:');
  print('transform: ${event.transform}');
  print('original: ${event.original}');

  // PointerEvent hierarchy
  print('\nPointerEvent hierarchy:');
  print('- PointerEvent (abstract base)');
  print('  - PointerDownEvent');
  print('  - PointerMoveEvent');
  print('  - PointerUpEvent');
  print('  - PointerCancelEvent');
  print('  - PointerHoverEvent');
  print('  - PointerScrollEvent');
  print('  - PointerPanZoomStartEvent');
  print('  - and more...');

  print('\nPointerEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Base class for all pointer events'),
      Text('position: ${event.position}'),
      Text('pointer: ${event.pointer}'),
      Text('kind: ${event.kind}'),
      Text('buttons: ${event.buttons}'),
      Text('pressure: ${event.pressure}'),
    ],
  );
}
