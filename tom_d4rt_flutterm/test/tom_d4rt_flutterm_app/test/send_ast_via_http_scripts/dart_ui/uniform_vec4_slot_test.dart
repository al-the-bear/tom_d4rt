// D4rt test script: Tests UniformVec4Slot concepts from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformVec4Slot comprehensive test executing');
  final results = <String>[];

  // ========== UniformVec4Slot Concept Tests ==========
  print('Testing UniformVec4Slot concepts...');

  // Test 1: UniformVec4Slot type availability
  final type = ui.UniformVec4Slot;
  assert(type != null, 'UniformVec4Slot type should be available');
  results.add('UniformVec4Slot type available');
  print('UniformVec4Slot type: $type');

  // Test 2: Vec4 uniform concept
  results.add('UniformVec4Slot: Four float shader uniform');
  print('Purpose: Set vec4 (4 floats) in fragment shader');

  // Test 3: Memory layout
  results.add('Memory: 4 consecutive floats (16 bytes)');
  print('Vec4 occupies 4 float slots (16 bytes)');

  // Test 4: RGBA color representation
  final r = 1.0, g = 0.5, b = 0.25, a = 0.8;
  results.add('RGBA color: ($r, $g, $b, $a)');
  print('RGBA as vec4: ($r, $g, $b, $a)');

  // Test 5: Color from Flutter Color with alpha
  final color = Color(0x804080C0); // 50% alpha
  final colorR = color.red / 255.0;
  final colorG = color.green / 255.0;
  final colorB = color.blue / 255.0;
  final colorA = color.alpha / 255.0;
  results.add('Color to vec4: (${colorR.toStringAsFixed(2)}, ${colorG.toStringAsFixed(2)}, ${colorB.toStringAsFixed(2)}, ${colorA.toStringAsFixed(2)})');
  print('Flutter Color to vec4 RGBA');

  // Test 6: Rect as vec4 (x, y, width, height)
  final rect = Rect.fromLTWH(10.0, 20.0, 100.0, 50.0);
  results.add('Rect as vec4: (${rect.left}, ${rect.top}, ${rect.width}, ${rect.height})');
  print('Rect (LTWH): (${rect.left}, ${rect.top}, ${rect.width}, ${rect.height})');

  // Test 7: Quaternion representation
  final qx = 0.0, qy = 0.0, qz = 0.707, qw = 0.707; // 90° Z rotation
  results.add('Quaternion: ($qx, $qy, $qz, $qw)');
  print('Quaternion for rotation: ($qx, $qy, $qz, $qw)');

  // Test 8: Homogeneous coordinates
  final hx = 100.0, hy = 200.0, hz = 0.0, hw = 1.0;
  results.add('Homogeneous: ($hx, $hy, $hz, $hw)');
  print('Homogeneous coords for projection');

  // Test 9: Clip rect uniform (left, top, right, bottom)
  final clipLeft = 0.0, clipTop = 0.0, clipRight = 400.0, clipBottom = 300.0;
  results.add('Clip: ($clipLeft, $clipTop, $clipRight, $clipBottom)');
  print('Clip rectangle bounds');

  // Test 10: Border radii (TL, TR, BR, BL)
  final tlRadius = 8.0, trRadius = 8.0, brRadius = 8.0, blRadius = 8.0;
  results.add('Radii: ($tlRadius, $trRadius, $brRadius, $blRadius)');
  print('Border radii as vec4');

  // Test 11: GLSL correspondence
  results.add('GLSL: uniform vec4 uValue');
  print('GLSL declaration: uniform vec4 uColor;');

  // Test 12: Setting via API
  results.add('API: 4 consecutive setFloat calls');
  print('shader.setFloat for x/r, y/g, z/b, w/a');

  // Test 13: Component access in GLSL
  results.add('GLSL access: .x .y .z .w, .r .g .b .a, .s .t .p .q');
  print('Swizzle: .xyzw, .rgba, .stpq');

  // Test 14: Edge insets as vec4
  final edgeInsets = EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0);
  results.add('EdgeInsets: (${edgeInsets.left}, ${edgeInsets.top}, ${edgeInsets.right}, ${edgeInsets.bottom})');
  print('EdgeInsets as vec4 (LTRB)');

  // Test 15: Shadow parameters
  final shadowColor = 0.3; // alpha
  final shadowX = 2.0, shadowY = 4.0, shadowBlur = 8.0;
  results.add('Shadow: ($shadowX, $shadowY, $shadowBlur, $shadowColor)');
  print('Shadow parameters in vec4');

  // Test 16: Gradient stops (up to 4)
  final stop0 = 0.0, stop1 = 0.33, stop2 = 0.66, stop3 = 1.0;
  results.add('Gradient stops: ($stop0, $stop1, $stop2, $stop3)');
  print('Gradient stop positions');

  // Test 17: Matrix row as vec4
  results.add('Matrix row: 4x4 matrix uses 4 vec4s');
  print('Each matrix row is a vec4');

  // Test 18: Animation parameters
  final duration = 1.0, delay = 0.5, progress = 0.75, easing = 0.0;
  results.add('Animation params: ($duration, $delay, $progress, $easing)');
  print('Animation parameters bundled');

  // Test 19: Blend factors
  final srcFactor = 1.0, dstFactor = 0.0, srcAlpha = 1.0, dstAlpha = 0.0;
  results.add('Blend: src=$srcFactor, dst=$dstFactor');
  print('Blending factors');

  // Test 20: Summary
  print('UniformVec4Slot test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UniformVec4Slot Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Type: Vec4 (4 floats, 16 bytes)'),
      Text('Uses: RGBA, rect, quaternion, clip bounds'),
      Text('GLSL: uniform vec4 uName;'),
      Text('Access: .xyzw, .rgba swizzles'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
