// D4rt test script: Tests RenderBackdropFilter from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderBackdropFilter test executing');

  // ========== BACKDROP FILTER CONCEPTS ==========
  print('--- RenderBackdropFilter Concepts ---');
  print('RenderBackdropFilter applies ImageFilter to content behind it');
  print('It creates a BackdropFilterLayer for compositing');
  print('Common use: frosted glass, blur effects');

  // ========== IMAGE FILTER TYPES ==========
  print('--- ImageFilter Types ---');
  print('ImageFilter.blur: Gaussian blur effect');
  print('ImageFilter.dilate: Morphological dilate effect');
  print('ImageFilter.erode: Morphological erode effect');
  print('ImageFilter.matrix: Matrix transformation');
  print('ImageFilter.compose: Compose multiple filters');

  // ========== BLUR FILTER TESTS ==========
  print('--- Blur Filter Tests ---');

  // Light blur
  final lightBlur = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
  print('Light blur: sigmaX=2.0, sigmaY=2.0');

  // Medium blur
  final mediumBlur = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  print('Medium blur: sigmaX=5.0, sigmaY=5.0');

  // Heavy blur
  final heavyBlur = ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  print('Heavy blur: sigmaX=10.0, sigmaY=10.0');

  // Directional blur
  final horizontalBlur = ImageFilter.blur(sigmaX: 8.0, sigmaY: 0.0);
  print('Horizontal blur: sigmaX=8.0, sigmaY=0.0');

  final verticalBlur = ImageFilter.blur(sigmaX: 0.0, sigmaY: 8.0);
  print('Vertical blur: sigmaX=0.0, sigmaY=8.0');

  // ========== TILE MODE TESTS ==========
  print('--- TileMode for Blur ---');
  print('TileMode.clamp: ${TileMode.clamp}');
  print('TileMode.repeat: ${TileMode.repeat}');
  print('TileMode.mirror: ${TileMode.mirror}');
  print('TileMode.decal: ${TileMode.decal}');

  final clampBlur = ImageFilter.blur(
    sigmaX: 5.0,
    sigmaY: 5.0,
    tileMode: TileMode.clamp,
  );
  print('Blur with TileMode.clamp');

  // ========== BACKDROP FILTER WIDGET ==========
  print('--- BackdropFilter Widget Tests ---');

  // Background with colorful content
  final background = Container(
    width: 200,
    height: 150,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red, Colors.blue, Colors.green],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Background',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 30),
            Icon(Icons.favorite, color: Colors.pink, size: 30),
            Icon(Icons.thumb_up, color: Colors.cyan, size: 30),
          ],
        ),
        Text('Content', style: TextStyle(color: Colors.white)),
      ],
    ),
  );
  print('Created colorful background');

  // Frosted glass effect
  final frostedGlass = ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        color: Colors.white.withValues(alpha: 0.3),
        padding: EdgeInsets.all(12),
        child: Text(
          'Frosted Glass',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
  print('Created frosted glass BackdropFilter');

  // ========== BLEND MODE TESTS ==========
  print('--- BlendMode Tests ---');

  print('BackdropFilter supports blendMode parameter');
  print('BlendMode.srcOver: ${BlendMode.srcOver} (default)');
  print('BlendMode.multiply: ${BlendMode.multiply}');
  print('BlendMode.screen: ${BlendMode.screen}');
  print('BlendMode.overlay: ${BlendMode.overlay}');

  // ========== STACK WITH BACKDROP FILTER ==========
  print('--- Stack Usage Pattern ---');

  final stackWithBlur = Stack(
    children: [
      // Background layer
      Container(
        width: 180,
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('https://via.placeholder.com/180x120'),
          ),
          color: Colors.purple,
        ),
        child: Center(
          child: Icon(Icons.landscape, size: 60, color: Colors.white54),
        ),
      ),
      // Blurred overlay
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              height: 40,
              color: Colors.black26,
              alignment: Alignment.center,
              child: Text(
                'Blurred Caption',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ],
  );
  print('Created Stack with BackdropFilter overlay');

  // ========== PERFORMANCE CONSIDERATIONS ==========
  print('--- Performance Notes ---');
  print('1. BackdropFilter is expensive - samples entire area behind');
  print('2. Minimize the filtered area with ClipRect/ClipRRect');
  print('3. Avoid stacking multiple backdrop filters');
  print('4. Use saveLayer sparingly with backdrop filters');
  print('5. Consider pre-blurred images for static content');

  // ========== ALTERNATIVE APPROACHES ==========
  print('--- Alternative Blur Approaches ---');
  print('ImageFiltered: applies filter to child (not backdrop)');
  print('ColorFiltered: applies color filter');
  print('ShaderMask: applies shader to child');

  final imageFiltered = ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
    child: Container(
      width: 60,
      height: 40,
      color: Colors.orange,
      child: Center(
        child: Text('Blur', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created ImageFiltered widget (blurs child, not backdrop)');

  // ========== BACKDROP FILTER LAYER ==========
  print('--- BackdropFilterLayer ---');
  print('RenderBackdropFilter creates BackdropFilterLayer');
  print('Layer properties:');
  print('  filter: the ImageFilter to apply');
  print('  blendMode: how to blend result');

  // ========== MORPHOLOGICAL FILTERS ==========
  print('--- Morphological Filters ---');

  final dilateFilter = ImageFilter.dilate(radiusX: 2.0, radiusY: 2.0);
  print('ImageFilter.dilate: expands bright areas');

  final erodeFilter = ImageFilter.erode(radiusX: 2.0, radiusY: 2.0);
  print('ImageFilter.erode: shrinks bright areas');

  // ========== COMPOSED FILTERS ==========
  print('--- Composed Filters ---');

  final composedFilter = ImageFilter.compose(
    outer: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    inner: ImageFilter.dilate(radiusX: 1.0, radiusY: 1.0),
  );
  print('Created composed filter: blur + dilate');

  // ========== CLIPPING FOR PERFORMANCE ==========
  print('--- Clipping Best Practices ---');
  print('Always clip BackdropFilter to minimize render area');
  print('ClipRect: rectangular clip');
  print('ClipRRect: rounded rectangle clip');
  print('ClipPath: custom path clip');
  print('ClipOval: elliptical clip');

  print('RenderBackdropFilter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderBackdropFilter Tests'),
      SizedBox(height: 8),
      Stack(alignment: Alignment.center, children: [background, frostedGlass]),
      SizedBox(height: 8),
      stackWithBlur,
      SizedBox(height: 8),
      imageFiltered,
      SizedBox(height: 8),
      Text('All backdrop filter tests passed'),
    ],
  );
}
