// D4rt test script: Tests ColorFilterEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ColorFilterEngineLayer test executing');

  final builder = ui.SceneBuilder();

  // ColorFilter.mode
  final cf1 = ColorFilter.mode(Colors.red, BlendMode.srcIn);
  final layer1 = builder.pushColorFilter(cf1);
  print('pushColorFilter mode: ${layer1.runtimeType}');
  print('is EngineLayer: ${true.EngineLayer}');
  builder.pop();

  // ColorFilter.linearToSrgbGamma
  final cf2 = ColorFilter.linearToSrgbGamma();
  final layer2 = builder.pushColorFilter(cf2);
  print('pushColorFilter linearToSrgb: ${layer2.runtimeType}');
  builder.pop();

  // ColorFilter.srgbToLinearGamma
  final cf3 = ColorFilter.srgbToLinearGamma();
  final layer3 = builder.pushColorFilter(cf3);
  print('pushColorFilter srgbToLinear: ${layer3.runtimeType}');
  builder.pop();

  // ColorFilter.matrix (identity)
  final cf4 = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);
  final layer4 = builder.pushColorFilter(cf4);
  print('pushColorFilter matrix: ${layer4.runtimeType}');
  builder.pop();

  final scene = builder.build();
  scene.dispose();

  print('ColorFilterEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ColorFilterEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${layer1.runtimeType}'),
      Text('mode, linearToSrgb, srgbToLinear, matrix'),
    ],
  );
}
