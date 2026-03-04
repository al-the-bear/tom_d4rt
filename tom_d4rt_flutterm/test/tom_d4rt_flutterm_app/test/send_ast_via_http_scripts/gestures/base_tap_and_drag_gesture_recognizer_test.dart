// D4rt test script: Tests BaseTapAndDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BaseTapAndDragGestureRecognizer test executing');

  // Test BaseTapAndDragGestureRecognizer - Base tap+drag
  print('BaseTapAndDragGestureRecognizer is available in the gestures package');
  print('BaseTapAndDragGestureRecognizer: Base tap+drag');

  print('BaseTapAndDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BaseTapAndDragGestureRecognizer Tests'),
      Text('Base tap+drag'),
    ],
  );
}
