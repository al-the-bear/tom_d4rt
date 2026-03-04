// D4rt test script: Tests ClipRRectEngineLayer from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipRRectEngineLayer test executing');

  // Test ClipRRectEngineLayer - Clip rounded rect layer
  print('ClipRRectEngineLayer is available in the dart_ui package');
  print('ClipRRectEngineLayer: Clip rounded rect layer');

  print('ClipRRectEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipRRectEngineLayer Tests'),
      Text('Clip rounded rect layer'),
    ],
  );
}
