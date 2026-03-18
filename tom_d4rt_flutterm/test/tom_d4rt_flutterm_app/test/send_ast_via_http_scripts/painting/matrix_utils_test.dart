// D4rt test script: Tests MatrixUtils from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MatrixUtils test executing');

  // MatrixUtils is a utility class with static methods
  print('MatrixUtils provides matrix transformation utilities');

  // Create a transform
  final matrix = Matrix4.identity();
  matrix.translateByDouble(100.0, 50.0, 0, 1);
  matrix.rotateZ(0.5);

  // transformPoint
  print('\nMatrixUtils.transformPoint:');
  final point = Offset(10, 20);
  final transformed = MatrixUtils.transformPoint(matrix, point);
  print('Original: $point');
  print('Transformed: $transformed');

  // transformRect
  print('\nMatrixUtils.transformRect:');
  final rect = Rect.fromLTWH(0, 0, 100, 100);
  final transformedRect = MatrixUtils.transformRect(matrix, rect);
  print('Original: $rect');
  print('Transformed bounds: $transformedRect');

  // inverseTransformRect
  print('\nMatrixUtils.inverseTransformRect:');
  print('Transforms rect from parent to local coords');

  // getAsTranslation
  print('\nMatrixUtils.getAsTranslation:');
  final translationOnly = Matrix4.translationValues(10, 20, 0);
  final offset = MatrixUtils.getAsTranslation(translationOnly);
  print('Translation-only matrix -> $offset');

  // getAsScale
  print('\nMatrixUtils.getAsScale:');
  final scaleOnly = Matrix4.diagonal3Values(2, 2, 1);
  final scale = MatrixUtils.getAsScale(scaleOnly);
  print('Scale-only matrix -> $scale');

  // isIdentity
  print('\nMatrixUtils.isIdentity:');
  print('Identity: ${MatrixUtils.isIdentity(Matrix4.identity())}');
  print('Translated: ${MatrixUtils.isIdentity(matrix)}');

  // forceToPoint
  print('\nMatrixUtils.forceToPoint:');
  print('Creates matrix placing all points at same location');

  print('\nMatrixUtils test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MatrixUtils Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Matrix transformation utilities'),
      Text('transformPoint, transformRect'),
      Text('getAsTranslation, getAsScale'),
    ],
  );
}
