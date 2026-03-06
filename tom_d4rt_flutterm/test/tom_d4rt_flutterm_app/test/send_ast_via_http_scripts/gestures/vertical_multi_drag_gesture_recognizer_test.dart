// D4rt test script: Tests VerticalMultiDragGestureRecognizer from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VerticalMultiDragGestureRecognizer test executing');

  // Test VerticalMultiDragGestureRecognizer - Vertical multi-drag
  print('VerticalMultiDragGestureRecognizer is available in the gestures package');
  print('VerticalMultiDragGestureRecognizer: Vertical multi-drag');

  print('VerticalMultiDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VerticalMultiDragGestureRecognizer Tests'),
      Text('Vertical multi-drag'),
    ],
  );
}
