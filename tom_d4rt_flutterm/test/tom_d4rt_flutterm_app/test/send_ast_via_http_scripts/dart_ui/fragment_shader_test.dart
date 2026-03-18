// D4rt test script: Tests FragmentShader from dart:ui (type reference)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FragmentShader test executing');

  // FragmentShader is created from FragmentProgram.shader()
  // Cannot instantiate without a compiled shader program
  print('FragmentShader type: ${ui.FragmentShader}');
  print('FragmentShader extends Shader');
  print('Shader type: ${ui.Shader}');

  // Shader is the base class
  // Test Gradient as another Shader subclass we can instantiate
  final gradient = ui.Gradient.linear(
    Offset.zero,
    Offset(100.0, 0.0),
    [Colors.red, Colors.blue],
  );
  print('true: ${gradient is ui.Shader}');
  print('Gradient type: ${gradient.runtimeType}');

  // ImageShader type reference
  print('ImageShader type: ${ui.ImageShader}');
  print('ImageShader extends Shader');

  print('FragmentShader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FragmentShader Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('FragmentShader: type reference (needs shader asset)'),
      Text('Shader hierarchy: Shader > Gradient/ImageShader/FragmentShader'),
      Text('true: ${gradient is ui.Shader}'),
    ],
  );
}
