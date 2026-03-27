// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeSliderThumbShape from material
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

  print('RangeSliderThumbShape test executing');
  print('=' * 50);

  // RangeSliderThumbShape is abstract base class for RangeSlider thumb shapes
  runCase('RoundRangeSliderThumbShape is available', () {
    final shape = RoundRangeSliderThumbShape();
    print('  Created: ${shape.runtimeType}');
    return shape.runtimeType.toString().contains('RoundRangeSliderThumbShape');
  });

  runCase('RoundRangeSliderThumbShape has enabledThumbRadius', () {
    final shape = RoundRangeSliderThumbShape(enabledThumbRadius: 12.0);
    print('  enabledThumbRadius: ${shape.enabledThumbRadius}');
    return shape.enabledThumbRadius == 12.0;
  });

  runCase('RoundRangeSliderThumbShape has disabledThumbRadius', () {
    final shape = RoundRangeSliderThumbShape(disabledThumbRadius: 8.0);
    print('  disabledThumbRadius: ${shape.disabledThumbRadius}');
    return shape.disabledThumbRadius == 8.0;
  });

  runCase('RoundRangeSliderThumbShape has elevation', () {
    final shape = RoundRangeSliderThumbShape(elevation: 2.0);
    print('  elevation: ${shape.elevation}');
    return shape.elevation == 2.0;
  });

  runCase('RoundRangeSliderThumbShape has pressedElevation', () {
    final shape = RoundRangeSliderThumbShape(pressedElevation: 6.0);
    print('  pressedElevation: ${shape.pressedElevation}');
    return shape.pressedElevation == 6.0;
  });

  runCase('default enabledThumbRadius is 10', () {
    final shape = RoundRangeSliderThumbShape();
    return shape.enabledThumbRadius == 10.0;
  });

  runCase('SliderThemeData accepts rangeThumbShape', () {
    final theme = SliderThemeData(
      rangeThumbShape: RoundRangeSliderThumbShape(),
    );
    print('  rangeThumbShape: ${theme.rangeThumbShape}');
    return theme.rangeThumbShape is RoundRangeSliderThumbShape;
  });

  runCase('RoundRangeSliderThumbShape has getPreferredSize', () {
    final shape = RoundRangeSliderThumbShape();
    final size = shape.getPreferredSize(true, false);
    print('  getPreferredSize: $size');
    return size.width > 0 && size.height > 0;
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
      Text('RangeSliderThumbShape Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
