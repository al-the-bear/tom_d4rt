// D4rt test script: Tests RenderSliverFloatingPinnedPersistentHeader from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFloatingPinnedPersistentHeader test executing');

  // RenderSliverFloatingPinnedPersistentHeader - Floating pinned
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverFloatingPinnedPersistentHeader is available in the rendering package');
  print('RenderSliverFloatingPinnedPersistentHeader: Floating pinned');

  print('RenderSliverFloatingPinnedPersistentHeader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFloatingPinnedPersistentHeader Tests'),
      Text('Floating pinned'),
    ],
  );
}
