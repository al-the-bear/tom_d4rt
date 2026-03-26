// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ShaderMaskLayer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShaderMaskLayer test executing');
  print('=' * 50);

  // ShaderMaskLayer applies a shader to its children
  print('\nShaderMaskLayer:');
  print('Extends: ContainerLayer');
  print('Purpose: Applies a shader mask over child layers');
  print('Similar to ShaderMask widget at the rendering layer level');

  // Create an instance
  final layer = ShaderMaskLayer();
  print('\nCreated ShaderMaskLayer:');
  print('  runtimeType: ${layer.runtimeType}');
  print('  shader: ${layer.shader}');
  print('  maskRect: ${layer.maskRect}');
  print('  blendMode: ${layer.blendMode}');

  // Set properties
  final gradient = const LinearGradient(
    colors: [Colors.transparent, Colors.black],
  );
  final shader = gradient.createShader(
    const Rect.fromLTWH(0, 0, 200, 200),
  );
  layer.shader = shader;
  layer.maskRect = const Rect.fromLTWH(0, 0, 200, 200);
  layer.blendMode = BlendMode.dstIn;
  print('\nAfter setting properties:');
  print('  shader: ${layer.shader != null ? "set" : "null"}');
  print('  maskRect: ${layer.maskRect}');
  print('  blendMode: ${layer.blendMode}');

  // BlendMode values used with shader masks
  print('\nCommon BlendMode values for shader masks:');
  print('  dstIn - only show destination where source is opaque');
  print('  srcIn - only show source where destination is opaque');
  print('  srcOver - default compositing');
  print('  modulate - multiply colors');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('  ShaderMask(');
  print('    shaderCallback: (Rect bounds) => gradient.createShader(bounds),');
  print('    blendMode: BlendMode.dstIn,');
  print('    child: Image.asset("fade_image.png"),');
  print('  )');

  // Layer tree
  print('\nLayer tree position:');
  print('  ContainerLayer');
  print('    \u2514\u2500 ShaderMaskLayer');
  print('         \u2514\u2500 child layers (affected by shader)');

  // Common use cases
  print('\nCommon use cases:');
  print('  Fade effects on images or lists');
  print('  Gradient overlays on content');
  print('  Custom visual effects via shaders');

  print('\n==================================================');
  print('ShaderMaskLayer test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ShaderMaskLayer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('Extends: ContainerLayer'),
      Text('blendMode: ${layer.blendMode}'),
      Text('Purpose: Shader mask on layer tree'),
    ],
  );
}
