// D4rt test script: Tests Offset from dart:ui
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Offset test executing');

  // Test Offset constructors
  final offset1 = Offset(100.0, 200.0);
  print('Offset created: dx=${offset1.dx}, dy=${offset1.dy}');

  // Test Offset.zero
  final zero = Offset.zero;
  print('Offset.zero: dx=${zero.dx}, dy=${zero.dy}');

  // Test Offset operations
  final offset2 = Offset(50.0, 50.0);
  final sum = offset1 + offset2;
  print('Offset addition: ${sum.dx}, ${sum.dy}');

  final diff = offset1 - offset2;
  print('Offset subtraction: ${diff.dx}, ${diff.dy}');

  final scaled = offset1 * 2.0;
  print('Offset scale: ${scaled.dx}, ${scaled.dy}');

  // Test distance
  final distance = offset1.distance;
  print('Offset distance: $distance');

  print('Offset test completed');

  return Container(
    width: offset1.dx,
    height: offset1.dy,
    color: Colors.blue,
    child: Center(
      child: Text(
        'Offset: ${offset1.dx}, ${offset1.dy}',
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    ),
  );
}
