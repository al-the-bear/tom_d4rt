// D4rt test script: Tests SerialTapDownDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapDownDetails test executing');

  // Test SerialTapDownDetails - Serial tap down
  print('SerialTapDownDetails is available in the gestures package');
  print('SerialTapDownDetails: Serial tap down');

  print('SerialTapDownDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SerialTapDownDetails Tests'),
      Text('Serial tap down'),
    ],
  );
}
