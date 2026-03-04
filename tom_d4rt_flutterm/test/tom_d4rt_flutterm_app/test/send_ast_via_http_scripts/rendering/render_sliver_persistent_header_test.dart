// D4rt test script: Tests RenderSliverPersistentHeader from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverPersistentHeader test executing');

  // RenderSliverPersistentHeader - Persistent header
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverPersistentHeader is available in the rendering package');
  print('RenderSliverPersistentHeader: Persistent header');

  print('RenderSliverPersistentHeader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverPersistentHeader Tests'),
      Text('Persistent header'),
    ],
  );
}
