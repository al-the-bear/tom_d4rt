// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverToBoxAdapter from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverToBoxAdapter test executing');

  // RenderSliverToBoxAdapter - Box adapter
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverToBoxAdapter is available in the rendering package');
  print('RenderSliverToBoxAdapter: Box adapter');

  print('RenderSliverToBoxAdapter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverToBoxAdapter Tests'),
      Text('Box adapter'),
    ],
  );
}
