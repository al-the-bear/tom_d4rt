// D4rt test script: Tests TapDragDownDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragDownDetails test executing');

  // Test TapDragDownDetails - Tap drag down
  print('TapDragDownDetails is available in the gestures package');
  print('TapDragDownDetails: Tap drag down');

  print('TapDragDownDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapDragDownDetails Tests'),
      Text('Tap drag down'),
    ],
  );
}
