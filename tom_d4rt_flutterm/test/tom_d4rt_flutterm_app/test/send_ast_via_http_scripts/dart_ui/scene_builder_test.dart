// D4rt test script: Tests SceneBuilder from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SceneBuilder test executing');

  final sb = ui.SceneBuilder();
  print('SceneBuilder: ${sb.runtimeType}');

  // pushOffset
  final offset = sb.pushOffset(10.0, 20.0);
  print('pushOffset: ${offset.runtimeType}');
  sb.pop();

  // pushClipRect
  final clip = sb.pushClipRect(Rect.fromLTWH(0, 0, 200, 200));
  print('pushClipRect: ${clip.runtimeType}');
  sb.pop();

  // pushClipRRect
  final clipRR = sb.pushClipRRect(RRect.fromRectXY(Rect.fromLTWH(0, 0, 100, 100), 8, 8));
  print('pushClipRRect: ${clipRR.runtimeType}');
  sb.pop();

  // pushOpacity
  final opacity = sb.pushOpacity(128, offset: Offset(5, 5));
  print('pushOpacity: ${opacity.runtimeType}');
  sb.pop();

  // pushColorFilter
  final cf = sb.pushColorFilter(ColorFilter.mode(Colors.red, BlendMode.srcIn));
  print('pushColorFilter: ${cf.runtimeType}');
  sb.pop();

  // pushImageFilter
  final imgf = sb.pushImageFilter(ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3));
  print('pushImageFilter: ${imgf.runtimeType}');
  sb.pop();

  // pushBackdropFilter
  final bd = sb.pushBackdropFilter(ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5));
  print('pushBackdropFilter: ${bd.runtimeType}');
  sb.pop();

  // Nested pushes
  sb.pushOffset(0, 0);
  sb.pushOpacity(200);
  sb.pushClipRect(Rect.fromLTWH(0, 0, 100, 100));
  sb.pop();
  sb.pop();
  sb.pop();
  print('Nested push/pop: OK');

  // Build scene
  final scene = sb.build();
  print('Scene: ${scene.runtimeType}');
  scene.dispose();
  print('Scene disposed');

  print('SceneBuilder test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SceneBuilder Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('7 push types tested'),
    Text('Nested push/pop OK'),
    Text('Scene build + dispose OK'),
  ]);
}
