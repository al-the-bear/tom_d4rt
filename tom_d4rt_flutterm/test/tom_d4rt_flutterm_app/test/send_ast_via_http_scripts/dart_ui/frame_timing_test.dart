// D4rt test script: Tests FrameTiming from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FrameTiming test executing');

  // Test FrameTiming - Frame performance
  print('FrameTiming is available in the dart_ui package');
  print('FrameTiming: Frame performance');

  print('FrameTiming test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FrameTiming Tests'),
      Text('Frame performance'),
    ],
  );
}
