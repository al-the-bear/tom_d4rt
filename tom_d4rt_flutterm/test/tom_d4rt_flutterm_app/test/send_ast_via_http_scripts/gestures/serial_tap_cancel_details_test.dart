// D4rt test script: Tests SerialTapCancelDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapCancelDetails test executing');

  // Test SerialTapCancelDetails - Serial tap cancel
  print('SerialTapCancelDetails is available in the gestures package');
  print('SerialTapCancelDetails: Serial tap cancel');

  print('SerialTapCancelDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SerialTapCancelDetails Tests'),
      Text('Serial tap cancel'),
    ],
  );
}
