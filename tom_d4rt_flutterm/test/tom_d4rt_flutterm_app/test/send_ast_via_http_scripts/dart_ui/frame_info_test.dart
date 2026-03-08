// D4rt test script: Tests FrameInfo from dart:ui (type reference — obtained from Codec)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FrameInfo test executing');

  // FrameInfo has no public constructor — obtained from Codec.getNextFrame()
  print('FrameInfo type: ${ui.FrameInfo}');
  print('FrameInfo properties: duration (Duration), image (Image)');
  print('Obtained via: Codec.getNextFrame() -> Future<FrameInfo>');

  // Image type reference
  print('Image type: ${ui.Image}');
  print('Image properties: width, height');
  print('Image methods: toByteData, dispose, clone, isCloneOf');

  // Codec -> FrameInfo -> Image pipeline description
  print('Pipeline: ImmutableBuffer -> ImageDescriptor -> Codec -> FrameInfo -> Image');

  print('FrameInfo test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FrameInfo Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('FrameInfo: no public constructor'),
      Text('Properties: duration + image'),
      Text('Obtained from Codec.getNextFrame()'),
      Text('Pipeline: Buffer -> Descriptor -> Codec -> FrameInfo'),
    ],
  );
}
