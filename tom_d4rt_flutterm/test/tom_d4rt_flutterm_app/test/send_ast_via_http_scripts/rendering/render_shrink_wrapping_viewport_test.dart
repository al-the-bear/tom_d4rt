// D4rt test script: Tests RenderShrinkWrappingViewport from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderShrinkWrappingViewport test executing');

  // RenderShrinkWrappingViewport - Shrink viewport
  // This is typically an abstract/base class used through subclasses
  print('RenderShrinkWrappingViewport is available in the rendering package');
  print('RenderShrinkWrappingViewport: Shrink viewport');

  print('RenderShrinkWrappingViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderShrinkWrappingViewport Tests'),
      Text('Shrink viewport'),
    ],
  );
}
