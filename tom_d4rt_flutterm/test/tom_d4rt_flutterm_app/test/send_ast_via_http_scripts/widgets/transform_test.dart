// D4rt test script: Tests Transform widget from widgets
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  print('Transform test executing');

  // Test Transform.rotate
  final rotated = Transform.rotate(
    angle: math.pi / 4, // 45 degrees
    child: Container(
      height: 60.0,
      width: 60.0,
      color: Colors.blue,
      child: Center(
        child: Text('45°', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.rotate(45 degrees) created');

  final rotatedOrigin = Transform.rotate(
    angle: math.pi / 6, // 30 degrees
    origin: Offset(30.0, 30.0), // rotate around center
    child: Container(
      height: 60.0,
      width: 60.0,
      color: Colors.green,
      child: Center(
        child: Text('30°', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.rotate with origin created');

  // Test Transform.scale
  final scaled = Transform.scale(
    scale: 1.5,
    child: Container(
      height: 40.0,
      width: 40.0,
      color: Colors.red,
      child: Center(
        child: Text(
          '1.5x',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('Transform.scale(1.5) created');

  final scaledXY = Transform.scale(
    scaleX: 2.0,
    scaleY: 0.5,
    child: Container(
      height: 40.0,
      width: 40.0,
      color: Colors.purple,
      child: Center(
        child: Text(
          '2x0.5',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('Transform.scale(scaleX: 2.0, scaleY: 0.5) created');

  // Test Transform.translate
  final translated = Transform.translate(
    offset: Offset(20.0, 10.0),
    child: Container(
      height: 50.0,
      width: 100.0,
      color: Colors.orange,
      child: Center(
        child: Text('Translated', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.translate(20, 10) created');

  // Test Transform.flip
  final flippedH = Transform.flip(
    flipX: true,
    child: Container(
      height: 50.0,
      width: 100.0,
      color: Colors.teal,
      child: Center(
        child: Text('Flip X', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.flip(flipX: true) created');

  final flippedV = Transform.flip(
    flipY: true,
    child: Container(
      height: 50.0,
      width: 100.0,
      color: Colors.cyan,
      child: Center(
        child: Text('Flip Y', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.flip(flipY: true) created');

  // Test Transform with Matrix4
  final matrix = Matrix4.identity();
  matrix.setEntry(3, 2, 0.001); // perspective
  matrix.rotateY(0.2);

  final perspective = Transform(
    transform: matrix,
    alignment: Alignment.center,
    child: Container(
      height: 80.0,
      width: 120.0,
      color: Colors.indigo,
      child: Center(
        child: Text('3D', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform with Matrix4 perspective created');

  // Test Transform with alignment
  final alignedTransform = Transform.rotate(
    angle: math.pi / 8,
    alignment: Alignment.topLeft,
    child: Container(
      height: 60.0,
      width: 100.0,
      color: Colors.pink,
      child: Center(
        child: Text(
          'Top-Left Origin',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('Transform with alignment=topLeft created');

  // Test Transform with transformHitTests
  final hitTestTransform = Transform.rotate(
    angle: math.pi / 4,
    transformHitTests: true,
    child: GestureDetector(
      onTap: () => print('Rotated button tapped'),
      child: Container(
        height: 60.0,
        width: 60.0,
        color: Colors.amber,
        child: Center(
          child: Text('Tap', style: TextStyle(color: Colors.black)),
        ),
      ),
    ),
  );
  print('Transform with transformHitTests=true created');

  // Test Matrix4 operations
  print('Matrix4 operations:');
  final m1 = Matrix4.identity();
  print('Matrix4.identity() created');

  final m2 = Matrix4.rotationZ(math.pi / 2);
  print('Matrix4.rotationZ(90°) created');

  final m3 = Matrix4.rotationX(0.5);
  print('Matrix4.rotationX created');

  final m4 = Matrix4.rotationY(0.5);
  print('Matrix4.rotationY created');

  final m5 = Matrix4.translationValues(10.0, 20.0, 0.0);
  print('Matrix4.translationValues(10, 20, 0) created');

  final m6 = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
  print('Matrix4.diagonal3Values(2, 2, 1) - scale created');

  final m7 = Matrix4.skewX(0.2);
  print('Matrix4.skewX(0.2) created');

  final m8 = Matrix4.skewY(0.2);
  print('Matrix4.skewY(0.2) created');

  // Test combining transforms
  final combined = Transform.rotate(
    angle: math.pi / 6,
    child: Transform.scale(
      scale: 1.2,
      child: Container(
        height: 50.0,
        width: 80.0,
        color: Colors.lime,
        child: Center(
          child: Text('Combined', style: TextStyle(color: Colors.black)),
        ),
      ),
    ),
  );
  print('Combined Transform (rotate + scale) created');

  // Test RotatedBox (different from Transform.rotate)
  final rotatedBox = RotatedBox(
    quarterTurns: 1, // 90 degrees clockwise
    child: Container(
      height: 60.0,
      width: 100.0,
      color: Colors.brown,
      child: Center(
        child: Text('RotatedBox', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('RotatedBox(quarterTurns: 1) created');

  // Test AnimatedContainer transform
  print('AnimatedContainer supports transform property');

  print('Transform test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Transform Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'Transform.rotate:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 40.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 80.0, width: 80.0, child: Center(child: rotated)),
            Container(
              height: 80.0,
              width: 80.0,
              child: Center(child: rotatedOrigin),
            ),
          ],
        ),
        SizedBox(height: 40.0),

        Text('Transform.scale:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 80.0, width: 80.0, child: Center(child: scaled)),
            Container(
              height: 80.0,
              width: 80.0,
              child: Center(child: scaledXY),
            ),
          ],
        ),
        SizedBox(height: 30.0),

        Text(
          'Transform.translate:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 80.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: translated,
        ),
        SizedBox(height: 16.0),

        Text('Transform.flip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [flippedH, flippedV],
        ),
        SizedBox(height: 16.0),

        Text(
          'Matrix4 Perspective:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: perspective),
        SizedBox(height: 30.0),

        Text(
          'Combined Transform:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        Center(child: combined),
        SizedBox(height: 30.0),

        Text('RotatedBox:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: rotatedBox),
        SizedBox(height: 16.0),

        Text('Transform Types:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Transform.rotate - rotation'),
        Text('• Transform.scale - scaling'),
        Text('• Transform.translate - translation'),
        Text('• Transform.flip - horizontal/vertical flip'),
        Text('• Transform(transform: Matrix4) - custom'),
        Text('• RotatedBox - 90° increments'),
      ],
    ),
  );
}
