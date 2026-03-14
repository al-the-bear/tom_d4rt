// D4rt test script: Tests ShaderWarmUp from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('ShaderWarmUp test executing');

  // ShaderWarmUp is abstract - explain concept
  print('ShaderWarmUp precompiles shaders');

  // Purpose
  print('\nPurpose:');
  print('- Prevents first-frame shader jank');
  print('- Compiles GPU shaders ahead of time');
  print('- Run during app startup');

  // How shader jank happens
  print('\nShader jank problem:');
  print('- GPU shaders compiled on first use');
  print('- Causes frame drops (stutter)');
  print('- Especially noticeable on animations');

  // Solution
  print('\nShaderWarmUp solution:');
  print('- Draw shapes during splash screen');
  print('- Forces shader compilation');
  print('- User doesnt see stutter');

  // Implementation
  print('\nTo implement:');
  print('class MyShaderWarmUp extends ShaderWarmUp {');
  print('  Future<void> warmUpOnCanvas(Canvas c) async {');
  print('    // Draw common shapes');
  print('    c.drawRect(...); // rect shader');
  print('    c.drawCircle(...); // circle shader');
  print('  }');
  print('}');

  // Usage
  print('\nUsage:');
  print('void main() async {');
  print('  await MyShaderWarmUp().warmUp();');
  print('  runApp(MyApp());');
  print('}');

  // Default
  print('\nDefault warm up:');
  print('- DefaultShaderWarmUp available');
  print('- Draws basic shapes');

  print('\nShaderWarmUp test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ShaderWarmUp Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Shader precompilation'),
      Text('Prevents: first-frame jank'),
      Text('Run at: app startup'),
    ],
  );
}
