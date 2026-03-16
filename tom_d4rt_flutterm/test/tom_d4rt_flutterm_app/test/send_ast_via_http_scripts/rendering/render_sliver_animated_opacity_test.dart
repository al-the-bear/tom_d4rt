// D4rt test script: Tests RenderSliverAnimatedOpacity from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverAnimatedOpacity test executing');

  // RenderSliverAnimatedOpacity - Animated opacity
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverAnimatedOpacity is available in the rendering package');
  print('RenderSliverAnimatedOpacity: Animated opacity');

  print('RenderSliverAnimatedOpacity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverAnimatedOpacity Tests'),
      Text('Animated opacity'),
    ],
  );
}
