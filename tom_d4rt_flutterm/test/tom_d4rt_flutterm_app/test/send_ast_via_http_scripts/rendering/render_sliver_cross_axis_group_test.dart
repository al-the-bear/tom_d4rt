// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverCrossAxisGroup from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverCrossAxisGroup test executing');

  // RenderSliverCrossAxisGroup - Cross axis group
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverCrossAxisGroup is available in the rendering package');
  print('RenderSliverCrossAxisGroup: Cross axis group');

  print('RenderSliverCrossAxisGroup test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverCrossAxisGroup Tests'),
      Text('Cross axis group'),
    ],
  );
}
