// D4rt test script: Tests GradientTransform, GradientRotation from painting
import 'dart:math' as math;
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GradientTransform test executing');

  // ========== GRADIENTROTATION ==========
  print('--- GradientRotation Tests ---');

  // GradientRotation is a concrete GradientTransform
  final rotation0 = GradientRotation(0.0);
  print('GradientRotation(0.0) created');
  print('GradientRotation radians: ${rotation0.radians}');

  final rotationPi = GradientRotation(math.pi);
  print('GradientRotation(pi) created');
  print('GradientRotation radians: ${rotationPi.radians}');

  final rotationHalfPi = GradientRotation(math.pi / 2);
  print('GradientRotation(pi/2) created');
  print('GradientRotation radians: ${rotationHalfPi.radians}');

  final rotationQuarterPi = GradientRotation(math.pi / 4);
  print('GradientRotation(pi/4) radians: ${rotationQuarterPi.radians}');

  // Test transform method with a bounds rect
  final bounds = Rect.fromLTWH(0.0, 0.0, 100.0, 100.0);
  final matrix = rotationHalfPi.transform(bounds);
  print('GradientRotation.transform() result type: ${matrix.runtimeType}');
  print('Transform matrix (pi/2): $matrix');

  // Test identity rotation
  final identityMatrix = rotation0.transform(bounds);
  print('Identity rotation transform: $identityMatrix');

  // Test with negative angle
  final rotationNeg = GradientRotation(-math.pi / 4);
  print('GradientRotation(-pi/4) radians: ${rotationNeg.radians}');

  // ========== GRADIENT WITH TRANSFORM ==========
  print('--- Gradient with Transform Tests ---');

  // Test using GradientRotation in a LinearGradient
  final gradient = LinearGradient(
    colors: [Colors.red, Colors.blue],
    transform: GradientRotation(math.pi / 4),
  );
  print('LinearGradient with GradientRotation created');
  print('Gradient transform: ${gradient.transform}');

  // Test RadialGradient with transform
  final radialGradient = RadialGradient(
    colors: [Colors.yellow, Colors.green],
    transform: GradientRotation(math.pi / 3),
  );
  print('RadialGradient with GradientRotation created');

  // Test SweepGradient with transform
  final sweepGradient = SweepGradient(
    colors: [Colors.purple, Colors.orange, Colors.purple],
    transform: GradientRotation(math.pi / 6),
  );
  print('SweepGradient with GradientRotation created');

  print('All GradientTransform tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GradientTransform Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              height: 100.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.blue],
                  transform: GradientRotation(math.pi / 4),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              height: 100.0,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.yellow, Colors.green],
                  transform: GradientRotation(math.pi / 3),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              height: 100.0,
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  colors: [Colors.purple, Colors.orange, Colors.purple],
                  transform: GradientRotation(math.pi / 6),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
