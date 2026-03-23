// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Quick check if .first works on PathMetrics
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PathMetrics .first test');

  final path1 = Path()..addRect(Rect.fromLTWH(0, 0, 100, 50));
  
  // Test .first directly on computeMetrics() — no intermediate variable
  final first = path1.computeMetrics().first;
  print('first: $first');
  print('first.length: ${first.length}');

  return Center(
    child: Text('PathMetrics first=${first.length}'),
  );
}
