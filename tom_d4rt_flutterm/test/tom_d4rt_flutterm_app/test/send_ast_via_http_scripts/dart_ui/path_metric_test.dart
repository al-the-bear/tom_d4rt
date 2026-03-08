// D4rt test script: Tests PathMetric from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PathMetric test executing');

  // Create a simple rectangular path
  final path = Path()
    ..addRect(Rect.fromLTWH(0, 0, 100, 50));
  final metrics = path.computeMetrics();
  final metric = metrics.first;
  print('PathMetric type: ${metric.runtimeType}');
  print('length: ${metric.length}');
  print('isClosed: ${metric.isClosed}');
  print('contourIndex: ${metric.contourIndex}');

  // getTangentForOffset
  final tangent0 = metric.getTangentForOffset(0.0);
  if (tangent0 != null) {
    print('Tangent at 0: pos=${tangent0.position}, vec=${tangent0.vector}, angle=${tangent0.angle}');
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

  final subPath2 = metric.extractPath(metric.length / 4.0, metric.length / 2.0);
  print('extractPath(len/4, len/2) bounds: ${subPath2.getBounds()}');

  // Circle path metric
  final circlePath = Path()
    ..addOval(Rect.fromCircle(center: Offset(50, 50), radius: 25));
  final circleMetric = circlePath.computeMetrics().first;
  print('Circle length: ${circleMetric.length.toStringAsFixed(1)}');
  print('Circle isClosed: ${circleMetric.isClosed}');

  print('PathMetric test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PathMetric Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Rect length: ${metric.length.toStringAsFixed(1)}'),
      Text('isClosed: ${metric.isClosed}'),
      Text('Tangent at 0: ${tangent0?.position}'),
      Text('extractPath: ${subPath.runtimeType}'),
      Text('Circle circumference: ${circleMetric.length.toStringAsFixed(1)}'),
    ],
  );
}
