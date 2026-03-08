// D4rt test script: Tests ParametricCurve from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ParametricCurve test executing');

  // ParametricCurve is the base class for all curves.
  // Test through concrete implementations.

  // ========== Cubic as ParametricCurve ==========
  print('--- Cubic as ParametricCurve ---');
  final cubic = Cubic(0.25, 0.1, 0.25, 1.0);
  final tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  for (final t in tValues) {
    print('  cubic.transform($t): ${cubic.transform(t).toStringAsFixed(4)}');
  }

  // ========== Interval as ParametricCurve ==========
  print('--- Interval as ParametricCurve ---');
  final interval = Interval(0.2, 0.8);
  for (final t in tValues) {
    print('  interval.transform($t): ${interval.transform(t).toStringAsFixed(4)}');
  }

  // ========== SawTooth as ParametricCurve ==========
  print('--- SawTooth as ParametricCurve ---');
  final sawTooth = SawTooth(3);
  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    print('  sawTooth.transform($t): ${sawTooth.transform(t).toStringAsFixed(4)}');
  }

  // ========== Threshold as ParametricCurve ==========
  print('--- Threshold as ParametricCurve ---');
  final threshold = Threshold(0.5);
  for (final t in tValues) {
    print('  threshold.transform($t): ${threshold.transform(t).toStringAsFixed(4)}');
  }

  // ========== Flipped via .flipped getter ==========
  print('--- Flipped curve ---');
  final flipped = cubic.flipped;
  for (final t in tValues) {
    print('  flipped.transform($t): ${flipped.transform(t).toStringAsFixed(4)}');
  }

  print('ParametricCurve test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ParametricCurve Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Cubic(0.25,0.1,0.25,1.0):'),
          for (final t in tValues)
            Text('  t=$t: ${cubic.transform(t).toStringAsFixed(4)}'),
          SizedBox(height: 4.0),
          Text('SawTooth(3):'),
          for (final t in [0.0, 0.33, 0.66, 1.0])
            Text('  t=$t: ${sawTooth.transform(t).toStringAsFixed(4)}'),
        ],
      ),
    ),
  );
}
