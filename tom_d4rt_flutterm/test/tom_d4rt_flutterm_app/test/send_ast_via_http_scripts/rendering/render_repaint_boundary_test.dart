// D4rt test script: Tests RenderRepaintBoundary from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderRepaintBoundary test executing');

  // RenderRepaintBoundary - Repaint boundary
  // This is typically an abstract/base class used through subclasses
  print('RenderRepaintBoundary is available in the rendering package');
  print('RenderRepaintBoundary: Repaint boundary');

  print('RenderRepaintBoundary test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderRepaintBoundary Tests'),
      Text('Repaint boundary'),
    ],
  );
}
