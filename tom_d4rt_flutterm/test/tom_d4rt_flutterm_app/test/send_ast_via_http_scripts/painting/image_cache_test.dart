// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImageCache, ImageConfiguration from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageCache test executing');

  // ========== IMAGECACHE ==========
  print('--- ImageCache Tests ---');

  // Access the global image cache
  final cache = PaintingBinding.instance.imageCache;
  print('ImageCache obtained from PaintingBinding');
  print('ImageCache type: ${cache.runtimeType}');

  // Check cache properties
  print('maximumSize: ${cache.maximumSize}');
  print('maximumSizeBytes: ${cache.maximumSizeBytes}');
  print('currentSize: ${cache.currentSize}');
  print('currentSizeBytes: ${cache.currentSizeBytes}');
  print('liveImageCount: ${cache.liveImageCount}');
  print('pendingImageCount: ${cache.pendingImageCount}');

  // Test setting maximum cache size
  final originalMax = cache.maximumSize;
  cache.maximumSize = 200;
  print('Set maximumSize to 200, now: ${cache.maximumSize}');
  cache.maximumSize = originalMax;
  print('Restored maximumSize to: ${cache.maximumSize}');

  // Test setting maximum size in bytes
  final originalMaxBytes = cache.maximumSizeBytes;
  cache.maximumSizeBytes = 100 * 1024 * 1024;
  print('Set maximumSizeBytes to 100MB, now: ${cache.maximumSizeBytes}');
  cache.maximumSizeBytes = originalMaxBytes;
  print('Restored maximumSizeBytes to: ${cache.maximumSizeBytes}');

  // Test clear
  cache.clear();
  print('After clear - currentSize: ${cache.currentSize}');
  print('After clear - currentSizeBytes: ${cache.currentSizeBytes}');

  // Test clearLiveImages
  cache.clearLiveImages();
  print('clearLiveImages called');

  // ========== IMAGECONFIGURATION ==========
  print('--- ImageConfiguration Tests ---');

  // Test default ImageConfiguration
  final defaultConfig = ImageConfiguration();
  print('Default ImageConfiguration created');
  print('  bundle: ${defaultConfig.bundle}');
  print('  devicePixelRatio: ${defaultConfig.devicePixelRatio}');
  print('  locale: ${defaultConfig.locale}');
  print('  textDirection: ${defaultConfig.textDirection}');
  print('  size: ${defaultConfig.size}');
  print('  platform: ${defaultConfig.platform}');

  // Test ImageConfiguration with parameters
  final customConfig = ImageConfiguration(
    devicePixelRatio: 2.0,
    locale: Locale('en', 'US'),
    textDirection: TextDirection.ltr,
    size: Size(100.0, 100.0),
    platform: TargetPlatform.linux,
  );
  print('Custom ImageConfiguration created');
  print('  devicePixelRatio: ${customConfig.devicePixelRatio}');
  print('  locale: ${customConfig.locale}');
  print('  textDirection: ${customConfig.textDirection}');
  print('  size: ${customConfig.size}');
  print('  platform: ${customConfig.platform}');

  // Test ImageConfiguration.empty
  final emptyConfig = ImageConfiguration.empty;
  print('ImageConfiguration.empty created');
  print('  devicePixelRatio: ${emptyConfig.devicePixelRatio}');
  print('  locale: ${emptyConfig.locale}');

  // Test copyWith
  final copiedConfig = customConfig.copyWith(
    devicePixelRatio: 3.0,
    size: Size(200.0, 200.0),
  );
  print('copyWith created');
  print('  devicePixelRatio: ${copiedConfig.devicePixelRatio}');
  print('  size: ${copiedConfig.size}');
  print('  platform (inherited): ${copiedConfig.platform}');

  // Test toString
  print('ImageConfiguration toString: $customConfig');

  print('All ImageCache tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ImageCache Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('Cache max size: ${cache.maximumSize}'),
            Text('Cache max bytes: ${cache.maximumSizeBytes}'),
            Text('Cache current size: ${cache.currentSize}'),
            SizedBox(height: 8.0),
            Text(
              'ImageConfiguration Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Text('Custom config dpr: ${customConfig.devicePixelRatio}'),
            Text('Custom config locale: ${customConfig.locale}'),
            Text('Custom config size: ${customConfig.size}'),
          ],
        ),
      ),
    ),
  );
}
