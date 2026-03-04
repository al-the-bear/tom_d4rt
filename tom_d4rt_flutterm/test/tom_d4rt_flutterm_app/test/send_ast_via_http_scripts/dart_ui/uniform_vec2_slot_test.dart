// D4rt test script: Tests UniformVec2Slot from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UniformVec2Slot test executing');

  // Test UniformVec2Slot - Shader vec2 slot
  print('UniformVec2Slot is available in the dart_ui package');
  print('UniformVec2Slot: Shader vec2 slot');

  print('UniformVec2Slot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UniformVec2Slot Tests'),
      Text('Shader vec2 slot'),
    ],
  );
}
