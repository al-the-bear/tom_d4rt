// D4rt test script: Tests ClipContext from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClipContext test executing');

  // ClipContext is a mixin for managing clips
  print('ClipContext is a mixin for clip management');

  // Purpose
  print('\nPurpose:');
  print('- Manages canvas clip/restore');
  print('- Used by CustomPainter, RenderBox');
  print('- Ensures proper save/restore pairs');

  // Key methods
  print('\nKey methods:');
  print('- clipPathAndPaint(): clip to path');
  print('- clipRRectAndPaint(): clip to rounded rect');
  print('- clipRectAndPaint(): clip to rect');

  // How it works
  print('\nHow it works:');
  print('1. Save canvas state');
  print('2. Apply clip (rect, path, etc)');
  print('3. Paint within clip');
  print('4. Restore canvas state');

  // Parameters
  print('\nCommon parameters:');
  print('- canvas: where to paint');
  print('- clipBehavior: Clip.hardEdge/antiAlias');
  print('- bounds: clip bounds');
  print('- painter: callback to do painting');

  // Clip behaviors
  print('\nClip behaviors:');
  print('- Clip.none: no clipping');
  print('- Clip.hardEdge: fast, aliased');
  print('- Clip.antiAlias: smooth edges');
  print('- Clip.antiAliasWithSaveLayer: best quality');

  // Usage context
  print('\nUsage context:');
  print('- RenderBox uses for overflow');
  print('- ClipRect, ClipRRect widgets');
  print('- CustomPainter for shapes');

  print('\nClipContext test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ClipContext Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Mixin for clip management'),
      Text('Methods: clipPath/RRect/Rect'),
      Text('Auto save/restore canvas'),
    ],
  );
}
