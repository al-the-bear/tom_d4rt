// D4rt test script: Tests CurveTween from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CurveTween test executing');

  // ========== CurveTween with Curves.easeIn ==========
  print('--- CurveTween with easeIn ---');
  final easeInTween = CurveTween(curve: Curves.easeIn);
  final tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  for (final t in tValues) {
    print('  easeIn($t): ${easeInTween.transform(t).toStringAsFixed(4)}');
  }

  // ========== CurveTween with Curves.easeOut ==========
  print('--- CurveTween with easeOut ---');
  final easeOutTween = CurveTween(curve: Curves.easeOut);
  for (final t in tValues) {
    print('  easeOut($t): ${easeOutTween.transform(t).toStringAsFixed(4)}');
  }

  // ========== CurveTween with linear ==========
  print('--- CurveTween with linear ---');
  final linearTween = CurveTween(curve: Curves.linear);
  for (final t in tValues) {
    print('  linear($t): ${linearTween.transform(t).toStringAsFixed(4)}');
  }

  // ========== CurveTween with bounceOut ==========
  print('--- CurveTween with bounceOut ---');
  final bounceTween = CurveTween(curve: Curves.bounceOut);
  print('  bounceOut(0.5): ${bounceTween.transform(0.5).toStringAsFixed(4)}');
  print('  bounceOut(0.9): ${bounceTween.transform(0.9).toStringAsFixed(4)}');

  // ========== Evaluate via Animation ==========
  print('--- Evaluate ---');
  final anim = AlwaysStoppedAnimation<double>(0.5);
  print('  easeIn.evaluate(0.5): ${easeInTween.evaluate(anim).toStringAsFixed(4)}');

  // ========== Chain with Tween ==========
  print('--- Chain with Tween ---');
  final chained = Tween<double>(begin: 100.0, end: 200.0).chain(easeInTween);
  print('  chained(0.5): ${chained.transform(0.5).toStringAsFixed(2)}');

  print('CurveTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('CurveTween Tests',
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
                      widthFactor: easeInTween.transform(t).clamp(0.0, 1.0),
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
