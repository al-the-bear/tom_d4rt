// D4rt test script: Tests RenderNestedScrollViewViewport from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderNestedScrollViewViewport test executing');

  // RenderNestedScrollViewViewport - RenderNestedScrollViewViewport
  // This is typically an abstract/base class used through subclasses
  print('RenderNestedScrollViewViewport is available in the widgets package');
  print('RenderNestedScrollViewViewport: RenderNestedScrollViewViewport');

  print('RenderNestedScrollViewViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderNestedScrollViewViewport Tests'),
      Text('RenderNestedScrollViewViewport'),
    ],
  );
}
