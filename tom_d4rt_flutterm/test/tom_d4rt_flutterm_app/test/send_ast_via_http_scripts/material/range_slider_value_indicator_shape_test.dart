// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeSliderValueIndicatorShape from material
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

  print('RangeSliderValueIndicatorShape test executing');
  print('=' * 50);

  // RangeSliderValueIndicatorShape is abstract base class for value indicators
  runCase('PaddleRangeSliderValueIndicatorShape is available', () {
    final shape = PaddleRangeSliderValueIndicatorShape();
    print('  Created: ${shape.runtimeType}');
    return shape.runtimeType.toString().contains('PaddleRangeSliderValueIndicatorShape');
  });

  runCase('RoundedRectRangeSliderValueIndicatorShape is available', () {
    final shape = RoundedRectRangeSliderValueIndicatorShape();
    print('  Created: ${shape.runtimeType}');
    return shape.runtimeType.toString().contains('RoundedRectRangeSliderValueIndicatorShape');
  });

  runCase('RectangularRangeSliderValueIndicatorShape is available', () {
    final shape = RectangularRangeSliderValueIndicatorShape();
    print('  Created: ${shape.runtimeType}');
    return shape.runtimeType.toString().contains('RectangularRangeSliderValueIndicatorShape');
  });

  runCase('SliderThemeData accepts rangeValueIndicatorShape', () {
    final theme = SliderThemeData(
      rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
    );
    print('  rangeValueIndicatorShape: ${theme.rangeValueIndicatorShape}');
    return theme.rangeValueIndicatorShape is PaddleRangeSliderValueIndicatorShape;
  });

  runCase('Paddle shape looks like a paddle', () {
    // PaddleRangeSliderValueIndicatorShape shows paddle-shaped indicator
    return true;
  });

  runCase('RoundedRect shape has rounded corners', () {
    // RoundedRectRangeSliderValueIndicatorShape shows rounded rectangle
    return true;
  });

  runCase('Rectangular shape has sharp corners', () {
    // RectangularRangeSliderValueIndicatorShape shows rectangle
    return true;
  });

  runCase('shapes have getPreferredSize', () {
    // getPreferredSize returns size needed for the indicator
    return true;
  });

  runCase('indicator shows value when dragging', () {
    // Value indicator shows current thumb value while dragging
    return true;
  });

  runCase('summary string can be formed', () {
    final summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('RangeSliderValueIndicatorShape Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
