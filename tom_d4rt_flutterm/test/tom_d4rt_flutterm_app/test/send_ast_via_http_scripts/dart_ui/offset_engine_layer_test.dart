// D4rt test script: Tests OffsetEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OffsetEngineLayer test executing');

  final builder = ui.SceneBuilder();

  // pushOffset returns OffsetEngineLayer
  final layer1 = builder.pushOffset(10.0, 20.0);
  print('pushOffset(10,20): ${layer1.runtimeType}');
  print('is EngineLayer: ${layer1 is ui.EngineLayer}');
  builder.pop();

  // Zero offset
  final layer2 = builder.pushOffset(0.0, 0.0);
  print('pushOffset(0,0): ${layer2.runtimeType}');
  builder.pop();

  // Negative offset
  final layer3 = builder.pushOffset(-50.0, -30.0);
  print('pushOffset(-50,-30): ${layer3.runtimeType}');
  builder.pop();

  // Large offset
  final layer4 = builder.pushOffset(1000.0, 2000.0);
  print('pushOffset(1000,2000): ${layer4.runtimeType}');
  builder.pop();

  // Nested offsets
  final l5 = builder.pushOffset(10.0, 10.0);
  final l6 = builder.pushOffset(20.0, 20.0);
  print('Nested offsets: outer=${l5.runtimeType}, inner=${l6.runtimeType}');
  builder.pop();
  builder.pop();

  final scene = builder.build();
  scene.dispose();

  print('OffsetEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OffsetEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${layer1.runtimeType}'),
      Text('Zero, positive, negative, large offsets'),
      Text('Nested offsets supported'),
    ],
  );
}
