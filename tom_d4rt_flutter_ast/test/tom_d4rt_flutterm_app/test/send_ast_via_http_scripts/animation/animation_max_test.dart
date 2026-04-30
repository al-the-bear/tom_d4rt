// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AnimationMax from animation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimationMax test executing');

  // ========== Basic AnimationMax ==========
  print('--- Basic AnimationMax ---');
  final first = AlwaysStoppedAnimation<double>(0.3);
  final next = AlwaysStoppedAnimation<double>(0.7);
  final animMax = AnimationMax<double>(first, next);
  print('  first.value: ${first.value}');
  print('  next.value: ${next.value}');
  print('  max.value: ${animMax.value}');

  // ========== Max when first > next ==========
  print('--- Max when first > next ---');
  final high = AlwaysStoppedAnimation<double>(0.9);
  final low = AlwaysStoppedAnimation<double>(0.1);
  final maxHL = AnimationMax<double>(high, low);
  print('  high=0.9, low=0.1, max: ${maxHL.value}');

  // ========== Max with equal values ==========
  print('--- Max with equal values ---');
  final eq1 = AlwaysStoppedAnimation<double>(0.5);
  final eq2 = AlwaysStoppedAnimation<double>(0.5);
  final maxEq = AnimationMax<double>(eq1, eq2);
  print('  equal(0.5, 0.5), max: ${maxEq.value}');

  // ========== Max with zero and one ==========
  print('--- Max boundary values ---');
  final zero = AlwaysStoppedAnimation<double>(0.0);
  final one = AlwaysStoppedAnimation<double>(1.0);
  final maxBound = AnimationMax<double>(zero, one);
  print('  max(0.0, 1.0): ${maxBound.value}');

  // ========== Max with negative values ==========
  print('--- Max with negative values ---');
  final neg = AlwaysStoppedAnimation<double>(-0.5);
  final pos = AlwaysStoppedAnimation<double>(0.5);
  final maxNeg = AnimationMax<double>(neg, pos);
  print('  max(-0.5, 0.5): ${maxNeg.value}');

  // ========== Status ==========
  print('--- Status ---');
  print('  status: ${animMax.status}');

  print('AnimationMax test completed');

  final results = [
    ('max(0.3, 0.7)', animMax.value),
    ('max(0.9, 0.1)', maxHL.value),
    ('max(0.5, 0.5)', maxEq.value),
    ('max(0.0, 1.0)', maxBound.value),
    ('max(-0.5, 0.5)', maxNeg.value),
  ];

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AnimationMax Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          for (final r in results)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  SizedBox(width: 150.0, child: Text('${r.$1}:')),
                  Expanded(
                    child: SizedBox(
                      height: 20.0,
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: r.$2.clamp(0.0, 1.0),
                        child: Container(color: Color(0xFF4CAF50)),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(r.$2.toStringAsFixed(2)),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
