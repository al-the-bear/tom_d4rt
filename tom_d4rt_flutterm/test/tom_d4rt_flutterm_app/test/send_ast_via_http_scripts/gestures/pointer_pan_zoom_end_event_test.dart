// D4rt test script: Tests PointerPanZoomEndEvent concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerPanZoomEndEvent test executing');
  final results = <String>[];

  // ========== PointerPanZoomEndEvent Tests ==========
  print('Testing PointerPanZoomEndEvent...');

  // Test 1: Create basic PointerPanZoomEndEvent
  final panZoomEnd1 = PointerPanZoomEndEvent(position: Offset(240.0, 340.0));
  assert(panZoomEnd1 is PointerEvent, 'Should be PointerEvent');
  results.add('PointerPanZoomEndEvent created');
  print('PointerPanZoomEndEvent created: ${panZoomEnd1.runtimeType}');

  // Test 2: Position property
  assert(panZoomEnd1.position == Offset(240.0, 340.0), 'Position should match');
  results.add('position: ${panZoomEnd1.position}');
  print('PanZoomEnd event position: ${panZoomEnd1.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${panZoomEnd1.localPosition}');
  print('PanZoomEnd event localPosition: ${panZoomEnd1.localPosition}');

  // Test 4: TimeStamp property
  final panZoomEndTime = PointerPanZoomEndEvent(
    position: Offset(200.0, 300.0),
    timeStamp: Duration(milliseconds: 1500),
  );
  assert(
    panZoomEndTime.timeStamp == Duration(milliseconds: 1500),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${panZoomEndTime.timeStamp}');
  print('PanZoomEnd event timeStamp: ${panZoomEndTime.timeStamp}');

  // Test 5: Device property
  final panZoomEndDevice = PointerPanZoomEndEvent(
    position: Offset(180.0, 260.0),
    device: 10,
  );
  assert(panZoomEndDevice.device == 10, 'Device should be 10');
  results.add('device: ${panZoomEndDevice.device}');
  print('PanZoomEnd event device: ${panZoomEndDevice.device}');

  // Test 6: Pointer ID
  final panZoomEndPointer = PointerPanZoomEndEvent(
    position: Offset(140.0, 180.0),
    pointer: 66,
  );
  assert(panZoomEndPointer.pointer == 66, 'Pointer should be 66');
  results.add('pointer: ${panZoomEndPointer.pointer}');
  print('PanZoomEnd event pointer: ${panZoomEndPointer.pointer}');

  // Test 7: Kind property
  final panZoomEndKind = PointerPanZoomEndEvent(
    position: Offset(170.0, 220.0),
    kind: PointerDeviceKind.trackpad,
  );
  assert(
    panZoomEndKind.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('kind: ${panZoomEndKind.kind}');
  print('PanZoomEnd event kind: ${panZoomEndKind.kind}');

  // Test 8: Down property
  results.add('down: ${panZoomEnd1.down}');
  print('PanZoomEnd event down: ${panZoomEnd1.down}');

  // Test 9: Buttons property
  results.add('buttons: ${panZoomEnd1.buttons}');
  print('PanZoomEnd event buttons: ${panZoomEnd1.buttons}');

  // Test 10: EmbedderId property
  final panZoomEndEmbed = PointerPanZoomEndEvent(
    position: Offset(60, 70),
    embedderId: 666,
  );
  assert(panZoomEndEmbed.embedderId == 666, 'EmbedderId should be 666');
  results.add('embedderId: ${panZoomEndEmbed.embedderId}');
  print('PanZoomEnd event embedderId: ${panZoomEndEmbed.embedderId}');

  // Test 11: Synthesized property
  results.add('synthesized: ${panZoomEnd1.synthesized}');
  print('PanZoomEnd event synthesized: ${panZoomEnd1.synthesized}');

  // Test 12: Obscured property
  final panZoomEndObscured = PointerPanZoomEndEvent(
    position: Offset(100, 120),
    obscured: true,
  );
  assert(panZoomEndObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${panZoomEndObscured.obscured}');
  print('PanZoomEnd event obscured: ${panZoomEndObscured.obscured}');

  // Test 13: Complete pan zoom sequence (start -> updates -> end)
  final pointerId = 99;
  final startEvent = PointerPanZoomStartEvent(
    position: Offset(100, 100),
    pointer: pointerId,
  );
  final updateEvent = PointerPanZoomUpdateEvent(
    position: Offset(150, 150),
    pointer: pointerId,
    pan: Offset(50, 50),
    scale: 1.5,
    rotation: 0.3,
  );
  final endEvent = PointerPanZoomEndEvent(
    position: Offset(200, 200),
    pointer: pointerId,
  );
  assert(
    startEvent.pointer == updateEvent.pointer &&
        updateEvent.pointer == endEvent.pointer,
    'Pointer IDs should match',
  );
  results.add('Complete sequence verified');
  print('Pan zoom sequence: start -> update -> end verified');

  // Test 14: Position drift calculation
  final startPos = Offset(100, 100);
  final endPos = panZoomEnd1.position;
  final totalDrift = endPos - startPos;
  results.add('drift: $totalDrift');
  print('Position drift: $totalDrift');

  // Test 15: Pressure property
  results.add('pressure: ${panZoomEnd1.pressure}');
  print('PanZoomEnd event pressure: ${panZoomEnd1.pressure}');

  // Test 16: Distance property
  results.add('distance: ${panZoomEnd1.distance}');
  print('PanZoomEnd event distance: ${panZoomEnd1.distance}');

  // Test 17: Multiple end events tracking
  final endEvents = <PointerPanZoomEndEvent>[];
  for (int i = 0; i < 3; i++) {
    endEvents.add(
      PointerPanZoomEndEvent(
        position: Offset(100.0 + i * 50, 100.0 + i * 50),
        pointer: i,
      ),
    );
  }
  assert(endEvents.length == 3, 'Should have 3 end events');
  results.add('Tracked ${endEvents.length} end events');
  print('Multiple end events tracked');

  // Test 18: End position distance from origin
  final distanceFromOrigin = panZoomEnd1.position.distance;
  results.add('Distance from origin: ${distanceFromOrigin.toStringAsFixed(2)}');
  print('End position distance from origin: $distanceFromOrigin');

  // Test 19: Mouse kind end event
  final panZoomEndMouse = PointerPanZoomEndEvent(
    position: Offset(190.0, 240.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(
    panZoomEndMouse.kind == PointerDeviceKind.mouse,
    'Kind should be mouse',
  );
  results.add('mouse kind: ${panZoomEndMouse.kind}');
  print('PanZoomEnd with mouse kind: ${panZoomEndMouse.kind}');

  // Test 20: End event timing analysis
  final gestureDuration =
      Duration(milliseconds: 1500) - Duration(milliseconds: 1000);
  results.add('gesture duration: ${gestureDuration.inMilliseconds}ms');
  print('Gesture duration: $gestureDuration');

  print('PointerPanZoomEndEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerPanZoomEndEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
