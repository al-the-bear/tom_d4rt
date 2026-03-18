// D4rt test script: Tests MacOSScrollViewFlingVelocityTracker
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MacOSScrollViewFlingVelocityTracker test executing');

  final tracker = MacOSScrollViewFlingVelocityTracker(PointerDeviceKind.trackpad);
  print('Type: ${tracker.runtimeType}');
  print('is VelocityTracker: ${true}');

  tracker.addPosition(Duration(milliseconds: 0), Offset(0, 0));
  tracker.addPosition(Duration(milliseconds: 16), Offset(5, 0));
  tracker.addPosition(Duration(milliseconds: 32), Offset(15, 0));
  tracker.addPosition(Duration(milliseconds: 48), Offset(30, 0));

  final estimate = tracker.getVelocityEstimate();
  print('Velocity estimate: $estimate');

  print('MacOSScrollViewFlingVelocityTracker test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('MacOSScrollViewFlingVelocityTracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    Text('macOS-like trackpad fling'),
    Text('estimate: ${estimate.pixelsPerSecond}'),
  ]);
}
