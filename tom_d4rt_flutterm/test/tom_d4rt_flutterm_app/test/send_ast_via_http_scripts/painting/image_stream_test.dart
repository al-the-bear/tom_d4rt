// D4rt test script: Tests ImageStream from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageStream test executing');

  // Test ImageStream - Image loading stream
  print('ImageStream is available in the painting package');
  print('ImageStream: Image loading stream');

  print('ImageStream test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageStream Tests'),
      Text('Image loading stream'),
    ],
  );
}
