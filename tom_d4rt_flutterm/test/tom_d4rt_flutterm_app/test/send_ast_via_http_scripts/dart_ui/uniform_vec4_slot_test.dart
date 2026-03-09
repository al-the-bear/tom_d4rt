// D4rt test script: Tests UniformVec4Slot from dart:ui (fragment shader type)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformVec4Slot test executing');
  print('UniformVec4Slot type: ${ui.UniformVec4Slot}');
  print('Sets a vec4 uniform (4 floats) in a FragmentShader');
  print('UniformVec4Slot test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('UniformVec4Slot Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Type ref: ${ui.UniformVec4Slot}'),
    Text('Vec4 (4 float) shader uniform'),
  ]);
}
