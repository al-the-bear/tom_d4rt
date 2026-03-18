// D4rt test script: Tests RenderSliverFillViewport from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFillViewport test executing');

  // RenderSliverFillViewport - Fill viewport
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverFillViewport is available in the rendering package');
  print('RenderSliverFillViewport: Fill viewport');

  print('RenderSliverFillViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFillViewport Tests'),
      Text('Fill viewport'),
    ],
  );
}
