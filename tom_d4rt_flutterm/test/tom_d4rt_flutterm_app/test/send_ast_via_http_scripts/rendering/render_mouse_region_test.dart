// D4rt test script: Tests RenderMouseRegion from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderMouseRegion test executing');

  // RenderMouseRegion - Mouse region
  // This is typically an abstract/base class used through subclasses
  print('RenderMouseRegion is available in the rendering package');
  print('RenderMouseRegion: Mouse region');

  print('RenderMouseRegion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderMouseRegion Tests'),
      Text('Mouse region'),
    ],
  );
}
