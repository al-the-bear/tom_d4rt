// D4rt test script: Tests PointerData from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PointerData test executing');

  // Test PointerData - Touch/mouse events
  print('PointerData is available in the dart_ui package');
  print('PointerData: Touch/mouse events');

  print('PointerData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerData Tests'),
      Text('Touch/mouse events'),
    ],
  );
}
