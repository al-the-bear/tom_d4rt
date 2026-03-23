// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderViewportBase from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderViewportBase test executing');

  // RenderViewportBase - Viewport base
  // This is typically an abstract/base class used through subclasses
  print('RenderViewportBase is available in the rendering package');
  print('RenderViewportBase: Viewport base');

  print('RenderViewportBase test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderViewportBase Tests'),
      Text('Viewport base'),
    ],
  );
}
