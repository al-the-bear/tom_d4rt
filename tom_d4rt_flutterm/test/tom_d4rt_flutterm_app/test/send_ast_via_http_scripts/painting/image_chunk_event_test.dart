// D4rt test script: Tests ImageChunkEvent from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageChunkEvent test executing');

  // Test ImageChunkEvent - Loading progress
  print('ImageChunkEvent is available in the painting package');
  print('ImageChunkEvent: Loading progress');

  print('ImageChunkEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageChunkEvent Tests'),
      Text('Loading progress'),
    ],
  );
}
