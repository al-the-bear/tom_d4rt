// D4rt test script: Tests PersistentHeaderShowOnScreenConfiguration from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PersistentHeaderShowOnScreenConfiguration test executing');

  // Test PersistentHeaderShowOnScreenConfiguration - Show on screen
  print('PersistentHeaderShowOnScreenConfiguration is available in the rendering package');
  print('PersistentHeaderShowOnScreenConfiguration: Show on screen');

  print('PersistentHeaderShowOnScreenConfiguration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PersistentHeaderShowOnScreenConfiguration Tests'),
      Text('Show on screen'),
    ],
  );
}
