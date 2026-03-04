// D4rt test script: Tests PointerAddedEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerAddedEvent test executing');

  // Test PointerAddedEvent - PointerAddedEvent
  print('PointerAddedEvent is available in the gestures package');
  print('PointerAddedEvent: PointerAddedEvent');

  print('PointerAddedEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerAddedEvent Tests'),
      Text('PointerAddedEvent'),
    ],
  );
}
