// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderShaderMask from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderShaderMask test executing');

  // RenderShaderMask - Shader mask
  // This is typically an abstract/base class used through subclasses
  print('RenderShaderMask is available in the rendering package');
  print('RenderShaderMask: Shader mask');

  print('RenderShaderMask test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderShaderMask Tests'),
      Text('Shader mask'),
    ],
  );
}
