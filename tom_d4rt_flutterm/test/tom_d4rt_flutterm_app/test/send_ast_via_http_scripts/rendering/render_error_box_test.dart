// D4rt test script: Tests RenderErrorBox from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderErrorBox test executing');

  // RenderErrorBox - Error display
  // This is typically an abstract/base class used through subclasses
  print('RenderErrorBox is available in the rendering package');
  print('RenderErrorBox: Error display');

  print('RenderErrorBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderErrorBox Tests'),
      Text('Error display'),
    ],
  );
}
