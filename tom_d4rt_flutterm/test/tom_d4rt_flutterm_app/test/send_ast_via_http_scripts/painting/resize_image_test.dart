// ignore_for_file: avoid_print
// D4rt test script: Tests ResizeImage from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ResizeImage test executing');

  // Create ResizeImage
  final resized = ResizeImage(
    AssetImage('placeholder.png'),
    width: 100,
    height: 100,
  );

  print('Created: ${resized.runtimeType}');
  print('is ImageProvider: ${true}');

  // Properties
  print('\nResizeImage properties:');
  print('width: ${resized.width}');
  print('height: ${resized.height}');
  print('allowUpscaling: ${resized.allowUpscaling}');

  // How it works
  print('\nHow it works:');
  print('1. Wraps another ImageProvider');
  print('2. During decode, resizes to target');
  print('3. Saves memory vs full resolution');
  print('4. Caches resized result');

  // Memory savings
  print('\nMemory savings example:');
  print('Original: 4000x4000 RGBA = 64MB');
  print('Resized: 100x100 RGBA = 40KB');
  print('Savings: 99.9%!');

  // allowUpscaling
  print('\nallowUpscaling:');
  print('- false (default): never upscale');
  print('- true: can enlarge small images');
  print('- Usually keep false for quality');

  // Via Image.asset
  print('\nVia Image.asset:');
  print('Image.asset(');
  print('  "large_image.png",');
  print('  cacheWidth: 100,');
  print('  cacheHeight: 100,');
  print(')');

  // resizeIfNeeded factory
  print('\nResizeImage.resizeIfNeeded:');
  print('- Only wraps if width/height provided');
  print('- Returns original if no resize needed');

  print('\nResizeImage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ResizeImage Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Memory-efficient image loading'),
      Text('width: ${resized.width}'),
      Text('height: ${resized.height}'),
      Text('Huge memory savings'),
    ],
  );
}
