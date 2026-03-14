// D4rt test script: Tests PointerScrollInertiaCancelEvent concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScrollInertiaCancelEvent test executing');
  final results = <String>[];

  // ========== PointerScrollInertiaCancelEvent Tests ==========
  print('Testing PointerScrollInertiaCancelEvent...');

  // Test 1: Create basic PointerScrollInertiaCancelEvent
  final cancelEvent1 = PointerScrollInertiaCancelEvent(
    position: Offset(200.0, 250.0),
  );
  assert(cancelEvent1 is PointerEvent, 'Should be PointerEvent');
  assert(cancelEvent1 is PointerSignalEvent, 'Should be PointerSignalEvent');
  results.add('PointerScrollInertiaCancelEvent created');
  print('PointerScrollInertiaCancelEvent created: ${cancelEvent1.runtimeType}');

  // Test 2: Position property
  assert(
    cancelEvent1.position == Offset(200.0, 250.0),
    'Position should match',
  );
  results.add('position: ${cancelEvent1.position}');
  print('Cancel event position: ${cancelEvent1.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${cancelEvent1.localPosition}');
  print('Cancel event localPosition: ${cancelEvent1.localPosition}');

  // Test 4: TimeStamp property
  final cancelTime = PointerScrollInertiaCancelEvent(
    position: Offset(150.0, 180.0),
    timeStamp: Duration(milliseconds: 800),
  );
  assert(
    cancelTime.timeStamp == Duration(milliseconds: 800),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${cancelTime.timeStamp}');
  print('Cancel event timeStamp: ${cancelTime.timeStamp}');

  // Test 5: Device property
  final cancelDevice = PointerScrollInertiaCancelEvent(
    position: Offset(170.0, 200.0),
    device: 6,
  );
  assert(cancelDevice.device == 6, 'Device should be 6');
  results.add('device: ${cancelDevice.device}');
  print('Cancel event device: ${cancelDevice.device}');

  // Test 6: Pointer ID
  final cancelPointer = PointerScrollInertiaCancelEvent(
    position: Offset(120.0, 150.0),
    pointer: 88,
  );
  assert(cancelPointer.pointer == 88, 'Pointer should be 88');
  results.add('pointer: ${cancelPointer.pointer}');
  print('Cancel event pointer: ${cancelPointer.pointer}');

  // Test 7: Kind property
  final cancelKind = PointerScrollInertiaCancelEvent(
    position: Offset(140.0, 170.0),
    kind: PointerDeviceKind.trackpad,
  );
  assert(
    cancelKind.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('kind: ${cancelKind.kind}');
  print('Cancel event kind: ${cancelKind.kind}');

  // Test 8: Down property (should be false for signal events)
  assert(cancelEvent1.down == false, 'Down should be false');
  results.add('down: ${cancelEvent1.down}');
  print('Cancel event down: ${cancelEvent1.down}');

  // Test 9: Buttons property
  results.add('buttons: ${cancelEvent1.buttons}');
  print('Cancel event buttons: ${cancelEvent1.buttons}');

  // Test 10: EmbedderId property
  final cancelEmbed = PointerScrollInertiaCancelEvent(
    position: Offset(80, 90),
    embedderId: 777,
  );
  assert(cancelEmbed.embedderId == 777, 'EmbedderId should be 777');
  results.add('embedderId: ${cancelEmbed.embedderId}');
  print('Cancel event embedderId: ${cancelEmbed.embedderId}');

  // Test 11: Synthesized property
  results.add('synthesized: ${cancelEvent1.synthesized}');
  print('Cancel event synthesized: ${cancelEvent1.synthesized}');

  // Test 12: Obscured property
  final cancelObscured = PointerScrollInertiaCancelEvent(
    position: Offset(110, 130),
    obscured: true,
  );
  assert(cancelObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${cancelObscured.obscured}');
  print('Cancel event obscured: ${cancelObscured.obscured}');

  // Test 13: Type hierarchy verification
  assert(cancelEvent1 is PointerEvent, 'Should be PointerEvent');
  assert(cancelEvent1 is PointerSignalEvent, 'Should be PointerSignalEvent');
  results.add('Type hierarchy: PointerEvent -> PointerSignalEvent');
  print('Type hierarchy verified');

  // Test 14: Inertia scroll and cancel sequence concept
  final scrollEvent = PointerScrollEvent(
    position: Offset(100, 100),
    scrollDelta: Offset(0, -100),
  );
  final cancelAfterScroll = PointerScrollInertiaCancelEvent(
    position: Offset(100, 100),
    timeStamp: Duration(milliseconds: 500),
  );
  results.add('Scroll -> Cancel sequence');
  print('Inertia scroll followed by cancel event');

  // Test 15: Pressure property
  results.add('pressure: ${cancelEvent1.pressure}');
  print('Cancel event pressure: ${cancelEvent1.pressure}');

  // Test 16: Distance property
  results.add('distance: ${cancelEvent1.distance}');
  print('Cancel event distance: ${cancelEvent1.distance}');

  // Test 17: Mouse kind cancel event
  final cancelMouse = PointerScrollInertiaCancelEvent(
    position: Offset(160.0, 190.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(cancelMouse.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('mouse kind: ${cancelMouse.kind}');
  print('Cancel event with mouse kind: ${cancelMouse.kind}');

  // Test 18: Multiple cancel events
  final cancelEvents = <PointerScrollInertiaCancelEvent>[];
  for (int i = 0; i < 3; i++) {
    cancelEvents.add(
      PointerScrollInertiaCancelEvent(
        position: Offset(100.0 + i * 30, 100.0 + i * 30),
        pointer: i,
      ),
    );
  }
  assert(cancelEvents.length == 3, 'Should have 3 cancel events');
  results.add('Multiple cancel events: ${cancelEvents.length}');
  print('Multiple cancel events tracked');

  // Test 19: Duration concept for inertia
  final scrollStartTime = Duration(milliseconds: 0);
  final scrollEndTime = Duration(milliseconds: 300);
  final inertiaDuration = scrollEndTime - scrollStartTime;
  results.add('Inertia duration: ${inertiaDuration.inMilliseconds}ms');
  print('Inertia duration: $inertiaDuration');

  // Test 20: Position distance from origin
  final distanceFromOrigin = cancelEvent1.position.distance;
  results.add('Distance from origin: ${distanceFromOrigin.toStringAsFixed(2)}');
  print('Position distance from origin: $distanceFromOrigin');

  print(
    'PointerScrollInertiaCancelEvent test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerScrollInertiaCancelEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
