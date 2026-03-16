// D4rt test script: Tests ElasticOutCurve from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ElasticOutCurve test executing');

  // ========== Default period ==========
  print('--- Default ElasticOutCurve ---');
  final curve = ElasticOutCurve();
  final tValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  for (final t in tValues) {
    print('  t=$t: ${curve.transform(t).toStringAsFixed(4)}');
  }

  // ========== Custom period ==========
  print('--- ElasticOutCurve(period: 0.2) ---');
  final tight = ElasticOutCurve(0.2);
  for (final t in [0.25, 0.5, 0.75]) {
    print('  tight($t): ${tight.transform(t).toStringAsFixed(4)}');
  }

  // ========== Compared to ElasticIn (should be mirror) ==========
  print('--- Compared to ElasticIn ---');
  final elasticIn = ElasticInCurve();
  for (final t in [0.25, 0.5, 0.75]) {
    print('  in($t)=${elasticIn.transform(t).toStringAsFixed(4)}, out($t)=${curve.transform(t).toStringAsFixed(4)}');
  }

  print('ElasticOutCurve test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ElasticOutCurve Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in tValues)
            Text('t=$t: ${curve.transform(t).toStringAsFixed(4)}'),
        ],
      ),
    ),
  );
}
