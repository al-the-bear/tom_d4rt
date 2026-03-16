// D4rt test script: Tests Alignment from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Alignment test executing');

  // Test Alignment constructor
  final custom = Alignment(0.5, -0.5);
  print('Alignment(0.5, -0.5): x=${custom.x}, y=${custom.y}');

  // Test Alignment constants
  print(
    'Alignment.topLeft: x=${Alignment.topLeft.x}, y=${Alignment.topLeft.y}',
  );
  print(
    'Alignment.topCenter: x=${Alignment.topCenter.x}, y=${Alignment.topCenter.y}',
  );
  print(
    'Alignment.topRight: x=${Alignment.topRight.x}, y=${Alignment.topRight.y}',
  );
  print(
    'Alignment.centerLeft: x=${Alignment.centerLeft.x}, y=${Alignment.centerLeft.y}',
  );
  print('Alignment.center: x=${Alignment.center.x}, y=${Alignment.center.y}');
  print(
    'Alignment.centerRight: x=${Alignment.centerRight.x}, y=${Alignment.centerRight.y}',
  );
  print(
    'Alignment.bottomLeft: x=${Alignment.bottomLeft.x}, y=${Alignment.bottomLeft.y}',
  );
  print(
    'Alignment.bottomCenter: x=${Alignment.bottomCenter.x}, y=${Alignment.bottomCenter.y}',
  );
  print(
    'Alignment.bottomRight: x=${Alignment.bottomRight.x}, y=${Alignment.bottomRight.y}',
  );

  print('Alignment test completed');

  return Container(
    width: 250.0,
    height: 250.0,
    color: Colors.grey.shade300,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(width: 40.0, height: 40.0, color: Colors.red),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(width: 40.0, height: 40.0, color: Colors.green),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(width: 40.0, height: 40.0, color: Colors.blue),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(width: 40.0, height: 40.0, color: Colors.yellow),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(width: 40.0, height: 40.0, color: Colors.purple),
        ),
        Align(
          alignment: custom,
          child: Container(
            width: 60.0,
            height: 30.0,
            color: Colors.orange,
            child: Center(
              child: Text('custom', style: TextStyle(fontSize: 12.0)),
            ),
          ),
        ),
      ],
    ),
  );
}
