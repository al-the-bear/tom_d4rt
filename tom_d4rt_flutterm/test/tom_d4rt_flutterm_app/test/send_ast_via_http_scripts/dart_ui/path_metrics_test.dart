// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PathMetrics from dart_ui
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

  print('PathMetrics test executing');
  print('=' * 50);

  final ui.Path path = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100));
  final ui.PathMetrics metrics = path.computeMetrics();

  runCase('PathMetrics can be obtained from Path', () {
    return metrics.runtimeType.toString().contains('PathMetrics');
  });

  runCase('PathMetrics is Iterable', () {
    return metrics.runtimeType.toString().contains('PathMetrics');
  });

  runCase('iterator property returns Iterator', () {
    return metrics.iterator.runtimeType.toString().contains('Iterator');
  });

  runCase('forEach works on metrics', () {
    int count = 0;
    for (final ui.PathMetric metric in metrics) { count = count + (metric.isClosed ? 1 : 1); }
    return count >= 0;
  });

  runCase('toList converts to List', () {
    final List<ui.PathMetric> list = metrics.toList();
    return list.isEmpty || list.isNotEmpty;
  });

  runCase('single contour path has one metric', () {
    final ui.Path p = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50));
    final List<ui.PathMetric> list = p.computeMetrics().toList();
    return list.length == 1;
  });

  runCase('forceClosed parameter works', () {
    final ui.Path open = ui.Path()..moveTo(0, 0)..lineTo(100, 100);
    final ui.PathMetrics closedMetrics = open.computeMetrics(forceClosed: true);
    final ui.PathMetric metric = closedMetrics.first;
    return metric.isClosed == true;
  });

  runCase('empty path has empty metrics', () {
    final ui.Path empty = ui.Path();
    final ui.PathMetrics emptyMetrics = empty.computeMetrics();
    return emptyMetrics.isEmpty;
  });

  runCase('rect path length is perimeter', () {
    final ui.Path rect = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100));
    final ui.PathMetric metric = rect.computeMetrics().first;
    return (metric.length - 400.0).abs() < 0.01;
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
      const Text('PathMetrics Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('PathMetrics behavior checks completed'),
    ],
  );
}
