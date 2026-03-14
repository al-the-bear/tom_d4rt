// D4rt test script: Tests VelocityTracker(kind) from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VelocityTracker test executing');
  final results = <String>[];

  // ========== VelocityTracker Tests ==========
  print('Testing VelocityTracker...');

  // Test 1: Create VelocityTracker with touch kind
  final tracker1 = VelocityTracker.withKind(PointerDeviceKind.touch);
  assert(tracker1 != null, 'Should create VelocityTracker');
  results.add('VelocityTracker(touch) created');
  print('VelocityTracker with touch kind created');

  // Test 2: Create VelocityTracker with mouse kind
  final tracker2 = VelocityTracker.withKind(PointerDeviceKind.mouse);
  assert(tracker2 != null, 'Should create VelocityTracker');
  results.add('VelocityTracker(mouse) created');
  print('VelocityTracker with mouse kind created');

  // Test 3: Add single position sample
  final time1 = Duration(milliseconds: 0);
  final pos1 = Offset(100.0, 100.0);
  tracker1.addPosition(time1, pos1);
  results.add('Added position: $pos1 at $time1');
  print('Added first position: $pos1 at $time1');

  // Test 4: Add second position sample
  final time2 = Duration(milliseconds: 16);
  final pos2 = Offset(150.0, 120.0);
  tracker1.addPosition(time2, pos2);
  results.add('Added position: $pos2 at $time2');
  print('Added second position: $pos2 at $time2');

  // Test 5: Add third position sample
  final time3 = Duration(milliseconds: 32);
  final pos3 = Offset(200.0, 140.0);
  tracker1.addPosition(time3, pos3);
  results.add('Added position: $pos3 at $time3');
  print('Added third position: $pos3 at $time3');

  // Test 6: Get velocity estimate
  final estimate = tracker1.getVelocityEstimate();
  if (estimate != null) {
    results.add('Velocity estimate: ${estimate.pixelsPerSecond}');
    print('Velocity estimate: ${estimate.pixelsPerSecond}');
  } else {
    results.add('Velocity estimate: null (need more samples)');
    print('Velocity estimate: null');
  }

  // Test 7: Get velocity (with Velocity.zero fallback)
  final velocity = tracker1.getVelocity();
  results.add('Velocity: ${velocity.pixelsPerSecond}');
  print('Velocity: ${velocity.pixelsPerSecond}');

  // Test 8: Calculate expected velocity manually
  final timeDelta = (time3 - time1).inMilliseconds / 1000.0; // in seconds
  final posDelta = pos3 - pos1;
  final expectedVelX = posDelta.dx / timeDelta;
  final expectedVelY = posDelta.dy / timeDelta;
  results.add(
    'Expected velocity: (${expectedVelX.toStringAsFixed(1)}, ${expectedVelY.toStringAsFixed(1)})',
  );
  print('Expected velocity: ($expectedVelX, $expectedVelY)');

  // Test 9: Create tracker with stylus kind
  final tracker3 = VelocityTracker.withKind(PointerDeviceKind.stylus);
  results.add('VelocityTracker(stylus) created');
  print('VelocityTracker with stylus kind created');

  // Test 10: Create tracker with trackpad kind
  final tracker4 = VelocityTracker.withKind(PointerDeviceKind.trackpad);
  results.add('VelocityTracker(trackpad) created');
  print('VelocityTracker with trackpad kind created');

  // Test 11: Multiple position samples for accuracy
  final accurateTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  for (int i = 0; i < 10; i++) {
    accurateTracker.addPosition(
      Duration(milliseconds: i * 16),
      Offset(100.0 + i * 10.0, 100.0 + i * 5.0),
    );
  }
  final accurateVelocity = accurateTracker.getVelocity();
  results.add('Accurate velocity: ${accurateVelocity.pixelsPerSecond}');
  print('Velocity with 10 samples: ${accurateVelocity.pixelsPerSecond}');

  // Test 12: Velocity zero check
  final zeroVelocity = Velocity.zero;
  assert(
    zeroVelocity.pixelsPerSecond == Offset.zero,
    'Zero velocity should be zero',
  );
  results.add('Velocity.zero: ${zeroVelocity.pixelsPerSecond}');
  print('Velocity.zero: ${zeroVelocity.pixelsPerSecond}');

  // Test 13: Horizontal movement only
  final hTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  hTracker.addPosition(Duration(milliseconds: 0), Offset(0, 100));
  hTracker.addPosition(Duration(milliseconds: 16), Offset(50, 100));
  hTracker.addPosition(Duration(milliseconds: 32), Offset(100, 100));
  final hVelocity = hTracker.getVelocity();
  results.add('Horizontal velocity: ${hVelocity.pixelsPerSecond}');
  print('Horizontal velocity: ${hVelocity.pixelsPerSecond}');

  // Test 14: Vertical movement only
  final vTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  vTracker.addPosition(Duration(milliseconds: 0), Offset(100, 0));
  vTracker.addPosition(Duration(milliseconds: 16), Offset(100, 50));
  vTracker.addPosition(Duration(milliseconds: 32), Offset(100, 100));
  final vVelocity = vTracker.getVelocity();
  results.add('Vertical velocity: ${vVelocity.pixelsPerSecond}');
  print('Vertical velocity: ${vVelocity.pixelsPerSecond}');

  // Test 15: Velocity magnitude (speed)
  final speed = velocity.pixelsPerSecond.distance;
  results.add('Speed: ${speed.toStringAsFixed(2)} px/s');
  print('Speed (velocity magnitude): $speed px/s');

  // Test 16: Velocity direction
  final direction = velocity.pixelsPerSecond.direction;
  results.add('Direction: ${direction.toStringAsFixed(4)} rad');
  print('Velocity direction: $direction radians');

  // Test 17: Create new tracker for fresh test
  final freshTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  results.add('Fresh tracker created');
  print('Created fresh velocity tracker');

  // Test 18: Negative velocity (moving backwards)
  final negTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  negTracker.addPosition(Duration(milliseconds: 0), Offset(200, 200));
  negTracker.addPosition(Duration(milliseconds: 16), Offset(150, 150));
  negTracker.addPosition(Duration(milliseconds: 32), Offset(100, 100));
  final negVelocity = negTracker.getVelocity();
  results.add('Negative velocity: ${negVelocity.pixelsPerSecond}');
  print('Negative velocity (backwards): ${negVelocity.pixelsPerSecond}');

  // Test 19: PointerDeviceKind values
  final kinds = PointerDeviceKind.values;
  results.add('Device kinds: ${kinds.length} types');
  print('PointerDeviceKind values: $kinds');

  // Test 20: Velocity clamp concept
  final maxVelocity = 8000.0; // typical max fling velocity
  final clampedSpeed = speed.clamp(0.0, maxVelocity);
  results.add('Clamped speed: ${clampedSpeed.toStringAsFixed(2)}');
  print('Clamped speed (max $maxVelocity): $clampedSpeed');

  print('VelocityTracker test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VelocityTracker Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
