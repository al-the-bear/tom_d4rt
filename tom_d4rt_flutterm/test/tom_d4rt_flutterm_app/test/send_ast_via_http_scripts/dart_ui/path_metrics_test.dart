// D4rt test script: Tests PathMetrics (Iterable<PathMetric>) from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PathMetrics test executing');

  // Single contour
  final path1 = Path()..addRect(Rect.fromLTWH(0, 0, 100, 50));
  final metrics1 = path1.computeMetrics();
  print('Single contour: length=${metrics1.length}, isEmpty=${metrics1.isEmpty}');
  print('first: ${metrics1.first.length.toStringAsFixed(1)}');
  print('single: ${metrics1.single.length.toStringAsFixed(1)}');

  // Multiple contours
  final path2 = Path()
    ..addRect(Rect.fromLTWH(0, 0, 100, 50))
    ..addOval(Rect.fromCircle(center: Offset(200, 50), radius: 30))
    ..moveTo(300, 0)
    ..lineTo(400, 100);
  final metrics2 = path2.computeMetrics();
  print('Multi contour: length=${metrics2.length}');
  print('isEmpty: ${metrics2.isEmpty}');
  print('isNotEmpty: ${metrics2.isNotEmpty}');

  // toList
  final list = metrics2.toList();
  print('toList: ${list.length} items');
  for (var i = 0; i < list.length; i++) {
    print('  contour $i: length=${list[i].length.toStringAsFixed(1)}, closed=${list[i].isClosed}');
  }

  // forEach
  var totalLength = 0.0;
  metrics2.forEach((m) { totalLength += m.length; });
  print('Total path length: ${totalLength.toStringAsFixed(1)}');

  // any, every
  final anyLong = metrics2.any((m) => m.length > 100);
  print('any length > 100: $anyLong');
  final allClosed = metrics2.every((m) => m.isClosed);
  print('all closed: $allClosed');

  // take, skip
  final first2 = metrics2.take(2).toList();
  print('take(2): ${first2.length} items');

  // Empty path
  final emptyPath = Path();
  final emptyMetrics = emptyPath.computeMetrics();
  print('Empty path: length=${emptyMetrics.length}, isEmpty=${emptyMetrics.isEmpty}');

  print('PathMetrics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PathMetrics Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Single contour: ${metrics1.length} metric(s)'),
      Text('Multi contour: ${list.length} metrics'),
      Text('Total length: ${totalLength.toStringAsFixed(1)}'),
      Text('any > 100: $anyLong, all closed: $allClosed'),
    ],
  );
}
