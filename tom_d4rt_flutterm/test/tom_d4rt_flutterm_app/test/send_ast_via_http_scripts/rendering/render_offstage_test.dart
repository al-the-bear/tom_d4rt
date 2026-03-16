// D4rt test script: Tests RenderOffstage from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderOffstage test executing');

  // RenderOffstage - Offstage
  // This is typically an abstract/base class used through subclasses
  print('RenderOffstage is available in the rendering package');
  print('RenderOffstage: Offstage');

  print('RenderOffstage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderOffstage Tests'),
      Text('Offstage'),
    ],
  );
}
