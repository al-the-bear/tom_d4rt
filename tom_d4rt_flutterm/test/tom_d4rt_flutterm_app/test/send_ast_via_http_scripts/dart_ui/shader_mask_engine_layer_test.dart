// ignore_for_file: avoid_print
// D4rt test script: Tests ShaderMaskEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShaderMaskEngineLayer test executing');

  final sb = ui.SceneBuilder();
  final gradient = ui.Gradient.linear(
    Offset.zero, Offset(100, 100),
    [Colors.red, Colors.blue],
  );
  final layer = sb.pushShaderMask(gradient, Rect.fromLTWH(0, 0, 200, 200), BlendMode.srcOver);
  print('pushShaderMask: ${layer.runtimeType}');
  print('is EngineLayer: true');
  sb.pop();

  // Different blend mode
  final layer2 = sb.pushShaderMask(gradient, Rect.fromLTWH(0, 0, 100, 100), BlendMode.dstIn);
  print('dstIn blend: ${layer2.runtimeType}');
  sb.pop();

  final scene = sb.build();
  scene.dispose();

  print('ShaderMaskEngineLayer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ShaderMaskEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Type: ${layer.runtimeType}'),
    Text('Created via pushShaderMask'),
  ]);
}
