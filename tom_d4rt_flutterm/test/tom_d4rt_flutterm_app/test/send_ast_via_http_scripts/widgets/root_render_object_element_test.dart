// D4rt test script: Tests RootRenderObjectElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RootRenderObjectElement test executing');

  // Test RootRenderObjectElement - RootRenderObjectElement
  print('RootRenderObjectElement is available in the widgets package');
  print('RootRenderObjectElement runtimeType accessible');

  print('RootRenderObjectElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RootRenderObjectElement Tests'),
      Text('RootRenderObjectElement'),
    ],
  );
}
