// D4rt test script: Tests SystemColorPalette from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SystemColorPalette test executing');

  // SystemColorPalette is accessed via SystemColor static methods
  print('SystemColor.platformProvidesSystemColors: ${ui.SystemColor.platformProvidesSystemColors}');

  // Access light and dark palettes
  final light = ui.SystemColor.light;
  print('Light palette: ${light.runtimeType}');

  final dark = ui.SystemColor.dark;
  print('Dark palette: ${dark.runtimeType}');

  // Access colors from the palette (CSS system color names)
  print('light.canvasText: ${light.canvasText}');
  print('light.canvas: ${light.canvas}');
  print('light.accentColor: ${light.accentColor}');
  print('dark.canvasText: ${dark.canvasText}');
  print('dark.canvas: ${dark.canvas}');

  print('SystemColorPalette test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SystemColorPalette Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Light and Dark palettes accessed'),
    Text('Platform provides: ${ui.SystemColor.platformProvidesSystemColors}'),
  ]);
}
