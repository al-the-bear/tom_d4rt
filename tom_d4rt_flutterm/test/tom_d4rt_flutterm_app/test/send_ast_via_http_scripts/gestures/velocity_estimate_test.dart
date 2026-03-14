// D4rt test script: Tests VelocityEstimate from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VelocityEstimate test executing');

  // Create VelocityEstimate
  final estimate = VelocityEstimate(
    pixelsPerSecond: Offset(500.0, 250.0),
    confidence: 0.95,
    duration: Duration(milliseconds: 200),
    offset: Offset(100.0, 50.0),
  );

  print('Created: ${estimate.runtimeType}');

  // Test velocity properties
  print('\nVelocity properties:');
  print('pixelsPerSecond: ${estimate.pixelsPerSecond}');
  print(
    'pixelsPerSecond.dx: ${estimate.pixelsPerSecond.dx} pixels/sec horizontal',
  );
  print(
    'pixelsPerSecond.dy: ${estimate.pixelsPerSecond.dy} pixels/sec vertical',
  );

  // Test confidence
  print('\nConfidence:');
  print('confidence: ${estimate.confidence}');
  print('0.0 = no confidence, 1.0 = perfect confidence');
  print('Based on polynomial fitting R-squared');

  // Test duration and offset
  print('\nAdditional properties:');
  print('duration: ${estimate.duration}');
  print('offset: ${estimate.offset}');

  // Explain purpose
  print('\nVelocityEstimate purpose:');
  print('- Result from VelocityTracker.getVelocityEstimate()');
  print('- Contains estimated velocity vector');
  print('- Includes confidence measure');
  print('- Used for fling detection');

  // Confidence usage
  print('\nConfidence usage:');
  print('- Low confidence: unreliable estimate');
  print('- High confidence: good for fling');
  print('- Threshold typically ~0.5');

  // Comparison with Velocity
  print('\nVelocityEstimate vs Velocity:');
  print('- VelocityEstimate: includes confidence, duration');
  print('- Velocity: just pixelsPerSecond');
  print('- getVelocity() returns Velocity');
  print('- getVelocityEstimate() returns VelocityEstimate');

  print('\nVelocityEstimate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'VelocityEstimate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Velocity with confidence'),
      Text('pixelsPerSecond: ${estimate.pixelsPerSecond}'),
      Text('confidence: ${estimate.confidence}'),
      Text('duration: ${estimate.duration}'),
    ],
  );
}
