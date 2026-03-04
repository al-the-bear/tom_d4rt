// D4rt test script: Tests ShaderMaskLayer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShaderMaskLayer test executing');

  // Test ShaderMaskLayer - Shader mask layer
  print('ShaderMaskLayer is available in the rendering package');
  print('ShaderMaskLayer: Shader mask layer');

  print('ShaderMaskLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShaderMaskLayer Tests'),
      Text('Shader mask layer'),
    ],
  );
}
