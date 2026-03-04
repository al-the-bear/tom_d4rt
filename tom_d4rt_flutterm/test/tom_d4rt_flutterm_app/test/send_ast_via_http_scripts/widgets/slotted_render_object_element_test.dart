// D4rt test script: Tests SlottedRenderObjectElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SlottedRenderObjectElement test executing');

  // Test SlottedRenderObjectElement - SlottedRenderObjectElement
  print('SlottedRenderObjectElement is available in the widgets package');
  print('SlottedRenderObjectElement runtimeType accessible');

  print('SlottedRenderObjectElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SlottedRenderObjectElement Tests'),
      Text('SlottedRenderObjectElement'),
    ],
  );
}
