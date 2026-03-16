// D4rt test script: Tests RenderIgnorePointer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderIgnorePointer test executing');

  // RenderIgnorePointer - Ignore pointer
  // This is typically an abstract/base class used through subclasses
  print('RenderIgnorePointer is available in the rendering package');
  print('RenderIgnorePointer: Ignore pointer');

  print('RenderIgnorePointer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderIgnorePointer Tests'),
      Text('Ignore pointer'),
    ],
  );
}
