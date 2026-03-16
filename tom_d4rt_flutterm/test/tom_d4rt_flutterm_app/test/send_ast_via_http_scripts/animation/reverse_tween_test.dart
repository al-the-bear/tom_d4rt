// D4rt test script: Tests ReverseTween from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ReverseTween test executing');

  // ========== Basic ReverseTween ==========
  print('--- ReverseTween ---');
  final original = Tween<double>(begin: 0.0, end: 100.0);
  final reversed = ReverseTween<double>(original);
  print('  original begin: ${original.begin}, end: ${original.end}');
  print('  reversed begin: ${reversed.begin}, end: ${reversed.end}');

  // ========== Lerp comparison ==========
  print('--- Lerp comparison ---');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  t=$t: original=${original.lerp(t).toStringAsFixed(1)}, reversed=${reversed.lerp(t).toStringAsFixed(1)}');
  }

  // ========== Color ReverseTween ==========
  print('--- Color ReverseTween ---');
  final colorTween = ColorTween(begin: Color(0xFFFF0000), end: Color(0xFF0000FF));
  final reversedColor = ReverseTween<Color?>(colorTween);
  print('  original lerp(0.0): ${colorTween.lerp(0.0)}');
  print('  reversed lerp(0.0): ${reversedColor.lerp(0.0)}');

  // ========== Evaluate ==========
  print('--- Evaluate ---');
  final anim = AlwaysStoppedAnimation<double>(0.25);
  print('  original.evaluate(0.25): ${original.evaluate(anim)}');
  print('  reversed.evaluate(0.25): ${reversed.evaluate(anim)}');

  print('ReverseTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ReverseTween Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
            Text('t=$t: orig=${original.lerp(t).toStringAsFixed(0)}, rev=${reversed.lerp(t).toStringAsFixed(0)}'),
        ],
      ),
    ),
  );
}
