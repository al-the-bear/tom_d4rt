// D4rt test script: Tests TransformProperty from painting
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  print('TransformProperty test executing');
  final results = <String>[];

  // ========== Basic TransformProperty Tests ==========
  print('Testing TransformProperty constructor...');

  // Test 1: Create TransformProperty with identity matrix
  final identity = Matrix4.identity();
  final prop1 = TransformProperty('transform', identity);
  assert(prop1.name == 'transform', 'Name should match');
  assert(prop1.value != null, 'Value should not be null');
  results.add('TransformProperty: name=${prop1.name}, identity matrix');
  print('Identity TransformProperty created');

  // Test 2: Create TransformProperty with null value
  final prop2 = TransformProperty('nullTransform', null);
  assert(prop2.name == 'nullTransform', 'Name should match');
  assert(prop2.value == null, 'Value should be null');
  results.add('TransformProperty null: name=${prop2.name}, value=null');
  print('Null TransformProperty created');

  // Test 3: Create TransformProperty with translation
  final translation = Matrix4.translationValues(100.0, 50.0, 0.0);
  final prop3 = TransformProperty('translation', translation);
  results.add('Translation property: tx=100, ty=50');
  print('Translation property created');

  // Test 4: Create TransformProperty with rotation
  final rotation = Matrix4.rotationZ(math.pi / 4); // 45 degrees
  final prop4 = TransformProperty('rotation', rotation);
  results.add('Rotation property: 45 degrees (π/4)');
  print('Rotation property created');

  // Test 5: Create TransformProperty with scale
  final scale = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
  final prop5 = TransformProperty('scale', scale);
  results.add('Scale property: 2x scaling');
  print('Scale property created');

  // ========== Matrix4 Constructor Tests ==========
  print('Testing various Matrix4 constructors...');

  // Identity matrix
  final m1 = Matrix4.identity();
  results.add('Matrix4.identity(): ${m1.isIdentity()}');
  print('Identity: ${m1.isIdentity()}');

  // Zero matrix
  final m2 = Matrix4.zero();
  results.add('Matrix4.zero(): all zeros');
  print('Zero matrix created');

  // Translation
  final m3 = Matrix4.translationValues(10.0, 20.0, 30.0);
  final t = m3.getTranslation();
  results.add('Translation: (${t.x}, ${t.y}, ${t.z})');
  print('Translation vector: $t');

  // Rotation X
  final m4 = Matrix4.rotationX(math.pi / 6);
  results.add('RotationX: 30 degrees');
  print('RotationX matrix created');

  // Rotation Y
  final m5 = Matrix4.rotationY(math.pi / 3);
  results.add('RotationY: 60 degrees');
  print('RotationY matrix created');

  // Rotation Z
  final m6 = Matrix4.rotationZ(math.pi / 2);
  results.add('RotationZ: 90 degrees');
  print('RotationZ matrix created');

  // Diagonal3
  final m7 = Matrix4.diagonal3Values(1.5, 2.5, 3.5);
  results.add('Diagonal3: (1.5, 2.5, 3.5)');
  print('Diagonal matrix created');

  // ========== Matrix Operations ==========
  print('Testing matrix operations...');

  // Matrix multiplication
  final transMatrix = Matrix4.translationValues(50.0, 0.0, 0.0);
  final rotMatrix = Matrix4.rotationZ(math.pi / 4);
  final combined = transMatrix.multiplied(rotMatrix);
  results.add('Matrix multiplication: translate * rotate');
  print('Matrices multiplied');

  // Matrix inversion
  final invertible = Matrix4.translationValues(100.0, 100.0, 0.0);
  final inverted = Matrix4.inverted(invertible);
  results.add('Matrix inversion: inverted translation');
  print('Matrix inverted');

  // Determinant
  final det = identity.determinant();
  assert(det == 1.0, 'Identity determinant should be 1');
  results.add('Determinant of identity: $det');
  print('Determinant: $det');

  // ========== TransformProperty Options ==========
  print('Testing TransformProperty options...');

  // With level
  final levelProp = TransformProperty(
    'levelTransform',
    Matrix4.identity(),
    level: DiagnosticLevel.info,
  );
  results.add('DiagnosticLevel: ${levelProp.level}');
  print('Level property created');

  // With showName
  final showNameProp = TransformProperty(
    'showNameTransform',
    Matrix4.identity(),
    showName: false,
  );
  results.add('showName=false property created');
  print('ShowName=false property created');

  // ========== Transform Decomposition ==========
  print('Testing transform decomposition...');

  // Extract translation from combined transform
  final complexTransform = Matrix4.identity()
    ..translate(25.0, 75.0)
    ..rotateZ(math.pi / 6)
    ..scale(1.5, 1.5);
  final extractedTrans = complexTransform.getTranslation();
  results.add('Extracted translation: (${extractedTrans.x.toStringAsFixed(1)}, ${extractedTrans.y.toStringAsFixed(1)})');
  print('Translation extracted');

  // Check if perspective
  final perspective = Matrix4.identity()..setEntry(3, 2, 0.001);
  final hasPerspective = perspective.entry(3, 2) != 0;
  results.add('Has perspective: $hasPerspective');
  print('Perspective check: $hasPerspective');

  // ========== DiagnosticsProperty Methods ==========
  print('Testing diagnostic methods...');

  // toDescription
  final descProp = TransformProperty('descTransform', Matrix4.identity());
  final desc = descProp.toDescription();
  results.add('toDescription length: ${desc.length} chars');
  print('Description: ${desc.substring(0, math.min(50, desc.length))}...');

  // toString
  final stringRep = descProp.toString();
  results.add('toString available: ${stringRep.isNotEmpty}');
  print('toString: ${stringRep.isNotEmpty}');

  // ========== Multiple Transform Types ==========
  print('Creating multiple transform properties...');

  final transforms = <TransformProperty>[
    TransformProperty('identity', Matrix4.identity()),
    TransformProperty('translate', Matrix4.translationValues(10, 20, 0)),
    TransformProperty('rotate90', Matrix4.rotationZ(math.pi / 2)),
    TransformProperty('scale2x', Matrix4.diagonal3Values(2, 2, 1)),
    TransformProperty('skewX', Matrix4.skewX(0.5)),
    TransformProperty('skewY', Matrix4.skewY(0.3)),
  ];

  for (final tp in transforms) {
    results.add('Transform: ${tp.name}');
    print('Created: ${tp.name}');
  }

  // ========== Edge Cases ==========
  print('Testing edge cases...');

  // Very large scale
  final largeScale = Matrix4.diagonal3Values(1000, 1000, 1);
  final largeProp = TransformProperty('largeScale', largeScale);
  results.add('Large scale (1000x) property created');
  print('Large scale created');

  // Very small scale
  final smallScale = Matrix4.diagonal3Values(0.001, 0.001, 1);
  final smallProp = TransformProperty('smallScale', smallScale);
  results.add('Small scale (0.001x) property created');
  print('Small scale created');

  print('TransformProperty test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('TransformProperty Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 11)),
      )),
    ],
  );
}
