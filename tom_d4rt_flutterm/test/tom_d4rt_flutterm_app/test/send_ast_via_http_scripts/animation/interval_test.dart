// D4rt test script: Tests Interval from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Interval test executing');

  // ========== Basic Interval ==========
  print('--- Interval(0.0, 1.0) ---');
  final full = Interval(0.0, 1.0);
  final tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  for (final t in tValues) {
    print('  t=$t: ${full.transform(t).toStringAsFixed(4)}');
  }

  // ========== Partial Interval ==========
  print('--- Interval(0.25, 0.75) ---');
  final partial = Interval(0.25, 0.75);
  for (final t in [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0]) {
    print('  t=$t: ${partial.transform(t).toStringAsFixed(4)}');
  }

  // ========== First half only ==========
  print('--- Interval(0.0, 0.5) ---');
  final firstHalf = Interval(0.0, 0.5);
  for (final t in tValues) {
    print('  t=$t: ${firstHalf.transform(t).toStringAsFixed(4)}');
  }

  // ========== Second half only ==========
  print('--- Interval(0.5, 1.0) ---');
  final secondHalf = Interval(0.5, 1.0);
  for (final t in tValues) {
    print('  t=$t: ${secondHalf.transform(t).toStringAsFixed(4)}');
  }

  // ========== With curve ==========
  print('--- Interval(0.0, 1.0, curve: easeIn) ---');
  final eased = Interval(0.0, 1.0, curve: Curves.easeIn);
  for (final t in tValues) {
    print('  t=$t: ${eased.transform(t).toStringAsFixed(4)}');
  }

  print('Interval test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Interval Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Interval(0.25, 0.75) at t=0.5: ${partial.transform(0.5).toStringAsFixed(3)}'),
          Text('Interval(0.0, 0.5) at t=0.25: ${firstHalf.transform(0.25).toStringAsFixed(3)}'),
          Text('Interval(0.5, 1.0) at t=0.75: ${secondHalf.transform(0.75).toStringAsFixed(3)}'),
        ],
      ),
    ),
  );
}
