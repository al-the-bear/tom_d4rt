// D4rt test script: Tests PointerEvent base class concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEvent base class concepts test executing');
  final results = <String>[];

  // ========== PointerEvent Base Class Concepts ==========
  // PointerEvent is abstract, test via concrete subclasses
  print('Testing PointerEvent concepts via concrete implementations...');

  // Test 1: PointerDownEvent as PointerEvent
  final downEvent = PointerDownEvent(
    position: Offset(100.0, 200.0),
    kind: PointerDeviceKind.touch,
    device: 0,
    buttons: kPrimaryButton,
    pressure: 0.5,
    pressureMin: 0.0,
    pressureMax: 1.0,
  );
  assert(downEvent is PointerEvent, 'PointerDownEvent should be PointerEvent');
  results.add('PointerDownEvent is PointerEvent: true');
  print('PointerDownEvent is PointerEvent: true');

  // Test 2: Position property
  assert(downEvent.position == Offset(100.0, 200.0), 'Position should match');
  results.add('position: ${downEvent.position}');
  print('Event position: ${downEvent.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${downEvent.localPosition}');
  print('Event localPosition: ${downEvent.localPosition}');

  // Test 4: PointerDeviceKind enumeration
  assert(downEvent.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('kind: ${downEvent.kind}');
  print('Event kind: ${downEvent.kind}');

  // Test 5: Device identifier
  assert(downEvent.device == 0, 'Device ID should be 0');
  results.add('device: ${downEvent.device}');
  print('Event device: ${downEvent.device}');

  // Test 6: Buttons property
  assert(downEvent.buttons == kPrimaryButton, 'Buttons should be primary');
  results.add('buttons: ${downEvent.buttons}');
  print('Event buttons: ${downEvent.buttons}');

  // Test 7: Pressure properties
  assert(downEvent.pressure == 0.5, 'Pressure should be 0.5');
  assert(downEvent.pressureMin == 0.0, 'PressureMin should be 0.0');
  assert(downEvent.pressureMax == 1.0, 'PressureMax should be 1.0');
  results.add('pressure: ${downEvent.pressure}');
  print('Event pressure: ${downEvent.pressure}, min: ${downEvent.pressureMin}, max: ${downEvent.pressureMax}');

  // Test 8: TimeStamp property
  results.add('timeStamp: ${downEvent.timeStamp}');
  print('Event timeStamp: ${downEvent.timeStamp}');

  // Test 9: Down property
  assert(downEvent.down == true, 'Down should be true for PointerDownEvent');
  results.add('down: ${downEvent.down}');
  print('Event down: ${downEvent.down}');

  // Test 10: PointerMoveEvent as PointerEvent
  final moveEvent = PointerMoveEvent(
    position: Offset(150.0, 250.0),
    delta: Offset(50.0, 50.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(moveEvent is PointerEvent, 'PointerMoveEvent should be PointerEvent');
  results.add('PointerMoveEvent is PointerEvent: true');
  print('PointerMoveEvent is PointerEvent: true');

  // Test 11: Delta property on move event
  assert(moveEvent.delta == Offset(50.0, 50.0), 'Delta should match');
  results.add('delta: ${moveEvent.delta}');
  print('Move event delta: ${moveEvent.delta}');

  // Test 12: PointerUpEvent as PointerEvent
  final upEvent = PointerUpEvent(
    position: Offset(200.0, 300.0),
    kind: PointerDeviceKind.touch,
  );
  assert(upEvent is PointerEvent, 'PointerUpEvent should be PointerEvent');
  assert(upEvent.down == false, 'Down should be false for PointerUpEvent');
  results.add('PointerUpEvent down: ${upEvent.down}');
  print('PointerUpEvent down: ${upEvent.down}');

  // Test 13: PointerDeviceKind enum values
  final kindValues = PointerDeviceKind.values;
  assert(kindValues.contains(PointerDeviceKind.touch), 'Should have touch');
  assert(kindValues.contains(PointerDeviceKind.mouse), 'Should have mouse');
  assert(kindValues.contains(PointerDeviceKind.stylus), 'Should have stylus');
  results.add('PointerDeviceKind count: ${kindValues.length}');
  print('PointerDeviceKind values: $kindValues');

  // Test 14: Pointer with stylus kind
  final stylusEvent = PointerDownEvent(
    position: Offset(50.0, 50.0),
    kind: PointerDeviceKind.stylus,
    tilt: 0.3,
  );
  assert(stylusEvent.kind == PointerDeviceKind.stylus, 'Kind should be stylus');
  results.add('Stylus tilt: ${stylusEvent.tilt}');
  print('Stylus event tilt: ${stylusEvent.tilt}');

  // Test 15: Pointer with specific device ID
  final deviceEvent = PointerDownEvent(
    position: Offset(75.0, 125.0),
    device: 42,
    kind: PointerDeviceKind.touch,
  );
  assert(deviceEvent.device == 42, 'Device should be 42');
  results.add('Custom device ID: ${deviceEvent.device}');
  print('Event with device ID 42: ${deviceEvent.device}');

  // Test 16: Obscured property
  results.add('obscured: ${downEvent.obscured}');
  print('Event obscured: ${downEvent.obscured}');

  // Test 17: Synthesized property
  results.add('synthesized: ${downEvent.synthesized}');
  print('Event synthesized: ${downEvent.synthesized}');

  // Test 18: Embdder ID
  results.add('embedderId: ${downEvent.embedderId}');
  print('Event embedderId: ${downEvent.embedderId}');

  // Test 19: Pointer ID
  results.add('pointer: ${downEvent.pointer}');
  print('Event pointer ID: ${downEvent.pointer}');

  // Test 20: Distance and distanceMax
  results.add('distance: ${downEvent.distance}');
  print('Event distance: ${downEvent.distance}, distanceMax: ${downEvent.distanceMax}');

  print('PointerEvent base class test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEvent Base Class Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
