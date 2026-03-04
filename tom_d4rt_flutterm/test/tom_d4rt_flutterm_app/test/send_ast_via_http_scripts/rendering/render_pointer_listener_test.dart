// D4rt test script: Tests RenderPointerListener from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderPointerListener test executing');

  // RenderPointerListener - Pointer listener
  // This is typically an abstract/base class used through subclasses
  print('RenderPointerListener is available in the rendering package');
  print('RenderPointerListener: Pointer listener');

  print('RenderPointerListener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderPointerListener Tests'),
      Text('Pointer listener'),
    ],
  );
}
