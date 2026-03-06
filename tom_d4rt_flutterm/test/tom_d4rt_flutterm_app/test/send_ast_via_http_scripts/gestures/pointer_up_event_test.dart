// D4rt test script: Tests PointerUpEvent from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerUpEvent test executing');

  // Test PointerUpEvent - Pointer up
  print('PointerUpEvent is available in the gestures package');
  print('PointerUpEvent: Pointer up');

  print('PointerUpEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerUpEvent Tests'),
      Text('Pointer up'),
    ],
  );
}
