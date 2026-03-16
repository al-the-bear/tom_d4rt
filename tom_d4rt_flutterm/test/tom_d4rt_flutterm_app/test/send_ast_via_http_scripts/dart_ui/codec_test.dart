// D4rt test script: Tests Codec from dart:ui (type reference — requires image data)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Codec test executing');

  // Codec has no public constructor — obtained from ImageDescriptor.instantiateCodec
  // or ui.instantiateImageCodec. Testing available API surface.
  print('Codec type reference: ${ui.Codec}');
  print('Codec properties: frameCount, repetitionCount');
  print('Codec methods: getNextFrame() -> Future<FrameInfo>, dispose()');

  // FrameInfo reference
  print('FrameInfo type reference: ${ui.FrameInfo}');
  print('FrameInfo properties: duration, image');

  // TargetImageSize — related to Codec decoding
  final targetSize1 = ui.TargetImageSize();
  print('TargetImageSize(): width=${targetSize1.width}, height=${targetSize1.height}');

  final targetSize2 = ui.TargetImageSize(width: 100, height: 200);
  print('TargetImageSize(100,200): width=${targetSize2.width}, height=${targetSize2.height}');

  final targetSize3 = ui.TargetImageSize(width: 50);
  print('TargetImageSize(width:50): width=${targetSize3.width}, height=${targetSize3.height}');

  final targetSize4 = ui.TargetImageSize(height: 75);
  print('TargetImageSize(height:75): width=${targetSize4.width}, height=${targetSize4.height}');

  print('TargetImageSize toString: ${targetSize2.toString()}');

  print('Codec test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Codec Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Codec: type reference (no public constructor)'),
      Text('TargetImageSize(): w=${targetSize1.width}, h=${targetSize1.height}'),
      Text('TargetImageSize(100,200): w=${targetSize2.width}, h=${targetSize2.height}'),
      Text('TargetImageSize(50,null): w=${targetSize3.width}'),
    ],
  );
}
