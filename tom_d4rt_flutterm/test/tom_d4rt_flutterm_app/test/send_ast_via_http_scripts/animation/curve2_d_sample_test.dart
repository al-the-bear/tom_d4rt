// D4rt test script: Tests Curve2DSample from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Curve2DSample test executing');

  // Curve2DSample holds a sample point from a 2D curve.
  // Generate samples via CatmullRomSpline.

  // ========== Generate samples from spline ==========
  print('--- Curve2DSample from CatmullRomSpline ---');
  final spline = CatmullRomSpline([
    Offset(0.0, 0.0),
    Offset(0.3, 0.8),
    Offset(0.7, 0.2),
    Offset(1.0, 1.0),
  ]);
  final samples = spline.generateSamples();
  print('  Total samples: ${samples.length}');

  // ========== Inspect sample properties ==========
  print('--- Sample properties ---');
  final first = samples.first;
  print('  first.t: ${first.t.toStringAsFixed(4)}');
  print('  first.value: ${first.value}');

  final last = samples.last;
  print('  last.t: ${last.t.toStringAsFixed(4)}');
  print('  last.value: ${last.value}');

  // ========== Check samples at various positions ==========
  print('--- Sample values ---');
  final step = samples.length ~/ 5;
  for (var i = 0; i < samples.length; i += step) {
    final s = samples[i];
    print('  sample[$i] t=${s.t.toStringAsFixed(3)} value=(${s.value.dx.toStringAsFixed(3)}, ${s.value.dy.toStringAsFixed(3)})');
  }

  print('Curve2DSample test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Curve2DSample Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Total samples: ${samples.length}'),
          Text('First: t=${first.t.toStringAsFixed(3)}, value=${first.value}'),
          Text('Last: t=${last.t.toStringAsFixed(3)}, value=${last.value}'),
        ],
      ),
    ),
  );
}
