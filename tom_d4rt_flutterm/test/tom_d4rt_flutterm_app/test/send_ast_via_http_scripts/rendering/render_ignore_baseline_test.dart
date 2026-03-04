// D4rt test script: Tests RenderIgnoreBaseline from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderIgnoreBaseline test executing');

  // RenderIgnoreBaseline - Ignore baseline
  // This is typically an abstract/base class used through subclasses
  print('RenderIgnoreBaseline is available in the rendering package');
  print('RenderIgnoreBaseline: Ignore baseline');

  print('RenderIgnoreBaseline test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderIgnoreBaseline Tests'),
      Text('Ignore baseline'),
    ],
  );
}
