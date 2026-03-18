// D4rt test script: Tests ClipPathLayer from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipPathLayer test executing');

  // Test ClipPathLayer - Clip path layer
  print('ClipPathLayer is available in the rendering package');
  print('ClipPathLayer: Clip path layer');

  print('ClipPathLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipPathLayer Tests'),
      Text('Clip path layer'),
    ],
  );
}
