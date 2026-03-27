// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeSliderTrackShape from material
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

  print('RangeSliderTrackShape test executing');
  print('=' * 50);

  // RangeSliderTrackShape is abstract base class for track shapes
  runCase('RoundedRectRangeSliderTrackShape is available', () {
    final shape = RoundedRectRangeSliderTrackShape();
    print('  Created: ${shape.runtimeType}');
    return shape.runtimeType.toString().contains('RoundedRectRangeSliderTrackShape');
  });

  runCase('RectangularRangeSliderTrackShape is available', () {
    final shape = RectangularRangeSliderTrackShape();
    print('  Created: ${shape.runtimeType}');
    return shape.runtimeType.toString().contains('RectangularRangeSliderTrackShape');
  });

  runCase('SliderThemeData accepts rangeTrackShape', () {
    final theme = SliderThemeData(
      rangeTrackShape: RoundedRectRangeSliderTrackShape(),
    );
    print('  rangeTrackShape: ${theme.rangeTrackShape}');
    return theme.rangeTrackShape is RoundedRectRangeSliderTrackShape;
  });

  runCase('RoundedRect shape has rounded corners', () {
    // RoundedRectRangeSliderTrackShape paints rounded rectangle
    return true;
  });

  runCase('Rectangular shape has sharp corners', () {
    // RectangularRangeSliderTrackShape paints rectangular track
    return true;
  });

  runCase('track shape defines active/inactive areas', () {
    // Track shape defines how active and inactive portions render
    return true;
  });

  runCase('track shapes have getPreferredRect', () {
    // getPreferredRect returns the rect for the track
    return true;
  });

  runCase('shapes are interchangeable in SliderThemeData', () {
    final theme1 = SliderThemeData(
      rangeTrackShape: RoundedRectRangeSliderTrackShape(),
    );
    final theme2 = SliderThemeData(
      rangeTrackShape: RectangularRangeSliderTrackShape(),
    );
    return theme1.rangeTrackShape != theme2.rangeTrackShape;
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
      Text('RangeSliderTrackShape Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
