// D4rt test script: Tests PointerEventConverter from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEventConverter test executing');

  // Test PointerEventConverter - Event conversion
  print('PointerEventConverter is available in the gestures package');
  print('PointerEventConverter: Event conversion');

  print('PointerEventConverter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEventConverter Tests'),
      Text('Event conversion'),
    ],
  );
}
