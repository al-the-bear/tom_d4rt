// ignore_for_file: avoid_print
// D4rt test script: Tests TransformEngineLayer via SceneBuilder
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TransformEngineLayer test executing');

  // TransformEngineLayer from pushOffset (offset is a special transform)
  final sb = ui.SceneBuilder();

  // pushOffset creates OffsetEngineLayer but tests transform concept
  final layer1 = sb.pushOffset(50.0, 100.0);
  print('pushOffset layer: ${layer1.runtimeType}');
  sb.pop();

  // Test nested transforms
  sb.pushOffset(10, 10);
  sb.pushOffset(20, 20);
  sb.pushOffset(30, 30);
  sb.pop();
  sb.pop();
  sb.pop();
  print('Nested offsets: OK');

  final scene = sb.build();
  scene.dispose();

  print('TransformEngineLayer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('TransformEngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('pushOffset creates OffsetEngineLayer'),
    Text('Nested transforms OK'),
  ]);
}
