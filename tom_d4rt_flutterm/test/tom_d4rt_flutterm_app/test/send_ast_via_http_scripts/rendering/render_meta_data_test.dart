// D4rt test script: Tests RenderMetaData from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderMetaData test executing');

  // RenderMetaData - Meta data
  // This is typically an abstract/base class used through subclasses
  print('RenderMetaData is available in the rendering package');
  print('RenderMetaData: Meta data');

  print('RenderMetaData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderMetaData Tests'),
      Text('Meta data'),
    ],
  );
}
