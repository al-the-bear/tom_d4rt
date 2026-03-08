// D4rt test script: Tests CatmullRomSpline from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CatmullRomSpline test executing');

  // ========== Basic CatmullRomSpline ==========
  print('--- Basic CatmullRomSpline ---');
  final controlPoints = <Offset>[
    Offset(0.0, 0.0),
    Offset(0.3, 0.8),
    Offset(0.7, 0.2),
    Offset(1.0, 1.0),
  ];
  final spline = CatmullRomSpline(controlPoints);

  // ========== Sample at various t ==========
  print('--- Spline samples ---');
  final tValues = [0.0, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0];
  for (final t in tValues) {
    final point = spline.transform(t);
    print('  t=$t: (${point.dx.toStringAsFixed(3)}, ${point.dy.toStringAsFixed(3)})');
  }

  // ========== Generate sample set ==========
  print('--- Sample set ---');
  final samples = spline.generateSamples();
  print('  Number of samples: ${samples.length}');
  print('  First sample t: ${samples.first.t.toStringAsFixed(4)}');
  print('  Last sample t: ${samples.last.t.toStringAsFixed(4)}');

  // ========== Precomputed spline ==========
  print('--- Precomputed variant ---');
  final precomp = CatmullRomSpline.precompute(controlPoints);
  final precompVal = precomp.transform(0.5);
  print('  precomputed(0.5): (${precompVal.dx.toStringAsFixed(3)}, ${precompVal.dy.toStringAsFixed(3)})');

  print('CatmullRomSpline test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('CatmullRomSpline Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Control points: ${controlPoints.length}'),
          Text('Samples generated: ${samples.length}'),
          for (final t in tValues)
            Text('t=$t: ${spline.transform(t).toString()}'),
        ],
      ),
    ),
  );
}
