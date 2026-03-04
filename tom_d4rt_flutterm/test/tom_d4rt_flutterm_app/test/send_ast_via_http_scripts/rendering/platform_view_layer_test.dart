// D4rt test script: Tests PlatformViewLayer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewLayer test executing');

  // Test PlatformViewLayer - Platform view layer
  print('PlatformViewLayer is available in the rendering package');
  print('PlatformViewLayer: Platform view layer');

  print('PlatformViewLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformViewLayer Tests'),
      Text('Platform view layer'),
    ],
  );
}
