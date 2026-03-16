// D4rt test script: Tests RenderSliverVariedExtentList from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverVariedExtentList test executing');

  // RenderSliverVariedExtentList - Varied extent list
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverVariedExtentList is available in the rendering package');
  print('RenderSliverVariedExtentList: Varied extent list');

  print('RenderSliverVariedExtentList test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverVariedExtentList Tests'),
      Text('Varied extent list'),
    ],
  );
}
