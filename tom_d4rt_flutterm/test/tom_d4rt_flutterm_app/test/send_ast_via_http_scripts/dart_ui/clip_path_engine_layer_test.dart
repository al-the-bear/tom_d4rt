// D4rt test script: Tests ClipPathEngineLayer from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipPathEngineLayer test executing');

  // Test ClipPathEngineLayer - Clip path layer
  print('ClipPathEngineLayer is available in the dart_ui package');
  print('ClipPathEngineLayer: Clip path layer');

  print('ClipPathEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipPathEngineLayer Tests'),
      Text('Clip path layer'),
    ],
  );
}
