// D4rt test script: Tests CatmullRomCurve from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CatmullRomCurve test executing');

  // ========== Basic CatmullRomCurve ==========
  print('--- Basic CatmullRomCurve ---');
  final controlPoints = <Offset>[
    Offset(0.2, 0.2),
    Offset(0.5, 0.8),
    Offset(0.8, 0.2),
  ];
  final curve = CatmullRomCurve(controlPoints);

  // ========== Transform at various t values ==========
  print('--- Transform values ---');
  final tValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  final results = <double>[];
  for (final t in tValues) {
    final v = curve.transform(t);
    results.add(v);
    print('  t=$t: ${v.toStringAsFixed(4)}');
  }

  // ========== Boundary conditions ==========
  print('--- Boundary conditions ---');
  print('  transform(0.0): ${curve.transform(0.0).toStringAsFixed(4)}');
  print('  transform(1.0): ${curve.transform(1.0).toStringAsFixed(4)}');

  // ========== Different control points ==========
  print('--- S-curve control points ---');
  final sCurve = CatmullRomCurve([
    Offset(0.25, 0.1),
    Offset(0.75, 0.9),
  ]);
  print('  sCurve(0.0): ${sCurve.transform(0.0).toStringAsFixed(4)}');
  print('  sCurve(0.5): ${sCurve.transform(0.5).toStringAsFixed(4)}');
  print('  sCurve(1.0): ${sCurve.transform(1.0).toStringAsFixed(4)}');

  print('CatmullRomCurve test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('CatmullRomCurve Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          for (var i = 0; i < tValues.length; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(children: [
                SizedBox(width: 60.0, child: Text('t=${tValues[i]}')),
                Expanded(
                  child: Container(
                    height: 16.0,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: results[i].clamp(0.0, 1.0),
                      child: Container(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(results[i].toStringAsFixed(3)),
              ]),
            ),
        ],
      ),
    ),
  );
}
