// ignore_for_file: avoid_print
// D4rt test script: Tests Transform and FractionallySizedBox from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Transform and FractionallySizedBox test executing');

  // Test Transform.rotate
  final rotated = Transform.rotate(
    angle: 0.5,
    child: Container(width: 80, height: 80, color: Colors.blue),
  );
  print('Transform.rotate(angle: 0.5) created');

  // Test Transform.scale
  final scaled = Transform.scale(
    scale: 1.5,
    child: Container(width: 60, height: 60, color: Colors.green),
  );
  print('Transform.scale(scale: 1.5) created');

  // Test Transform.translate
  final translated = Transform.translate(
    offset: Offset(10, 20),
    child: Container(width: 80, height: 80, color: Colors.red),
  );
  print('Transform.translate(offset: Offset(10, 20)) created');

  // Test Transform with Matrix4.identity
  final identity = Transform(
    transform: Matrix4.identity(),
    child: Container(width: 80, height: 80, color: Colors.orange),
  );
  print('Transform(transform: Matrix4.identity()) created');

  // Test FractionallySizedBox with widthFactor and heightFactor
  final fractional1 = FractionallySizedBox(
    widthFactor: 0.5,
    heightFactor: 0.8,
    child: Container(color: Colors.purple),
  );
  print('FractionallySizedBox(widthFactor: 0.5, heightFactor: 0.8) created');

  // Test FractionallySizedBox with alignment
  final fractional2 = FractionallySizedBox(
    alignment: Alignment.topLeft,
    widthFactor: 0.6,
    child: Container(color: Colors.teal),
  );
  print('FractionallySizedBox(alignment: Alignment.topLeft) created');

  // Test Transform.rotate with alignment
  final rotatedAligned = Transform.rotate(
    angle: 1.0,
    alignment: Alignment.bottomRight,
    child: Container(width: 50, height: 50, color: Colors.amber),
  );
  print('Transform.rotate with alignment created');

  print('Transform and FractionallySizedBox test completed');
  return Column(
    children: [
      rotated,
      scaled,
      translated,
      identity,
      SizedBox(height: 100, child: fractional1),
      SizedBox(height: 100, child: fractional2),
      rotatedAligned,
    ],
  );
}
