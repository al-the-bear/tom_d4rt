// ignore_for_file: avoid_print
// D4rt test script: Tests Scene from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scene test executing');

  // Build a scene
  final sb = ui.SceneBuilder();
  sb.pushOffset(10.0, 20.0);
  sb.pushOpacity(200);
  sb.pop();
  sb.pop();
  final scene = sb.build();
  print('Scene type: ${scene.runtimeType}');

  // dispose
  scene.dispose();
  print('Scene disposed');

  // Build another scene with content
  final sb2 = ui.SceneBuilder();
  sb2.pushClipRect(Rect.fromLTWH(0, 0, 300, 300));
  sb2.pushOffset(50, 50);
  sb2.pop();
  sb2.pop();
  final scene2 = sb2.build();
  print('Scene2: ${scene2.runtimeType}');
  scene2.dispose();

  print('Scene test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('Scene Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Created via SceneBuilder.build()'),
    Text('dispose() called successfully'),
  ]);
}
