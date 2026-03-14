// D4rt test script: Tests TapDragUpdateDetails from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragUpdateDetails comprehensive test executing');
  final results = <String>[];

  // ========== TapDragUpdateDetails Tests ==========
  print('Testing TapDragUpdateDetails...');

  // Test 1: Create TapDragUpdateDetails
  final details = TapDragUpdateDetails(
    globalPosition: Offset(150.0, 250.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
    delta: Offset(50.0, 50.0),
    offsetFromOrigin: Offset(50.0, 50.0),
    localOffsetFromOrigin: Offset(50.0, 50.0),
  );
  assert(details != null, 'Should create details');
  results.add('TapDragUpdateDetails created');
  print('TapDragUpdateDetails created');

  // Test 2: Global position property
  assert(details.globalPosition == Offset(150.0, 250.0), 'Global should match');
  results.add('Global position: ${details.globalPosition}');
  print('Global position: ${details.globalPosition}');

  // Test 3: Local position property
  assert(details.localPosition == Offset(100.0, 150.0), 'Local should match');
  results.add('Local position: ${details.localPosition}');
  print('Local position: ${details.localPosition}');

  // Test 4: Delta property (incremental movement)
  assert(details.delta == Offset(50.0, 50.0), 'Delta should match');
  results.add('Delta: ${details.delta}');
  print('Delta (since last update): ${details.delta}');

  // Test 5: Offset from origin property
  assert(details.offsetFromOrigin == Offset(50.0, 50.0), 'Offset should match');
  results.add('Offset from origin: ${details.offsetFromOrigin}');
  print('Offset from origin: ${details.offsetFromOrigin}');

  // Test 6: Local offset from origin
  assert(details.localOffsetFromOrigin == Offset(50.0, 50.0), 'Local offset should match');
  results.add('Local offset from origin: ${details.localOffsetFromOrigin}');
  print('Local offset from origin: ${details.localOffsetFromOrigin}');

  // Test 7: Consecutive tap count
  assert(details.consecutiveTapCount == 1, 'Count should be 1');
  results.add('Consecutive tap count: ${details.consecutiveTapCount}');
  print('Consecutive tap count: ${details.consecutiveTapCount}');

  // Test 8: Double tap drag update
  final doubleTapUpdate = TapDragUpdateDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(150.0, 200.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 2,
    delta: Offset(10.0, 10.0),
    offsetFromOrigin: Offset(100.0, 100.0),
    localOffsetFromOrigin: Offset(100.0, 100.0),
  );
  assert(doubleTapUpdate.consecutiveTapCount == 2, 'Count should be 2');
  results.add('Double tap update: count=${doubleTapUpdate.consecutiveTapCount}');
  print('Double tap drag update: count=${doubleTapUpdate.consecutiveTapCount}');

  // Test 9: Delta distance
  final deltaDistance = details.delta.distance;
  assert((deltaDistance - 70.71).abs() < 0.1, 'Delta distance should be ~70.71');
  results.add('Delta distance: ${deltaDistance.toStringAsFixed(2)}');
  print('Delta distance: ${deltaDistance.toStringAsFixed(2)}');

  // Test 10: Total drag distance
  final totalDistance = details.offsetFromOrigin.distance;
  assert((totalDistance - 70.71).abs() < 0.1, 'Total distance should be ~70.71');
  results.add('Total distance: ${totalDistance.toStringAsFixed(2)}');
  print('Total drag distance from origin: ${totalDistance.toStringAsFixed(2)}');

  // Test 11: Horizontal delta component
  final horizontalDelta = details.delta.dx;
  results.add('Horizontal delta: $horizontalDelta');
  print('Horizontal delta: $horizontalDelta');

  // Test 12: Vertical delta component
  final verticalDelta = details.delta.dy;
  results.add('Vertical delta: $verticalDelta');
  print('Vertical delta: $verticalDelta');

  // Test 13: Drag direction
  final direction = details.offsetFromOrigin.direction;
  results.add('Drag direction: ${direction.toStringAsFixed(4)} rad');
  print('Drag direction: ${direction.toStringAsFixed(4)} radians');

  // Test 14: Velocity calculation concept
  final timeInterval = Duration(milliseconds: 16);
  final velocityX = details.delta.dx / (timeInterval.inMilliseconds / 1000.0);
  final velocityY = details.delta.dy / (timeInterval.inMilliseconds / 1000.0);
  results.add('Velocity estimate: (${velocityX.toStringAsFixed(0)}, ${velocityY.toStringAsFixed(0)}) px/s');
  print('Velocity estimate: ($velocityX, $velocityY) px/s');

  // Test 15: Mouse device update
  final mouseUpdate = TapDragUpdateDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(150.0, 200.0),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 1,
    delta: Offset(5.0, 5.0),
    offsetFromOrigin: Offset(100.0, 100.0),
    localOffsetFromOrigin: Offset(100.0, 100.0),
  );
  assert(mouseUpdate.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('Mouse update: ${mouseUpdate.kind}');
  print('Mouse drag update: kind=${mouseUpdate.kind}');

  // Test 16: Small delta (fine movement)
  final fineUpdate = TapDragUpdateDetails(
    globalPosition: Offset(101.0, 201.0),
    localPosition: Offset(51.0, 101.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
    delta: Offset(1.0, 1.0),
    offsetFromOrigin: Offset(1.0, 1.0),
    localOffsetFromOrigin: Offset(1.0, 1.0),
  );
  final fineDist = fineUpdate.delta.distance;
  results.add('Fine delta distance: ${fineDist.toStringAsFixed(2)}');
  print('Fine movement delta: ${fineDist.toStringAsFixed(2)}');

  // Test 17: Callback pattern
  TapDragUpdateDetails? capturedUpdate;
  void onDragUpdate(TapDragUpdateDetails d) {
    capturedUpdate = d;
  }
  onDragUpdate(details);
  assert(capturedUpdate != null, 'Should capture update');
  results.add('Callback pattern works');
  print('Callback captured update');

  // Test 18: Cumulative updates concept
  var totalDelta = Offset.zero;
  final updates = [Offset(10.0, 5.0), Offset(15.0, 8.0), Offset(12.0, 10.0)];
  for (final u in updates) {
    totalDelta = totalDelta + u;
  }
  results.add('Cumulative delta: $totalDelta');
  print('Cumulative delta from updates: $totalDelta');

  // Test 19: Kind property
  assert(details.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('Device kind: ${details.kind}');
  print('Device kind: ${details.kind}');

  // Test 20: Summary
  results.add('Properties: globalPosition, localPosition, delta, offsetFromOrigin, localOffsetFromOrigin, kind, consecutiveTapCount');
  print('TapDragUpdateDetails: continuous drag updates with delta and cumulative offset');

  print('TapDragUpdateDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapDragUpdateDetails Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Properties: position (global/local)'),
      Text('Properties: delta, offsetFromOrigin'),
      Text('Properties: kind, consecutiveTapCount'),
      Text('Usage: onDragUpdate - continuous updates'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
