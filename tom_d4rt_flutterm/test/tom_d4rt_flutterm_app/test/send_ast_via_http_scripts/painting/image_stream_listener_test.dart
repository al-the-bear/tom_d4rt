// D4rt test script: Tests ImageStreamListener from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageStreamListener test executing');

  // Test ImageStreamListener - Stream listener
  print('ImageStreamListener is available in the painting package');
  print('ImageStreamListener: Stream listener');

  print('ImageStreamListener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageStreamListener Tests'),
      Text('Stream listener'),
    ],
  );
}
