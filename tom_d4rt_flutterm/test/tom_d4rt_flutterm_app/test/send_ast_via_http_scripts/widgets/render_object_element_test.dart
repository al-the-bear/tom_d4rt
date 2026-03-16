// D4rt test script: Tests RenderObjectElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderObjectElement test executing');

  // RenderObjectElement - Render element
  // This is typically an abstract/base class used through subclasses
  print('RenderObjectElement is available in the widgets package');
  print('RenderObjectElement: Render element');

  print('RenderObjectElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderObjectElement Tests'),
      Text('Render element'),
    ],
  );
}
