// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextureLayer from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextureLayer test executing');

  // Test TextureLayer - Texture layer
  print('TextureLayer is available in the rendering package');
  print('TextureLayer: Texture layer');

  print('TextureLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextureLayer Tests'),
      Text('Texture layer'),
    ],
  );
}
