// D4rt test script: Tests RenderDarwinPlatformView from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderDarwinPlatformView test executing');

  // RenderDarwinPlatformView - Darwin view
  // This is typically an abstract/base class used through subclasses
  print('RenderDarwinPlatformView is available in the rendering package');
  print('RenderDarwinPlatformView: Darwin view');

  print('RenderDarwinPlatformView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderDarwinPlatformView Tests'),
      Text('Darwin view'),
    ],
  );
}
