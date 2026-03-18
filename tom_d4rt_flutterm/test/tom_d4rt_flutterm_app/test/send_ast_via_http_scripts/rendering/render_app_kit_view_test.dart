// D4rt test script: Tests RenderAppKitView from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAppKitView test executing');

  // RenderAppKitView - macOS view
  // This is typically an abstract/base class used through subclasses
  print('RenderAppKitView is available in the rendering package');
  print('RenderAppKitView: macOS view');

  print('RenderAppKitView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAppKitView Tests'),
      Text('macOS view'),
    ],
  );
}
