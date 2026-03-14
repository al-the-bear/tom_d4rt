// D4rt test script: Tests ColorFilterLayer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ColorFilterLayer test executing');

  // ========== ColorFilterLayer Basic Creation ==========
  print('--- ColorFilterLayer Basic Creation ---');
  final colorFilter = ColorFilter.mode(Color(0xFF2196F3), BlendMode.srcIn);
  final filterLayer = ColorFilterLayer(colorFilter: colorFilter);
  print('  created: ${filterLayer.runtimeType}');
  print('  colorFilter: ${filterLayer.colorFilter}');

  // ========== ColorFilter.mode with Different BlendModes ==========
  print('--- ColorFilter.mode with Different BlendModes ---');
  final srcOverFilter = ColorFilter.mode(Color(0xFFFF5722), BlendMode.srcOver);
  final srcOverLayer = ColorFilterLayer(colorFilter: srcOverFilter);
  print('  srcOver filter: ${srcOverLayer.colorFilter}');

  final multiplyFilter = ColorFilter.mode(Color(0xFF4CAF50), BlendMode.multiply);
  final multiplyLayer = ColorFilterLayer(colorFilter: multiplyFilter);
  print('  multiply filter: ${multiplyLayer.colorFilter}');

  final screenFilter = ColorFilter.mode(Color(0xFF9C27B0), BlendMode.screen);
  final screenLayer = ColorFilterLayer(colorFilter: screenFilter);
  print('  screen filter: ${screenLayer.colorFilter}');

  final overlayFilter = ColorFilter.mode(Color(0xFFE91E63), BlendMode.overlay);
  final overlayLayer = ColorFilterLayer(colorFilter: overlayFilter);
  print('  overlay filter: ${overlayLayer.colorFilter}');

  final colorDodgeFilter = ColorFilter.mode(Color(0xFF00BCD4), BlendMode.colorDodge);
  final colorDodgeLayer = ColorFilterLayer(colorFilter: colorDodgeFilter);
  print('  colorDodge filter: ${colorDodgeLayer.colorFilter}');

  // ========== ColorFilter.matrix ==========
  print('--- ColorFilter.matrix ---');
  // Grayscale matrix
  final grayscaleMatrix = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ]);
  final grayscaleLayer = ColorFilterLayer(colorFilter: grayscaleMatrix);
  print('  grayscale matrix filter: created');

  // Sepia matrix
  final sepiaMatrix = ColorFilter.matrix(<double>[
    0.393, 0.769, 0.189, 0, 0,
    0.349, 0.686, 0.168, 0, 0,
    0.272, 0.534, 0.131, 0, 0,
    0, 0, 0, 1, 0,
  ]);
  final sepiaLayer = ColorFilterLayer(colorFilter: sepiaMatrix);
  print('  sepia matrix filter: created');

  // Invert matrix
  final invertMatrix = ColorFilter.matrix(<double>[
    -1, 0, 0, 0, 255,
    0, -1, 0, 0, 255,
    0, 0, -1, 0, 255,
    0, 0, 0, 1, 0,
  ]);
  final invertLayer = ColorFilterLayer(colorFilter: invertMatrix);
  print('  invert matrix filter: created');

  // ========== ColorFilter.linearToSrgbGamma ==========
  print('--- ColorFilter.linearToSrgbGamma ---');
  final linearToSrgb = ColorFilter.linearToSrgbGamma();
  final linearToSrgbLayer = ColorFilterLayer(colorFilter: linearToSrgb);
  print('  linearToSrgbGamma filter: created');

  // ========== ColorFilter.srgbToLinearGamma ==========
  print('--- ColorFilter.srgbToLinearGamma ---');
  final srgbToLinear = ColorFilter.srgbToLinearGamma();
  final srgbToLinearLayer = ColorFilterLayer(colorFilter: srgbToLinear);
  print('  srgbToLinearGamma filter: created');

  // ========== ColorFilterLayer Property Modification ==========
  print('--- ColorFilterLayer Property Modification ---');
  final mutableLayer = ColorFilterLayer(colorFilter: colorFilter);
  print('  initial colorFilter: ${mutableLayer.colorFilter}');

  final newFilter = ColorFilter.mode(Color(0xFF607D8B), BlendMode.saturation);
  mutableLayer.colorFilter = newFilter;
  print('  modified colorFilter: ${mutableLayer.colorFilter}');

  // ========== ColorFilterLayer Layer Hierarchy ==========
  print('--- ColorFilterLayer Layer Hierarchy ---');
  print('  parent: ${filterLayer.parent}');
  print('  firstChild: ${filterLayer.firstChild}');
  print('  lastChild: ${filterLayer.lastChild}');
  print('  nextSibling: ${filterLayer.nextSibling}');
  print('  previousSibling: ${filterLayer.previousSibling}');
  print('  hasChildren: ${filterLayer.hasChildren}');

  // ========== Various Colors with Mode ==========
  print('--- Various Colors with Mode ---');
  final colors = [
    Color(0xFFFF0000), // Red
    Color(0xFF00FF00), // Green
    Color(0xFF0000FF), // Blue
    Color(0xFFFFFF00), // Yellow
    Color(0xFFFF00FF), // Magenta
    Color(0xFF00FFFF), // Cyan
  ];
  for (int i = 0; i < colors.length; i++) {
    final filter = ColorFilter.mode(colors[i], BlendMode.srcIn);
    final layer = ColorFilterLayer(colorFilter: filter);
    print('  color[$i] filter: ${layer.colorFilter}');
  }

  // ========== BlendMode Values ==========
  print('--- BlendMode Values for ColorFilter ---');
  final usefulBlendModes = [
    BlendMode.srcIn, BlendMode.srcOver, BlendMode.multiply,
    BlendMode.screen, BlendMode.overlay, BlendMode.darken,
    BlendMode.lighten, BlendMode.colorDodge, BlendMode.colorBurn,
  ];
  for (final mode in usefulBlendModes) {
    print('  ${mode.name}: useful for color filtering');
  }

  print('ColorFilterLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ColorFilterLayer Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('ColorFilterLayer: ${filterLayer.runtimeType}'),
          Text('ColorFilter.mode: various blend modes'),
          Text('ColorFilter.matrix: grayscale, sepia, invert'),
          Text('Gamma conversions: linearToSrgb, srgbToLinear'),
          Text('Multiple colors tested'),
          Text('Layer hierarchy verified'),
        ],
      ),
    ),
  );
}
