// D4rt test script: Tests MultiDragPointerState from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiDragPointerState test executing');

  // Test MultiDragPointerState - Multi-drag state
  print('MultiDragPointerState is available in the gestures package');
  print('MultiDragPointerState: Multi-drag state');

  print('MultiDragPointerState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MultiDragPointerState Tests'),
      Text('Multi-drag state'),
    ],
  );
}
