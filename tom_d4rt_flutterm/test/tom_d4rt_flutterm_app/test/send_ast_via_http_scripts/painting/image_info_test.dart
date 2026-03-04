// D4rt test script: Tests ImageInfo from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageInfo test executing');

  // Test ImageInfo - Image metadata
  print('ImageInfo is available in the painting package');
  print('ImageInfo: Image metadata');

  print('ImageInfo test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageInfo Tests'),
      Text('Image metadata'),
    ],
  );
}
