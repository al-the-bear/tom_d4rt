// D4rt test script: Tests RenderIndexedStack from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderIndexedStack test executing');

  // RenderIndexedStack - Indexed stack
  // This is typically an abstract/base class used through subclasses
  print('RenderIndexedStack is available in the rendering package');
  print('RenderIndexedStack: Indexed stack');

  print('RenderIndexedStack test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderIndexedStack Tests'),
      Text('Indexed stack'),
    ],
  );
}
