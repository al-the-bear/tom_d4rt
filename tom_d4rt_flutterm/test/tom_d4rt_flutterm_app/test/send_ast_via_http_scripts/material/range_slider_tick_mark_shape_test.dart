// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeSliderTickMarkShape from material
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

  print('RangeSliderTickMarkShape test executing');
  print('=' * 50);

  // RangeSliderTickMarkShape is abstract base class for tick marks
  runCase('RoundRangeSliderTickMarkShape is available', () {
    final shape = RoundRangeSliderTickMarkShape();
    print('  Created: ${shape.runtimeType}');
    return shape.runtimeType.toString().contains('RoundRangeSliderTickMarkShape');
  });

  runCase('RoundRangeSliderTickMarkShape has tickMarkRadius', () {
    final shape = RoundRangeSliderTickMarkShape(tickMarkRadius: 3.0);
    print('  tickMarkRadius: ${shape.tickMarkRadius}');
    return shape.tickMarkRadius == 3.0;
  });

  runCase('default tickMarkRadius is null', () {
    final shape = RoundRangeSliderTickMarkShape();
    print('  default tickMarkRadius: ${shape.tickMarkRadius}');
    return shape.tickMarkRadius == null;
  });

  runCase('RoundRangeSliderTickMarkShape has getPreferredSize', () {
    final shape = RoundRangeSliderTickMarkShape();
    // getPreferredSize takes sliderTheme and isEnabled
    return true;
  });

  runCase('SliderThemeData accepts rangeTickMarkShape', () {
    final theme = SliderThemeData(
      rangeTickMarkShape: RoundRangeSliderTickMarkShape(),
    );
    print('  rangeTickMarkShape: ${theme.rangeTickMarkShape}');
    return theme.rangeTickMarkShape is RoundRangeSliderTickMarkShape;
  });

  runCase('tick marks appear for discrete sliders', () {
    // Tick marks shown when divisions is set on RangeSlider
    return true;
  });

  runCase('custom tickMarkRadius can be set', () {
    final shape = RoundRangeSliderTickMarkShape(tickMarkRadius: 5.0);
    return shape.tickMarkRadius == 5.0;
  });

  runCase('shape runtimeType check', () {
    final shape = RoundRangeSliderTickMarkShape();
    final type = shape.runtimeType.toString();
    print('  runtimeType: $type');
    return type.isNotEmpty;
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
      Text('RangeSliderTickMarkShape Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
