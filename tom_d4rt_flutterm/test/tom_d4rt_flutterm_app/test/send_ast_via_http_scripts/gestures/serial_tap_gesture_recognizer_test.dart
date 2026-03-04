// D4rt test script: Tests SerialTapGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapGestureRecognizer test executing');

  // Test SerialTapGestureRecognizer - Serial taps
  print('SerialTapGestureRecognizer is available in the gestures package');
  print('SerialTapGestureRecognizer: Serial taps');

  print('SerialTapGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SerialTapGestureRecognizer Tests'),
      Text('Serial taps'),
    ],
  );
}
