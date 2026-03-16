// D4rt test script: Tests BackdropFilterEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BackdropFilterEngineLayer test executing');

  // Create SceneBuilder
  final builder = ui.SceneBuilder();
  print('SceneBuilder created');

  // Push backdrop filter — returns BackdropFilterEngineLayer
  final filter = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final layer = builder.pushBackdropFilter(filter);
  print('pushBackdropFilter returned: ${layer.runtimeType}');
  print('is EngineLayer: ${layer is ui.EngineLayer}');

  // Push with blendMode
  builder.pop();
  final layer2 = builder.pushBackdropFilter(filter, blendMode: BlendMode.multiply);
  print('pushBackdropFilter with blendMode: ${layer2.runtimeType}');

  // Push with different blur
  builder.pop();
  final filter2 = ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 2.0);
  final layer3 = builder.pushBackdropFilter(filter2);
  print('pushBackdropFilter asymmetric blur: ${layer3.runtimeType}');

  builder.pop();
  final scene = builder.build();
  print('Scene built: ${scene.runtimeType}');
  scene.dispose();
  print('Scene disposed');

  print('BackdropFilterEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BackdropFilterEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${layer.runtimeType}'),
      Text('Created via SceneBuilder.pushBackdropFilter'),
      Text('Tested with different blur modes'),
    ],
  );
}
