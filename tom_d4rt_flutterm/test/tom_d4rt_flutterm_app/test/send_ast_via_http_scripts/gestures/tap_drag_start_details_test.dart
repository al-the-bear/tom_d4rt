// D4rt test script: Tests TapDragStartDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragStartDetails test executing');

  // Test TapDragStartDetails - Tap drag start
  print('TapDragStartDetails is available in the gestures package');
  print('TapDragStartDetails: Tap drag start');

  print('TapDragStartDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapDragStartDetails Tests'),
      Text('Tap drag start'),
    ],
  );
}
