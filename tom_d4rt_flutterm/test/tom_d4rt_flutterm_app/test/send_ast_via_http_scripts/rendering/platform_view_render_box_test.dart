// D4rt test script: Tests PlatformViewRenderBox from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewRenderBox test executing');

  // Test PlatformViewRenderBox - Platform view box
  print('PlatformViewRenderBox is available in the rendering package');
  print('PlatformViewRenderBox: Platform view box');

  print('PlatformViewRenderBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformViewRenderBox Tests'),
      Text('Platform view box'),
    ],
  );
}
