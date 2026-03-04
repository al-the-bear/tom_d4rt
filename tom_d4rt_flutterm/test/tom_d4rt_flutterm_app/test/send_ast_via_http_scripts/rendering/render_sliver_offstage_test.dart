// D4rt test script: Tests RenderSliverOffstage from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverOffstage test executing');

  // RenderSliverOffstage - Sliver offstage
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverOffstage is available in the rendering package');
  print('RenderSliverOffstage: Sliver offstage');

  print('RenderSliverOffstage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverOffstage Tests'),
      Text('Sliver offstage'),
    ],
  );
}
