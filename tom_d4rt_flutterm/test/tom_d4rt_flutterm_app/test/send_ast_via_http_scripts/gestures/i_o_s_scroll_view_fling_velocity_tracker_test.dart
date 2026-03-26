// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSScrollViewFlingVelocityTracker from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSScrollViewFlingVelocityTracker test executing');
  print('=' * 50);

  // Overview
  print('\nIOSScrollViewFlingVelocityTracker overview:');
  print('Purpose: VelocityTracker subclass for iOS-style fling behavior');
  print('Extends: VelocityTracker');
  print('Uses iOS scroll physics for fling velocity estimation');

  // Create with touch kind
  final tracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('\nIOSScrollViewFlingVelocityTracker(touch) created');
  print('runtimeType: ${tracker.runtimeType}');
  print('is VelocityTracker: ${tracker is VelocityTracker}');
  print('is IOSScrollViewFlingVelocityTracker: ${tracker is IOSScrollViewFlingVelocityTracker}');

  // Create with different pointer kinds
  final mouseTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.mouse);
  print('\nIOSScrollViewFlingVelocityTracker(mouse) created');
  print('runtimeType: ${mouseTracker.runtimeType}');

  final stylusTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.stylus);
  print('IOSScrollViewFlingVelocityTracker(stylus) created');
  print('runtimeType: ${stylusTracker.runtimeType}');

  // Simulate pointer movement
  print('\nSimulating pointer movement:');
  tracker.addPosition(Duration(milliseconds: 0), Offset(0, 0));
  print('  Added position at t=0ms: (0, 0)');
  tracker.addPosition(Duration(milliseconds: 16), Offset(0, 10));
  print('  Added position at t=16ms: (0, 10)');
  tracker.addPosition(Duration(milliseconds: 32), Offset(0, 25));
  print('  Added position at t=32ms: (0, 25)');
  tracker.addPosition(Duration(milliseconds: 48), Offset(0, 45));
  print('  Added position at t=48ms: (0, 45)');
  tracker.addPosition(Duration(milliseconds: 64), Offset(0, 70));
  print('  Added position at t=64ms: (0, 70)');

  // Get velocity estimate
  final estimate = tracker.getVelocityEstimate();
  print('\nVelocity estimate:');
  if (estimate != null) {
    print('  pixelsPerSecond: ${estimate.pixelsPerSecond}');
    print('  confidence: ${estimate.confidence}');
    print('  duration: ${estimate.duration}');
    print('  offset: ${estimate.offset}');
  } else {
    print('  No estimate available');
  }

  // Get velocity
  final velocity = tracker.getVelocity();
  print('\nVelocity:');
  print('  pixelsPerSecond: ${velocity.pixelsPerSecond}');

  // Compare with standard VelocityTracker
  print('\n--- Comparison with VelocityTracker ---');
  final standard = VelocityTracker.withKind(PointerDeviceKind.touch);
  standard.addPosition(Duration(milliseconds: 0), Offset(0, 0));
  standard.addPosition(Duration(milliseconds: 16), Offset(0, 10));
  standard.addPosition(Duration(milliseconds: 32), Offset(0, 25));
  standard.addPosition(Duration(milliseconds: 48), Offset(0, 45));
  standard.addPosition(Duration(milliseconds: 64), Offset(0, 70));
  final stdVelocity = standard.getVelocity();
  print('Standard VelocityTracker velocity: ${stdVelocity.pixelsPerSecond}');
  print('iOS tracker velocity: ${velocity.pixelsPerSecond}');
  print('Velocities differ due to iOS-specific algorithm');

  // PointerDeviceKind values
  print('\nPointerDeviceKind values:');
  for (final kind in PointerDeviceKind.values) {
    print('  ${kind.name}');
  }

  print('\n' + '=' * 50);
  print('IOSScrollViewFlingVelocityTracker test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSScrollViewFlingVelocityTracker Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Created with touch, mouse, stylus'),
      Text('Velocity: ${velocity.pixelsPerSecond}'),
      if (estimate != null)
        Text('Confidence: ${estimate.confidence}'),
      Text('Compared with standard VelocityTracker'),
    ],
  );
}
