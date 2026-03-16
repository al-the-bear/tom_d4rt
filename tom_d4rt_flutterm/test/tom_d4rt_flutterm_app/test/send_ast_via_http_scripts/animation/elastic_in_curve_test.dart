// D4rt test script: Tests ElasticInCurve from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ElasticInCurve test executing');

  // ========== Default period ==========
  print('--- Default ElasticInCurve ---');
  final curve = ElasticInCurve();
  final tValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  for (final t in tValues) {
    print('  t=$t: ${curve.transform(t).toStringAsFixed(4)}');
  }

  // ========== Custom period ==========
  print('--- ElasticInCurve(period: 0.2) ---');
  final tight = ElasticInCurve(0.2);
  for (final t in [0.25, 0.5, 0.75]) {
    print('  tight($t): ${tight.transform(t).toStringAsFixed(4)}');
  }

  // ========== Large period ==========
  print('--- ElasticInCurve(period: 1.0) ---');
  final wide = ElasticInCurve(1.0);
  for (final t in [0.25, 0.5, 0.75]) {
    print('  wide($t): ${wide.transform(t).toStringAsFixed(4)}');
  }

  // ========== Boundary ==========
  print('--- Boundary ---');
  print('  transform(0.0): ${curve.transform(0.0).toStringAsFixed(4)}');
  print('  transform(1.0): ${curve.transform(1.0).toStringAsFixed(4)}');

  print('ElasticInCurve test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ElasticInCurve Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in tValues)
            Text('t=$t: ${curve.transform(t).toStringAsFixed(4)}'),
        ],
      ),
    ),
  );
}
