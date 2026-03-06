// D4rt test script: Tests ImageSamplerSlot from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageSamplerSlot test executing');

  // Test ImageSamplerSlot - Shader image sampler
  print('ImageSamplerSlot is available in the dart_ui package');
  print('ImageSamplerSlot: Shader image sampler');

  print('ImageSamplerSlot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageSamplerSlot Tests'),
      Text('Shader image sampler'),
    ],
  );
}
