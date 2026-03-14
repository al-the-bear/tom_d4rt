// D4rt test script: Tests PointerScaleEvent concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScaleEvent test executing');
  final results = <String>[];

  // ========== PointerScaleEvent Tests ==========
  print('Testing PointerScaleEvent...');

  // Test 1: Create basic PointerScaleEvent
  final scaleEvent1 = PointerScaleEvent(
    position: Offset(200.0, 250.0),
    scale: 1.5,
  );
  assert(scaleEvent1 is PointerEvent, 'Should be PointerEvent');
  assert(scaleEvent1 is PointerSignalEvent, 'Should be PointerSignalEvent');
  results.add('PointerScaleEvent created');
  print('PointerScaleEvent created: ${scaleEvent1.runtimeType}');

  // Test 2: Scale property
  assert(scaleEvent1.scale == 1.5, 'Scale should be 1.5');
  results.add('scale: ${scaleEvent1.scale}');
  print('Scale event scale: ${scaleEvent1.scale}');

  // Test 3: Position property
  assert(scaleEvent1.position == Offset(200.0, 250.0), 'Position should match');
  results.add('position: ${scaleEvent1.position}');
  print('Scale event position: ${scaleEvent1.position}');

  // Test 4: Zoom in (scale > 1)
  final scaleZoomIn = PointerScaleEvent(
    position: Offset(150.0, 180.0),
    scale: 2.0,
  );
  assert(scaleZoomIn.scale > 1.0, 'Zoom in should have scale > 1');
  results.add('zoom in scale: ${scaleZoomIn.scale}');
  print('Zoom in event: ${scaleZoomIn.scale}');

  // Test 5: Zoom out (scale < 1)
  final scaleZoomOut = PointerScaleEvent(
    position: Offset(150.0, 180.0),
    scale: 0.5,
  );
  assert(scaleZoomOut.scale < 1.0, 'Zoom out should have scale < 1');
  results.add('zoom out scale: ${scaleZoomOut.scale}');
  print('Zoom out event: ${scaleZoomOut.scale}');

  // Test 6: No scale change (scale = 1)
  final scaleNoChange = PointerScaleEvent(
    position: Offset(150.0, 180.0),
    scale: 1.0,
  );
  assert(scaleNoChange.scale == 1.0, 'No change should have scale = 1');
  results.add('no scale change: ${scaleNoChange.scale}');
  print('No scale change event: ${scaleNoChange.scale}');

  // Test 7: LocalPosition property
  results.add('localPosition: ${scaleEvent1.localPosition}');
  print('Scale event localPosition: ${scaleEvent1.localPosition}');

  // Test 8: TimeStamp property
  final scaleTime = PointerScaleEvent(
    position: Offset(100.0, 120.0),
    scale: 1.3,
    timeStamp: Duration(milliseconds: 600),
  );
  assert(scaleTime.timeStamp == Duration(milliseconds: 600), 'TimeStamp should match');
  results.add('timeStamp: ${scaleTime.timeStamp}');
  print('Scale event timeStamp: ${scaleTime.timeStamp}');

  // Test 9: Device property
  final scaleDevice = PointerScaleEvent(
    position: Offset(180.0, 210.0),
    scale: 1.75,
    device: 4,
  );
  assert(scaleDevice.device == 4, 'Device should be 4');
  results.add('device: ${scaleDevice.device}');
  print('Scale event device: ${scaleDevice.device}');

  // Test 10: Kind property
  final scaleKind = PointerScaleEvent(
    position: Offset(160.0, 190.0),
    scale: 1.25,
    kind: PointerDeviceKind.trackpad,
  );
  assert(scaleKind.kind == PointerDeviceKind.trackpad, 'Kind should be trackpad');
  results.add('kind: ${scaleKind.kind}');
  print('Scale event kind: ${scaleKind.kind}');

  // Test 11: Pointer ID
  final scalePointer = PointerScaleEvent(
    position: Offset(120.0, 140.0),
    scale: 0.8,
    pointer: 77,
  );
  assert(scalePointer.pointer == 77, 'Pointer should be 77');
  results.add('pointer: ${scalePointer.pointer}');
  print('Scale event pointer: ${scalePointer.pointer}');

  // Test 12: Down property (should be false for scale signal)
  assert(scaleEvent1.down == false, 'Down should be false for scale event');
  results.add('down: ${scaleEvent1.down}');
  print('Scale event down: ${scaleEvent1.down}');

  // Test 13: Buttons property
  results.add('buttons: ${scaleEvent1.buttons}');
  print('Scale event buttons: ${scaleEvent1.buttons}');

  // Test 14: EmbedderId property
  final scaleEmbed = PointerScaleEvent(
    position: Offset(50, 60),
    scale: 1.1,
    embedderId: 333,
  );
  assert(scaleEmbed.embedderId == 333, 'EmbedderId should be 333');
  results.add('embedderId: ${scaleEmbed.embedderId}');
  print('Scale event embedderId: ${scaleEmbed.embedderId}');

  // Test 15: Cumulative scale calculation
  var cumulativeScale = 1.0;
  final scales = [1.1, 1.2, 0.9];
  for (final s in scales) {
    cumulativeScale *= s;
  }
  results.add('cumulative scale: ${cumulativeScale.toStringAsFixed(3)}');
  print('Cumulative scale: $cumulativeScale');

  // Test 16: Scale percentage
  final percentage = (scaleEvent1.scale - 1.0) * 100;
  results.add('scale change: ${percentage.toStringAsFixed(1)}%');
  print('Scale change: $percentage%');

  // Test 17: Synthesized property
  results.add('synthesized: ${scaleEvent1.synthesized}');
  print('Scale event synthesized: ${scaleEvent1.synthesized}');

  // Test 18: Obscured property
  final scaleObscured = PointerScaleEvent(
    position: Offset(90, 100),
    scale: 0.75,
    obscured: true,
  );
  assert(scaleObscured.obscured == true, 'Obscured should be true');
  results.add('obscured: ${scaleObscured.obscured}');
  print('Scale event obscured: ${scaleObscured.obscured}');

  // Test 19: Distance properties
  results.add('distance: ${scaleEvent1.distance}');
  print('Scale event distance: ${scaleEvent1.distance}');

  // Test 20: Very small scale
  final scaleSmall = PointerScaleEvent(
    position: Offset(100, 100),
    scale: 0.1,
  );
  assert(scaleSmall.scale == 0.1, 'Small scale should be 0.1');
  results.add('very small scale: ${scaleSmall.scale}');
  print('Very small scale: ${scaleSmall.scale}');

  print('PointerScaleEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerScaleEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
