// D4rt test script: Tests PathMetricIterator from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PathMetricIterator test executing');

  // Create a path with multiple contours
  final path = Path()
    ..addRect(Rect.fromLTWH(0, 0, 100, 50))
    ..addOval(Rect.fromCircle(center: Offset(200, 50), radius: 30));

  final metrics = path.computeMetrics();
  print('PathMetrics type: ${metrics.runtimeType}');

  // Get iterator
  final iterator = metrics.iterator;
  print('Iterator type: ${iterator.runtimeType}');
  print('is PathMetricIterator: ${iterator is PathMetricIterator}');

  // Iterate manually
  var count = 0;
  while (iterator.moveNext()) {
    final metric = iterator.current;
    print('Contour $count: length=${metric.length.toStringAsFixed(1)}, isClosed=${metric.isClosed}');
    count++;
  }
  print('Total contours: $count');

  // Second path — single line
  final path2 = Path()..moveTo(0, 0)..lineTo(100, 0);
  final metrics2 = path2.computeMetrics();
  final iter2 = metrics2.iterator;
  if (iter2.moveNext()) {
    print('Line contour: length=${iter2.current.length}, isClosed=${iter2.current.isClosed}');
  }
  print('Has more: ${iter2.moveNext()}');

  print('PathMetricIterator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PathMetricIterator Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Iterator from path with 2 contours'),
      Text('Total contours iterated: $count'),
      Text('moveNext + current pattern'),
    ],
  );
}
