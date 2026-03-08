// D4rt test script: Tests AnimationMin from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimationMin test executing');

  // ========== Basic AnimationMin ==========
  print('--- Basic AnimationMin ---');
  final first = AlwaysStoppedAnimation<double>(0.3);
  final next = AlwaysStoppedAnimation<double>(0.7);
  final animMin = AnimationMin<double>(first, next);
  print('  first=0.3, next=0.7, min: ${animMin.value}');

  // ========== Min when first < next ==========
  print('--- Min when first < next ---');
  final low = AlwaysStoppedAnimation<double>(0.1);
  final high = AlwaysStoppedAnimation<double>(0.9);
  final minLH = AnimationMin<double>(low, high);
  print('  min(0.1, 0.9): ${minLH.value}');

  // ========== Min with equal values ==========
  print('--- Min with equal values ---');
  final eq1 = AlwaysStoppedAnimation<double>(0.5);
  final eq2 = AlwaysStoppedAnimation<double>(0.5);
  final minEq = AnimationMin<double>(eq1, eq2);
  print('  min(0.5, 0.5): ${minEq.value}');

  // ========== Min with boundary values ==========
  print('--- Min boundary values ---');
  final zero = AlwaysStoppedAnimation<double>(0.0);
  final one = AlwaysStoppedAnimation<double>(1.0);
  final minBound = AnimationMin<double>(zero, one);
  print('  min(0.0, 1.0): ${minBound.value}');

  // ========== Min with negative values ==========
  print('--- Min with negative values ---');
  final neg = AlwaysStoppedAnimation<double>(-0.5);
  final pos = AlwaysStoppedAnimation<double>(0.5);
  final minNeg = AnimationMin<double>(neg, pos);
  print('  min(-0.5, 0.5): ${minNeg.value}');

  // ========== Status ==========
  print('--- Status ---');
  print('  status: ${animMin.status}');

  print('AnimationMin test completed');

  final results = [
    ('min(0.3, 0.7)', animMin.value),
    ('min(0.1, 0.9)', minLH.value),
    ('min(0.5, 0.5)', minEq.value),
    ('min(0.0, 1.0)', minBound.value),
    ('min(-0.5, 0.5)', minNeg.value),
  ];

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('AnimationMin Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final r in results)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(children: [
                SizedBox(width: 150.0, child: Text('${r.$1}:')),
                Text('${r.$2.toStringAsFixed(2)}'),
              ]),
            ),
        ],
      ),
    ),
  );
}
