// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FixedScrollMetrics from widgets
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

  print('FixedScrollMetrics test executing');
  print('=' * 50);

  final FixedScrollMetrics metrics = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 500.0,
    pixels: 100.0,
    viewportDimension: 300.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 2.0,
  );

  runCase('minScrollExtent is stored', () {
    return metrics.minScrollExtent == 0.0;
  });

  runCase('maxScrollExtent is stored', () {
    return metrics.maxScrollExtent == 500.0;
  });

  runCase('pixels is stored', () {
    return metrics.pixels == 100.0;
  });

  runCase('viewportDimension is stored', () {
    return metrics.viewportDimension == 300.0;
  });

  runCase('axisDirection is stored', () {
    return metrics.axisDirection == AxisDirection.down;
  });

  runCase('devicePixelRatio is stored', () {
    return metrics.devicePixelRatio == 2.0;
  });

  runCase('hasContentDimensions is true', () {
    return metrics.hasContentDimensions == true;
  });

  runCase('extentBefore is correct', () {
    return metrics.extentBefore == 100.0;
  });

  runCase('extentAfter is correct', () {
    return metrics.extentAfter == 400.0;
  });

  runCase('copyWith preserves values', () {
    final ScrollMetrics copy = metrics.copyWith();
    return copy.pixels == 100.0 && copy.maxScrollExtent == 500.0;
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
      const Text('FixedScrollMetrics Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FixedScrollMetrics behavior checks completed'),
    ],
  );
}
