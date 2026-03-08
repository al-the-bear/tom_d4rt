// D4rt test script: Tests SizeTween from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SizeTween test executing');

  // ========== Basic SizeTween ==========
  print('--- Basic SizeTween ---');
  final tween = SizeTween(
    begin: Size(50.0, 50.0),
    end: Size(200.0, 100.0),
  );
  print('  begin: ${tween.begin}');
  print('  end: ${tween.end}');

  // ========== Lerp at various t ==========
  print('--- Lerp values ---');
  final tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  for (final t in tValues) {
    final s = tween.lerp(t);
    print('  t=$t: ${s!.width.toStringAsFixed(1)} x ${s.height.toStringAsFixed(1)}');
  }

  // ========== Zero to full ==========
  print('--- Zero to full ---');
  final zeroTween = SizeTween(begin: Size.zero, end: Size(300.0, 200.0));
  print('  zero->full at 0.5: ${zeroTween.lerp(0.5)}');

  // ========== Square to rectangle ==========
  print('--- Square to rectangle ---');
  final shapeTween = SizeTween(
    begin: Size(100.0, 100.0),
    end: Size(300.0, 50.0),
  );
  for (final t in tValues) {
    final s = shapeTween.lerp(t);
    print('  t=$t: ${s!.width.toStringAsFixed(0)}x${s.height.toStringAsFixed(0)}');
  }

  // ========== Evaluate ==========
  print('--- Evaluate ---');
  final anim = AlwaysStoppedAnimation<double>(0.5);
  print('  evaluate(0.5): ${tween.evaluate(anim)}');

  print('SizeTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SizeTween Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in tValues)
            Container(
              width: tween.lerp(t)!.width * 0.5,
              height: tween.lerp(t)!.height * 0.5,
              margin: EdgeInsets.symmetric(vertical: 2.0),
              color: Color(0xFF795548),
              child: Center(child: Text('t=$t', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10.0))),
            ),
        ],
      ),
    ),
  );
}
