// D4rt test script: Tests FrameTiming from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FrameTiming test executing');

  // Create FrameTiming with required params
  final ft1 = ui.FrameTiming(
    vsyncStart: 1000,
    buildStart: 2000,
    buildFinish: 5000,
    rasterStart: 6000,
    rasterFinish: 9000,
    rasterFinishWallTime: 9500,
  );
  print('FrameTiming created');
  print('buildDuration: ${ft1.buildDuration}');
  print('rasterDuration: ${ft1.rasterDuration}');
  print('vsyncOverhead: ${ft1.vsyncOverhead}');
  print('totalSpan: ${ft1.totalSpan}');
  print('layerCacheCount: ${ft1.layerCacheCount}');
  print('layerCacheBytes: ${ft1.layerCacheBytes}');
  print('layerCacheMegabytes: ${ft1.layerCacheMegabytes}');
  print('pictureCacheCount: ${ft1.pictureCacheCount}');
  print('pictureCacheBytes: ${ft1.pictureCacheBytes}');
  print('pictureCacheMegabytes: ${ft1.pictureCacheMegabytes}');
  print('frameNumber: ${ft1.frameNumber}');

  // With optional cache and frame params
  final ft2 = ui.FrameTiming(
    vsyncStart: 0,
    buildStart: 1000,
    buildFinish: 3000,
    rasterStart: 4000,
    rasterFinish: 7000,
    rasterFinishWallTime: 7200,
    layerCacheCount: 5,
    layerCacheBytes: 1048576,
    pictureCacheCount: 10,
    pictureCacheBytes: 2097152,
    frameNumber: 42,
  );
  print('ft2 layerCacheCount: ${ft2.layerCacheCount}');
  print('ft2 layerCacheBytes: ${ft2.layerCacheBytes}');
  print('ft2 layerCacheMegabytes: ${ft2.layerCacheMegabytes}');
  print('ft2 pictureCacheCount: ${ft2.pictureCacheCount}');
  print('ft2 pictureCacheBytes: ${ft2.pictureCacheBytes}');
  print('ft2 pictureCacheMegabytes: ${ft2.pictureCacheMegabytes}');
  print('ft2 frameNumber: ${ft2.frameNumber}');

  // FramePhase timestamps
  print('--- FramePhase Timestamps ---');
  print('vsyncStart: ${ft2.timestampInMicroseconds(ui.FramePhase.vsyncStart)}');
  print('buildStart: ${ft2.timestampInMicroseconds(ui.FramePhase.buildStart)}');
  print('buildFinish: ${ft2.timestampInMicroseconds(ui.FramePhase.buildFinish)}');
  print('rasterStart: ${ft2.timestampInMicroseconds(ui.FramePhase.rasterStart)}');
  print('rasterFinish: ${ft2.timestampInMicroseconds(ui.FramePhase.rasterFinish)}');

  print('toString: ${ft1.toString()}');

  print('FrameTiming test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FrameTiming Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('buildDuration: ${ft1.buildDuration}'),
      Text('rasterDuration: ${ft1.rasterDuration}'),
      Text('totalSpan: ${ft1.totalSpan}'),
      Text('ft2 frameNumber: ${ft2.frameNumber}'),
      Text('ft2 caches: ${ft2.layerCacheCount} layers, ${ft2.pictureCacheCount} pictures'),
    ],
  );
}
