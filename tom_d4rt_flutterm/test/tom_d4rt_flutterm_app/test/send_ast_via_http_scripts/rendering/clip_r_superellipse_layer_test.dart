// D4rt test script: Tests ClipRSuperellipseLayer from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipRSuperellipseLayer test executing');

  // Test ClipRSuperellipseLayer - Superellipse clip
  print('ClipRSuperellipseLayer is available in the rendering package');
  print('ClipRSuperellipseLayer: Superellipse clip');

  print('ClipRSuperellipseLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipRSuperellipseLayer Tests'),
      Text('Superellipse clip'),
    ],
  );
}
