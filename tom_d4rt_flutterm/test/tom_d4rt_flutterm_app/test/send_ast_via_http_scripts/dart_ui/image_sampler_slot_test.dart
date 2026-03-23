// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImageSamplerSlot from dart:ui (type reference — part of FragmentShader)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageSamplerSlot test executing');

  // ImageSamplerSlot is part of the fragment shader system
  print('ImageSamplerSlot type: ${ui.ImageSamplerSlot}');
  print('Used to bind Image to a FragmentShader sampler slot');
  print('Accessed via FragmentProgram after compiling a SPIR-V shader');

  // Related uniform slot types
  print('UniformFloatSlot type: ${ui.UniformFloatSlot}');
  print('UniformVec2Slot type: ${ui.UniformVec2Slot}');
  print('UniformVec3Slot type: ${ui.UniformVec3Slot}');
  print('UniformVec4Slot type: ${ui.UniformVec4Slot}');

  print('Fragment shader pipeline: GLSL -> SPIR-V -> FragmentProgram.fromAsset -> FragmentShader');
  print('Uniforms set via slot types, images via ImageSamplerSlot');

  print('ImageSamplerSlot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageSamplerSlot Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type reference (requires shader asset)'),
      Text('Part of FragmentShader uniform system'),
      Text('Slot types: Float, Vec2, Vec3, Vec4, ImageSampler'),
    ],
  );
}
