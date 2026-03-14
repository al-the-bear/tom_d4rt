// D4rt test script: Tests PointerPanZoomUpdateEvent concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerPanZoomUpdateEvent test executing');
  final results = <String>[];

  // ========== PointerPanZoomUpdateEvent Tests ==========
  print('Testing PointerPanZoomUpdateEvent...');

  // Test 1: Create basic PointerPanZoomUpdateEvent
  final panZoomUpdate1 = PointerPanZoomUpdateEvent(
    position: Offset(220.0, 320.0),
    pan: Offset(20.0, 20.0),
    scale: 1.2,
    rotation: 0.1,
  );
  assert(panZoomUpdate1 is PointerEvent, 'Should be PointerEvent');
  results.add('PointerPanZoomUpdateEvent created');
  print('PointerPanZoomUpdateEvent created: ${panZoomUpdate1.runtimeType}');

  // Test 2: Position property
  assert(
    panZoomUpdate1.position == Offset(220.0, 320.0),
    'Position should match',
  );
  results.add('position: ${panZoomUpdate1.position}');
  print('PanZoomUpdate event position: ${panZoomUpdate1.position}');

  // Test 3: Pan property
  assert(panZoomUpdate1.pan == Offset(20.0, 20.0), 'Pan should match');
  results.add('pan: ${panZoomUpdate1.pan}');
  print('PanZoomUpdate event pan: ${panZoomUpdate1.pan}');

  // Test 4: Scale property
  assert(panZoomUpdate1.scale == 1.2, 'Scale should be 1.2');
  results.add('scale: ${panZoomUpdate1.scale}');
  print('PanZoomUpdate event scale: ${panZoomUpdate1.scale}');

  // Test 5: Rotation property
  assert(panZoomUpdate1.rotation == 0.1, 'Rotation should be 0.1');
  results.add('rotation: ${panZoomUpdate1.rotation}');
  print('PanZoomUpdate event rotation: ${panZoomUpdate1.rotation}');

  // Test 6: LocalPan property
  results.add('localPan: ${panZoomUpdate1.localPan}');
  print('PanZoomUpdate event localPan: ${panZoomUpdate1.localPan}');

  // Test 7: LocalPanDelta property
  results.add('localPanDelta: ${panZoomUpdate1.localPanDelta}');
  print('PanZoomUpdate event localPanDelta: ${panZoomUpdate1.localPanDelta}');

  // Test 8: PanDelta property
  final panZoomWithDelta = PointerPanZoomUpdateEvent(
    position: Offset(200.0, 300.0),
    pan: Offset(30.0, 40.0),
    panDelta: Offset(5.0, 10.0),
    scale: 1.0,
    rotation: 0.0,
  );
  assert(
    panZoomWithDelta.panDelta == Offset(5.0, 10.0),
    'PanDelta should match',
  );
  results.add('panDelta: ${panZoomWithDelta.panDelta}');
  print('PanZoomUpdate event panDelta: ${panZoomWithDelta.panDelta}');

  // Test 9: TimeStamp property
  final panZoomTime = PointerPanZoomUpdateEvent(
    position: Offset(150.0, 200.0),
    pan: Offset.zero,
    scale: 1.0,
    rotation: 0.0,
    timeStamp: Duration(milliseconds: 1200),
  );
  assert(
    panZoomTime.timeStamp == Duration(milliseconds: 1200),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${panZoomTime.timeStamp}');
  print('PanZoomUpdate event timeStamp: ${panZoomTime.timeStamp}');

  // Test 10: Device property
  final panZoomDevice = PointerPanZoomUpdateEvent(
    position: Offset(180.0, 250.0),
    pan: Offset(10.0, 15.0),
    scale: 1.1,
    rotation: 0.05,
    device: 9,
  );
  assert(panZoomDevice.device == 9, 'Device should be 9');
  results.add('device: ${panZoomDevice.device}');
  print('PanZoomUpdate event device: ${panZoomDevice.device}');

  // Test 11: Pointer ID
  final panZoomPointer = PointerPanZoomUpdateEvent(
    position: Offset(130.0, 170.0),
    pan: Offset(25.0, 30.0),
    scale: 0.9,
    rotation: -0.1,
    pointer: 55,
  );
  assert(panZoomPointer.pointer == 55, 'Pointer should be 55');
  results.add('pointer: ${panZoomPointer.pointer}');
  print('PanZoomUpdate event pointer: ${panZoomPointer.pointer}');

  // Test 12: Kind property
  final panZoomKind = PointerPanZoomUpdateEvent(
    position: Offset(160.0, 200.0),
    pan: Offset(15.0, 20.0),
    scale: 1.3,
    rotation: 0.2,
    kind: PointerDeviceKind.trackpad,
  );
  assert(
    panZoomKind.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('kind: ${panZoomKind.kind}');
  print('PanZoomUpdate event kind: ${panZoomKind.kind}');

  // Test 13: Down property
  results.add('down: ${panZoomUpdate1.down}');
  print('PanZoomUpdate event down: ${panZoomUpdate1.down}');

  // Test 14: EmbedderId property
  final panZoomEmbed = PointerPanZoomUpdateEvent(
    position: Offset(70, 80),
    pan: Offset(5, 5),
    scale: 1.0,
    rotation: 0.0,
    embedderId: 555,
  );
  assert(panZoomEmbed.embedderId == 555, 'EmbedderId should be 555');
  results.add('embedderId: ${panZoomEmbed.embedderId}');
  print('PanZoomUpdate event embedderId: ${panZoomEmbed.embedderId}');

  // Test 15: Synthesized property
  results.add('synthesized: ${panZoomUpdate1.synthesized}');
  print('PanZoomUpdate event synthesized: ${panZoomUpdate1.synthesized}');

  // Test 16: Cumulative pan calculation
  var totalPan = Offset.zero;
  final panDeltas = [Offset(10, 5), Offset(15, 10), Offset(-5, 20)];
  for (final delta in panDeltas) {
    totalPan += delta;
  }
  assert(totalPan == Offset(20, 35), 'Total pan should match');
  results.add('cumulative pan: $totalPan');
  print('Cumulative pan: $totalPan');

  // Test 17: Scale change calculation
  final initialScale = 1.0;
  final finalScale = 1.5;
  final scaleChange = finalScale / initialScale;
  results.add('scale change: ${scaleChange.toStringAsFixed(2)}x');
  print('Scale change: ${scaleChange}x');

  // Test 18: Rotation in degrees
  final rotationDegrees = panZoomUpdate1.rotation * (180 / 3.14159);
  results.add('rotation degrees: ${rotationDegrees.toStringAsFixed(2)}');
  print('Rotation in degrees: $rotationDegrees');

  // Test 19: Pan magnitude
  final panMagnitude = panZoomUpdate1.pan.distance;
  results.add('pan magnitude: ${panMagnitude.toStringAsFixed(2)}');
  print('Pan magnitude: $panMagnitude');

  // Test 20: LocalPosition property
  results.add('localPosition: ${panZoomUpdate1.localPosition}');
  print('PanZoomUpdate event localPosition: ${panZoomUpdate1.localPosition}');

  print(
    'PointerPanZoomUpdateEvent test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerPanZoomUpdateEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
