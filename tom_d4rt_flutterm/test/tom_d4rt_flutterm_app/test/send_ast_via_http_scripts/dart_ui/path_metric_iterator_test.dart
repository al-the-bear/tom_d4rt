// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PathMetricIterator from dart_ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final List<String> passed = <String>[];
  final List<String> failed = <String>[];

  void runCase(String name, bool Function() body) {
    try {
      if (body()) {
        passed.add(name);
        print('PASS: $name');
      } else {
        failed.add(name);
        print('FAIL: $name');
      }
    } catch (e, s) {
      failed.add('$name threw');
      print('FAIL: $name threw $e');
      print(s.toString());
    }
  }

  print('PathMetricIterator test executing');
  print('=' * 50);

  final ui.Path path = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100));
  final ui.PathMetrics metrics = path.computeMetrics();
  final Iterator<ui.PathMetric> iterator = metrics.iterator;

  runCase('iterator can be obtained from PathMetrics', () {
    return iterator.runtimeType.toString().contains('Iterator');
  });

  runCase('iterator is PathMetricIterator', () {
    return iterator.runtimeType.toString().contains('PathMetricIterator');
  });

  runCase('moveNext returns true for valid path', () {
    final ui.Path p = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50));
    final Iterator<ui.PathMetric> it = p.computeMetrics().iterator;
    return it.moveNext() == true;
  });

  runCase('current returns PathMetric after moveNext', () {
    final ui.Path p = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50));
    final Iterator<ui.PathMetric> it = p.computeMetrics().iterator;
    it.moveNext();
    return it.current.runtimeType == ui.PathMetric;
  });

  runCase('moveNext returns false when exhausted', () {
    final ui.Path p = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50));
    final Iterator<ui.PathMetric> it = p.computeMetrics().iterator;
    it.moveNext();
    final bool second = it.moveNext();
    return second == false;
  });

  runCase('current before moveNext throws', () {
    final ui.Path p = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50));
    final Iterator<ui.PathMetric> it = p.computeMetrics().iterator;
    try {
      it.current;
      return false;
    } on RangeError {
      return true;
    }
  });

  runCase('empty path has no contours', () {
    final ui.Path empty = ui.Path();
    final Iterator<ui.PathMetric> it = empty.computeMetrics().iterator;
    return it.moveNext() == false;
  });

  runCase('multi-contour path has multiple iterations', () {
    final ui.Path p = ui.Path()
      ..addRect(const Rect.fromLTWH(0, 0, 10, 10))
      ..addRect(const Rect.fromLTWH(50, 50, 10, 10));
    final Iterator<ui.PathMetric> it = p.computeMetrics().iterator;
    int count = 0;
    while (it.moveNext()) {
      count++;
    }
    return count == 2;
  });

  runCase('summary string can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('PathMetricIterator Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('PathMetricIterator behavior checks completed'),
    ],
  );
}
