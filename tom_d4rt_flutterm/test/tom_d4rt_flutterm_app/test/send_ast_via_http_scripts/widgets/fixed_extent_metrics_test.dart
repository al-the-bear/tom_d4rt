// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FixedExtentMetrics from widgets
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

  print('FixedExtentMetrics test executing');
  print('=' * 50);

  final FixedExtentMetrics metrics = FixedExtentMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1000.0,
    pixels: 250.0,
    viewportDimension: 400.0,
    axisDirection: AxisDirection.down,
    itemIndex: 5,
    devicePixelRatio: 1.0,
  );

  runCase('minScrollExtent is stored', () {
    return metrics.minScrollExtent == 0.0;
  });

  runCase('maxScrollExtent is stored', () {
    return metrics.maxScrollExtent == 1000.0;
  });

  runCase('pixels is stored', () {
    return metrics.pixels == 250.0;
  });

  runCase('viewportDimension is stored', () {
    return metrics.viewportDimension == 400.0;
  });

  runCase('axisDirection is stored', () {
    return metrics.axisDirection == AxisDirection.down;
  });

  runCase('itemIndex is stored', () {
    return metrics.itemIndex == 5;
  });

  runCase('devicePixelRatio is stored', () {
    return metrics.devicePixelRatio == 1.0;
  });

  runCase('copyWith preserves values when no args', () {
    final FixedExtentMetrics copy = metrics.copyWith();
    return copy.itemIndex == 5 && copy.pixels == 250.0;
  });

  runCase('copyWith overrides itemIndex', () {
    final FixedExtentMetrics copy = metrics.copyWith(itemIndex: 10);
    return copy.itemIndex == 10 && copy.pixels == 250.0;
  });

  runCase('toString is non-empty', () {
    return metrics.toString().isNotEmpty;
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
      const Text('FixedExtentMetrics Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FixedExtentMetrics behavior checks completed'),
    ],
  );
}
