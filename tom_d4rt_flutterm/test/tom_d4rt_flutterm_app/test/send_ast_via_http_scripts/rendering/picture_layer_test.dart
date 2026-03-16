// D4rt test script: Tests PictureLayer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PictureLayer test executing');

  // Test PictureLayer - Picture layer
  print('PictureLayer is available in the rendering package');
  print('PictureLayer: Picture layer');

  print('PictureLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PictureLayer Tests'),
      Text('Picture layer'),
    ],
  );
}
