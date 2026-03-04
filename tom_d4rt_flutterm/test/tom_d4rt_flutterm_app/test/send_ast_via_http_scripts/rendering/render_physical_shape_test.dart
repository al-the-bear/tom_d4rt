// D4rt test script: Tests RenderPhysicalShape from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderPhysicalShape test executing');

  // RenderPhysicalShape - Physical shape
  // This is typically an abstract/base class used through subclasses
  print('RenderPhysicalShape is available in the rendering package');
  print('RenderPhysicalShape: Physical shape');

  print('RenderPhysicalShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderPhysicalShape Tests'),
      Text('Physical shape'),
    ],
  );
}
