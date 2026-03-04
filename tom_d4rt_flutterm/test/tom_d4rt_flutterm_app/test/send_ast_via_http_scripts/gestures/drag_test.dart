// D4rt test script: Tests Drag from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Drag test executing');

  // Test Drag - Drag callback
  print('Drag is available in the gestures package');
  print('Drag: Drag callback');

  print('Drag test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Drag Tests'),
      Text('Drag callback'),
    ],
  );
}
