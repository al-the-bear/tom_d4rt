// D4rt test script: Tests ClipRSuperellipseEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClipRSuperellipseEngineLayer test executing');

  final builder = ui.SceneBuilder();
  final rse = RSuperellipse.fromRectAndCorners(
    Rect.fromLTWH(0, 0, 200, 150),
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  final layer = builder.pushClipRSuperellipse(rse);
  print('pushClipRSuperellipse returned: ${layer.runtimeType}');
  print('is EngineLayer: ${layer is ui.EngineLayer}');
  builder.pop();

  // With different clip behavior
  final layer2 = builder.pushClipRSuperellipse(rse, clipBehavior: Clip.hardEdge);
  print('pushClipRSuperellipse hardEdge: ${layer2.runtimeType}');
  builder.pop();

  // Asymmetric superellipse
  final rse2 = RSuperellipse.fromRectAndCorners(
    Rect.fromLTWH(0, 0, 100, 100),
    topLeft: Radius.circular(5),
    topRight: Radius.circular(30),
    bottomLeft: Radius.circular(15),
    bottomRight: Radius.circular(25),
  );
  final layer3 = builder.pushClipRSuperellipse(rse2);
  print('pushClipRSuperellipse asymmetric: ${layer3.runtimeType}');
  builder.pop();

  final scene = builder.build();
  scene.dispose();

  print('ClipRSuperellipseEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipRSuperellipseEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${layer.runtimeType}'),
      Text('Symmetric + asymmetric corners'),
      Text('Smoother clipping than RRect'),
    ],
  );
}
