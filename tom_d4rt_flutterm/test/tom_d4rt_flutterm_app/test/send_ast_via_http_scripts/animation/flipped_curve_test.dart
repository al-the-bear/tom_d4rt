// D4rt test script: Tests FlippedCurve from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlippedCurve test executing');

  // ========== Flip easeIn ==========
  print('--- FlippedCurve(easeIn) ---');
  final flipped = FlippedCurve(Curves.easeIn);
  final tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  for (final t in tValues) {
    final orig = Curves.easeIn.transform(t);
    final flip = flipped.transform(t);
    print('  t=$t: original=${orig.toStringAsFixed(4)}, flipped=${flip.toStringAsFixed(4)}');
  }

  // ========== FlippedCurve is reverse of original ==========
  print('--- Verify: flipped(t) = 1 - original(1 - t) ---');
  for (final t in tValues) {
    final expected = 1.0 - Curves.easeIn.transform(1.0 - t);
    final actual = flipped.transform(t);
    print('  t=$t: expected=${expected.toStringAsFixed(4)}, actual=${actual.toStringAsFixed(4)}');
  }

  // ========== Flip linear ==========
  print('--- FlippedCurve(linear) ---');
  final flippedLinear = FlippedCurve(Curves.linear);
  for (final t in tValues) {
    print('  linear flipped($t): ${flippedLinear.transform(t).toStringAsFixed(4)}');
  }

  // ========== Double flip = original ==========
  print('--- Double flip ---');
  final doubleFlip = FlippedCurve(flipped);
  for (final t in [0.25, 0.5, 0.75]) {
    final orig = Curves.easeIn.transform(t);
    final df = doubleFlip.transform(t);
    print('  t=$t: original=${orig.toStringAsFixed(4)}, double-flipped=${df.toStringAsFixed(4)}');
  }

  print('FlippedCurve test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('FlippedCurve Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in tValues)
            Text('t=$t: easeIn=${Curves.easeIn.transform(t).toStringAsFixed(3)}, flipped=${flipped.transform(t).toStringAsFixed(3)}'),
        ],
      ),
    ),
  );
}
