// D4rt test script: Tests ClipPathEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClipPathEngineLayer test executing');

  final builder = ui.SceneBuilder();
  final path = Path()
    ..moveTo(0, 0)
    ..lineTo(100, 0)
    ..lineTo(50, 100)
    ..close();

  // Default clip behavior
  final layer1 = builder.pushClipPath(path);
  print('pushClipPath returned: ${layer1.runtimeType}');
  print('is EngineLayer: ${layer1 is ui.EngineLayer}');
  builder.pop();

  // With clipBehavior
  final layer2 = builder.pushClipPath(path, clipBehavior: Clip.hardEdge);
  print('pushClipPath hardEdge: ${layer2.runtimeType}');
  builder.pop();

  final layer3 = builder.pushClipPath(path, clipBehavior: Clip.antiAliasWithSaveLayer);
  print('pushClipPath antiAliasWithSaveLayer: ${layer3.runtimeType}');
  builder.pop();

  // Complex path
  final complexPath = Path()
    ..addOval(Rect.fromCircle(center: Offset(50, 50), radius: 40))
    ..addRect(Rect.fromLTWH(70, 10, 60, 80));
  final layer4 = builder.pushClipPath(complexPath);
  print('pushClipPath complex: ${layer4.runtimeType}');
  builder.pop();

  final scene = builder.build();
  scene.dispose();

  print('ClipPathEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipPathEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${layer1.runtimeType}'),
      Text('Clip behaviors: antiAlias, hardEdge, saveLayer'),
      Text('Simple + complex paths'),
    ],
  );
}
