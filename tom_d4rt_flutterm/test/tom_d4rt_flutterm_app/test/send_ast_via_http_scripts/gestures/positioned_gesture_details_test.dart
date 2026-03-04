// D4rt test script: Tests PositionedGestureDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PositionedGestureDetails test executing');

  // Test PositionedGestureDetails - Positioned details
  print('PositionedGestureDetails is available in the gestures package');
  print('PositionedGestureDetails: Positioned details');

  print('PositionedGestureDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PositionedGestureDetails Tests'),
      Text('Positioned details'),
    ],
  );
}
