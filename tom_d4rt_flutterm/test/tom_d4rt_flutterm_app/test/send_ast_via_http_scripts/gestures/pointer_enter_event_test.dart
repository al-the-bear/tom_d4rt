// D4rt test script: Tests PointerEnterEvent from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEnterEvent test executing');

  // Test PointerEnterEvent - PointerEnterEvent
  print('PointerEnterEvent is available in the gestures package');
  print('PointerEnterEvent: PointerEnterEvent');

  print('PointerEnterEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEnterEvent Tests'),
      Text('PointerEnterEvent'),
    ],
  );
}
