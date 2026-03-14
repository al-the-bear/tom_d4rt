// D4rt test script: Tests PointerUpEvent concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerUpEvent test executing');
  final results = <String>[];

  // ========== PointerUpEvent Tests ==========
  print('Testing PointerUpEvent...');

  // Test 1: Create basic PointerUpEvent
  final upEvent1 = PointerUpEvent(
    position: Offset(250.0, 350.0),
  );
  assert(upEvent1 is PointerEvent, 'Should be PointerEvent');
  results.add('PointerUpEvent created');
  print('PointerUpEvent created: ${upEvent1.runtimeType}');

  // Test 2: Position property
  assert(upEvent1.position == Offset(250.0, 350.0), 'Position should match');
  results.add('position: ${upEvent1.position}');
  print('Up event position: ${upEvent1.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${upEvent1.localPosition}');
  print('Up event localPosition: ${upEvent1.localPosition}');

  // Test 4: Down property should be false
  assert(upEvent1.down == false, 'Down should be false for up event');
  results.add('down: ${upEvent1.down}');
  print('Up event down: ${upEvent1.down}');

  // Test 5: Up with touch kind
  final upTouch = PointerUpEvent(
    position: Offset(180.0, 220.0),
    kind: PointerDeviceKind.touch,
  );
  assert(upTouch.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('touch kind: ${upTouch.kind}');
  print('Up event with touch kind: ${upTouch.kind}');

  // Test 6: Up with mouse kind
  final upMouse = PointerUpEvent(
    position: Offset(120.0, 140.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(upMouse.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('mouse kind: ${upMouse.kind}');
  print('Up event with mouse kind: ${upMouse.kind}');

  // Test 7: TimeStamp property
  final upTime = PointerUpEvent(
    position: Offset(90.0, 110.0),
    timeStamp: Duration(milliseconds: 1500),
  );
  assert(upTime.timeStamp == Duration(milliseconds: 1500), 'TimeStamp should match');
  results.add('timeStamp: ${upTime.timeStamp}');
  print('Up event timeStamp: ${upTime.timeStamp}');

  // Test 8: Device property
  final upDevice = PointerUpEvent(
    position: Offset(200.0, 240.0),
    device: 11,
  );
  assert(upDevice.device == 11, 'Device should be 11');
  results.add('device: ${upDevice.device}');
  print('Up event device: ${upDevice.device}');

  // Test 9: Buttons property (should be 0 for up)
  results.add('buttons: ${upEvent1.buttons}');
  print('Up event buttons: ${upEvent1.buttons}');

  // Test 10: Pointer ID
  final upPointer = PointerUpEvent(
    position: Offset(70.0, 85.0),
    pointer: 77,
  );
  assert(upPointer.pointer == 77, 'Pointer should be 77');
  results.add('pointer: ${upPointer.pointer}');
  print('Up event pointer: ${upPointer.pointer}');

  // Test 11: Pressure (typically 0 for up event)
  final upPressure = PointerUpEvent(
    position: Offset(130.0, 155.0),
    pressure: 0.0,
  );
  assert(upPressure.pressure == 0.0, 'Pressure should be 0');
  results.add('pressure: ${upPressure.pressure}');
  print('Up event pressure: ${upPressure.pressure}');

  // Test 12: Stylus up event
  final upStylus = PointerUpEvent(
    position: Offset(160.0, 190.0),
    kind: PointerDeviceKind.stylus,
  );
  assert(upStylus.kind == PointerDeviceKind.stylus, 'Kind should be stylus');
  results.add('stylus kind: ${upStylus.kind}');
  print('Up event stylus kind: ${upStylus.kind}');

  // Test 13: Synthesized property
  results.add('synthesized: ${upEvent1.synthesized}');
  print('Up event synthesized: ${upEvent1.synthesized}');

  // Test 14: Obscured property
  final upObscured = PointerUpEvent(
    position: Offset(105.0, 125.0),
    obscured: true,
  );
  assert(upObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${upObscured.obscured}');
  print('Up event obscured: ${upObscured.obscured}');

  // Test 15: EmbedderId property
  final upEmbed = PointerUpEvent(
    position: Offset(55, 65),
    embedderId: 321,
  );
  assert(upEmbed.embedderId == 321, 'EmbedderId should be 321');
  results.add('embedderId: ${upEmbed.embedderId}');
  print('Up event embedderId: ${upEmbed.embedderId}');

  // Test 16: Down/Up event pair pattern
  final downEvent = PointerDownEvent(position: Offset(100, 100));
  final upEventPair = PointerUpEvent(position: Offset(100, 100));
  assert(downEvent.down == true && upEventPair.down == false, 'Down/Up pattern');
  results.add('Down/Up pair verified');
  print('Down/Up event pair: down=${downEvent.down}, up=${upEventPair.down}');

  // Test 17: Position comparison between events
  final downPos = Offset(150, 200);
  final upPos = Offset(155, 205);
  final drift = upPos - downPos;
  results.add('drift: $drift');
  print('Position drift from down to up: $drift');

  // Test 18: Distance properties
  results.add('distance: ${upEvent1.distance}');
  print('Up event distance: ${upEvent1.distance}');

  // Test 19: Multiple up events
  final upA = PointerUpEvent(position: Offset(10, 10), pointer: 1);
  final upB = PointerUpEvent(position: Offset(20, 20), pointer: 2);
  assert(upA.pointer != upB.pointer, 'Pointers should differ');
  results.add('Different pointers: ${upA.pointer} vs ${upB.pointer}');
  print('Multiple up events with different pointers');

  // Test 20: Size property
  final upSize = PointerUpEvent(
    position: Offset(220, 270),
    size: 1.2,
  );
  results.add('size: ${upSize.size}');
  print('Up event size: ${upSize.size}');

  print('PointerUpEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerUpEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
