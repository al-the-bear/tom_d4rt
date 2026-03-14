// D4rt test script: Tests VelocityTracker from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VelocityTracker test executing');

  // Create VelocityTracker
  final tracker = VelocityTracker.withKind(PointerDeviceKind.touch);

  print('Created: ${tracker.runtimeType}');

  // Add some sample points
  print('\nAdding sample points:');
  final baseTime = Duration(milliseconds: 0);
  tracker.addPosition(baseTime, Offset(0.0, 0.0));
  print('Added: (0, 0) at 0ms');

  tracker.addPosition(Duration(milliseconds: 20), Offset(40.0, 20.0));
  print('Added: (40, 20) at 20ms');

  tracker.addPosition(Duration(milliseconds: 40), Offset(80.0, 40.0));
  print('Added: (80, 40) at 40ms');

  tracker.addPosition(Duration(milliseconds: 60), Offset(120.0, 60.0));
  print('Added: (120, 60) at 60ms');

  // Get velocity estimate
  print('\nVelocity estimate:');
  final estimate = tracker.getVelocityEstimate();
  if (estimate != null) {
    print('pixelsPerSecond: ${estimate.pixelsPerSecond}');
    print('confidence: ${estimate.confidence}');
    print('duration: ${estimate.duration}');
    print('offset: ${estimate.offset}');
  } else {
    print('Estimate is null (not enough samples)');
  }

  // Get velocity (simpler)
  print('\nVelocity (simple):');
  final velocity = tracker.getVelocity();
  print('pixelsPerSecond: ${velocity.pixelsPerSecond}');

  // Explain purpose
  print('\nVelocityTracker purpose:');
  print('- Tracks pointer position over time');
  print('- Estimates velocity from samples');
  print('- Uses polynomial fitting');
  print('- Essential for fling gestures');

  // Usage pattern
  print('\nUsage pattern:');
  print('1. Create tracker with pointer kind');
  print('2. addPosition() on each move event');
  print('3. getVelocity() when gesture ends');
  print('4. Use velocity for fling animation');

  // Internal algorithm
  print('\nInternal algorithm:');
  print('- Collects recent position samples');
  print('- Fits polynomial curve');
  print('- Derives velocity from curve');
  print('- Calculates confidence measure');

  print('\nVelocityTracker test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'VelocityTracker Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tracks and estimates velocity'),
      if (estimate != null) ...[
        Text('velocity: ${estimate.pixelsPerSecond}'),
        Text('confidence: ${estimate.confidence.toStringAsFixed(2)}'),
      ],
      Text('Used for: fling detection'),
    ],
  );
}
