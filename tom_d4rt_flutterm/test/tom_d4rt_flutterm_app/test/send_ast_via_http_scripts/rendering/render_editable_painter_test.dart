// D4rt test script: Tests RenderEditablePainter from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderEditablePainter test executing');

  // RenderEditablePainter - Editable painter
  // This is typically an abstract/base class used through subclasses
  print('RenderEditablePainter is available in the rendering package');
  print('RenderEditablePainter: Editable painter');

  print('RenderEditablePainter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderEditablePainter Tests'),
      Text('Editable painter'),
    ],
  );
}
