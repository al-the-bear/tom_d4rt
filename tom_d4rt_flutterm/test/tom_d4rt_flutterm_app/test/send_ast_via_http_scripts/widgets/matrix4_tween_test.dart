// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Matrix4Tween from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  print('Matrix4Tween test executing');
  print('=' * 50);

  // === Test Matrix4Tween class ===
  print('\nMatrix4Tween interpolates between Matrix4 transformations');

  // Create identity matrices
  print('\n--- Testing Matrix4Tween creation ---');
  final begin = Matrix4.identity();
  final end = Matrix4.identity()..translate(100.0, 50.0);
  final tween = Matrix4Tween(begin: begin, end: end);
  print('Created Matrix4Tween');
  print('tween.runtimeType: ${tween.runtimeType}');
  print('tween.begin: ${tween.begin}');
  print('tween.end: ${tween.end}');

  // Test lerp at various points
  print('\n--- Testing lerp interpolation ---');
  final at0 = tween.lerp(0.0);
  print('lerp(0.0) translation: (${at0.getTranslation().x}, ${at0.getTranslation().y})');
  
  final at05 = tween.lerp(0.5);
  print('lerp(0.5) translation: (${at05.getTranslation().x}, ${at05.getTranslation().y})');
  
  final at1 = tween.lerp(1.0);
  print('lerp(1.0) translation: (${at1.getTranslation().x}, ${at1.getTranslation().y})');

  // Test with rotation
  print('\n--- Testing with rotation ---');
  final rotBegin = Matrix4.identity();
  final rotEnd = Matrix4.identity()..rotateZ(math.pi / 2);
  final rotTween = Matrix4Tween(begin: rotBegin, end: rotEnd);
  print('Created rotation tween (0 to 90 degrees)');
  final rotMid = rotTween.lerp(0.5);
  print('lerp(0.5) approximates 45 degree rotation');

  // Test with scale
  print('\n--- Testing with scale ---');
  final scaleBegin = Matrix4.identity();
  final scaleEnd = Matrix4.identity()..scale(2.0, 2.0);
  final scaleTween = Matrix4Tween(begin: scaleBegin, end: scaleEnd);
  print('Created scale tween (1x to 2x)');
  final scaleMid = scaleTween.lerp(0.5);
  print('lerp(0.5) scale should be ~1.5x');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('tween is Tween<Matrix4>: ${tween is Tween<Matrix4>}');
  print('tween is Animatable<Matrix4>: ${tween is Animatable<Matrix4>}');

  // Test transform method
  print('\n--- Testing transform method ---');
  print('transform(0.25): ${tween.transform(0.25).getTranslation()}');
  print('transform(0.75): ${tween.transform(0.75).getTranslation()}');

  // Test with null begin/end
  print('\n--- Testing default values ---');
  final defaultTween = Matrix4Tween();
  print('Default begin: ${defaultTween.begin}');
  print('Default end: ${defaultTween.end}');

  // Test complex transformation
  print('\n--- Testing complex transformation ---');
  final complexEnd = Matrix4.identity()
    ..translate(50.0, 30.0)
    ..rotateZ(math.pi / 4)
    ..scale(1.5);
  final complexTween = Matrix4Tween(begin: Matrix4.identity(), end: complexEnd);
  print('Complex tween combines translate, rotate, scale');
  print('Uses decomposition for smooth interpolation');

  print('\n' + '=' * 50);
  print('Matrix4Tween test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Matrix4Tween Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('lerp(0.5) x: ${at05.getTranslation().x}'),
      Text('lerp(0.5) y: ${at05.getTranslation().y}'),
      Text('Is Tween<Matrix4>: ${tween is Tween<Matrix4>}'),
    ],
  );
}
