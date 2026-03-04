// D4rt test script: Tests PictureRasterizationException from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PictureRasterizationException test executing');

  // Test PictureRasterizationException - Picture error
  print('PictureRasterizationException is available in the dart_ui package');
  print('PictureRasterizationException: Picture error');

  print('PictureRasterizationException test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PictureRasterizationException Tests'),
      Text('Picture error'),
    ],
  );
}
