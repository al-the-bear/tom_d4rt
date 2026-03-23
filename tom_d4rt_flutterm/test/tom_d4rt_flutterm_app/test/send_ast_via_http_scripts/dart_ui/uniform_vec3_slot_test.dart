// ignore_for_file: avoid_print
// D4rt test script: Tests UniformVec3Slot from dart:ui (fragment shader type)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformVec3Slot test executing');

  // Type information
  print('UniformVec3Slot type: ${ui.UniformVec3Slot}');
  print('Type reference available: true');

  // UniformVec3Slot is part of the uniform slot hierarchy
  // It represents a vec3 (3 floats: x, y, z) in fragment shaders
  print('\nUniformVec3Slot hierarchy:');
  print('- UniformSlot (abstract base)');
  print('  - UniformFloatSlot (1 float)');
  print('  - UniformVec2Slot (2 floats)');
  print('  - UniformVec3Slot (3 floats: x, y, z) <-- current');
  print('  - UniformVec4Slot (4 floats)');

  // Sample values for vec3
  print('\nVec3 sample values:');
  print('RGB color: (1.0, 0.0, 0.0) = red');
  print('Position: (x, y, z) in 3D space');
  print('Direction: normalized (dx, dy, dz)');

  // Component info
  print('\nVec3 components:');
  print('- x (or r, or s): First component');
  print('- y (or g, or t): Second component');
  print('- z (or b, or p): Third component');
  print('Occupies: 3 float32 values = 12 bytes');
  print('Note: May be padded to 16 bytes in some layouts');

  // Usage patterns
  print('\nCommon vec3 uniforms in shaders:');
  print('- color: RGB color without alpha');
  print('- lightDir: light direction vector');
  print('- cameraPos: camera position in 3D');
  print('- normal: surface normal vector');
  print('- ambient: ambient light color');

  print('\nUniformVec3Slot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UniformVec3Slot Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${ui.UniformVec3Slot}'),
      Text('Components: x, y, z (3 floats)'),
      Text('Size: 12 bytes (may pad to 16)'),
      Text('Common uses:'),
      Padding(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• RGB color'),
            Text('• 3D position'),
            Text('• Surface normal'),
            Text('• Light direction'),
          ],
        ),
      ),
    ],
  );
}
