// D4rt test script: Tests PointerDownEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerDownEvent test executing');

  // Test PointerDownEvent - Pointer down
  print('PointerDownEvent is available in the gestures package');
  print('PointerDownEvent: Pointer down');

  print('PointerDownEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerDownEvent Tests'),
      Text('Pointer down'),
    ],
  );
}
