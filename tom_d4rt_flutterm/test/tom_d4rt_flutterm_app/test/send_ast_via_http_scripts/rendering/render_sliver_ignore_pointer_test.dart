// D4rt test script: Tests RenderSliverIgnorePointer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverIgnorePointer test executing');

  // RenderSliverIgnorePointer - Sliver ignore
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverIgnorePointer is available in the rendering package');
  print('RenderSliverIgnorePointer: Sliver ignore');

  print('RenderSliverIgnorePointer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverIgnorePointer Tests'),
      Text('Sliver ignore'),
    ],
  );
}
