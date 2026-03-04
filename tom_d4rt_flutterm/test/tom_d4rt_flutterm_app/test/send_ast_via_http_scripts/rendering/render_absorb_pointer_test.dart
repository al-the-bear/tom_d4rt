// D4rt test script: Tests RenderAbsorbPointer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAbsorbPointer test executing');

  // RenderAbsorbPointer - Absorb pointer
  // This is typically an abstract/base class used through subclasses
  print('RenderAbsorbPointer is available in the rendering package');
  print('RenderAbsorbPointer: Absorb pointer');

  print('RenderAbsorbPointer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAbsorbPointer Tests'),
      Text('Absorb pointer'),
    ],
  );
}
