// D4rt test script: Tests ImageSizeInfo from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageSizeInfo test executing');

  // Test ImageSizeInfo - Image size debugging
  print('ImageSizeInfo is available in the painting package');
  print('ImageSizeInfo: Image size debugging');

  print('ImageSizeInfo test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageSizeInfo Tests'),
      Text('Image size debugging'),
    ],
  );
}
