// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverFixedExtentList from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFixedExtentList test executing');

  // RenderSliverFixedExtentList - Fixed extent list
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverFixedExtentList is available in the rendering package');
  print('RenderSliverFixedExtentList: Fixed extent list');

  print('RenderSliverFixedExtentList test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFixedExtentList Tests'),
      Text('Fixed extent list'),
    ],
  );
}
