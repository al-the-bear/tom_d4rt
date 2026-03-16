// D4rt test script: Tests ClipRRectEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClipRRectEngineLayer test executing');

  final builder = ui.SceneBuilder();
  final rrect = RRect.fromRectXY(Rect.fromLTWH(0, 0, 200, 150), 16, 16);

  final layer = builder.pushClipRRect(rrect);
  print('pushClipRRect returned: ${layer.runtimeType}');
  print('is EngineLayer: ${layer is ui.EngineLayer}');
  builder.pop();

  // With different clip behaviors
  final layer2 = builder.pushClipRRect(rrect, clipBehavior: Clip.hardEdge);
  print('pushClipRRect hardEdge: ${layer2.runtimeType}');
  builder.pop();

  // Asymmetric corners
  final rrect2 = RRect.fromRectAndCorners(
    Rect.fromLTWH(0, 0, 100, 80),
    topLeft: Radius.circular(4),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(8),
  );
  final layer3 = builder.pushClipRRect(rrect2);
  print('pushClipRRect asymmetric: ${layer3.runtimeType}');
  builder.pop();

  final scene = builder.build();
  scene.dispose();

  print('ClipRRectEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipRRectEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${layer.runtimeType}'),
      Text('Symmetric + asymmetric corners'),
      Text('Multiple clip behaviors'),
    ],
  );
}
