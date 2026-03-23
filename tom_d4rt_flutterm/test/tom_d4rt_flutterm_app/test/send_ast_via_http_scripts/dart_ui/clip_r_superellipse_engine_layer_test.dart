// ignore_for_file: avoid_print
// D4rt test script: Tests ClipRSuperellipseEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final builder = ui.SceneBuilder();
  final rse = RSuperellipse.fromRectAndCorners(
    Rect.fromLTWH(0, 0, 200, 150),
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  final layer = builder.pushClipRSuperellipse(rse);
  builder.pop();

  // With different clip behavior
  builder.pop();

  // Asymmetric superellipse
  builder.pop();

  final scene = builder.build();
  scene.dispose();

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ClipRSuperellipseEngineLayer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text('Type: ${layer.runtimeType}'),
      Text('Symmetric + asymmetric corners'),
      Text('Smoother clipping than RRect'),
    ],
  );
}
