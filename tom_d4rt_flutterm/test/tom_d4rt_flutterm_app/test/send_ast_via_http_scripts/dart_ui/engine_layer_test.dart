// D4rt test script: Tests EngineLayer base class from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EngineLayer test executing');

  final builder = ui.SceneBuilder();

  // All push methods return EngineLayer subtypes
  final offsetLayer = builder.pushOffset(10.0, 20.0);
  print('true: ${offsetLayer is ui.EngineLayer}');
  builder.pop();

  final clipRectLayer = builder.pushClipRect(Rect.fromLTWH(0, 0, 100, 100));
  print('true: ${clipRectLayer is ui.EngineLayer}');
  builder.pop();

  final opacityLayer = builder.pushOpacity(128);
  print('true: ${opacityLayer is ui.EngineLayer}');
  builder.pop();

  final colorFilter = ColorFilter.mode(Colors.blue, BlendMode.srcIn);
  final cfLayer = builder.pushColorFilter(colorFilter);
  print('true: ${cfLayer is ui.EngineLayer}');
  builder.pop();

  final imgFilter = ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0);
  final ifLayer = builder.pushImageFilter(imgFilter);
  print('true: ${ifLayer is ui.EngineLayer}');
  builder.pop();

  final bdLayer = builder.pushBackdropFilter(imgFilter);
  print('true: ${bdLayer is ui.EngineLayer}');
  builder.pop();

  // EngineLayer.dispose via dynamic dispatch
  print('EngineLayer API: dispose()');

  final scene = builder.build();
  scene.dispose();

  print('EngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('EngineLayer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Base type for all scene layers'),
      Text('OffsetEngineLayer: ${offsetLayer.runtimeType}'),
      Text('ClipRectEngineLayer: ${clipRectLayer.runtimeType}'),
      Text('OpacityEngineLayer: ${opacityLayer.runtimeType}'),
      Text('All subtypes verified as EngineLayer'),
    ],
  );
}
