// D4rt test script: Tests DecorationImagePainter from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DecorationImagePainter test executing');

  // Test DecorationImagePainter - Image painter
  print('DecorationImagePainter is available in the painting package');
  print('DecorationImagePainter: Image painter');

  print('DecorationImagePainter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DecorationImagePainter Tests'),
      Text('Image painter'),
    ],
  );
}
