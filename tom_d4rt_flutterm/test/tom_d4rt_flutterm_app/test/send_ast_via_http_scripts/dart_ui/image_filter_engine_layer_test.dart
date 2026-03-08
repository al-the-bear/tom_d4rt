// D4rt test script: Tests ImageFilterEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageFilterEngineLayer test executing');

  final builder = ui.SceneBuilder();

  // Blur filter
  final blurFilter = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final layer1 = builder.pushImageFilter(blurFilter);
  print('pushImageFilter blur: ${layer1.runtimeType}');
  print('is EngineLayer: ${layer1 is ui.EngineLayer}');
  builder.pop();

  // Blur with offset
  final layer2 = builder.pushImageFilter(blurFilter, offset: Offset(10.0, 20.0));
  print('pushImageFilter with offset: ${layer2.runtimeType}');
  builder.pop();

  // Asymmetric blur
  final asymFilter = ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 0.0);
  final layer3 = builder.pushImageFilter(asymFilter);
  print('pushImageFilter asymmetric: ${layer3.runtimeType}');
  builder.pop();

  // No blur
  final noBlur = ui.ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0);
  final layer4 = builder.pushImageFilter(noBlur);
  print('pushImageFilter no blur: ${layer4.runtimeType}');
  builder.pop();

  final scene = builder.build();
  scene.dispose();

  print('ImageFilterEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageFilterEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${layer1.runtimeType}'),
      Text('Blur, offset, asymmetric, zero'),
    ],
  );
}
