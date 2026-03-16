// D4rt test script: Tests Curve2D from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Curve2D test executing');

  // Curve2D is abstract; CatmullRomSpline is a concrete implementation.

  // ========== CatmullRomSpline as Curve2D ==========
  print('--- CatmullRomSpline as Curve2D ---');
  final curve = CatmullRomSpline([
    Offset(0.0, 0.0),
    Offset(0.5, 1.0),
    Offset(1.0, 0.0),
  ]);

  // ========== transform returns Offset ==========
  print('--- transform returns Offset ---');
  final tValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  for (final t in tValues) {
    final point = curve.transform(t);
    print('  t=$t: (${point.dx.toStringAsFixed(3)}, ${point.dy.toStringAsFixed(3)})');
  }

  // ========== generateSamples ==========
  print('--- generateSamples ---');
  final samples = curve.generateSamples();
  print('  sample count: ${samples.length}');

  // ========== Generate with custom tolerance ==========
  print('--- Custom tolerance ---');
  final fineSamples = curve.generateSamples(tolerance: 0.01);
  print('  fine sample count: ${fineSamples.length}');
  final coarseSamples = curve.generateSamples(tolerance: 0.5);
  print('  coarse sample count: ${coarseSamples.length}');

  // ========== findInverse ==========
  print('--- findInverse ---');
  final mid = curve.transform(0.5);
  print('  transform(0.5): (${mid.dx.toStringAsFixed(3)}, ${mid.dy.toStringAsFixed(3)})');

  print('Curve2D test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Curve2D Tests (via CatmullRomSpline)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (final t in tValues)
            Text('t=$t: ${curve.transform(t).toString()}'),
          SizedBox(height: 4.0),
          Text('Default samples: ${samples.length}'),
          Text('Fine samples: ${fineSamples.length}'),
          Text('Coarse samples: ${coarseSamples.length}'),
        ],
      ),
    ),
  );
}
