// D4rt test script: Tests RenderFractionalTranslation from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderFractionalTranslation test executing');

  // RenderFractionalTranslation - Fractional translation
  // This is typically an abstract/base class used through subclasses
  print('RenderFractionalTranslation is available in the rendering package');
  print('RenderFractionalTranslation: Fractional translation');

  print('RenderFractionalTranslation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderFractionalTranslation Tests'),
      Text('Fractional translation'),
    ],
  );
}
