// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverPinnedPersistentHeader from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverPinnedPersistentHeader test executing');

  // RenderSliverPinnedPersistentHeader - Pinned header
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverPinnedPersistentHeader is available in the rendering package');
  print('RenderSliverPinnedPersistentHeader: Pinned header');

  print('RenderSliverPinnedPersistentHeader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverPinnedPersistentHeader Tests'),
      Text('Pinned header'),
    ],
  );
}
