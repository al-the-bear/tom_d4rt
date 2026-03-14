// D4rt test script: Tests PerformanceOverlayLayer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PerformanceOverlayLayer test executing');

  // ========== Basic PerformanceOverlayLayer creation ==========
  print('--- Basic PerformanceOverlayLayer ---');
  final layer1 = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
  );
  print('  created: ${layer1.runtimeType}');
  print('  overlayRect: ${layer1.overlayRect}');
  print('  optionsMask: ${layer1.optionsMask}');

  // ========== Different overlayRect values ==========
  print('--- Different overlayRect values ---');
  final layer2 = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(10.0, 20.0, 200.0, 80.0),
    optionsMask: 0,
  );
  print('  rect (10, 20, 200, 80): ${layer2.overlayRect}');
  
  final layer3 = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 400.0, 150.0),
    optionsMask: 0,
  );
  print('  rect (0, 0, 400, 150): ${layer3.overlayRect}');
  
  final layer4 = PerformanceOverlayLayer(
    overlayRect: Rect.fromCenter(center: Offset(150.0, 50.0), width: 300.0, height: 100.0),
    optionsMask: 0,
  );
  print('  centered rect: ${layer4.overlayRect}');

  // ========== PerformanceOverlayOption masks ==========
  print('--- PerformanceOverlayOption ---');
  print('  displayRasterizerStatistics: ${PerformanceOverlayOption.displayRasterizerStatistics.index}');
  print('  visualizeRasterizerStatistics: ${PerformanceOverlayOption.visualizeRasterizerStatistics.index}');
  print('  displayEngineStatistics: ${PerformanceOverlayOption.displayEngineStatistics.index}');
  print('  visualizeEngineStatistics: ${PerformanceOverlayOption.visualizeEngineStatistics.index}');

  // ========== Creating with different option masks ==========
  print('--- Different option masks ---');
  final layerRaster = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 1 << PerformanceOverlayOption.displayRasterizerStatistics.index,
  );
  print('  displayRasterizerStatistics mask: ${layerRaster.optionsMask}');
  
  final layerEngine = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 1 << PerformanceOverlayOption.displayEngineStatistics.index,
  );
  print('  displayEngineStatistics mask: ${layerEngine.optionsMask}');
  
  // Combined mask
  final combinedMask = (1 << PerformanceOverlayOption.displayRasterizerStatistics.index) |
                        (1 << PerformanceOverlayOption.visualizeRasterizerStatistics.index);
  final layerCombined = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: combinedMask,
  );
  print('  combined mask (raster display + visualize): ${layerCombined.optionsMask}');

  // ========== rasterizerThreshold property ==========
  print('--- rasterizerThreshold property ---');
  final layerWithThreshold = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    rasterizerThreshold: 16,
  );
  print('  rasterizerThreshold = 16: ${layerWithThreshold.rasterizerThreshold}');
  
  final layerThreshold0 = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    rasterizerThreshold: 0,
  );
  print('  rasterizerThreshold = 0: ${layerThreshold0.rasterizerThreshold}');

  // ========== checkerboardRasterCacheImages property ==========
  print('--- checkerboardRasterCacheImages ---');
  final layerCheckerboard = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    checkerboardRasterCacheImages: true,
  );
  print('  checkerboardRasterCacheImages = true: ${layerCheckerboard.checkerboardRasterCacheImages}');
  
  final layerNoCheckerboard = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    checkerboardRasterCacheImages: false,
  );
  print('  checkerboardRasterCacheImages = false: ${layerNoCheckerboard.checkerboardRasterCacheImages}');

  // ========== checkerboardOffscreenLayers property ==========
  print('--- checkerboardOffscreenLayers ---');
  final layerOffscreen = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    checkerboardOffscreenLayers: true,
  );
  print('  checkerboardOffscreenLayers = true: ${layerOffscreen.checkerboardOffscreenLayers}');

  // ========== Layer inheritance ==========
  print('--- Layer inheritance ---');
  print('  is Layer: ${layer1 is Layer}');
  print('  is ContainerLayer: ${layer1 is ContainerLayer}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  layer1.runtimeType: ${layer1.runtimeType}');
  print('  layerCheckerboard.runtimeType: ${layerCheckerboard.runtimeType}');

  print('PerformanceOverlayLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('PerformanceOverlayLayer Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Type: ${layer1.runtimeType}'),
          Text('overlayRect: ${layer1.overlayRect}'),
          Text('optionsMask: ${layer1.optionsMask}'),
          SizedBox(height: 8.0),
          Text('PerformanceOverlayOption values:'),
          Text('  displayRasterizerStatistics: ${PerformanceOverlayOption.displayRasterizerStatistics.index}'),
          Text('  visualizeRasterizerStatistics: ${PerformanceOverlayOption.visualizeRasterizerStatistics.index}'),
          Text('  displayEngineStatistics: ${PerformanceOverlayOption.displayEngineStatistics.index}'),
          Text('  visualizeEngineStatistics: ${PerformanceOverlayOption.visualizeEngineStatistics.index}'),
          SizedBox(height: 8.0),
          Text('Configuration options:'),
          Text('  rasterizerThreshold: ${layerWithThreshold.rasterizerThreshold}'),
          Text('  checkerboardRasterCacheImages: ${layerCheckerboard.checkerboardRasterCacheImages}'),
          Text('  checkerboardOffscreenLayers: ${layerOffscreen.checkerboardOffscreenLayers}'),
        ],
      ),
    ),
  );
}
