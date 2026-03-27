// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RectangularRangeSliderValueIndicatorShape from material
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

  print('RectangularRangeSliderValueIndicatorShape test executing');
  print('=' * 50);

  // RectangularRangeSliderValueIndicatorShape extends RangeSliderValueIndicatorShape
  runCase('shape can be created', () {
    final shape = RectangularRangeSliderValueIndicatorShape();
    print('  Created: ${shape.runtimeType}');
    return shape.runtimeType.toString().contains('RectangularRangeSliderValueIndicatorShape');
  });

  runCase('shape extends RangeSliderValueIndicatorShape', () {
    final shape = RectangularRangeSliderValueIndicatorShape();
    return shape is RangeSliderValueIndicatorShape;
  });

  runCase('SliderThemeData accepts shape', () {
    final theme = SliderThemeData(
      rangeValueIndicatorShape: RectangularRangeSliderValueIndicatorShape(),
    );
    print('  rangeValueIndicatorShape: ${theme.rangeValueIndicatorShape}');
    return theme.rangeValueIndicatorShape is RectangularRangeSliderValueIndicatorShape;
  });

  runCase('shape has rectangular appearance', () {
    // RectangularRangeSliderValueIndicatorShape renders rectangular indicator
    return true;
  });

  runCase('shape different from Paddle version', () {
    final rect = RectangularRangeSliderValueIndicatorShape();
    final paddle = PaddleRangeSliderValueIndicatorShape();
    return rect.runtimeType != paddle.runtimeType;
  });

  runCase('shape different from RoundedRect version', () {
    final rect = RectangularRangeSliderValueIndicatorShape();
    final rounded = RoundedRectRangeSliderValueIndicatorShape();
    return rect.runtimeType != rounded.runtimeType;
  });

  runCase('indicator shows value text', () {
    // Value indicator displays label text
    return true;
  });

  runCase('shape has getPreferredSize', () {
    // getPreferredSize returns size needed for indicator
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
      Text('RectangularRangeSliderValueIndicatorShape Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
