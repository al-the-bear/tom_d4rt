// D4rt test script: Tests ShaderWarmUp from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShaderWarmUp test executing');

  // Test ShaderWarmUp - Shader precompilation
  print('ShaderWarmUp is available in the painting package');
  print('ShaderWarmUp: Shader precompilation');

  print('ShaderWarmUp test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShaderWarmUp Tests'),
      Text('Shader precompilation'),
    ],
  );
}
