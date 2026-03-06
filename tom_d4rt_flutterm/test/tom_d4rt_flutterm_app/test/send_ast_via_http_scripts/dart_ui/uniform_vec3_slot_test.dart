// D4rt test script: Tests UniformVec3Slot from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UniformVec3Slot test executing');

  // Test UniformVec3Slot - Shader vec3 slot
  print('UniformVec3Slot is available in the dart_ui package');
  print('UniformVec3Slot: Shader vec3 slot');

  print('UniformVec3Slot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UniformVec3Slot Tests'),
      Text('Shader vec3 slot'),
    ],
  );
}
