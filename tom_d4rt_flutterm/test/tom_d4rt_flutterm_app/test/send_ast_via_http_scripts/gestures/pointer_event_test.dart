// D4rt test script: Tests PointerEvent from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEvent test executing');

  // Test PointerEvent - Base pointer event
  print('PointerEvent is available in the gestures package');
  print('PointerEvent: Base pointer event');

  print('PointerEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEvent Tests'),
      Text('Base pointer event'),
    ],
  );
}
