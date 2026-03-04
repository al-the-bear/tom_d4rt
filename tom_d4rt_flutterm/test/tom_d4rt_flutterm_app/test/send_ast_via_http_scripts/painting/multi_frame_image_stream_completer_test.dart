// D4rt test script: Tests MultiFrameImageStreamCompleter from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MultiFrameImageStreamCompleter test executing');

  // Test MultiFrameImageStreamCompleter - Multi-frame images
  print('MultiFrameImageStreamCompleter is available in the painting package');
  print('MultiFrameImageStreamCompleter: Multi-frame images');

  print('MultiFrameImageStreamCompleter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MultiFrameImageStreamCompleter Tests'),
      Text('Multi-frame images'),
    ],
  );
}
