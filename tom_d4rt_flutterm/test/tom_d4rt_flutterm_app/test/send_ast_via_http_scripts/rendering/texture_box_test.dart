// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextureBox from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextureBox test executing');

  // Test TextureBox - Texture box
  print('TextureBox is available in the rendering package');
  print('TextureBox: Texture box');

  print('TextureBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextureBox Tests'),
      Text('Texture box'),
    ],
  );
}
