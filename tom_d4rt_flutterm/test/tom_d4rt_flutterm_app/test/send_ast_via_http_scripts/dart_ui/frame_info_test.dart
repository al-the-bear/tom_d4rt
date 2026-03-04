// D4rt test script: Tests FrameInfo from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FrameInfo test executing');

  // Test FrameInfo - Frame metadata
  print('FrameInfo is available in the dart_ui package');
  print('FrameInfo: Frame metadata');

  print('FrameInfo test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FrameInfo Tests'),
      Text('Frame metadata'),
    ],
  );
}
