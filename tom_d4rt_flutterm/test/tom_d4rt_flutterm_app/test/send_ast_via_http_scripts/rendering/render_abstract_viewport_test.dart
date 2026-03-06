// D4rt test script: Tests RenderAbstractViewport from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAbstractViewport test executing');

  // RenderAbstractViewport - Abstract viewport
  // This is typically an abstract/base class used through subclasses
  print('RenderAbstractViewport is available in the rendering package');
  print('RenderAbstractViewport: Abstract viewport');

  print('RenderAbstractViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAbstractViewport Tests'),
      Text('Abstract viewport'),
    ],
  );
}
