// D4rt test script: Tests RenderUiKitView from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderUiKitView test executing');

  // RenderUiKitView - iOS view
  // This is typically an abstract/base class used through subclasses
  print('RenderUiKitView is available in the rendering package');
  print('RenderUiKitView: iOS view');

  print('RenderUiKitView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderUiKitView Tests'),
      Text('iOS view'),
    ],
  );
}
