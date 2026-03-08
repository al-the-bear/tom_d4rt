// D4rt test script: Tests PictureRasterizationException from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PictureRasterizationException test executing');

  // PictureRasterizationException has no public constructor
  // It's thrown when Picture.toImage/toImageSync fails during rasterization
  print('PictureRasterizationException type: ${PictureRasterizationException}');
  print('Properties: message (String), stack (StackTrace?)');
  print('Methods: toString()');

  // Demonstrate related APIs that could throw this exception
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, 100, 100));
  canvas.drawRect(Rect.fromLTWH(10, 10, 80, 80), Paint()..color = Colors.blue);
  final picture = recorder.endRecording();
  print('Picture recorded: ${picture.runtimeType}');

  // picture.toImage is async and normally succeeds
  print('picture.toImage would return Future<Image>');
  print('PictureRasterizationException thrown on GPU failure');

  picture.dispose();
  print('Picture disposed');

  print('PictureRasterizationException test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PictureRasterizationException Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('No public constructor'),
      Text('Thrown when rasterization fails'),
      Text('Properties: message + stack'),
      Text('Related to Picture.toImage/toImageSync'),
    ],
  );
}
