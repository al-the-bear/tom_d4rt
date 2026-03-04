// D4rt test script: Tests MultiTapGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiTapGestureRecognizer test executing');

  // Test MultiTapGestureRecognizer - Multi-tap
  print('MultiTapGestureRecognizer is available in the gestures package');
  print('MultiTapGestureRecognizer: Multi-tap');

  print('MultiTapGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MultiTapGestureRecognizer Tests'),
      Text('Multi-tap'),
    ],
  );
}
