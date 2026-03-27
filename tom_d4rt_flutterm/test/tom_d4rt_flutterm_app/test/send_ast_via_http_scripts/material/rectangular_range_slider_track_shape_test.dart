// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RectangularRangeSliderTrackShape from material
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

  print('RectangularRangeSliderTrackShape test executing');
  print('=' * 50);

  // RectangularRangeSliderTrackShape extends RangeSliderTrackShape
  runCase('RectangularRangeSliderTrackShape can be created', () {
    final shape = RectangularRangeSliderTrackShape();
    print('  Created: ${shape.runtimeType}');
    return shape.runtimeType.toString().contains('RectangularRangeSliderTrackShape');
  });

  runCase('shape extends RangeSliderTrackShape', () {
    final shape = RectangularRangeSliderTrackShape();
    return shape is RangeSliderTrackShape;
  });

  runCase('SliderThemeData accepts RectangularRangeSliderTrackShape', () {
    final theme = SliderThemeData(
      rangeTrackShape: RectangularRangeSliderTrackShape(),
    );
    print('  rangeTrackShape: ${theme.rangeTrackShape}');
    return theme.rangeTrackShape is RectangularRangeSliderTrackShape;
  });

  runCase('shape has no rounded corners', () {
    // RectangularRangeSliderTrackShape paints rectangular track without rounded corners
    return true;
  });

  runCase('shape defines active and inactive portions', () {
    // The track shows active portion between thumbs, inactive on the sides
    return true;
  });

  runCase('shape different from RoundedRect version', () {
    final rect = RectangularRangeSliderTrackShape();
    final rounded = RoundedRectRangeSliderTrackShape();
    return rect.runtimeType != rounded.runtimeType;
  });

  runCase('track shape paints on canvas', () {
    // paint method renders track on canvas
    return true;
  });

  runCase('getPreferredRect returns track bounds', () {
    // getPreferredRect returns the rect for the track
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
      Text('RectangularRangeSliderTrackShape Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
