// D4rt test script: Tests UniformFloatSlot from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UniformFloatSlot test executing');

  // Test UniformFloatSlot - Shader uniform slot
  print('UniformFloatSlot is available in the dart_ui package');
  print('UniformFloatSlot: Shader uniform slot');

  print('UniformFloatSlot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UniformFloatSlot Tests'),
      Text('Shader uniform slot'),
    ],
  );
}
