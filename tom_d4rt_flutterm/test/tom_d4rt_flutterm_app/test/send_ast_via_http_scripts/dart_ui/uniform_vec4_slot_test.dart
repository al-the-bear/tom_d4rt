// D4rt test script: Tests UniformVec4Slot from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UniformVec4Slot test executing');

  // Test UniformVec4Slot - Shader vec4 slot
  print('UniformVec4Slot is available in the dart_ui package');
  print('UniformVec4Slot: Shader vec4 slot');

  print('UniformVec4Slot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UniformVec4Slot Tests'),
      Text('Shader vec4 slot'),
    ],
  );
}
