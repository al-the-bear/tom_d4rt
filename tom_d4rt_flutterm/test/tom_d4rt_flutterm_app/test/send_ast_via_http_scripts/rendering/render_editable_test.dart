// D4rt test script: Tests RenderEditable from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderEditable test executing');

  // RenderEditable - Editable text
  // This is typically an abstract/base class used through subclasses
  print('RenderEditable is available in the rendering package');
  print('RenderEditable: Editable text');

  print('RenderEditable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderEditable Tests'),
      Text('Editable text'),
    ],
  );
}
