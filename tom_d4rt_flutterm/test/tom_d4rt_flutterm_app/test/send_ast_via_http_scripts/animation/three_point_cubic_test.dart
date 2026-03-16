// D4rt test script: Tests ThreePointCubic from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ThreePointCubic test executing');

  // ========== Basic ThreePointCubic ==========
  print('--- Basic ThreePointCubic ---');
  final curve = ThreePointCubic(
    Offset(0.05, 0.0),
    Offset(0.133333, 0.06),
    Offset(0.166666, 0.4),
    Offset(0.208333, 0.82),
    Offset(0.25, 1.0),
  );
  final tValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  for (final t in tValues) {
    print('  t=$t: ${curve.transform(t).toStringAsFixed(4)}');
  }

  // ========== Boundary conditions ==========
  print('--- Boundary conditions ---');
  print('  transform(0.0): ${curve.transform(0.0).toStringAsFixed(4)}');
  print('  transform(1.0): ${curve.transform(1.0).toStringAsFixed(4)}');

  // ========== Flipped ==========
  print('--- Flipped ---');
  final flipped = curve.flipped;
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  flipped($t): ${flipped.transform(t).toStringAsFixed(4)}');
  }

  print('ThreePointCubic test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ThreePointCubic Tests',
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
                      widthFactor: curve.transform(t).clamp(0.0, 1.0),
                      child: Container(color: Color(0xFFE91E63)),
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
