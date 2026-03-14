// D4rt test script: Tests PointerExitEvent via PointerEvent concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerExitEvent test executing');
  final results = <String>[];

  // ========== PointerExitEvent Tests ==========
  print('Testing PointerExitEvent...');

  // Test 1: Create basic PointerExitEvent
  final exitEvent1 = PointerExitEvent(position: Offset(100.0, 150.0));
  assert(exitEvent1 is PointerEvent, 'Should be PointerEvent');
  results.add('PointerExitEvent created');
  print('PointerExitEvent created: ${exitEvent1.runtimeType}');

  // Test 2: Position property
  assert(exitEvent1.position == Offset(100.0, 150.0), 'Position should match');
  results.add('position: ${exitEvent1.position}');
  print('Exit event position: ${exitEvent1.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${exitEvent1.localPosition}');
  print('Exit event localPosition: ${exitEvent1.localPosition}');

  // Test 4: Default kind is mouse
  results.add('default kind: ${exitEvent1.kind}');
  print('Exit event default kind: ${exitEvent1.kind}');

  // Test 5: Exit event with specific kind
  final exitEventTouch = PointerExitEvent(
    position: Offset(200.0, 250.0),
    kind: PointerDeviceKind.touch,
  );
  assert(
    exitEventTouch.kind == PointerDeviceKind.touch,
    'Kind should be touch',
  );
  results.add('touch kind: ${exitEventTouch.kind}');
  print('Exit event with touch kind: ${exitEventTouch.kind}');

  // Test 6: Exit event with delta
  final exitEventDelta = PointerExitEvent(
    position: Offset(150.0, 175.0),
    delta: Offset(25.0, 30.0),
  );
  assert(exitEventDelta.delta == Offset(25.0, 30.0), 'Delta should match');
  results.add('delta: ${exitEventDelta.delta}');
  print('Exit event delta: ${exitEventDelta.delta}');

  // Test 7: TimeStamp property
  final exitEventTime = PointerExitEvent(
    position: Offset(50.0, 75.0),
    timeStamp: Duration(milliseconds: 500),
  );
  assert(
    exitEventTime.timeStamp == Duration(milliseconds: 500),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${exitEventTime.timeStamp}');
  print('Exit event timeStamp: ${exitEventTime.timeStamp}');

  // Test 8: Device property
  final exitEventDevice = PointerExitEvent(
    position: Offset(125.0, 175.0),
    device: 5,
  );
  assert(exitEventDevice.device == 5, 'Device should be 5');
  results.add('device: ${exitEventDevice.device}');
  print('Exit event device: ${exitEventDevice.device}');

  // Test 9: Down property should be false
  assert(exitEvent1.down == false, 'Down should be false for exit event');
  results.add('down: ${exitEvent1.down}');
  print('Exit event down: ${exitEvent1.down}');

  // Test 10: Buttons property
  final exitEventButtons = PointerExitEvent(
    position: Offset(300.0, 400.0),
    buttons: kSecondaryButton,
  );
  assert(
    exitEventButtons.buttons == kSecondaryButton,
    'Buttons should be secondary',
  );
  results.add('buttons: ${exitEventButtons.buttons}');
  print('Exit event buttons: ${exitEventButtons.buttons}');

  // Test 11: Pressure defaults
  results.add('pressure: ${exitEvent1.pressure}');
  print('Exit event pressure: ${exitEvent1.pressure}');

  // Test 12: Obscured property
  final exitEventObscured = PointerExitEvent(
    position: Offset(80.0, 90.0),
    obscured: true,
  );
  assert(exitEventObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${exitEventObscured.obscured}');
  print('Exit event obscured: ${exitEventObscured.obscured}');

  // Test 13: Synthesized property
  results.add('synthesized: ${exitEvent1.synthesized}');
  print('Exit event synthesized: ${exitEvent1.synthesized}');

  // Test 14: Pointer ID property
  final exitEventPointer = PointerExitEvent(
    position: Offset(180.0, 220.0),
    pointer: 42,
  );
  assert(exitEventPointer.pointer == 42, 'Pointer should be 42');
  results.add('pointer: ${exitEventPointer.pointer}');
  print('Exit event pointer: ${exitEventPointer.pointer}');

  // Test 15: Multiple exit events comparison
  final exitA = PointerExitEvent(position: Offset(10, 10));
  final exitB = PointerExitEvent(position: Offset(20, 20));
  assert(exitA.position != exitB.position, 'Positions should differ');
  results.add('Event comparison: positions differ');
  print('Exit events have different positions');

  // Test 16: Offset helper tests
  final offset1 = Offset(100.0, 200.0);
  final offset2 = Offset(150.0, 250.0);
  final offsetSum = offset1 + offset2;
  assert(offsetSum == Offset(250.0, 450.0), 'Offset sum should be correct');
  results.add('Offset sum: $offsetSum');
  print('Offset arithmetic: $offsetSum');

  // Test 17: Offset distance calculation
  final distance = offset1.distance;
  results.add('Offset distance: ${distance.toStringAsFixed(2)}');
  print('Offset distance: $distance');

  // Test 18: Offset direction
  final direction = offset1.direction;
  results.add('Offset direction: ${direction.toStringAsFixed(4)}');
  print('Offset direction: $direction');

  // Test 19: Exit with embedderId
  final exitEventEmbed = PointerExitEvent(
    position: Offset(50, 60),
    embedderId: 123,
  );
  assert(exitEventEmbed.embedderId == 123, 'EmbedderId should be 123');
  results.add('embedderId: ${exitEventEmbed.embedderId}');
  print('Exit event embedderId: ${exitEventEmbed.embedderId}');

  // Test 20: Distance properties
  results.add('distance: ${exitEvent1.distance}');
  print(
    'Exit event distance: ${exitEvent1.distance}, distanceMax: ${exitEvent1.distanceMax}',
  );

  print('PointerExitEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerExitEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
