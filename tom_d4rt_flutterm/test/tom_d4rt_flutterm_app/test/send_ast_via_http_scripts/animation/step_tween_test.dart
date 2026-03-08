// D4rt test script: Tests StepTween from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StepTween test executing');

  // ========== Basic StepTween ==========
  print('--- StepTween(0, 10) ---');
  final tween = StepTween(begin: 0, end: 10);
  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    print('  t=$t: ${tween.lerp(t)}');
  }

  // ========== StepTween uses floor (truncation) ==========
  print('--- Step behavior (floor) ---');
  final step = StepTween(begin: 0, end: 5);
  for (final t in [0.0, 0.19, 0.2, 0.39, 0.4, 0.59, 0.6, 0.79, 0.8, 0.99, 1.0]) {
    print('  t=$t: ${step.lerp(t)}');
  }

  // ========== Large range ==========
  print('--- StepTween(0, 100) ---');
  final large = StepTween(begin: 0, end: 100);
  print('  t=0.0: ${large.lerp(0.0)}');
  print('  t=0.1: ${large.lerp(0.1)}');
  print('  t=0.5: ${large.lerp(0.5)}');
  print('  t=1.0: ${large.lerp(1.0)}');

  // ========== Reverse ==========
  print('--- StepTween(10, 0) ---');
  final rev = StepTween(begin: 10, end: 0);
  for (final t in [0.0, 0.5, 1.0]) {
    print('  t=$t: ${rev.lerp(t)}');
  }

  // ========== Evaluate ==========
  print('--- Evaluate ---');
  final anim = AlwaysStoppedAnimation<double>(0.33);
  print('  evaluate(0.33): ${tween.evaluate(anim)}');

  print('StepTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('StepTween Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0])
            Text('t=$t: ${tween.lerp(t)}'),
        ],
      ),
    ),
  );
}
