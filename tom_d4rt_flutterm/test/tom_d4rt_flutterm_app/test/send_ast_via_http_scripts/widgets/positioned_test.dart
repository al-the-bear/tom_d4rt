// ignore_for_file: avoid_print
// D4rt test script: Tests Positioned widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Positioned test executing');

  // Test Positioned with left and top
  final leftTop = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        left: 10.0,
        top: 10.0,
        child: Container(width: 50.0, height: 50.0, color: Colors.blue),
      ),
    ],
  );
  print('Positioned with left=10, top=10 created');

  // Test Positioned with right and bottom
  final rightBottom = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        right: 10.0,
        bottom: 10.0,
        child: Container(width: 50.0, height: 50.0, color: Colors.green),
      ),
    ],
  );
  print('Positioned with right=10, bottom=10 created');

  // Test Positioned with all four positions
  final allPositions = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        left: 20.0,
        top: 20.0,
        right: 20.0,
        bottom: 20.0,
        child: Container(color: Colors.orange),
      ),
    ],
  );
  print('Positioned with all four positions created');

  // Test Positioned with width and height
  final sized = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        left: 10.0,
        top: 10.0,
        width: 80.0,
        height: 40.0,
        child: Container(color: Colors.purple),
      ),
    ],
  );
  print('Positioned with width and height created');

  // Test Positioned.fill
  final fill = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned.fill(child: Container(color: Colors.red.withOpacity(0.5))),
    ],
  );
  print('Positioned.fill created');

  // Test Positioned.fromRect
  final fromRect = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned.fromRect(
        rect: Rect.fromLTWH(30.0, 20.0, 60.0, 50.0),
        child: Container(color: Colors.teal),
      ),
    ],
  );
  print('Positioned.fromRect created');

  // Test PositionedDirectional
  final directional = Directionality(
    textDirection: TextDirection.rtl,
    child: Stack(
      children: [
        Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
        PositionedDirectional(
          start: 10.0,
          top: 10.0,
          child: Container(width: 50.0, height: 50.0, color: Colors.pink),
        ),
      ],
    ),
  );
  print('PositionedDirectional with start=10 created');

  // Test multiple Positioned widgets
  final multiple = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        left: 5.0,
        top: 5.0,
        child: Container(width: 30.0, height: 30.0, color: Colors.red),
      ),
      Positioned(
        right: 5.0,
        top: 5.0,
        child: Container(width: 30.0, height: 30.0, color: Colors.green),
      ),
      Positioned(
        left: 5.0,
        bottom: 5.0,
        child: Container(width: 30.0, height: 30.0, color: Colors.blue),
      ),
      Positioned(
        right: 5.0,
        bottom: 5.0,
        child: Container(width: 30.0, height: 30.0, color: Colors.yellow),
      ),
    ],
  );
  print('Multiple Positioned widgets created');

  print('Positioned test completed');

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        leftTop,
        SizedBox(height: 8.0),
        rightBottom,
        SizedBox(height: 8.0),
        allPositions,
        SizedBox(height: 8.0),
        sized,
        SizedBox(height: 8.0),
        fill,
        SizedBox(height: 8.0),
        fromRect,
        SizedBox(height: 8.0),
        multiple,
      ],
    ),
  );
}
