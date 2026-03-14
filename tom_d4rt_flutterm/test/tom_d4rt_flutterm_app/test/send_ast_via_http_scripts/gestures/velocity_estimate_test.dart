// D4rt test script: Tests VelocityEstimate(pixelsPerSecond, confidence, duration, offset) from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VelocityEstimate test executing');
  final results = <String>[];

  // ========== VelocityEstimate Tests ==========
  print('Testing VelocityEstimate...');

  // Test 1: Create VelocityEstimate
  final estimate1 = VelocityEstimate(
    pixelsPerSecond: Offset(500.0, 300.0),
    confidence: 0.95,
    duration: Duration(milliseconds: 100),
    offset: Offset(50.0, 30.0),
  );
  assert(estimate1 != null, 'Should create VelocityEstimate');
  results.add('VelocityEstimate created');
  print('VelocityEstimate created: ${estimate1.runtimeType}');

  // Test 2: pixelsPerSecond property
  assert(
    estimate1.pixelsPerSecond == Offset(500.0, 300.0),
    'pixelsPerSecond should match',
  );
  results.add('pixelsPerSecond: ${estimate1.pixelsPerSecond}');
  print('pixelsPerSecond: ${estimate1.pixelsPerSecond}');

  // Test 3: confidence property
  assert(estimate1.confidence == 0.95, 'Confidence should be 0.95');
  results.add('confidence: ${estimate1.confidence}');
  print('confidence: ${estimate1.confidence}');

  // Test 4: duration property
  assert(
    estimate1.duration == Duration(milliseconds: 100),
    'Duration should match',
  );
  results.add('duration: ${estimate1.duration}');
  print('duration: ${estimate1.duration}');

  // Test 5: offset property
  assert(estimate1.offset == Offset(50.0, 30.0), 'Offset should match');
  results.add('offset: ${estimate1.offset}');
  print('offset: ${estimate1.offset}');

  // Test 6: Speed calculation (magnitude of pixelsPerSecond)
  final speed = estimate1.pixelsPerSecond.distance;
  results.add('Speed: ${speed.toStringAsFixed(2)} px/s');
  print('Speed: $speed px/s');

  // Test 7: High confidence estimate
  final highConfidence = VelocityEstimate(
    pixelsPerSecond: Offset(1000.0, 800.0),
    confidence: 1.0,
    duration: Duration(milliseconds: 200),
    offset: Offset(200.0, 160.0),
  );
  assert(highConfidence.confidence == 1.0, 'High confidence should be 1.0');
  results.add('High confidence: ${highConfidence.confidence}');
  print('High confidence estimate: ${highConfidence.confidence}');

  // Test 8: Low confidence estimate
  final lowConfidence = VelocityEstimate(
    pixelsPerSecond: Offset(100.0, 50.0),
    confidence: 0.3,
    duration: Duration(milliseconds: 50),
    offset: Offset(5.0, 2.5),
  );
  assert(lowConfidence.confidence == 0.3, 'Low confidence should be 0.3');
  results.add('Low confidence: ${lowConfidence.confidence}');
  print('Low confidence estimate: ${lowConfidence.confidence}');

  // Test 9: Horizontal velocity estimate
  final horizontalEst = VelocityEstimate(
    pixelsPerSecond: Offset(800.0, 0.0),
    confidence: 0.9,
    duration: Duration(milliseconds: 80),
    offset: Offset(64.0, 0.0),
  );
  assert(horizontalEst.pixelsPerSecond.dy == 0, 'Y velocity should be 0');
  results.add('Horizontal: ${horizontalEst.pixelsPerSecond}');
  print('Horizontal velocity estimate: ${horizontalEst.pixelsPerSecond}');

  // Test 10: Vertical velocity estimate
  final verticalEst = VelocityEstimate(
    pixelsPerSecond: Offset(0.0, 600.0),
    confidence: 0.85,
    duration: Duration(milliseconds: 75),
    offset: Offset(0.0, 45.0),
  );
  assert(verticalEst.pixelsPerSecond.dx == 0, 'X velocity should be 0');
  results.add('Vertical: ${verticalEst.pixelsPerSecond}');
  print('Vertical velocity estimate: ${verticalEst.pixelsPerSecond}');

  // Test 11: Negative velocity (moving backwards)
  final negativeEst = VelocityEstimate(
    pixelsPerSecond: Offset(-400.0, -200.0),
    confidence: 0.88,
    duration: Duration(milliseconds: 90),
    offset: Offset(-36.0, -18.0),
  );
  assert(negativeEst.pixelsPerSecond.dx < 0, 'X should be negative');
  results.add('Negative: ${negativeEst.pixelsPerSecond}');
  print('Negative velocity estimate: ${negativeEst.pixelsPerSecond}');

  // Test 12: Direction from velocity
  final direction = estimate1.pixelsPerSecond.direction;
  results.add('Direction: ${direction.toStringAsFixed(4)} rad');
  print('Velocity direction: $direction radians');

  // Test 13: Convert direction to degrees
  final degrees = direction * (180.0 / 3.14159);
  results.add('Direction: ${degrees.toStringAsFixed(2)} deg');
  print('Velocity direction: $degrees degrees');

  // Test 14: Obtain VelocityEstimate from VelocityTracker
  final tracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  tracker.addPosition(Duration(milliseconds: 0), Offset(100, 100));
  tracker.addPosition(Duration(milliseconds: 16), Offset(150, 120));
  tracker.addPosition(Duration(milliseconds: 32), Offset(200, 140));
  tracker.addPosition(Duration(milliseconds: 48), Offset(250, 160));
  final trackerEstimate = tracker.getVelocityEstimate();
  results.add('Tracker estimate: ${trackerEstimate?.pixelsPerSecond}');
  print('VelocityEstimate from tracker: ${trackerEstimate?.pixelsPerSecond}');

  // Test 15: Confidence from tracker estimate
  if (trackerEstimate != null) {
    results.add(
      'Tracker confidence: ${trackerEstimate.confidence.toStringAsFixed(3)}',
    );
    print('Tracker estimate confidence: ${trackerEstimate.confidence}');
  } else {
    results.add('Tracker confidence: null');
    print('Tracker estimate is null');
  }

  // Test 16: Duration milliseconds
  final durationMs = estimate1.duration.inMilliseconds;
  results.add('Duration: ${durationMs}ms');
  print('Duration in milliseconds: $durationMs');

  // Test 17: Velocity to Velocity object
  final velocity = Velocity(pixelsPerSecond: estimate1.pixelsPerSecond);
  assert(velocity.pixelsPerSecond == estimate1.pixelsPerSecond, 'Should match');
  results.add('Velocity obj: ${velocity.pixelsPerSecond}');
  print('Velocity object: ${velocity.pixelsPerSecond}');

  // Test 18: Fast fling estimate
  final fastFling = VelocityEstimate(
    pixelsPerSecond: Offset(3000.0, 2500.0),
    confidence: 0.98,
    duration: Duration(milliseconds: 120),
    offset: Offset(360.0, 300.0),
  );
  final flingSpeed = fastFling.pixelsPerSecond.distance;
  results.add('Fling speed: ${flingSpeed.toStringAsFixed(1)} px/s');
  print('Fast fling speed: $flingSpeed px/s');

  // Test 19: Offset distance matches duration concept
  final offsetDistance = estimate1.offset.distance;
  results.add('Offset distance: ${offsetDistance.toStringAsFixed(2)}');
  print('Offset distance: $offsetDistance');

  // Test 20: Calculate velocity from offset and duration
  final durationSeconds = estimate1.duration.inMicroseconds / 1000000.0;
  final calcVelX = estimate1.offset.dx / durationSeconds;
  final calcVelY = estimate1.offset.dy / durationSeconds;
  results.add(
    'Calc velocity: (${calcVelX.toStringAsFixed(1)}, ${calcVelY.toStringAsFixed(1)})',
  );
  print('Calculated velocity: ($calcVelX, $calcVelY)');

  print('VelocityEstimate test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VelocityEstimate Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
