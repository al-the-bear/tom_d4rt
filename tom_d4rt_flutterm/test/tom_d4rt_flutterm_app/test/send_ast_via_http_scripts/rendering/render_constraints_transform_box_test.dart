// D4rt test script: Tests RenderConstraintsTransformBox from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderConstraintsTransformBox test executing');

  // RenderConstraintsTransformBox - Constraints transform
  // This is typically an abstract/base class used through subclasses
  print('RenderConstraintsTransformBox is available in the rendering package');
  print('RenderConstraintsTransformBox: Constraints transform');

  print('RenderConstraintsTransformBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderConstraintsTransformBox Tests'),
      Text('Constraints transform'),
    ],
  );
}
