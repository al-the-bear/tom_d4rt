// D4rt test script: Tests IntTween from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IntTween test executing');

  // ========== Basic IntTween ==========
  print('--- Basic IntTween(0, 100) ---');
  final tween = IntTween(begin: 0, end: 100);
  final tValues = [0.0, 0.1, 0.25, 0.5, 0.75, 0.9, 1.0];
  for (final t in tValues) {
    print('  t=$t: ${tween.lerp(t)}');
  }

  // ========== Negative range ==========
  print('--- IntTween(-50, 50) ---');
  final negTween = IntTween(begin: -50, end: 50);
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  t=$t: ${negTween.lerp(t)}');
  }

  // ========== Reverse direction ==========
  print('--- IntTween(100, 0) ---');
  final reverseTween = IntTween(begin: 100, end: 0);
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  t=$t: ${reverseTween.lerp(t)}');
  }

  // ========== Small range ==========
  print('--- IntTween(0, 3) ---');
  final smallTween = IntTween(begin: 0, end: 3);
  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    print('  t=$t: ${smallTween.lerp(t)}');
  }

  // ========== Evaluate ==========
  print('--- Evaluate ---');
  final anim = AlwaysStoppedAnimation<double>(0.5);
  print('  evaluate(0.5): ${tween.evaluate(anim)}');

  print('IntTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('IntTween Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in tValues)
            Text('IntTween(0,100) at t=$t: ${tween.lerp(t)}'),
        ],
      ),
    ),
  );
}
