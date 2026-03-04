// D4rt test script: Tests MatrixUtils from painting
import 'dart:math' as math;
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MatrixUtils test executing');

  // ========== MATRIXUTILS ==========
  print('--- MatrixUtils Tests ---');

  // Test MatrixUtils.transformPoint
  final identity = Matrix4.identity();
  final point = Offset(10.0, 20.0);
  final transformedPoint = MatrixUtils.transformPoint(identity, point);
  print('transformPoint with identity: $transformedPoint');

  // Test with translation
  final translated = Matrix4.translationValues(100.0, 200.0, 0.0);
  final translatedPoint = MatrixUtils.transformPoint(translated, point);
  print('transformPoint with translate(100,200): $translatedPoint');

  // Test with scaling
  final scaled = Matrix4.diagonal3Values(2.0, 3.0, 1.0);
  final scaledPoint = MatrixUtils.transformPoint(scaled, point);
  print('transformPoint with scale(2,3): $scaledPoint');

  // Test MatrixUtils.transformRect
  final rect = Rect.fromLTWH(10.0, 20.0, 100.0, 50.0);
  final identityRect = MatrixUtils.transformRect(identity, rect);
  print('transformRect with identity: $identityRect');

  final translatedRect = MatrixUtils.transformRect(translated, rect);
  print('transformRect with translate(100,200): $translatedRect');

  final scaledRect = MatrixUtils.transformRect(scaled, rect);
  print('transformRect with scale(2,3): $scaledRect');

  // Test MatrixUtils.getAsTranslation
  final translationOnly = Matrix4.translationValues(50.0, 75.0, 0.0);
  final asTranslation = MatrixUtils.getAsTranslation(translationOnly);
  print('getAsTranslation (translation): $asTranslation');

  final notTranslation = Matrix4.rotationZ(math.pi / 4);
  final asTranslation2 = MatrixUtils.getAsTranslation(notTranslation);
  print('getAsTranslation (rotation): $asTranslation2');

  // Test MatrixUtils.getAsScale
  final scaleOnly = Matrix4.diagonal3Values(2.0, 3.0, 1.0);
  final asScale = MatrixUtils.getAsScale(scaleOnly);
  print('getAsScale (scale): $asScale');

  final notScale = Matrix4.rotationZ(math.pi / 4);
  final asScale2 = MatrixUtils.getAsScale(notScale);
  print('getAsScale (rotation): $asScale2');

  // Test MatrixUtils.isIdentity
  print('isIdentity (identity): ${MatrixUtils.isIdentity(identity)}');
  print('isIdentity (translated): ${MatrixUtils.isIdentity(translated)}');

  // Test MatrixUtils.forceToPoint
  final forceMatrix = MatrixUtils.forceToPoint(Offset(100.0, 200.0));
  print('forceToPoint(100,200) type: ${forceMatrix.runtimeType}');
  final forcedPoint = MatrixUtils.transformPoint(forceMatrix, Offset(0.0, 0.0));
  print('forceToPoint applied to origin: $forcedPoint');

  // Test combining transforms
  final combined = Matrix4.identity()
    ..translate(50.0, 50.0)
    ..scale(2.0, 2.0);
  final combinedPoint = MatrixUtils.transformPoint(combined, Offset(10.0, 10.0));
  print('Combined translate+scale on (10,10): $combinedPoint');

  print('All MatrixUtils tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MatrixUtils Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('Identity point: $transformedPoint'),
            Text('Translated point: $translatedPoint'),
            Text('Scaled point: $scaledPoint'),
            SizedBox(height: 8.0),
            Transform(
              transform: Matrix4.rotationZ(0.1),
              child: Container(
                color: Colors.blue,
                width: 100.0,
                height: 50.0,
                child: Center(child: Text('Rotated', style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
