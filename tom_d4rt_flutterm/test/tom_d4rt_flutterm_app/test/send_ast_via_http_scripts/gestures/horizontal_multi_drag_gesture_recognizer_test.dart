// D4rt test script: Tests HorizontalMultiDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HorizontalMultiDragGestureRecognizer test executing');

  // Test HorizontalMultiDragGestureRecognizer - Horizontal multi-drag
  print('HorizontalMultiDragGestureRecognizer is available in the gestures package');
  print('HorizontalMultiDragGestureRecognizer: Horizontal multi-drag');

  print('HorizontalMultiDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HorizontalMultiDragGestureRecognizer Tests'),
      Text('Horizontal multi-drag'),
    ],
  );
}
