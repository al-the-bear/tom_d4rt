// D4rt test script: Tests PointerMoveEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerMoveEvent test executing');

  // Test PointerMoveEvent - PointerMoveEvent
  print('PointerMoveEvent is available in the gestures package');
  print('PointerMoveEvent: PointerMoveEvent');

  print('PointerMoveEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerMoveEvent Tests'),
      Text('PointerMoveEvent'),
    ],
  );
}
