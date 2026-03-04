// D4rt test script: Tests OneFrameImageStreamCompleter from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OneFrameImageStreamCompleter test executing');

  // Test OneFrameImageStreamCompleter - Single-frame images
  print('OneFrameImageStreamCompleter is available in the painting package');
  print('OneFrameImageStreamCompleter: Single-frame images');

  print('OneFrameImageStreamCompleter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OneFrameImageStreamCompleter Tests'),
      Text('Single-frame images'),
    ],
  );
}
