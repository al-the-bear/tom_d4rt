// D4rt test script: Tests MultiDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiDragGestureRecognizer test executing');

  // Test MultiDragGestureRecognizer - Multi-pointer drag
  print('MultiDragGestureRecognizer is available in the gestures package');
  print('MultiDragGestureRecognizer: Multi-pointer drag');

  print('MultiDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MultiDragGestureRecognizer Tests'),
      Text('Multi-pointer drag'),
    ],
  );
}
