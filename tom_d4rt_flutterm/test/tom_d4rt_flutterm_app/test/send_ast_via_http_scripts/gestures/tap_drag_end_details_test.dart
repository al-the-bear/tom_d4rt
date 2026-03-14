// D4rt test script: Tests TapDragEndDetails from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragEndDetails comprehensive test executing');
  final results = <String>[];

  // ========== TapDragEndDetails Tests ==========
  print('Testing TapDragEndDetails...');

  // Test 1: Create TapDragEndDetails
  final details = TapDragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(500.0, 300.0)),
    consecutiveTapCount: 1,
  );
  assert(details != null, 'Should create details');
  results.add('TapDragEndDetails created');
  print('TapDragEndDetails created');

  // Test 2: Velocity property
  assert(details.velocity.pixelsPerSecond == Offset(500.0, 300.0), 'Velocity should match');
  results.add('Velocity: ${details.velocity.pixelsPerSecond}');
  print('Velocity: ${details.velocity.pixelsPerSecond}');

  // Test 3: Consecutive tap count
  assert(details.consecutiveTapCount == 1, 'Count should be 1');
  results.add('Consecutive tap count: ${details.consecutiveTapCount}');
  print('Consecutive tap count: ${details.consecutiveTapCount}');

  // Test 4: Velocity speed (magnitude)
  final speed = details.velocity.pixelsPerSecond.distance;
  results.add('Speed: ${speed.toStringAsFixed(2)} px/s');
  print('Velocity speed: ${speed.toStringAsFixed(2)} px/s');

  // Test 5: Velocity direction
  final velDirection = details.velocity.pixelsPerSecond.direction;
  results.add('Velocity direction: ${velDirection.toStringAsFixed(4)} rad');
  print('Velocity direction: ${velDirection.toStringAsFixed(4)} radians');

  // Test 6: Double tap drag end
  final doubleTapEnd = TapDragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(800.0, 400.0)),
    consecutiveTapCount: 2,
  );
  assert(doubleTapEnd.consecutiveTapCount == 2, 'Count should be 2');
  results.add('Double tap end: count=${doubleTapEnd.consecutiveTapCount}');
  print('Double tap drag end: count=${doubleTapEnd.consecutiveTapCount}');

  // Test 7: Zero velocity (slow end)
  final slowEnd = TapDragEndDetails(
    velocity: Velocity.zero,
    consecutiveTapCount: 1,
  );
  assert(slowEnd.velocity == Velocity.zero, 'Velocity should be zero');
  results.add('Zero velocity end');
  print('Slow drag end: velocity=${slowEnd.velocity.pixelsPerSecond}');

  // Test 8: Velocity.zero properties
  assert(Velocity.zero.pixelsPerSecond == Offset.zero, 'Zero velocity should be zero offset');
  results.add('Velocity.zero: ${Velocity.zero.pixelsPerSecond}');
  print('Velocity.zero: ${Velocity.zero.pixelsPerSecond}');

  // Test 9: Fling detection concept
  final kMinFlingVelocity = 50.0;
  final isFling = speed > kMinFlingVelocity;
  results.add('Is fling (>$kMinFlingVelocity): $isFling');
  print('Fling detection: $isFling');

  // Test 10: Max fling velocity concept
  final kMaxFlingVelocity = 8000.0;
  final cappedSpeed = speed.clamp(0.0, kMaxFlingVelocity);
  results.add('Capped speed: ${cappedSpeed.toStringAsFixed(2)}');
  print('Capped velocity: ${cappedSpeed.toStringAsFixed(2)} px/s (max $kMaxFlingVelocity)');

  // Test 11: Horizontal velocity component
  final horizontalVel = details.velocity.pixelsPerSecond.dx;
  results.add('Horizontal velocity: $horizontalVel px/s');
  print('Horizontal velocity: $horizontalVel px/s');

  // Test 12: Vertical velocity component
  final verticalVel = details.velocity.pixelsPerSecond.dy;
  results.add('Vertical velocity: $verticalVel px/s');
  print('Vertical velocity: $verticalVel px/s');

  // Test 13: High velocity fling
  final fastFling = TapDragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(3000.0, 2000.0)),
    consecutiveTapCount: 1,
  );
  final fastSpeed = fastFling.velocity.pixelsPerSecond.distance;
  results.add('Fast fling speed: ${fastSpeed.toStringAsFixed(0)} px/s');
  print('Fast fling: ${fastSpeed.toStringAsFixed(0)} px/s');

  // Test 14: Triple tap drag end
  final tripleTapEnd = TapDragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(200.0, 100.0)),
    consecutiveTapCount: 3,
  );
  assert(tripleTapEnd.consecutiveTapCount == 3, 'Count should be 3');
  results.add('Triple tap end: count=${tripleTapEnd.consecutiveTapCount}');
  print('Triple tap drag end: count=${tripleTapEnd.consecutiveTapCount}');

  // Test 15: Velocity for animation
  final animationDuration = 300; // milliseconds
  final travelDistance = speed * (animationDuration / 1000.0);
  results.add('Travel estimate: ${travelDistance.toStringAsFixed(2)} px over ${animationDuration}ms');
  print('Animation travel: ${travelDistance.toStringAsFixed(2)} px');

  // Test 16: Dominant axis detection
  final isHorizontalFling = horizontalVel.abs() > verticalVel.abs();
  results.add('Horizontal fling: $isHorizontalFling');
  print('Dominant axis horizontal: $isHorizontalFling');

  // Test 17: Velocity negation for reverse
  final reversed = Velocity(pixelsPerSecond: -details.velocity.pixelsPerSecond);
  results.add('Reversed velocity: ${reversed.pixelsPerSecond}');
  print('Reversed velocity: ${reversed.pixelsPerSecond}');

  // Test 18: Callback pattern
  TapDragEndDetails? capturedEnd;
  void onDragEnd(TapDragEndDetails d) {
    capturedEnd = d;
  }
  onDragEnd(details);
  assert(capturedEnd != null, 'Should capture end');
  results.add('Callback pattern works');
  print('Callback captured end details');

  // Test 19: Velocity scaling
  final scaledVel = Offset(horizontalVel * 0.5, verticalVel * 0.5);
  results.add('Scaled velocity (50%): $scaledVel');
  print('Scaled velocity: $scaledVel');

  // Test 20: Summary
  results.add('Properties: velocity, consecutiveTapCount');
  print('TapDragEndDetails: velocity for fling animations, tap count for multi-tap-drag');

  print('TapDragEndDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapDragEndDetails Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Properties: velocity, consecutiveTapCount'),
      Text('Velocity: pixelsPerSecond, speed, direction'),
      Text('Fling: detect and animate based on velocity'),
      Text('Usage: onDragEnd callback'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
