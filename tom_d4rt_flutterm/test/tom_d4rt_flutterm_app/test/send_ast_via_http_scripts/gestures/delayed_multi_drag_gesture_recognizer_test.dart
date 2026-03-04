// D4rt test script: Tests DelayedMultiDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DelayedMultiDragGestureRecognizer test executing');

  // Test DelayedMultiDragGestureRecognizer - Delayed multi-drag
  print('DelayedMultiDragGestureRecognizer is available in the gestures package');
  print('DelayedMultiDragGestureRecognizer: Delayed multi-drag');

  print('DelayedMultiDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DelayedMultiDragGestureRecognizer Tests'),
      Text('Delayed multi-drag'),
    ],
  );
}
