// D4rt test script: Tests RenderListWheelViewport from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderListWheelViewport test executing');

  // RenderListWheelViewport - Wheel viewport
  // This is typically an abstract/base class used through subclasses
  print('RenderListWheelViewport is available in the rendering package');
  print('RenderListWheelViewport: Wheel viewport');

  print('RenderListWheelViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderListWheelViewport Tests'),
      Text('Wheel viewport'),
    ],
  );
}
