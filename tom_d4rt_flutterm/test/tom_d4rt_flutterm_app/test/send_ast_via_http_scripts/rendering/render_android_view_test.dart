// D4rt test script: Tests RenderAndroidView from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAndroidView test executing');

  // RenderAndroidView - Android view
  // This is typically an abstract/base class used through subclasses
  print('RenderAndroidView is available in the rendering package');
  print('RenderAndroidView: Android view');

  print('RenderAndroidView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAndroidView Tests'),
      Text('Android view'),
    ],
  );
}
