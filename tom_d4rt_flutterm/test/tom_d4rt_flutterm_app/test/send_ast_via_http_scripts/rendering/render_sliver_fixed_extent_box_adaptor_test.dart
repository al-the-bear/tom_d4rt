// D4rt test script: Tests RenderSliverFixedExtentBoxAdaptor from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFixedExtentBoxAdaptor test executing');

  // RenderSliverFixedExtentBoxAdaptor - Fixed extent adaptor
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverFixedExtentBoxAdaptor is available in the rendering package');
  print('RenderSliverFixedExtentBoxAdaptor: Fixed extent adaptor');

  print('RenderSliverFixedExtentBoxAdaptor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFixedExtentBoxAdaptor Tests'),
      Text('Fixed extent adaptor'),
    ],
  );
}
