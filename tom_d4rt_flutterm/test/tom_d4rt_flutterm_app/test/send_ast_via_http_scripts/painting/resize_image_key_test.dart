// D4rt test script: Tests ResizeImageKey from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ResizeImageKey test executing');

  // ResizeImageKey is the cache key for ResizeImage
  print('ResizeImageKey is cache key for ResizeImage');

  // What ResizeImage does
  print('\nResizeImage purpose:');
  print('- Downscales images during decode');
  print('- Saves memory for large images');
  print('- Caches resized result');

  // ResizeImageKey components
  print('\nResizeImageKey uniquely identifies:');
  print('- Original image provider');
  print('- Target width');
  print('- Target height');
  print('- Allow upscale flag');

  // How it works
  print('\nHow caching works:');
  print('1. ResizeImage creates ResizeImageKey');
  print('2. Cache checks for existing key');
  print('3. If hit: returns cached resized image');
  print('4. If miss: decodes and resizes');

  // Create ResizeImage
  print('\nCreating ResizeImage:');
  print('ResizeImage(');
  print('  AssetImage("big_image.png"),');
  print('  width: 100,');
  print('  height: 100,');
  print(')');

  // Image.asset convenience
  print('\nImage.asset convenience:');
  print('Image.asset(');
  print('  "big.png",');
  print('  cacheWidth: 100,');
  print('  cacheHeight: 100,');
  print(')');

  // Memory savings
  print('\nMemory savings:');
  print('2000x2000 RGBA = 16MB');
  print('200x200 RGBA = 160KB');
  print('100x reduction!');

  print('\nResizeImageKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ResizeImageKey Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Cache key for ResizeImage'),
      Text('Identifies: provider + dimensions'),
      Text('For: memory-efficient images'),
    ],
  );
}
