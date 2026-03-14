// D4rt test script: Tests MatrixUtils static methods from painting
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

dynamic build(BuildContext context) {
  print('MatrixUtils test executing');
  final results = <String>[];

  // ========== MatrixUtils Tests ==========
  print('Testing MatrixUtils static methods...');

  // Test 1: MatrixUtils.forceToPoint
  final matrix1 = Matrix4.identity();
  final point1 = MatrixUtils.transformPoint(matrix1, Offset(10.0, 20.0));
  assert(point1 == Offset(10.0, 20.0), 'Identity should not change point');
  results.add('MatrixUtils.transformPoint identity: $point1');
  print('MatrixUtils.transformPoint: $point1');

  // Test 2: MatrixUtils.transformPoint with translation
  final matrix2 = Matrix4.translationValues(100.0, 50.0, 0.0);
  final point2 = MatrixUtils.transformPoint(matrix2, Offset(10.0, 20.0));
  assert(point2.dx == 110.0, 'Translated X should be 110.0');
  assert(point2.dy == 70.0, 'Translated Y should be 70.0');
  results.add('MatrixUtils.transformPoint translated: $point2');
  print('MatrixUtils.transformPoint translated: $point2');

  // Test 3: MatrixUtils.transformPoint with scale
  final matrix3 = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
  final point3 = MatrixUtils.transformPoint(matrix3, Offset(10.0, 20.0));
  assert(point3.dx == 20.0, 'Scaled X should be 20.0');
  assert(point3.dy == 40.0, 'Scaled Y should be 40.0');
  results.add('MatrixUtils.transformPoint scaled: $point3');
  print('MatrixUtils.transformPoint scaled: $point3');

  // Test 4: MatrixUtils.transformRect with identity
  final rect4 = Rect.fromLTWH(10, 20, 100, 50);
  final transformedRect = MatrixUtils.transformRect(Matrix4.identity(), rect4);
  assert(transformedRect == rect4, 'Identity should not change rect');
  results.add('MatrixUtils.transformRect identity: $transformedRect');
  print('MatrixUtils.transformRect: $transformedRect');

  // Test 5: MatrixUtils.transformRect with translation
  final matrix5 = Matrix4.translationValues(10.0, 10.0, 0.0);
  final rect5 = Rect.fromLTWH(0, 0, 50, 50);
  final transRect = MatrixUtils.transformRect(matrix5, rect5);
  assert(transRect.left == 10.0, 'Translated rect left should be 10.0');
  results.add('MatrixUtils.transformRect translated: left=${transRect.left}');
  print('MatrixUtils.transformRect translated: $transRect');

  // Test 6: MatrixUtils.inverseTransformRect
  final matrix6 = Matrix4.translationValues(20.0, 30.0, 0.0);
  final rect6 = Rect.fromLTWH(20, 30, 100, 100);
  final inverseRect = MatrixUtils.inverseTransformRect(matrix6, rect6);
  assert(inverseRect.left == 0.0, 'Inverse rect left should be 0.0');
  results.add('MatrixUtils.inverseTransformRect: left=${inverseRect.left}');
  print('MatrixUtils.inverseTransformRect: $inverseRect');

  // Test 7: MatrixUtils.getAsTranslation
  final translationMatrix = Matrix4.translationValues(50.0, 75.0, 0.0);
  final translation = MatrixUtils.getAsTranslation(translationMatrix);
  assert(translation != null, 'Should extract translation');
  assert(translation!.dx == 50.0, 'Translation dx should be 50.0');
  results.add('MatrixUtils.getAsTranslation: $translation');
  print('MatrixUtils.getAsTranslation: $translation');

  // Test 8: MatrixUtils.getAsTranslation returns null for non-translation
  final rotationMatrix = Matrix4.rotationZ(0.5);
  final notTranslation = MatrixUtils.getAsTranslation(rotationMatrix);
  assert(notTranslation == null, 'Non-translation should return null');
  results.add('MatrixUtils.getAsTranslation rotation: ${notTranslation}');
  print('MatrixUtils.getAsTranslation for rotation: null');

  // Test 9: MatrixUtils.getAsScale
  final scaleMatrix = Matrix4.diagonal3Values(2.5, 2.5, 1.0);
  final scale = MatrixUtils.getAsScale(scaleMatrix);
  assert(scale != null, 'Should extract scale');
  assert(scale == 2.5, 'Scale should be 2.5');
  results.add('MatrixUtils.getAsScale: $scale');
  print('MatrixUtils.getAsScale: $scale');

  // Test 10: MatrixUtils.matrixEquals
  final matrixA = Matrix4.identity();
  final matrixB = Matrix4.identity();
  final equals = MatrixUtils.matrixEquals(matrixA, matrixB);
  assert(equals == true, 'Identity matrices should be equal');
  results.add('MatrixUtils.matrixEquals: $equals');
  print('MatrixUtils.matrixEquals: $equals');

  // Test 11: MatrixUtils.isIdentity
  final identityCheck = MatrixUtils.isIdentity(Matrix4.identity());
  assert(identityCheck == true, 'Identity matrix should be identity');
  results.add('MatrixUtils.isIdentity: $identityCheck');
  print('MatrixUtils.isIdentity: $identityCheck');

  // Test 12: MatrixUtils.isIdentity false case
  final notIdentity = MatrixUtils.isIdentity(
    Matrix4.translationValues(1, 0, 0),
  );
  assert(notIdentity == false, 'Translated matrix should not be identity');
  results.add('MatrixUtils.isIdentity translated: $notIdentity');
  print('MatrixUtils.isIdentity for translated: $notIdentity');

  // Test 13: Matrix4 operations for utility context
  final combined = Matrix4.identity()
    ..translate(10.0, 20.0)
    ..scale(2.0);
  final combinedPoint = MatrixUtils.transformPoint(combined, Offset.zero);
  results.add('Combined transform: $combinedPoint');
  print('Combined matrix transform: $combinedPoint');

  print('MatrixUtils test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MatrixUtils Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
