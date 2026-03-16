// D4rt test script: Tests ConstantTween from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ConstantTween test executing');

  // ========== Double ConstantTween ==========
  print('--- Double ConstantTween ---');
  final doubleTween = ConstantTween<double>(42.0);
  print('  value at 0.0: ${doubleTween.lerp(0.0)}');
  print('  value at 0.5: ${doubleTween.lerp(0.5)}');
  print('  value at 1.0: ${doubleTween.lerp(1.0)}');
  print('  begin: ${doubleTween.begin}');
  print('  end: ${doubleTween.end}');

  // ========== String ConstantTween ==========
  print('--- String ConstantTween ---');
  final stringTween = ConstantTween<String>('hello');
  print('  value at 0.0: ${stringTween.lerp(0.0)}');
  print('  value at 1.0: ${stringTween.lerp(1.0)}');

  // ========== Int ConstantTween ==========
  print('--- Int ConstantTween ---');
  final intTween = ConstantTween<int>(7);
  print('  value at 0.0: ${intTween.lerp(0.0)}');
  print('  value at 0.5: ${intTween.lerp(0.5)}');

  // ========== Color ConstantTween ==========
  print('--- Color ConstantTween ---');
  final colorTween = ConstantTween<Color>(Color(0xFFFF5722));
  print('  value at 0.0: ${colorTween.lerp(0.0)}');
  print('  value at 1.0: ${colorTween.lerp(1.0)}');

  // ========== Evaluate via animation ==========
  print('--- Evaluate ---');
  final anim = AlwaysStoppedAnimation<double>(0.7);
  print('  evaluate(0.7): ${doubleTween.evaluate(anim)}');

  print('ConstantTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ConstantTween Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('double(42.0) at t=0: ${doubleTween.lerp(0.0)}'),
          Text('double(42.0) at t=0.5: ${doubleTween.lerp(0.5)}'),
          Text('double(42.0) at t=1: ${doubleTween.lerp(1.0)}'),
          Text('string("hello") at t=0.5: ${stringTween.lerp(0.5)}'),
          Text('int(7) at t=0.5: ${intTween.lerp(0.5)}'),
          Container(
            height: 30.0,
            width: 200.0,
            color: colorTween.lerp(0.5),
            child: Center(child: Text('Constant Color', style: TextStyle(color: Color(0xFFFFFFFF)))),
          ),
        ],
      ),
    ),
  );
}
