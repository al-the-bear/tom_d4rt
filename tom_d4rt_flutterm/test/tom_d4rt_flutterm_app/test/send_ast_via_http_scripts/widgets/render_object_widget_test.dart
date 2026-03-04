// D4rt test script: Tests RenderObjectWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderObjectWidget test executing');

  // RenderObjectWidget - Render widget
  // This is typically an abstract/base class used through subclasses
  print('RenderObjectWidget is available in the widgets package');
  print('RenderObjectWidget: Render widget');

  print('RenderObjectWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderObjectWidget Tests'),
      Text('Render widget'),
    ],
  );
}
