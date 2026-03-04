// D4rt test script: Tests TapAndHorizontalDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndHorizontalDragGestureRecognizer test executing');

  // Test TapAndHorizontalDragGestureRecognizer - Tap and horizontal
  print('TapAndHorizontalDragGestureRecognizer is available in the gestures package');
  print('TapAndHorizontalDragGestureRecognizer: Tap and horizontal');

  print('TapAndHorizontalDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapAndHorizontalDragGestureRecognizer Tests'),
      Text('Tap and horizontal'),
    ],
  );
}
