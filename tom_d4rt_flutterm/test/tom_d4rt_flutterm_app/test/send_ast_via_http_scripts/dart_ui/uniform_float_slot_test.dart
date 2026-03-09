// D4rt test script: Tests UniformFloatSlot from dart:ui (fragment shader type)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformFloatSlot test executing');
  print('UniformFloatSlot type: ${ui.UniformFloatSlot}');
  print('Part of FragmentProgram uniform system');
  print('Sets a single float uniform in a shader');
  print('UniformFloatSlot test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('UniformFloatSlot Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Type ref: ${ui.UniformFloatSlot}'),
    Text('Single float shader uniform'),
  ]);
}
