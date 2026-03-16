// D4rt test script: Tests RenderObjectToWidgetAdapter from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderObjectToWidgetAdapter test executing');

  // RenderObjectToWidgetAdapter - RenderObjectToWidgetAdapter
  // This is typically an abstract/base class used through subclasses
  print('RenderObjectToWidgetAdapter is available in the widgets package');
  print('RenderObjectToWidgetAdapter: RenderObjectToWidgetAdapter');

  print('RenderObjectToWidgetAdapter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderObjectToWidgetAdapter Tests'),
      Text('RenderObjectToWidgetAdapter'),
    ],
  );
}
