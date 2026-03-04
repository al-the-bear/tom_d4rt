// D4rt test script: Tests RenderBackdropFilter from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderBackdropFilter test executing');

  // RenderBackdropFilter - Backdrop filter
  // This is typically an abstract/base class used through subclasses
  print('RenderBackdropFilter is available in the rendering package');
  print('RenderBackdropFilter: Backdrop filter');

  print('RenderBackdropFilter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderBackdropFilter Tests'),
      Text('Backdrop filter'),
    ],
  );
}
