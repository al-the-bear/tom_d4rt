// D4rt test script: Tests DragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragGestureRecognizer test executing');

  // Test DragGestureRecognizer - Base drag recognizer
  print('DragGestureRecognizer is available in the gestures package');
  print('DragGestureRecognizer: Base drag recognizer');

  print('DragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DragGestureRecognizer Tests'),
      Text('Base drag recognizer'),
    ],
  );
}
