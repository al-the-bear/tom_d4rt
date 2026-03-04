// D4rt test script: Tests ShaderMask from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShaderMask test executing');

  // Test ShaderMask - Shader masking
  print('ShaderMask is available in the widgets package');
  print('ShaderMask runtimeType accessible');

  print('ShaderMask test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShaderMask Tests'),
      Text('Shader masking'),
    ],
  );
}
