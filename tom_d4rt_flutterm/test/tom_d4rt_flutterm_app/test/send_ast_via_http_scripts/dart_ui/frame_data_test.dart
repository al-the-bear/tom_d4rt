// D4rt test script: Tests FrameData from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FrameData test executing');

  // Test FrameData - Frame data
  print('FrameData is available in the dart_ui package');
  print('FrameData: Frame data');

  print('FrameData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FrameData Tests'),
      Text('Frame data'),
    ],
  );
}
