// D4rt test script: Tests PathMetric from dart:ui
// Uses for-in pattern to iterate PathMetrics (same as path_metric_iterator_test)
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PathMetric test executing');

  // Create a simple rectangular path and iterate with for-in
  final path = Path()..addRect(Rect.fromLTWH(0, 0, 100, 50));

  var rectLength = 0.0;
  var rectClosed = false;
  var rectIndex = 0;
  for (final metric in path.computeMetrics()) {
    rectLength = metric.length;
    rectClosed = metric.isClosed;
    rectIndex = metric.contourIndex;
    print('PathMetric type: ${metric.runtimeType}');
    print('length: ${metric.length}');
    print('isClosed: ${metric.isClosed}');
    print('contourIndex: ${metric.contourIndex}');
    print(
      'Captured values: length=$rectLength, closed=$rectClosed, index=$rectIndex',
    );

    // getTangentForOffset
    final tangent0 = metric.getTangentForOffset(0.0);
    if (tangent0 != null) {
      print(
        'Tangent at 0: pos=${tangent0.position}, vec=${tangent0.vector}, angle=${tangent0.angle}',
      );
    }

    final tangentMid = metric.getTangentForOffset(metric.length / 2.0);
    if (tangentMid != null) {
      print('Tangent at mid: pos=${tangentMid.position}');
    }

    final tangentEnd = metric.getTangentForOffset(metric.length);
    if (tangentEnd != null) {
      print('Tangent at end: pos=${tangentEnd.position}');
    }

    // extractPath
    final subPath = metric.extractPath(0.0, metric.length / 4.0);
    print('extractPath(0, len/4): ${subPath.runtimeType}');
    final subBounds = subPath.getBounds();
    print('subPath bounds: $subBounds');

    final subPath2 = metric.extractPath(
      metric.length / 4.0,
      metric.length / 2.0,
    );
    print('extractPath(len/4, len/2) bounds: ${subPath2.getBounds()}');
  }

  // Circle path metric using for-in
  final circlePath = Path()
    ..addOval(Rect.fromCircle(center: Offset(50, 50), radius: 25));
  var circleLen = 0.0;
  var circleClosed = false;
  for (final circleMetric in circlePath.computeMetrics()) {
    circleLen = circleMetric.length;
    circleClosed = circleMetric.isClosed;
    print('Circle length: ${circleMetric.length.toStringAsFixed(1)}');
    print('Circle isClosed: ${circleMetric.isClosed}');
  }
  print('Captured circle values: length=$circleLen, closed=$circleClosed');

  print('PathMetric test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PathMetric Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Rect length: ${rectLength.toStringAsFixed(1)}'),
      Text('isClosed: $rectClosed'),
      Text('Circle circumference: ${circleLen.toStringAsFixed(1)}'),
    ],
  );
}
