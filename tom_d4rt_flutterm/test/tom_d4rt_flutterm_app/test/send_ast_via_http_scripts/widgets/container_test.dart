// D4rt test script: Tests Container from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Container test executing');

  // Test Container with basic properties
  final basic = Container(width: 200.0, height: 100.0, color: Colors.blue);
  print('Basic Container created: width=200, height=100');

  // Test Container with decoration
  final decorated = Container(
    width: 150.0,
    height: 80.0,
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(12.0),
    ),
  );
  print('Decorated Container created');

  // Test Container with padding and margin
  final padded = Container(
    width: 120.0,
    height: 60.0,
    padding: EdgeInsets.all(8.0),
    margin: EdgeInsets.all(4.0),
    color: Colors.orange,
  );
  print('Padded Container created');

  // Test Container with alignment
  final aligned = Container(
    width: 100.0,
    height: 100.0,
    color: Colors.purple,
    alignment: Alignment.center,
    child: Text('Aligned', style: TextStyle(color: Colors.white)),
  );
  print('Aligned Container created');

  // Test Container with constraints
  final constrained = Container(
    constraints: BoxConstraints(
      minWidth: 50.0,
      maxWidth: 200.0,
      minHeight: 30.0,
      maxHeight: 100.0,
    ),
    color: Colors.teal,
  );
  print('Constrained Container created');

  // Test Container with transform
  final transformed = Container(
    width: 80.0,
    height: 40.0,
    color: Colors.pink,
    transform: Matrix4.rotationZ(0.1),
  );
  print('Transformed Container created');

  print('Container test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      basic,
      SizedBox(height: 8.0),
      decorated,
      SizedBox(height: 8.0),
      padded,
      SizedBox(height: 8.0),
      aligned,
    ],
  );
}
