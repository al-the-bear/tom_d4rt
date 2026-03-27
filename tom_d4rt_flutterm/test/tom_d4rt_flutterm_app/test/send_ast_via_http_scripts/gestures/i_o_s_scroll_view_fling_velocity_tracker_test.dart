// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests IOSScrollViewFlingVelocityTracker from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSScrollViewFlingVelocityTracker test executing');
  print('=' * 50);

  // IOSScrollViewFlingVelocityTracker extends VelocityTracker
  print('Testing IOSScrollViewFlingVelocityTracker class');

  // Create tracker with touch pointer kind
  final tracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('\nTracker created with PointerDeviceKind.touch');
  print('runtimeType: ${tracker.runtimeType}');
  print('is VelocityTracker: ${tracker is VelocityTracker}');
  print('is IOSScrollViewFlingVelocityTracker: ${tracker is IOSScrollViewFlingVelocityTracker}');

  // Add some positions to simulate scroll
  print('\nAdding positions to simulate scroll:');
  final baseTime = Duration.zero;
  tracker.addPosition(baseTime, const Offset(0, 0));
  print('Position 1: (0, 0) at ${baseTime.inMilliseconds}ms');

  tracker.addPosition(baseTime + const Duration(milliseconds: 16), const Offset(0, 10));
  print('Position 2: (0, 10) at 16ms');

  tracker.addPosition(baseTime + const Duration(milliseconds: 32), const Offset(0, 25));
  print('Position 3: (0, 25) at 32ms');

  tracker.addPosition(baseTime + const Duration(milliseconds: 48), const Offset(0, 45));
  print('Position 4: (0, 45) at 48ms');

  tracker.addPosition(baseTime + const Duration(milliseconds: 64), const Offset(0, 70));
  print('Position 5: (0, 70) at 64ms');

  // Get velocity estimate
  final estimate = tracker.getVelocityEstimate();
  print('\nVelocity estimate:');
  if (estimate != null) {
    print('pixelsPerSecond: ${estimate.pixelsPerSecond}');
    print('confidence: ${estimate.confidence}');
    print('duration: ${estimate.duration}');
    print('offset: ${estimate.offset}');
  } else {
    print('No velocity estimate (insufficient data)');
  }

  // Get velocity
  final velocity = tracker.getVelocity();
  print('\nVelocity result:');
  print('pixelsPerSecond: ${velocity.pixelsPerSecond}');

  // Create tracker with different pointer kinds
  print('\nTesting with different PointerDeviceKind:');
  final mouseTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.mouse);
  print('Mouse tracker created');
  mouseTracker.addPosition(Duration.zero, Offset.zero);
  mouseTracker.addPosition(const Duration(milliseconds: 16), const Offset(20, 0));
  print('Horizontal mouse velocity: ${mouseTracker.getVelocity().pixelsPerSecond}');

  final stylusTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.stylus);
  print('Stylus tracker created');
  stylusTracker.addPosition(Duration.zero, Offset.zero);
  stylusTracker.addPosition(const Duration(milliseconds: 16), const Offset(10, 10));
  print('Stylus velocity: ${stylusTracker.getVelocity().pixelsPerSecond}');

  // Test iOS-specific behavior
  print('\niOS scroll view behavior:');
  print('Uses up to 20 samples for velocity estimation');
  print('Mimics UIScrollView fling physics');

  // Compare with regular VelocityTracker
  final regularTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  print('\nRegular VelocityTracker for comparison');
  print('Regular tracker type: ${regularTracker.runtimeType}');

  print('\n' + '=' * 50);
  print('IOSScrollViewFlingVelocityTracker test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IOSScrollViewFlingVelocityTracker Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Extends: VelocityTracker'),
      Text('Purpose: iOS UIScrollView fling behavior'),
      Text('Sample size: 20 positions'),
    ],
  );
}
