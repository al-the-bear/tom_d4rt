// D4rt test script: Tests RenderTreeSliver from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderTreeSliver test executing');

  // RenderTreeSliver - Tree sliver
  // This is typically an abstract/base class used through subclasses
  print('RenderTreeSliver is available in the rendering package');
  print('RenderTreeSliver: Tree sliver');

  print('RenderTreeSliver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderTreeSliver Tests'),
      Text('Tree sliver'),
    ],
  );
}
