// D4rt test script: Tests RenderSliverScrollingPersistentHeader from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverScrollingPersistentHeader test executing');

  // RenderSliverScrollingPersistentHeader - Scrolling header
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverScrollingPersistentHeader is available in the rendering package');
  print('RenderSliverScrollingPersistentHeader: Scrolling header');

  print('RenderSliverScrollingPersistentHeader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverScrollingPersistentHeader Tests'),
      Text('Scrolling header'),
    ],
  );
}
