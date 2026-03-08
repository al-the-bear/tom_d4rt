// D4rt test script: Tests AnimationMean from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimationMean test executing');

  // ========== Basic AnimationMean ==========
  print('--- Basic AnimationMean ---');
  final first = AlwaysStoppedAnimation<double>(0.2);
  final next = AlwaysStoppedAnimation<double>(0.8);
  final mean = AnimationMean(left: first, right: next);
  print('  first=0.2, next=0.8, mean: ${mean.value}');

  // ========== Mean with equal values ==========
  print('--- Mean with equal values ---');
  final eq1 = AlwaysStoppedAnimation<double>(0.5);
  final eq2 = AlwaysStoppedAnimation<double>(0.5);
  final meanEq = AnimationMean(left: eq1, right: eq2);
  print('  mean(0.5, 0.5): ${meanEq.value}');

  // ========== Mean with zero and one ==========
  print('--- Mean boundary values ---');
  final zero = AlwaysStoppedAnimation<double>(0.0);
  final one = AlwaysStoppedAnimation<double>(1.0);
  final meanBound = AnimationMean(left: zero, right: one);
  print('  mean(0.0, 1.0): ${meanBound.value}');

  // ========== Mean with different ratios ==========
  print('--- Mean various values ---');
  final pairs = [
    (0.0, 0.0),
    (0.1, 0.9),
    (0.3, 0.7),
    (0.4, 0.6),
    (1.0, 1.0),
  ];
  for (final pair in pairs) {
    final a = AlwaysStoppedAnimation<double>(pair.$1);
    final b = AlwaysStoppedAnimation<double>(pair.$2);
    final m = AnimationMean(left: a, right: b);
    print('  mean(${pair.$1}, ${pair.$2}): ${m.value}');
  }

  // ========== Status ==========
  print('--- Status ---');
  print('  status: ${mean.status}');

  print('AnimationMean test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('AnimationMean Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('mean(0.2, 0.8) = ${mean.value}'),
          Text('mean(0.5, 0.5) = ${meanEq.value}'),
          Text('mean(0.0, 1.0) = ${meanBound.value}'),
          SizedBox(height: 8.0),
          for (final pair in pairs)
            Text('mean(${pair.$1}, ${pair.$2}) = ${((pair.$1 + pair.$2) / 2.0).toStringAsFixed(2)}'),
        ],
      ),
    ),
  );
}
