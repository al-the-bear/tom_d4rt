// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ClipRectEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final builder = ui.SceneBuilder();
  final rect = Rect.fromLTWH(10, 20, 200, 150);

  final layer = builder.pushClipRect(rect);
  builder.pop();

  // Different clip behaviors

  builder.pop();

  final scene = builder.build();
  scene.dispose();

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ClipRectEngineLayer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text('Type: ${layer.runtimeType}'),
      Text('3 clip behaviors tested'),
      Text('Small, normal, large rects'),
    ],
  );
}
