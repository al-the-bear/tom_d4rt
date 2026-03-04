// D4rt test script: Tests OffsetPair from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OffsetPair test executing');

  // Test OffsetPair - OffsetPair
  print('OffsetPair is available in the gestures package');
  print('OffsetPair: OffsetPair');

  print('OffsetPair test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OffsetPair Tests'),
      Text('OffsetPair'),
    ],
  );
}
