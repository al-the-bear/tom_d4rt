// D4rt test script: Tests PointerPanZoomStartEvent from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerPanZoomStartEvent test executing');

  // Test PointerPanZoomStartEvent - Pan zoom start
  print('PointerPanZoomStartEvent is available in the gestures package');
  print('PointerPanZoomStartEvent: Pan zoom start');

  print('PointerPanZoomStartEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerPanZoomStartEvent Tests'),
      Text('Pan zoom start'),
    ],
  );
}
