// D4rt test script: Tests Align widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Align test executing');

  // Test Align with Alignment.center
  final centerAlign = Align(
    alignment: Alignment.center,
    child: Container(width: 50.0, height: 50.0, color: Colors.blue),
  );
  print('Align with Alignment.center created');

  // Test Align with Alignment.topLeft
  final topLeftAlign = Align(
    alignment: Alignment.topLeft,
    child: Container(width: 40.0, height: 40.0, color: Colors.green),
  );
  print('Align with Alignment.topLeft created');

  // Test Align with Alignment.bottomRight
  final bottomRightAlign = Align(
    alignment: Alignment.bottomRight,
    child: Container(width: 40.0, height: 40.0, color: Colors.orange),
  );
  print('Align with Alignment.bottomRight created');

  // Test Align with custom Alignment values
  final customAlign = Align(
    alignment: Alignment(0.5, -0.5),
    child: Container(width: 30.0, height: 30.0, color: Colors.purple),
  );
  print('Align with custom Alignment(0.5, -0.5) created');

  // Test Align with widthFactor and heightFactor
  final factorAlign = Align(
    alignment: Alignment.center,
    widthFactor: 2.0,
    heightFactor: 2.0,
    child: Container(width: 50.0, height: 50.0, color: Colors.red),
  );
  print('Align with widthFactor=2.0, heightFactor=2.0 created');

  // Test Align with AlignmentDirectional
  final directionalAlign = Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(width: 40.0, height: 40.0, color: Colors.teal),
  );
  print('Align with AlignmentDirectional.centerStart created');

  print('Align test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 150.0,
        height: 80.0,
        color: Colors.grey.shade200,
        child: centerAlign,
      ),
      SizedBox(height: 8.0),
      Container(
        width: 150.0,
        height: 80.0,
        color: Colors.grey.shade200,
        child: topLeftAlign,
      ),
      SizedBox(height: 8.0),
      Container(
        width: 150.0,
        height: 80.0,
        color: Colors.grey.shade200,
        child: bottomRightAlign,
      ),
      SizedBox(height: 8.0),
      factorAlign,
    ],
  );
}
