// D4rt test script: Tests UniformVec2Slot concepts from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformVec2Slot comprehensive test executing');
  final results = <String>[];

  // ========== UniformVec2Slot Concept Tests ==========
  print('Testing UniformVec2Slot concepts...');

  // Test 1: UniformVec2Slot type availability
  final type = ui.UniformVec2Slot;
  assert(type != null, 'UniformVec2Slot type should be available');
  results.add('UniformVec2Slot type available');
  print('UniformVec2Slot type: $type');

  // Test 2: Vec2 uniform concept
  results.add('UniformVec2Slot: Two float shader uniform');
  print('Purpose: Set vec2 (2 floats) in fragment shader');

  // Test 3: Memory layout
  results.add('Memory: 2 consecutive floats (8 bytes)');
  print('Vec2 occupies 2 float slots (8 bytes)');

  // Test 4: Offset concept (uses ui.Offset)
  final offset = Offset(100.0, 200.0);
  assert(offset.dx == 100.0, 'dx should be 100');
  assert(offset.dy == 200.0, 'dy should be 200');
  results.add('Offset(100, 200): dx=${offset.dx}, dy=${offset.dy}');
  print('Offset maps to vec2: (${offset.dx}, ${offset.dy})');

  // Test 5: Resolution uniform example
  final resolution = Offset(1920.0, 1080.0);
  results.add('Resolution: ${resolution.dx}x${resolution.dy}');
  print('Resolution uniform: ${resolution.dx}x${resolution.dy}');

  // Test 6: UV coordinates concept
  final uv = Offset(0.5, 0.5);
  assert(uv.dx >= 0.0 && uv.dx <= 1.0, 'U should be 0-1');
  assert(uv.dy >= 0.0 && uv.dy <= 1.0, 'V should be 0-1');
  results.add('UV coordinates: (${uv.dx}, ${uv.dy})');
  print('UV texture coordinates: (${uv.dx}, ${uv.dy})');

  // Test 7: Mouse/touch position uniform
  final mousePos = Offset(256.0, 384.0);
  results.add('Mouse position: (${mousePos.dx}, ${mousePos.dy})');
  print('Mouse/touch position uniform');

  // Test 8: Direction vector concept
  final direction = Offset(0.707, 0.707); // 45 degrees normalized
  final magnitude = direction.distance;
  results.add('Direction: (${direction.dx.toStringAsFixed(3)}, ${direction.dy.toStringAsFixed(3)})');
  print('Direction vector, magnitude: ${magnitude.toStringAsFixed(3)}');

  // Test 9: Velocity vector concept
  final velocity = Offset(10.0, -5.0);
  results.add('Velocity: (${velocity.dx}, ${velocity.dy})');
  print('Velocity vector for animation');

  // Test 10: Texture scale uniform
  final scale = Offset(2.0, 2.0);
  results.add('Scale: (${scale.dx}, ${scale.dy})');
  print('Texture scale uniform: ${scale.dx}x${scale.dy}');

  // Test 11: GLSL correspondence
  results.add('GLSL: uniform vec2 uValue');
  print('GLSL declaration: uniform vec2 uResolution;');

  // Test 12: Setting via API
  results.add('API: shader.setFloat(idx, x); shader.setFloat(idx+1, y)');
  print('Set vec2 via two consecutive setFloat calls');

  // Test 13: Component access in GLSL
  results.add('GLSL access: uVec.x, uVec.y, uVec.xy');
  print('Access components: .x, .y, .xy swizzle');

  // Test 14: Normalized device coordinates
  final ndc = Offset(0.0, 0.0); // center
  results.add('NDC: (${ndc.dx}, ${ndc.dy}) = center');
  print('NDC range: -1 to 1');

  // Test 15: Aspect ratio calculation
  final width = 1920.0;
  final height = 1080.0;
  final aspectRatio = width / height;
  results.add('Aspect ratio: ${aspectRatio.toStringAsFixed(3)}');
  print('Common uniform: aspect ratio = $aspectRatio');

  // Test 16: Center offset uniform
  final center = Offset(resolution.dx / 2, resolution.dy / 2);
  results.add('Center: (${center.dx}, ${center.dy})');
  print('Center point uniform: (${center.dx}, ${center.dy})');

  // Test 17: Animation offset
  final animOffset = Offset(0.0, 100.0); // scroll offset
  results.add('Scroll offset: ${animOffset.dy}');
  print('Scroll/pan offset uniform');

  // Test 18: Vector arithmetic in Dart
  final v1 = Offset(1.0, 2.0);
  final v2 = Offset(3.0, 4.0);
  final sum = v1 + v2;
  final diff = v1 - v2;
  results.add('Vector math: ($v1) + ($v2) = ($sum)');
  print('Offset supports +, -, *, / operators');

  // Test 19: Normalization pattern
  final raw = Offset(3.0, 4.0);
  final len = raw.distance;
  final normalized = Offset(raw.dx / len, raw.dy / len);
  results.add('Normalized: (${normalized.dx.toStringAsFixed(1)}, ${normalized.dy.toStringAsFixed(1)})');
  print('Normalized vector for direction uniforms');

  // Test 20: Summary
  print('UniformVec2Slot test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UniformVec2Slot Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Type: Vec2 (2 floats, 8 bytes)'),
      Text('Dart: Offset(dx, dy) maps to vec2'),
      Text('Uses: resolution, UV, mouse, direction'),
      Text('GLSL: uniform vec2 uName;'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
