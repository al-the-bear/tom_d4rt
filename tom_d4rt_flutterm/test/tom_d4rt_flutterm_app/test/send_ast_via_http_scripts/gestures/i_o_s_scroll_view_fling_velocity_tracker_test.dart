import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('IOSScrollViewFlingVelocityTracker test failed: $message');
  }
  logs.add('PASS: $message');
}

String _formatVelocity(Velocity velocity) {
  return '(${velocity.pixelsPerSecond.dx.toStringAsFixed(2)}, '
      '${velocity.pixelsPerSecond.dy.toStringAsFixed(2)})';
}

dynamic build(BuildContext context) {
  print('=== IOSScrollViewFlingVelocityTracker comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final trackerTouch = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  final trackerMouse = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.mouse);

  _expectCondition(
    trackerTouch is VelocityTracker,
    'trackerTouch is a VelocityTracker',
    logs,
  );
  assertionCount++;

  _expectCondition(
    trackerMouse.runtimeType == IOSScrollViewFlingVelocityTracker,
    'trackerMouse runtimeType matches IOSScrollViewFlingVelocityTracker',
    logs,
  );
  assertionCount++;

  print('trackerTouch.runtimeType: ${trackerTouch.runtimeType}');
  print('trackerMouse.runtimeType: ${trackerMouse.runtimeType}');

  final samplePoints = <({Duration t, Offset p})>[
    (t: const Duration(milliseconds: 0), p: const Offset(0, 0)),
    (t: const Duration(milliseconds: 16), p: const Offset(4, 2)),
    (t: const Duration(milliseconds: 32), p: const Offset(12, 6)),
    (t: const Duration(milliseconds: 48), p: const Offset(24, 12)),
    (t: const Duration(milliseconds: 64), p: const Offset(38, 20)),
    (t: const Duration(milliseconds: 80), p: const Offset(56, 31)),
  ];

  for (final point in samplePoints) {
    trackerTouch.addPosition(point.t, point.p);
    trackerMouse.addPosition(point.t, point.p);
    print('addPosition(t=${point.t.inMilliseconds}ms, p=${point.p})');
  }

  final estimateTouch = trackerTouch.getVelocityEstimate();
  final estimateMouse = trackerMouse.getVelocityEstimate();

  _expectCondition(
    estimateTouch != null,
    'touch tracker returns non-null VelocityEstimate after sufficient samples',
    logs,
  );
  assertionCount++;

  _expectCondition(
    estimateMouse != null,
    'mouse tracker returns non-null VelocityEstimate after sufficient samples',
    logs,
  );
  assertionCount++;

  final velocityTouch = trackerTouch.getVelocity();
  final velocityMouse = trackerMouse.getVelocity();

  print('touch estimate pixelsPerSecond: ${estimateTouch?.pixelsPerSecond}');
  print('mouse estimate pixelsPerSecond: ${estimateMouse?.pixelsPerSecond}');
  print('touch velocity: ${_formatVelocity(velocityTouch)}');
  print('mouse velocity: ${_formatVelocity(velocityMouse)}');

  _expectCondition(
    velocityTouch.pixelsPerSecond.distance > 0,
    'touch velocity magnitude is greater than zero',
    logs,
  );
  assertionCount++;

  _expectCondition(
    velocityMouse.pixelsPerSecond.distance > 0,
    'mouse velocity magnitude is greater than zero',
    logs,
  );
  assertionCount++;

  final freshTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  final freshVelocity = freshTracker.getVelocity();
  final freshEstimate = freshTracker.getVelocityEstimate();

  _expectCondition(
    freshEstimate == null,
    'fresh tracker has null VelocityEstimate before input',
    logs,
  );
  assertionCount++;

  _expectCondition(
    freshVelocity.pixelsPerSecond == Offset.zero,
    'fresh tracker velocity defaults to Offset.zero',
    logs,
  );
  assertionCount++;

  freshTracker.addPosition(const Duration(milliseconds: 0), const Offset(10, 10));
  freshTracker.addPosition(const Duration(milliseconds: 2), const Offset(10, 10));
  final lowMovementVelocity = freshTracker.getVelocity();
  print('low movement velocity: ${_formatVelocity(lowMovementVelocity)}');

  _expectCondition(
    lowMovementVelocity.pixelsPerSecond.distance >= 0,
    'low movement velocity call returns finite result',
    logs,
  );
  assertionCount++;

  final summary = <String>[
    'constructors covered for touch and mouse PointerDeviceKind',
    'properties via runtimeType and estimate access covered',
    'behavior via addPosition/getVelocity/getVelocityEstimate covered',
    'edge cases: empty tracker and minimal movement covered',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== IOSScrollViewFlingVelocityTracker comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('IOSScrollViewFlingVelocityTracker Tests'),
      Text('Assertions: $assertionCount'),
      Text('Touch velocity: ${_formatVelocity(velocityTouch)}'),
      Text('Mouse velocity: ${_formatVelocity(velocityMouse)}'),
      Text('Fresh estimate null: ${freshEstimate == null}'),
      Text('Logs: ${logs.length} entries'),
      const Text('Summary widget generated successfully'),
    ],
  );
}// D4rt test script: Tests IOSScrollViewFlingVelocityTracker
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
