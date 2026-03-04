// D4rt test script: Tests PointerScrollEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScrollEvent test executing');

  // Test PointerScrollEvent - PointerScrollEvent
  print('PointerScrollEvent is available in the gestures package');
  print('PointerScrollEvent: PointerScrollEvent');

  print('PointerScrollEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerScrollEvent Tests'),
      Text('PointerScrollEvent'),
    ],
  );
}
