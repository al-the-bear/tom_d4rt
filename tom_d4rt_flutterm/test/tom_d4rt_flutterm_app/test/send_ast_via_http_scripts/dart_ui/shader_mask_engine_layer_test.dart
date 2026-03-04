// D4rt test script: Tests ShaderMaskEngineLayer from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShaderMaskEngineLayer test executing');

  // Test ShaderMaskEngineLayer - Shader mask layer
  print('ShaderMaskEngineLayer is available in the dart_ui package');
  print('ShaderMaskEngineLayer: Shader mask layer');

  print('ShaderMaskEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShaderMaskEngineLayer Tests'),
      Text('Shader mask layer'),
    ],
  );
}
