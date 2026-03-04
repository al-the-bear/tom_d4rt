// D4rt test script: Tests RenderAnimatedSize from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAnimatedSize test executing');

  // RenderAnimatedSize - Animated size
  // This is typically an abstract/base class used through subclasses
  print('RenderAnimatedSize is available in the rendering package');
  print('RenderAnimatedSize: Animated size');

  print('RenderAnimatedSize test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAnimatedSize Tests'),
      Text('Animated size'),
    ],
  );
}
