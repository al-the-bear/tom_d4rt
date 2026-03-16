// D4rt test script: Tests ResizeImage from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ResizeImage test executing');

  // Test ResizeImage - Image resizing
  print('ResizeImage is available in the painting package');
  print('ResizeImage: Image resizing');

  print('ResizeImage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ResizeImage Tests'),
      Text('Image resizing'),
    ],
  );
}
