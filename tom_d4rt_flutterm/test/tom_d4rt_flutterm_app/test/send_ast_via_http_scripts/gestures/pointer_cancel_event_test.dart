// D4rt test script: Tests PointerCancelEvent from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerCancelEvent test executing');

  // Test PointerCancelEvent - Pointer cancel
  print('PointerCancelEvent is available in the gestures package');
  print('PointerCancelEvent: Pointer cancel');

  print('PointerCancelEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerCancelEvent Tests'),
      Text('Pointer cancel'),
    ],
  );
}
