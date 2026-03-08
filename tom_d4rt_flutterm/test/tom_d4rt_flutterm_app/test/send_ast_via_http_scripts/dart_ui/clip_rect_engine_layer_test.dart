// D4rt test script: Tests ClipRectEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClipRectEngineLayer test executing');

  final builder = ui.SceneBuilder();
  final rect = Rect.fromLTWH(10, 20, 200, 150);

  final layer = builder.pushClipRect(rect);
  print('pushClipRect returned: ${layer.runtimeType}');
  print('is EngineLayer: ${layer is ui.EngineLayer}');
  builder.pop();

  // Different clip behaviors
  for (final clip in [Clip.hardEdge, Clip.antiAlias, Clip.antiAliasWithSaveLayer]) {
    final l = builder.pushClipRect(rect, clipBehavior: clip);
    print('pushClipRect ${clip.name}: ${l.runtimeType}');
    builder.pop();
  }

  // Different rects
  final smallRect = Rect.fromLTWH(0, 0, 10, 10);
  final layer2 = builder.pushClipRect(smallRect);
  print('pushClipRect small: ${layer2.runtimeType}');
  builder.pop();

  final largeRect = Rect.fromLTWH(-100, -100, 1000, 1000);
  final layer3 = builder.pushClipRect(largeRect);
  print('pushClipRect large: ${layer3.runtimeType}');
  builder.pop();

  final scene = builder.build();
  scene.dispose();

  print('ClipRectEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipRectEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${layer.runtimeType}'),
      Text('3 clip behaviors tested'),
      Text('Small, normal, large rects'),
    ],
  );
}
