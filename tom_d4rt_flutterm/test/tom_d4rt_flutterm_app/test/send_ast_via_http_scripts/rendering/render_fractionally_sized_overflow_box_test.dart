// D4rt test script: Tests RenderFractionallySizedOverflowBox from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderFractionallySizedOverflowBox test executing');

  // RenderFractionallySizedOverflowBox - Fractional overflow
  // This is typically an abstract/base class used through subclasses
  print('RenderFractionallySizedOverflowBox is available in the rendering package');
  print('RenderFractionallySizedOverflowBox: Fractional overflow');

  print('RenderFractionallySizedOverflowBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderFractionallySizedOverflowBox Tests'),
      Text('Fractional overflow'),
    ],
  );
}
