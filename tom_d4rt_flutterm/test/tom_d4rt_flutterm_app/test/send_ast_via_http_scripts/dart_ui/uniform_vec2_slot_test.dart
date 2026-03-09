// D4rt test script: Tests UniformVec2Slot from dart:ui (fragment shader type)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformVec2Slot test executing');
  print('UniformVec2Slot type: ${ui.UniformVec2Slot}');
  print('Sets a vec2 uniform (2 floats) in a FragmentShader');
  print('UniformVec2Slot test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('UniformVec2Slot Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Type ref: ${ui.UniformVec2Slot}'),
    Text('Vec2 (2 float) shader uniform'),
  ]);
}
