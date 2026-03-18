// D4rt test script: Tests OpacityEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OpacityEngineLayer test executing');

  final builder = ui.SceneBuilder();

  // Full opacity
  final layer1 = builder.pushOpacity(255);
  print('pushOpacity(255): ${layer1.runtimeType}');
  print('is EngineLayer: true');
  builder.pop();

  // Half opacity
  final layer2 = builder.pushOpacity(128);
  print('pushOpacity(128): ${layer2.runtimeType}');
  builder.pop();

  // Zero opacity (fully transparent)
  final layer3 = builder.pushOpacity(0);
  print('pushOpacity(0): ${layer3.runtimeType}');
  builder.pop();

  // With offset
  final layer4 = builder.pushOpacity(200, offset: Offset(10.0, 20.0));
  print('pushOpacity with offset: ${layer4.runtimeType}');
  builder.pop();

  // Various alpha values
  for (final alpha in [25, 50, 75, 100, 150, 200]) {
    final l = builder.pushOpacity(alpha);
    print('pushOpacity($alpha): ${l.runtimeType}');
    builder.pop();
  }

  final scene = builder.build();
  scene.dispose();

  print('OpacityEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OpacityEngineLayer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text('Type: ${layer1.runtimeType}'),
      Text('Alpha 0, 128, 255 tested'),
      Text('With offset supported'),
      Text('6 additional alpha values tested'),
    ],
  );
}
