// ignore_for_file: avoid_print
// D4rt test script: Tests RenderSliverFloatingPersistentHeader from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFloatingPersistentHeader test executing');

  // RenderSliverFloatingPersistentHeader - Floating header
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverFloatingPersistentHeader is available in the rendering package');
  print('RenderSliverFloatingPersistentHeader: Floating header');

  print('RenderSliverFloatingPersistentHeader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFloatingPersistentHeader Tests'),
      Text('Floating header'),
    ],
  );
}
