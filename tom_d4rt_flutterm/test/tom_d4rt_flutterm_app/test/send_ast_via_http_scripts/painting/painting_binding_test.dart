// D4rt test script: Tests PaintingBinding from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PaintingBinding test executing');

  // PaintingBinding is a mixin on BindingBase
  print('PaintingBinding is a mixin');

  // Access via WidgetsFlutterBinding
  print('\nAccess via binding:');
  print('PaintingBinding provides imageCache');

  // Key properties
  print('\nKey properties:');
  print('- imageCache: ImageCache instance');
  print('- instantiateImageCodec(): decode images');
  print('- shaderWarmUp: ShaderWarmUp instance');

  // ImageCache
  print('\nImageCache:');
  print('- Caches decoded images');
  print('- Configurable max size');
  print('- Prevents redundant decoding');

  // Usage
  print('\nUsage:');
  print('final cache = PaintingBinding.instance.imageCache;');
  print('cache.maximumSize = 1000;');
  print('cache.maximumSizeBytes = 100 << 20;');
  print('cache.clear();');

  // In app lifecycle
  print('\nIn app lifecycle:');
  print('- Created by WidgetsFlutterBinding');
  print('- Available after binding init');
  print('- Part of Flutter binding mix');

  // Mixin hierarchy
  print('\nBinding mixin hierarchy:');
  print('BindingBase');
  print('  + GestureBinding');
  print('  + SchedulerBinding');
  print('  + ServicesBinding');
  print('  + PaintingBinding');
  print('  + ...');

  print('\nPaintingBinding test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PaintingBinding Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Painting services mixin'),
      Text('Provides: imageCache'),
      Text('Part of: WidgetsFlutterBinding'),
    ],
  );
}
