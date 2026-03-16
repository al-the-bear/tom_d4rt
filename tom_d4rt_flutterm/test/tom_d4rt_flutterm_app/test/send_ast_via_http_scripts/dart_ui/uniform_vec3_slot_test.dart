// D4rt test script: Tests UniformVec3Slot from dart:ui (fragment shader type)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformVec3Slot test executing');
  print('UniformVec3Slot type: ${ui.UniformVec3Slot}');
  print('Sets a vec3 uniform (3 floats) in a FragmentShader');
  print('UniformVec3Slot test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('UniformVec3Slot Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Type ref: ${ui.UniformVec3Slot}'),
    Text('Vec3 (3 float) shader uniform'),
  ]);
}
