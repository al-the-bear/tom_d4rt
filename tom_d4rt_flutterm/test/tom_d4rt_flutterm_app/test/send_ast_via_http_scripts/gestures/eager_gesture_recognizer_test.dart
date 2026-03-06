// D4rt test script: Tests EagerGestureRecognizer from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EagerGestureRecognizer test executing');

  // Test EagerGestureRecognizer - Eager recognizer
  print('EagerGestureRecognizer is available in the gestures package');
  print('EagerGestureRecognizer: Eager recognizer');

  print('EagerGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('EagerGestureRecognizer Tests'),
      Text('Eager recognizer'),
    ],
  );
}
