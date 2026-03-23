// ignore_for_file: avoid_print
// D4rt test script: Tests UniformFloatSlot from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformFloatSlot test executing');

  // ========== Basic UniformFloatSlot tests ==========
  print('--- UniformFloatSlot Type Info ---');
  print('Type: ${ui.UniformFloatSlot}');
  print('Part of FragmentProgram uniform system');

  // ========== UniformSlot Hierarchy ==========
  print('--- Uniform Slot Types ---');
  print('UniformFloatSlot: Single float value');
  print('UniformVec2Slot: 2D vector (x, y)');
  print('UniformVec3Slot: 3D vector (x, y, z)');
  print('UniformVec4Slot: 4D vector (x, y, z, w)');

  // ========== Sample float values for shaders ==========
  print('--- Sample Float Values for Shaders ---');
  final floatValues = [0.0, 0.5, 1.0, -1.0, 3.14159, 100.0];
  for (final v in floatValues) {
    print('  Float value: $v');
  }

  // ========== Float precision notes ==========
  print('--- Float Precision Notes ---');
  print('GPU floats are typically 32-bit (GLSL float)');
  print('Very large or small values may lose precision');
  print('Range: approximately ±3.4e38');
  print('Precision: ~7 significant digits');

  // ========== Usage pattern ==========
  print('--- Usage Pattern ---');
  print('1. Create FragmentProgram from asset');
  print('2. Get UniformFloatSlot from program');
  print('3. Call shader.setFloat(slot, value)');

  // ========== Common shader uses ==========
  print('--- Common Shader Uses ---');
  print('Time uniforms: animation time value');
  print('Intensity: brightness, opacity');
  print('Scale factors: zoom, size multipliers');
  print('Thresholds: cutoff values for effects');

  print('UniformFloatSlot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UniformFloatSlot Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Type: ${ui.UniformFloatSlot}'),
      Text('Single float shader uniform'),
      Text('Used with FragmentShader.setFloat()'),
      Text('Float range: ±3.4e38'),
    ],
  );
}
