// D4rt test script: Tests IOSScrollViewFlingVelocityTracker
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSScrollViewFlingVelocityTracker test executing');

  final tracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('IOSScrollViewFlingVelocityTracker: ${tracker.runtimeType}');
  print('is VelocityTracker: ${tracker is VelocityTracker}');

  // Add sample points
  tracker.addPosition(Duration(milliseconds: 0), Offset(0, 0));
  tracker.addPosition(Duration(milliseconds: 16), Offset(0, 10));
  tracker.addPosition(Duration(milliseconds: 32), Offset(0, 25));
  tracker.addPosition(Duration(milliseconds: 48), Offset(0, 45));

  final estimate = tracker.getVelocityEstimate();
  print('Velocity estimate: $estimate');
  if (estimate != null) {
    print('pixelsPerSecond: ${estimate.pixelsPerSecond}');
    print('confidence: ${estimate.confidence}');
  }

  print('IOSScrollViewFlingVelocityTracker test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('IOSScrollViewFlingVelocityTracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    Text('iOS-like fling physics'),
    Text('estimate: ${estimate?.pixelsPerSecond}'),
  ]);
}
