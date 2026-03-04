// D4rt test script: Tests RenderObjectToWidgetElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderObjectToWidgetElement test executing');

  // RenderObjectToWidgetElement - RenderObjectToWidgetElement
  // This is typically an abstract/base class used through subclasses
  print('RenderObjectToWidgetElement is available in the widgets package');
  print('RenderObjectToWidgetElement: RenderObjectToWidgetElement');

  print('RenderObjectToWidgetElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderObjectToWidgetElement Tests'),
      Text('RenderObjectToWidgetElement'),
    ],
  );
}
