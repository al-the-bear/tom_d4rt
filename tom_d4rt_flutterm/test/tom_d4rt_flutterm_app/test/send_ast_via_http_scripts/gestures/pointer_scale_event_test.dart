// D4rt test script: Tests PointerScaleEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScaleEvent test executing');

  // Test PointerScaleEvent - PointerScaleEvent
  print('PointerScaleEvent is available in the gestures package');
  print('PointerScaleEvent: PointerScaleEvent');

  print('PointerScaleEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerScaleEvent Tests'),
      Text('PointerScaleEvent'),
    ],
  );
}
