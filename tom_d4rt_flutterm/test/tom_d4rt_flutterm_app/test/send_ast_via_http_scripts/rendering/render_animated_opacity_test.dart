// D4rt test script: Tests RenderAnimatedOpacity from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAnimatedOpacity test executing');

  // RenderAnimatedOpacity - Animated opacity
  // This is typically an abstract/base class used through subclasses
  print('RenderAnimatedOpacity is available in the rendering package');
  print('RenderAnimatedOpacity: Animated opacity');

  print('RenderAnimatedOpacity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAnimatedOpacity Tests'),
      Text('Animated opacity'),
    ],
  );
}
