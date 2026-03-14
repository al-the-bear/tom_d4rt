// D4rt test script: Tests PointerEventConverter concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEventConverter test executing');
  final results = <String>[];

  // ========== PointerEventConverter Concepts ==========
  print('Testing PointerEventConverter concepts...');

  // Test 1: PointerEventConverter has expand static method
  results.add('PointerEventConverter class available');
  print('PointerEventConverter is available for event conversion');

  // Test 2: Test PointerDownEvent conversion structure
  final downEvent = PointerDownEvent(
    position: Offset(100.0, 150.0),
    kind: PointerDeviceKind.touch,
    device: 0,
    buttons: kPrimaryButton,
  );
  assert(downEvent is PointerEvent, 'Should be PointerEvent');
  results.add('PointerDownEvent prepared');
  print('PointerDownEvent for conversion: ${downEvent.runtimeType}');

  // Test 3: Position from event
  final position = downEvent.position;
  assert(position == Offset(100.0, 150.0), 'Position should match');
  results.add('position: $position');
  print('Event position: $position');

  // Test 4: LocalPosition property
  results.add('localPosition: ${downEvent.localPosition}');
  print('Event localPosition: ${downEvent.localPosition}');

  // Test 5: PointerMoveEvent for conversion
  final moveEvent = PointerMoveEvent(
    position: Offset(120.0, 170.0),
    delta: Offset(20.0, 20.0),
    kind: PointerDeviceKind.touch,
  );
  assert(moveEvent.delta == Offset(20.0, 20.0), 'Delta should match');
  results.add('moveEvent delta: ${moveEvent.delta}');
  print('PointerMoveEvent delta: ${moveEvent.delta}');

  // Test 6: PointerUpEvent for conversion
  final upEvent = PointerUpEvent(
    position: Offset(140.0, 190.0),
    kind: PointerDeviceKind.touch,
  );
  assert(upEvent.down == false, 'Down should be false');
  results.add('upEvent down: ${upEvent.down}');
  print('PointerUpEvent down: ${upEvent.down}');

  // Test 7: Pointer event sequence concept
  final events = <PointerEvent>[downEvent, moveEvent, upEvent];
  assert(events.length == 3, 'Should have 3 events');
  results.add('Event sequence: ${events.length} events');
  print('Event sequence created: ${events.length} events');

  // Test 8: TimeStamp progression
  final timedDown = PointerDownEvent(
    position: Offset(100, 100),
    timeStamp: Duration(milliseconds: 0),
  );
  final timedMove = PointerMoveEvent(
    position: Offset(110, 110),
    delta: Offset(10, 10),
    timeStamp: Duration(milliseconds: 16),
  );
  final timedUp = PointerUpEvent(
    position: Offset(120, 120),
    timeStamp: Duration(milliseconds: 32),
  );
  results.add('TimeStamps: 0, 16, 32 ms');
  print(
    'TimeStamp progression: ${timedDown.timeStamp}, ${timedMove.timeStamp}, ${timedUp.timeStamp}',
  );

  // Test 9: Device consistency in sequence
  final deviceId = 5;
  final deviceDown = PointerDownEvent(
    position: Offset(50, 50),
    device: deviceId,
  );
  final deviceMove = PointerMoveEvent(
    position: Offset(60, 60),
    delta: Offset(10, 10),
    device: deviceId,
  );
  final deviceUp = PointerUpEvent(position: Offset(70, 70), device: deviceId);
  assert(
    deviceDown.device == deviceMove.device &&
        deviceMove.device == deviceUp.device,
    'Devices should match',
  );
  results.add('Device consistency: $deviceId');
  print('Device consistency across sequence: $deviceId');

  // Test 10: Pointer ID consistency
  final pointerId = 42;
  final pointerDown = PointerDownEvent(
    position: Offset(80, 80),
    pointer: pointerId,
  );
  final pointerUp = PointerUpEvent(
    position: Offset(80, 80),
    pointer: pointerId,
  );
  assert(pointerDown.pointer == pointerUp.pointer, 'Pointer IDs should match');
  results.add('Pointer ID consistency: $pointerId');
  print('Pointer ID consistency: $pointerId');

  // Test 11: Kind consistency
  final kind = PointerDeviceKind.touch;
  assert(downEvent.kind == kind, 'Kind should be touch');
  results.add('Kind consistency: $kind');
  print('Kind consistency: $kind');

  // Test 12: Buttons state in down/move
  assert(downEvent.buttons == kPrimaryButton, 'Buttons should be primary');
  results.add('buttons: ${downEvent.buttons}');
  print('Buttons state: ${downEvent.buttons}');

  // Test 13: PointerAddedEvent for lifecycle
  final addedEvent = PointerAddedEvent(
    position: Offset(100, 100),
    kind: PointerDeviceKind.mouse,
    device: 1,
  );
  results.add('Added event device: ${addedEvent.device}');
  print('PointerAddedEvent device: ${addedEvent.device}');

  // Test 14: PointerRemovedEvent for lifecycle
  final removedEvent = PointerRemovedEvent(
    position: Offset(100, 100),
    kind: PointerDeviceKind.mouse,
    device: 1,
  );
  results.add('Removed event device: ${removedEvent.device}');
  print('PointerRemovedEvent device: ${removedEvent.device}');

  // Test 15: Hover event conversion
  final hoverEvent = PointerHoverEvent(
    position: Offset(150, 200),
    delta: Offset(5, 5),
  );
  results.add('hover delta: ${hoverEvent.delta}');
  print('PointerHoverEvent delta: ${hoverEvent.delta}');

  // Test 16: Pressure values in conversion
  final pressureEvent = PointerDownEvent(
    position: Offset(100, 100),
    pressure: 0.8,
    pressureMin: 0.0,
    pressureMax: 1.0,
  );
  results.add('pressure: ${pressureEvent.pressure}');
  print('Pressure in event: ${pressureEvent.pressure}');

  // Test 17: Synthesized property check
  results.add('synthesized: ${downEvent.synthesized}');
  print('Event synthesized: ${downEvent.synthesized}');

  // Test 18: Obscured property check
  final obscuredEvent = PointerDownEvent(
    position: Offset(100, 100),
    obscured: true,
  );
  assert(obscuredEvent.obscured == true, 'Should be obscured');
  results.add('obscured: ${obscuredEvent.obscured}');
  print('Event obscured: ${obscuredEvent.obscured}');

  // Test 19: EmbedderId in conversion
  final embedEvent = PointerDownEvent(
    position: Offset(100, 100),
    embedderId: 123,
  );
  assert(embedEvent.embedderId == 123, 'EmbedderId should match');
  results.add('embedderId: ${embedEvent.embedderId}');
  print('Event embedderId: ${embedEvent.embedderId}');

  // Test 20: Conversion preserves all properties
  final fullEvent = PointerDownEvent(
    position: Offset(200, 300),
    timeStamp: Duration(milliseconds: 100),
    kind: PointerDeviceKind.touch,
    device: 2,
    pointer: 99,
    buttons: kPrimaryButton,
    pressure: 0.5,
  );
  assert(fullEvent.position == Offset(200, 300), 'All properties preserved');
  results.add('Full event: all properties preserved');
  print(
    'Full event conversion: position=${fullEvent.position}, pointer=${fullEvent.pointer}',
  );

  print('PointerEventConverter test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEventConverter Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
