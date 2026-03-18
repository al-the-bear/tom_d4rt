// D4rt test script: Tests UniformVec2Slot from dart:ui (fragment shader type)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformVec2Slot test executing');

  // Type information
  print('UniformVec2Slot type: ${ui.UniformVec2Slot}');
  print('Type reference available: true');

  // UniformVec2Slot is part of the uniform slot hierarchy
  // It represents a vec2 (2 floats: x, y) in fragment shaders
  print('\nUniformVec2Slot hierarchy:');
  print('- UniformSlot (abstract base)');
  print('  - UniformFloatSlot (1 float)');
  print('  - UniformVec2Slot (2 floats: x, y) <-- current');
  print('  - UniformVec3Slot (3 floats: x, y, z)');
  print('  - UniformVec4Slot (4 floats: x, y, z, w)');

  // Sample values for vec2
  print('\nVec2 sample values:');
  print('UV coords: (0.0, 0.0) to (1.0, 1.0)');
  print('Screen pos: (width, height)');
  print('Direction: (cos(angle), sin(angle))');

  // Component info
  print('\nVec2 components:');
  print('- x (or s, or r): First component (horizontal/texture U)');
  print('- y (or t, or g): Second component (vertical/texture V)');
  print('Occupies: 2 float32 values = 8 bytes');

  // Usage patterns
  print('\nCommon vec2 uniforms in shaders:');
  print('- resolution: screen/texture dimensions');
  print('- mousePos: cursor position');
  print('- uv: texture coordinates');
  print('- offset: translation offset');
  print('- scale: 2D scale factor');

  print('\nUniformVec2Slot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UniformVec2Slot Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${ui.UniformVec2Slot}'),
      Text('Components: x, y (2 floats)'),
      Text('Size: 8 bytes'),
      Text('Common uses:'),
      Padding(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Resolution'),
            Text('• UV coordinates'),
            Text('• Position offset'),
          ],
        ),
      ),
    ],
  );
}
