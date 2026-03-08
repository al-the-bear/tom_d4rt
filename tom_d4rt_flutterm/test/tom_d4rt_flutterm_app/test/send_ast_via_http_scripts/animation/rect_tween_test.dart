// D4rt test script: Tests RectTween from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RectTween test executing');

  // ========== Basic RectTween ==========
  print('--- Basic RectTween ---');
  final tween = RectTween(
    begin: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    end: Rect.fromLTWH(50.0, 50.0, 200.0, 200.0),
  );
  print('  begin: ${tween.begin}');
  print('  end: ${tween.end}');

  // ========== Lerp at various t ==========
  print('--- Lerp values ---');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final r = tween.lerp(t);
    print('  t=$t: $r');
  }

  // ========== Size changes ==========
  print('--- Size interpolation ---');
  final sizeTween = RectTween(
    begin: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
    end: Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
  );
  final mid = sizeTween.lerp(0.5);
  print('  midpoint size: ${mid!.width} x ${mid.height}');

  // ========== Position changes ==========
  print('--- Position interpolation ---');
  final posTween = RectTween(
    begin: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    end: Rect.fromLTWH(200.0, 100.0, 100.0, 100.0),
  );
  final midPos = posTween.lerp(0.5);
  print('  midpoint position: (${midPos!.left}, ${midPos.top})');

  // ========== Evaluate ==========
  print('--- Evaluate ---');
  final anim = AlwaysStoppedAnimation<double>(0.5);
  final evalResult = tween.evaluate(anim);
  print('  evaluate(0.5): $evalResult');

  print('RectTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('RectTween Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
            Text('t=$t: ${tween.lerp(t)}'),
        ],
      ),
    ),
  );
}
