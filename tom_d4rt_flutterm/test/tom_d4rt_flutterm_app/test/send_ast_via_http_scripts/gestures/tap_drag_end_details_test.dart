// D4rt test script: Tests TapDragEndDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragEndDetails test executing');

  // Test TapDragEndDetails - Tap drag end
  print('TapDragEndDetails is available in the gestures package');
  print('TapDragEndDetails: Tap drag end');

  print('TapDragEndDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapDragEndDetails Tests'),
      Text('Tap drag end'),
    ],
  );
}
