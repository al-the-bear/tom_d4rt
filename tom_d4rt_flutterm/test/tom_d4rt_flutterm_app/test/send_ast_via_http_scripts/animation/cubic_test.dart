// D4rt test script: Tests Cubic from animation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Cubic test executing');

  // ========== Standard Cubic ==========
  print('--- Standard Cubic (ease) ---');
  final ease = Cubic(0.25, 0.1, 0.25, 1.0);
  final tValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  final results = <double>[];
  for (final t in tValues) {
    final v = ease.transform(t);
    results.add(v);
    print('  t=$t: ${v.toStringAsFixed(4)}');
  }

  // ========== Cubic ease-in ==========
  print('--- Cubic ease-in ---');
  final easeIn = Cubic(0.42, 0.0, 1.0, 1.0);
  print('  easeIn(0.25): ${easeIn.transform(0.25).toStringAsFixed(4)}');
  print('  easeIn(0.50): ${easeIn.transform(0.50).toStringAsFixed(4)}');
  print('  easeIn(0.75): ${easeIn.transform(0.75).toStringAsFixed(4)}');

  // ========== Cubic ease-out ==========
  print('--- Cubic ease-out ---');
  final easeOut = Cubic(0.0, 0.0, 0.58, 1.0);
  print('  easeOut(0.25): ${easeOut.transform(0.25).toStringAsFixed(4)}');
  print('  easeOut(0.50): ${easeOut.transform(0.50).toStringAsFixed(4)}');
  print('  easeOut(0.75): ${easeOut.transform(0.75).toStringAsFixed(4)}');

  // ========== Linear Cubic ==========
  print('--- Linear Cubic ---');
  final linear = Cubic(0.0, 0.0, 1.0, 1.0);
  print('  linear(0.25): ${linear.transform(0.25).toStringAsFixed(4)}');
  print('  linear(0.50): ${linear.transform(0.50).toStringAsFixed(4)}');
  print('  linear(0.75): ${linear.transform(0.75).toStringAsFixed(4)}');

  // ========== Boundary conditions ==========
  print('--- Boundary conditions ---');
  print('  transform(0.0): ${ease.transform(0.0).toStringAsFixed(4)}');
  print('  transform(1.0): ${ease.transform(1.0).toStringAsFixed(4)}');

  // ========== Flipped ==========
  print('--- Flipped ---');
  final flipped = ease.flipped;
  print('  flipped(0.5): ${flipped.transform(0.5).toStringAsFixed(4)}');

  print('Cubic test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Cubic Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Ease curve visualization:'),
          for (var i = 0; i < tValues.length; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                children: [
                  SizedBox(width: 50.0, child: Text('t=${tValues[i]}')),
                  Expanded(
                    child: SizedBox(
                      height: 14.0,
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: results[i].clamp(0.0, 1.0),
                        child: Container(color: Color(0xFF9C27B0)),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(results[i].toStringAsFixed(3)),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
