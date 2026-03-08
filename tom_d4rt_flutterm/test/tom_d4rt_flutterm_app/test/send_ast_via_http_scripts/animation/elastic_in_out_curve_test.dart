// D4rt test script: Tests ElasticInOutCurve from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ElasticInOutCurve test executing');

  // ========== Default period ==========
  print('--- Default ElasticInOutCurve ---');
  final curve = ElasticInOutCurve();
  final tValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  for (final t in tValues) {
    print('  t=$t: ${curve.transform(t).toStringAsFixed(4)}');
  }

  // ========== Custom period ==========
  print('--- ElasticInOutCurve(period: 0.3) ---');
  final custom = ElasticInOutCurve(0.3);
  for (final t in [0.25, 0.5, 0.75]) {
    print('  custom($t): ${custom.transform(t).toStringAsFixed(4)}');
  }

  // ========== Symmetry check ==========
  print('--- Symmetry ---');
  for (final t in [0.1, 0.2, 0.3, 0.4]) {
    final low = curve.transform(t);
    final high = curve.transform(1.0 - t);
    print('  f($t)=${low.toStringAsFixed(4)}, f(${(1.0 - t).toStringAsFixed(1)})=${high.toStringAsFixed(4)}, sum=${(low + high).toStringAsFixed(4)}');
  }

  print('ElasticInOutCurve test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ElasticInOutCurve Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in tValues)
            Text('t=$t: ${curve.transform(t).toStringAsFixed(4)}'),
        ],
      ),
    ),
  );
}
