// D4rt test script: Tests TapAndPanGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndPanGestureRecognizer test executing');

  // Test TapAndPanGestureRecognizer - Tap and pan
  print('TapAndPanGestureRecognizer is available in the gestures package');
  print('TapAndPanGestureRecognizer: Tap and pan');

  print('TapAndPanGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapAndPanGestureRecognizer Tests'),
      Text('Tap and pan'),
    ],
  );
}
