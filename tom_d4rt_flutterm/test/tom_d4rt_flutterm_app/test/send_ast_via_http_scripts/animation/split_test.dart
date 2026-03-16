// D4rt test script: Tests Split from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Split test executing');

  // Split is a Curve that applies two sub-curves: one before a threshold, one after.
  // Test through Split constructor.

  // ========== Basic Split ==========
  print('--- Split(0.5) ---');
  final split = Split(0.5, beginCurve: Curves.easeIn, endCurve: Curves.easeOut);
  final tValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  for (final t in tValues) {
    print('  t=$t: ${split.transform(t).toStringAsFixed(4)}');
  }

  // ========== Split at 0.25 ==========
  print('--- Split(0.25) ---');
  final split25 = Split(0.25, beginCurve: Curves.easeIn, endCurve: Curves.linear);
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  t=$t: ${split25.transform(t).toStringAsFixed(4)}');
  }

  // ========== Split at 0.75 ==========
  print('--- Split(0.75) ---');
  final split75 = Split(0.75, beginCurve: Curves.linear, endCurve: Curves.easeOut);
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  t=$t: ${split75.transform(t).toStringAsFixed(4)}');
  }

  // ========== Boundary ==========
  print('--- Boundary ---');
  print('  transform(0.0): ${split.transform(0.0).toStringAsFixed(4)}');
  print('  transform(1.0): ${split.transform(1.0).toStringAsFixed(4)}');

  print('Split test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Split Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in tValues)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(children: [
                SizedBox(width: 50.0, child: Text('t=$t')),
                Expanded(
                  child: Container(
                    height: 14.0,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: split.transform(t).clamp(0.0, 1.0),
                      child: Container(color: Color(0xFF009688)),
                    ),
                  ),
                ),
              ]),
            ),
        ],
      ),
    ),
  );
}
