// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImageSizeInfo from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageSizeInfo test executing');

  // Create ImageSizeInfo
  final info = ImageSizeInfo(
    source: 'asset://images/logo.png',
    displaySize: Size(100, 100),
    imageSize: Size(200, 200),
  );

  print('Created: ${info.runtimeType}');

  // Test properties
  print('\nImageSizeInfo properties:');
  print('source: ${info.source}');
  print('displaySize: ${info.displaySize}');
  print('imageSize: ${info.imageSize}');

  // Wasteful analysis
  print('\nSize analysis:');
  print('Image pixels: ${info.imageSize.width * info.imageSize.height}');
  print('Display pixels: ${info.displaySize.width * info.displaySize.height}');

  // Purpose
  print('\nPurpose:');
  print('- Reports oversized images');
  print('- Helps optimize memory');
  print('- Used by debugInvertOversizedImages');

  // debugInvertOversizedImages
  print('\ndebugInvertOversizedImages:');
  print('- Set to true in development');
  print('- Inverts colors of wasteful images');
  print('- Shows when image > display size');

  // Usage
  print('\nUsage for debugging:');
  print('void main() {');
  print('  debugInvertOversizedImages = true;');
  print('  runApp(MyApp());');
  print('}');

  // Optimization tip
  print('\nOptimization:');
  print('- Use ResizeImage to downscale');
  print('- Provide @1x, @2x, @3x variants');
  print('- Use cacheWidth/cacheHeight');

  print('\nImageSizeInfo test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ImageSizeInfo Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Image size diagnostic'),
      Text('displaySize: ${info.displaySize}'),
      Text('imageSize: ${info.imageSize}'),
      Text('For: debugInvertOversizedImages'),
    ],
  );
}
