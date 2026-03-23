// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ColorTween from animation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ColorTween test executing');

  // ========== Basic ColorTween ==========
  print('--- Basic ColorTween ---');
  final tween = ColorTween(begin: Color(0xFFFF0000), end: Color(0xFF0000FF));
  print('  begin: ${tween.begin}');
  print('  end: ${tween.end}');

  // ========== Lerp at various t ==========
  print('--- Lerp values ---');
  final tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  final colors = <Color?>[];
  for (final t in tValues) {
    final color = tween.transform(t);
    colors.add(color);
    print('  t=$t: $color');
  }

  // ========== Null begin/end ==========
  print('--- Null begin ---');
  final nullBegin = ColorTween(begin: null, end: Color(0xFF00FF00));
  print('  lerp(0.0): ${nullBegin.transform(0.0)}');
  print('  lerp(1.0): ${nullBegin.transform(1.0)}');

  // ========== Same color ==========
  print('--- Same color ---');
  final same = ColorTween(begin: Color(0xFF808080), end: Color(0xFF808080));
  print('  lerp(0.5): ${same.transform(0.5)}');

  // ========== With transparency ==========
  print('--- With transparency ---');
  final alpha = ColorTween(begin: Color(0x00FF0000), end: Color(0xFFFF0000));
  print('  t=0.0 alpha: ${alpha.transform(0.0)}');
  print('  t=0.5 alpha: ${alpha.transform(0.5)}');
  print('  t=1.0 alpha: ${alpha.transform(1.0)}');

  // ========== Transform (uses Animation) ==========
  print('--- Transform via Animation ---');
  final anim = AlwaysStoppedAnimation<double>(0.5);
  final result = tween.evaluate(anim);
  print('  evaluate at 0.5: $result');

  print('ColorTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ColorTween Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          for (var i = 0; i < tValues.length; i++)
            Container(
              height: 30.0,
              width: 200.0,
              margin: EdgeInsets.symmetric(vertical: 2.0),
              color: colors[i] ?? Color(0x00000000),
              child: Center(
                child: Text(
                  't=${tValues[i]}',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
