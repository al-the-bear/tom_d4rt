// D4rt test script: Tests Matrix4
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MatrixTest test executing');

  // Matrix4.identity()
  final identity = Matrix4.identity();
  print('Matrix4.identity(): $identity');

  // Matrix4.rotationZ
  final rotationZ = Matrix4.rotationZ(0.785398); // ~45 degrees
  print('Matrix4.rotationZ(0.785): $rotationZ');

  // Matrix4.translationValues
  final translation = Matrix4.translationValues(10.0, 20.0, 0.0);
  print('Matrix4.translationValues(10, 20, 0): $translation');

  // Matrix4.diagonal3Values (scale)
  final scale = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
  print('Matrix4.diagonal3Values(2, 2, 1): $scale');

  // Matrix4.skewX
  final skewX = Matrix4.skewX(0.3);
  print('Matrix4.skewX(0.3): $skewX');

  // Matrix4.skewY
  final skewY = Matrix4.skewY(0.2);
  print('Matrix4.skewY(0.2): $skewY');

  // Compose transforms
  final composed = Matrix4.identity()
    ..translate(50.0, 0.0)
    ..rotateZ(0.1);
  print('Composed (translate+rotateZ): $composed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Transform(
        transform: identity,
        child: Container(
          width: 80.0,
          height: 40.0,
          color: Colors.blue.shade100,
          child: Center(child: Text('Identity', style: TextStyle(fontSize: 11.0))),
        ),
      ),
      SizedBox(height: 16.0),
      Transform(
        transform: rotationZ,
        alignment: Alignment.center,
        child: Container(
          width: 80.0,
          height: 40.0,
          color: Colors.red.shade100,
          child: Center(child: Text('Rotate 45°', style: TextStyle(fontSize: 11.0))),
        ),
      ),
      SizedBox(height: 16.0),
      Transform(
        transform: translation,
        child: Container(
          width: 80.0,
          height: 40.0,
          color: Colors.green.shade100,
          child: Center(child: Text('Translate', style: TextStyle(fontSize: 11.0))),
        ),
      ),
      SizedBox(height: 16.0),
      Transform(
        transform: scale,
        alignment: Alignment.center,
        child: Container(
          width: 40.0,
          height: 20.0,
          color: Colors.orange.shade100,
          child: Center(child: Text('2x', style: TextStyle(fontSize: 10.0))),
        ),
      ),
      SizedBox(height: 16.0),
      Transform(
        transform: skewX,
        alignment: Alignment.center,
        child: Container(
          width: 80.0,
          height: 40.0,
          color: Colors.purple.shade100,
          child: Center(child: Text('SkewX', style: TextStyle(fontSize: 11.0))),
        ),
      ),
    ],
  );
}
