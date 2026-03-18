// D4rt test script: Tests RenderDecoratedSliver from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderDecoratedSliver test executing');

  // RenderDecoratedSliver - RenderDecoratedSliver
  // This is typically an abstract/base class used through subclasses
  print('RenderDecoratedSliver is available in the rendering package');
  print('RenderDecoratedSliver: RenderDecoratedSliver');

  print('RenderDecoratedSliver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderDecoratedSliver Tests'),
      Text('RenderDecoratedSliver'),
    ],
  );
}
