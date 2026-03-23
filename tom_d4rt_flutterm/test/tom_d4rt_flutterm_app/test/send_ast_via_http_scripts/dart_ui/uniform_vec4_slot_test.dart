// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UniformVec4Slot from dart:ui (fragment shader type)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformVec4Slot test executing');

  // Type information
  print('UniformVec4Slot type: ${ui.UniformVec4Slot}');
  print('Type reference available: true');

  // UniformVec4Slot is part of the uniform slot hierarchy
  // It represents a vec4 (4 floats: x, y, z, w) in fragment shaders
  print('\nUniformVec4Slot hierarchy:');
  print('- UniformSlot (abstract base)');
  print('  - UniformFloatSlot (1 float)');
  print('  - UniformVec2Slot (2 floats)');
  print('  - UniformVec3Slot (3 floats)');
  print('  - UniformVec4Slot (4 floats: x, y, z, w) <-- current');

  // Sample values for vec4
  print('\nVec4 sample values:');
  print('RGBA color: (1.0, 0.0, 0.0, 1.0) = opaque red');
  print('Position+w: (x, y, z, 1.0) homogeneous coords');
  print('Rect: (left, top, right, bottom)');

  // Component info
  print('\nVec4 components:');
  print('- x (or r, or s): First component');
  print('- y (or g, or t): Second component');
  print('- z (or b, or p): Third component');
  print('- w (or a, or q): Fourth component');
  print('Occupies: 4 float32 values = 16 bytes');

  // Swizzling examples
  print('\nSwizzle operations (in GLSL):');
  print('vec4 v = vec4(1, 2, 3, 4);');
  print('v.xy -> vec2(1, 2)');
  print('v.rgb -> vec3(1, 2, 3)');
  print('v.wzyx -> vec4(4, 3, 2, 1)');

  // Usage patterns
  print('\nCommon vec4 uniforms in shaders:');
  print('- color: RGBA color with alpha');
  print('- bounds: rectangle (left, top, right, bottom)');
  print('- clipRect: clipping rectangle');
  print('- matrix row: one row of mat4');
  print('- transform: position + scale');

  print('\nUniformVec4Slot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UniformVec4Slot Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${ui.UniformVec4Slot}'),
      Text('Components: x, y, z, w (4 floats)'),
      Text('Size: 16 bytes (naturally aligned)'),
      Text('Common uses:'),
      Padding(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• RGBA color'),
            Text('• Rectangle bounds'),
            Text('• Matrix row'),
            Text('• Clip rect'),
          ],
        ),
      ),
    ],
  );
}
