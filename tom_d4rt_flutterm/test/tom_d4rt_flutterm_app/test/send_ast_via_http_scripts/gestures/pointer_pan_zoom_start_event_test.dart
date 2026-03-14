// D4rt test script: Tests PointerPanZoomStartEvent concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerPanZoomStartEvent test executing');
  final results = <String>[];

  // ========== PointerPanZoomStartEvent Tests ==========
  print('Testing PointerPanZoomStartEvent...');

  // Test 1: Create basic PointerPanZoomStartEvent
  final panZoomStart1 = PointerPanZoomStartEvent(
    position: Offset(200.0, 300.0),
  );
  assert(panZoomStart1 is PointerEvent, 'Should be PointerEvent');
  results.add('PointerPanZoomStartEvent created');
  print('PointerPanZoomStartEvent created: ${panZoomStart1.runtimeType}');

  // Test 2: Position property
  assert(
    panZoomStart1.position == Offset(200.0, 300.0),
    'Position should match',
  );
  results.add('position: ${panZoomStart1.position}');
  print('PanZoomStart event position: ${panZoomStart1.position}');

  // Test 3: LocalPosition property
  results.add('localPosition: ${panZoomStart1.localPosition}');
  print('PanZoomStart event localPosition: ${panZoomStart1.localPosition}');

  // Test 4: Default kind for pan zoom (usually trackpad)
  final panZoomTrackpad = PointerPanZoomStartEvent(
    position: Offset(150.0, 200.0),
    kind: PointerDeviceKind.trackpad,
  );
  assert(
    panZoomTrackpad.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('trackpad kind: ${panZoomTrackpad.kind}');
  print('PanZoomStart with trackpad kind: ${panZoomTrackpad.kind}');

  // Test 5: TimeStamp property
  final panZoomTime = PointerPanZoomStartEvent(
    position: Offset(100.0, 150.0),
    timeStamp: Duration(milliseconds: 1000),
  );
  assert(
    panZoomTime.timeStamp == Duration(milliseconds: 1000),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${panZoomTime.timeStamp}');
  print('PanZoomStart event timeStamp: ${panZoomTime.timeStamp}');

  // Test 6: Device property
  final panZoomDevice = PointerPanZoomStartEvent(
    position: Offset(180.0, 220.0),
    device: 8,
  );
  assert(panZoomDevice.device == 8, 'Device should be 8');
  results.add('device: ${panZoomDevice.device}');
  print('PanZoomStart event device: ${panZoomDevice.device}');

  // Test 7: Pointer ID
  final panZoomPointer = PointerPanZoomStartEvent(
    position: Offset(120.0, 160.0),
    pointer: 44,
  );
  assert(panZoomPointer.pointer == 44, 'Pointer should be 44');
  results.add('pointer: ${panZoomPointer.pointer}');
  print('PanZoomStart event pointer: ${panZoomPointer.pointer}');

  // Test 8: Down property
  results.add('down: ${panZoomStart1.down}');
  print('PanZoomStart event down: ${panZoomStart1.down}');

  // Test 9: Buttons property
  results.add('buttons: ${panZoomStart1.buttons}');
  print('PanZoomStart event buttons: ${panZoomStart1.buttons}');

  // Test 10: EmbedderId property
  final panZoomEmbed = PointerPanZoomStartEvent(
    position: Offset(50, 60),
    embedderId: 444,
  );
  assert(panZoomEmbed.embedderId == 444, 'EmbedderId should be 444');
  results.add('embedderId: ${panZoomEmbed.embedderId}');
  print('PanZoomStart event embedderId: ${panZoomEmbed.embedderId}');

  // Test 11: Synthesized property
  results.add('synthesized: ${panZoomStart1.synthesized}');
  print('PanZoomStart event synthesized: ${panZoomStart1.synthesized}');

  // Test 12: Obscured property
  final panZoomObscured = PointerPanZoomStartEvent(
    position: Offset(90, 110),
    obscured: true,
  );
  assert(panZoomObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${panZoomObscured.obscured}');
  print('PanZoomStart event obscured: ${panZoomObscured.obscured}');

  // Test 13: Start with mouse kind
  final panZoomMouse = PointerPanZoomStartEvent(
    position: Offset(170.0, 210.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(panZoomMouse.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('mouse kind: ${panZoomMouse.kind}');
  print('PanZoomStart with mouse kind: ${panZoomMouse.kind}');

  // Test 14: Pressure property
  results.add('pressure: ${panZoomStart1.pressure}');
  print('PanZoomStart event pressure: ${panZoomStart1.pressure}');

  // Test 15: Distance property
  results.add('distance: ${panZoomStart1.distance}');
  print('PanZoomStart event distance: ${panZoomStart1.distance}');

  // Test 16: Pan zoom sequence pattern (start -> updates -> end)
  final sequenceId = 123;
  final startEvent = PointerPanZoomStartEvent(
    position: Offset(100, 100),
    pointer: sequenceId,
  );
  results.add('Sequence started with pointer: $sequenceId');
  print('Pan zoom sequence started with pointer: $sequenceId');

  // Test 17: Different start positions
  final positions = [Offset(0, 0), Offset(100, 100), Offset(200, 200)];
  for (int i = 0; i < positions.length; i++) {
    final event = PointerPanZoomStartEvent(position: positions[i]);
    assert(event.position == positions[i], 'Position should match');
  }
  results.add('Tested ${positions.length} start positions');
  print('Tested multiple start positions');

  // Test 18: Offset calculations for position
  final startPos = panZoomStart1.position;
  final endPos = Offset(250.0, 350.0);
  final totalMovement = endPos - startPos;
  results.add('Total movement: $totalMovement');
  print('Total movement from start: $totalMovement');

  // Test 19: Multiple pan zoom gestures
  final gesture1 = PointerPanZoomStartEvent(
    position: Offset(50, 50),
    device: 1,
  );
  final gesture2 = PointerPanZoomStartEvent(
    position: Offset(250, 250),
    device: 2,
  );
  assert(gesture1.device != gesture2.device, 'Devices should differ');
  results.add(
    'Multiple gestures: devices ${gesture1.device} and ${gesture2.device}',
  );
  print('Multiple pan zoom gestures tracked');

  // Test 20: Start position distance from origin
  final distanceFromOrigin = panZoomStart1.position.distance;
  results.add('Distance from origin: ${distanceFromOrigin.toStringAsFixed(2)}');
  print('Start position distance from origin: $distanceFromOrigin');

  print('PointerPanZoomStartEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerPanZoomStartEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
