// D4rt test script: Tests FragmentProgram from dart:ui (type reference — requires shader assets)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FragmentProgram test executing');

  // FragmentProgram requires compiled shader assets to instantiate
  // Testing type reference and related slot types
  print('FragmentProgram type: ${ui.FragmentProgram}');
  print('FragmentProgram.fromAsset: static factory (requires SPIR-V asset)');

  // UniformFloatSlot
  print('UniformFloatSlot type: ${ui.UniformFloatSlot}');

  // UniformVec2Slot
  print('UniformVec2Slot type: ${ui.UniformVec2Slot}');

  // UniformVec3Slot
  print('UniformVec3Slot type: ${ui.UniformVec3Slot}');

  // UniformVec4Slot
  print('UniformVec4Slot type: ${ui.UniformVec4Slot}');

  // ImageSamplerSlot
  print('ImageSamplerSlot type: ${ui.ImageSamplerSlot}');

  // FragmentShader type
  print('FragmentShader type: ${ui.FragmentShader}');

  print('FragmentProgram test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FragmentProgram Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('FragmentProgram: type reference'),
      Text('Requires SPIR-V shader assets'),
      Text('Slot types: Float, Vec2, Vec3, Vec4, ImageSampler'),
      Text('FragmentShader: produced by FragmentProgram'),
    ],
  );
}
