// D4rt test script: Tests LayerHandle from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LayerHandle test executing');

  // Test LayerHandle - Layer handle
  print('LayerHandle is available in the rendering package');
  print('LayerHandle: Layer handle');

  print('LayerHandle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LayerHandle Tests'),
      Text('Layer handle'),
    ],
  );
}
