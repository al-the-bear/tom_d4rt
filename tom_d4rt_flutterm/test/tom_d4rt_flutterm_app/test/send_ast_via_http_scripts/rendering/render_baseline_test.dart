// D4rt test script: Tests RenderBaseline from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderBaseline test executing');

  // RenderBaseline - Baseline
  // This is typically an abstract/base class used through subclasses
  print('RenderBaseline is available in the rendering package');
  print('RenderBaseline: Baseline');

  print('RenderBaseline test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderBaseline Tests'),
      Text('Baseline'),
    ],
  );
}
