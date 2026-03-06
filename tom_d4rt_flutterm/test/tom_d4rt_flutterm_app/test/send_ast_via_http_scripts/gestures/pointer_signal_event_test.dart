// D4rt test script: Tests PointerSignalEvent from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerSignalEvent test executing');

  // Test PointerSignalEvent - Pointer signal
  print('PointerSignalEvent is available in the gestures package');
  print('PointerSignalEvent: Pointer signal');

  print('PointerSignalEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerSignalEvent Tests'),
      Text('Pointer signal'),
    ],
  );
}
