// D4rt test script: Tests AnimatedPositioned from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedPositioned test executing');

  // Test AnimatedPositioned with left and top
  final pos1 = AnimatedPositioned(
    left: 10,
    top: 10,
    duration: Duration(milliseconds: 300),
    child: Container(width: 50, height: 50, color: Colors.blue),
  );
  print('AnimatedPositioned(left: 10, top: 10) created');

  // Test AnimatedPositioned with right and bottom
  final pos2 = AnimatedPositioned(
    right: 20,
    bottom: 20,
    duration: Duration(milliseconds: 300),
    child: Container(width: 50, height: 50, color: Colors.green),
  );
  print('AnimatedPositioned(right: 20, bottom: 20) created');

  // Test AnimatedPositioned with left, right, and top (stretching)
  final pos3 = AnimatedPositioned(
    left: 0,
    right: 0,
    top: 50,
    duration: Duration(milliseconds: 400),
    child: Container(height: 40, color: Colors.red),
  );
  print('AnimatedPositioned(left: 0, right: 0, top: 50) created');

  // Test AnimatedPositioned with explicit width and height
  final pos4 = AnimatedPositioned(
    width: 100,
    height: 60,
    left: 20,
    top: 20,
    duration: Duration(milliseconds: 300),
    child: Container(color: Colors.orange),
  );
  print('AnimatedPositioned(width: 100, height: 60, left: 20, top: 20) created');

  // Test AnimatedPositioned with curve
  final pos5 = AnimatedPositioned(
    left: 50,
    top: 80,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Container(width: 60, height: 60, color: Colors.purple),
  );
  print('AnimatedPositioned with Curves.easeInOut created');

  print('AnimatedPositioned test completed');
  return SizedBox(
    width: 300,
    height: 300,
    child: Stack(children: [
      pos1,
      pos2,
      pos3,
      pos4,
      pos5,
    ]),
  );
}
