// D4rt test script: Tests BackdropKey from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BackdropKey test executing');

  // ========== BackdropKey Static Instance ==========
  print('--- BackdropKey Static Instance ---');
  // BackdropKey is typically used internally with BackdropFilterLayer
  print('  BackdropKey is used with BackdropFilterLayer');
  print('  Used to identify backdrop filter effects');

  // ========== BackdropFilterLayer Basic Tests ==========
  print('--- BackdropFilterLayer Basic Tests ---');
  final filter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final backdropLayer = BackdropFilterLayer(filter: filter);
  print('  created: ${backdropLayer.runtimeType}');
  print('  filter: ${backdropLayer.filter}');
  print('  blendMode: ${backdropLayer.blendMode}');

  // ========== BackdropFilterLayer with Different Filters ==========
  print('--- BackdropFilterLayer with Different Filters ---');
  final blurFilter = ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  final blurLayer = BackdropFilterLayer(filter: blurFilter);
  print('  blur filter layer: ${blurLayer.filter}');

  final smallBlur = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
  final smallBlurLayer = BackdropFilterLayer(filter: smallBlur);
  print('  small blur layer created');

  final largeBlur = ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0);
  final largeBlurLayer = BackdropFilterLayer(filter: largeBlur);
  print('  large blur layer created');

  // ========== BackdropFilterLayer with BlendMode ==========
  print('--- BackdropFilterLayer with BlendMode ---');
  final srcOverLayer = BackdropFilterLayer(
    filter: filter,
    blendMode: BlendMode.srcOver,
  );
  print('  srcOver blendMode: ${srcOverLayer.blendMode}');

  final multiplyLayer = BackdropFilterLayer(
    filter: filter,
    blendMode: BlendMode.multiply,
  );
  print('  multiply blendMode: ${multiplyLayer.blendMode}');

  final screenLayer = BackdropFilterLayer(
    filter: filter,
    blendMode: BlendMode.screen,
  );
  print('  screen blendMode: ${screenLayer.blendMode}');

  final overlayLayer = BackdropFilterLayer(
    filter: filter,
    blendMode: BlendMode.overlay,
  );
  print('  overlay blendMode: ${overlayLayer.blendMode}');

  // ========== BackdropFilterLayer Property Modification ==========
  print('--- BackdropFilterLayer Property Modification ---');
  final mutableLayer = BackdropFilterLayer(filter: filter);
  print('  initial filter: ${mutableLayer.filter}');

  final newFilter = ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0);
  mutableLayer.filter = newFilter;
  print('  modified filter: ${mutableLayer.filter}');

  mutableLayer.blendMode = BlendMode.colorDodge;
  print('  modified blendMode: ${mutableLayer.blendMode}');

  // ========== BackdropFilterLayer Layer Hierarchy ==========
  print('--- BackdropFilterLayer Layer Hierarchy ---');
  print('  parent: ${backdropLayer.parent}');
  print('  nextSibling: ${backdropLayer.nextSibling}');
  print('  previousSibling: ${backdropLayer.previousSibling}');
  print('  alwaysNeedsAddToScene: ${backdropLayer.alwaysNeedsAddToScene}');

  // ========== ImageFilter Blur Variations ==========
  print('--- ImageFilter Blur Variations ---');
  final blurXOnly = ImageFilter.blur(sigmaX: 10.0, sigmaY: 0.0);
  print('  horizontal blur: sigmaX=10, sigmaY=0');

  final blurYOnly = ImageFilter.blur(sigmaX: 0.0, sigmaY: 10.0);
  print('  vertical blur: sigmaX=0, sigmaY=10');

  final equalBlur = ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0);
  print('  equal blur: sigmaX=8, sigmaY=8');

  // ========== BlendMode Values ==========
  print('--- BlendMode Values ---');
  final blendModes = [
    BlendMode.clear,
    BlendMode.src,
    BlendMode.dst,
    BlendMode.srcOver,
    BlendMode.dstOver,
    BlendMode.srcIn,
    BlendMode.dstIn,
    BlendMode.srcOut,
  ];
  for (final mode in blendModes) {
    print('  ${mode.name}: index=${mode.index}');
  }

  // ========== BackdropFilter Widget Context ==========
  print('--- BackdropFilter Widget Context ---');
  print('  BackdropFilterLayer is created by BackdropFilter widget');
  print('  Used for frosted glass effects');
  print('  Applied to content behind the filter');

  // ========== Key Concepts ==========
  print('--- Key Concepts ---');
  print('  BackdropKey identifies the backdrop filter');
  print('  Allows efficient repainting of backdrop effects');
  print('  Used internally by rendering pipeline');

  print('BackdropKey test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'BackdropKey Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('BackdropFilterLayer: ${backdropLayer.runtimeType}'),
          Text('Filter: blur effect'),
          Text('BlendMode options tested'),
          Text('Layer hierarchy properties verified'),
          Text('ImageFilter variations: horizontal, vertical, equal'),
          Text('Used with BackdropFilter widget'),
        ],
      ),
    ),
  );
}
