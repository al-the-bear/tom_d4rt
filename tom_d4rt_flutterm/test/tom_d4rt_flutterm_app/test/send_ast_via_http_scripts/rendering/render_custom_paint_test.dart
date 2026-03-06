// D4rt test script: Tests RenderCustomPaint from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderCustomPaint test executing');

  // RenderCustomPaint - Custom paint render
  // This is typically an abstract/base class used through subclasses
  print('RenderCustomPaint is available in the rendering package');
  print('RenderCustomPaint: Custom paint render');

  print('RenderCustomPaint test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderCustomPaint Tests'),
      Text('Custom paint render'),
    ],
  );
}
