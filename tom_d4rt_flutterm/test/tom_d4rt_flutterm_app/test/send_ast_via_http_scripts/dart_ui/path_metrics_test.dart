// ignore_for_file: avoid_print
// D4rt test script: Tests PathMetrics (Iterable<PathMetric>) from dart:ui
// NOTE: PathMetrics doesn't support .first/.length/.isEmpty through bridge.
// Must use iterator.moveNext() + iterator.current pattern.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PathMetrics test executing');

  // Single contour - use iterator pattern
  final path1 = Path()..addRect(Rect.fromLTWH(0, 0, 100, 50));
  final metrics1 = path1.computeMetrics();
  final iter1 = metrics1.iterator;
  final hasFirst = iter1.moveNext();
  print('Single contour hasFirst: $hasFirst');
  if (hasFirst) {
    print('first length: ${iter1.current.length.toStringAsFixed(1)}');
    print('first isClosed: ${iter1.current.isClosed}');
  }
  final hasSecond = iter1.moveNext();
  print('hasSecond: $hasSecond');

  // Multiple contours
  final path2 = Path()
    ..addRect(Rect.fromLTWH(0, 0, 100, 50))
    ..addOval(Rect.fromCircle(center: Offset(200, 50), radius: 30))
    ..moveTo(300, 0)
    ..lineTo(400, 100);
  final metrics2 = path2.computeMetrics();
  final iter2 = metrics2.iterator;

  // Count contours using iterator
  var count = 0;
  final lengths = <String>[];
  final closedFlags = <bool>[];
  while (iter2.moveNext()) {
    final m = iter2.current;
    lengths.add(m.length.toStringAsFixed(1));
    closedFlags.add(m.isClosed);
    count++;
  }
  print('Multi contour count: $count');
  for (var i = 0; i < count; i++) {
    print('contour $i: length=${lengths[i]}, closed=${closedFlags[i]}');
  }

  // Empty path
  final emptyPath = Path();
  final emptyMetrics = emptyPath.computeMetrics();
  final emptyIter = emptyMetrics.iterator;
  final emptyHasFirst = emptyIter.moveNext();
  print('Empty path hasFirst: $emptyHasFirst');

  // for-in loop (Iterable iteration)
  final path3 = Path()
    ..addRect(Rect.fromLTWH(0, 0, 50, 50))
    ..addRect(Rect.fromLTWH(100, 0, 50, 50));
  var forInCount = 0;
  for (final m in path3.computeMetrics()) {
    print('for-in contour $forInCount: length=${m.length.toStringAsFixed(1)}');
    forInCount++;
  }
  print('for-in total: $forInCount');

  print('PathMetrics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PathMetrics Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Single contour OK'),
      Text('Multi contour: $count'),
      Text('Empty path: no contours'),
      Text('for-in iteration: $forInCount contours'),
    ],
  );
}
