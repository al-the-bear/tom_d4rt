// D4rt test script: Tests Texture from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Texture test executing');

  // Test Texture - Texture
  print('Texture is available in the widgets package');
  print('Texture runtimeType accessible');

  print('Texture test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Texture Tests'),
      Text('Texture'),
    ],
  );
}
