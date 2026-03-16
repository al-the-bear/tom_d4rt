// D4rt test script: Tests RenderView, RenderViewport, and root render object concepts
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects view test executing');

  // ========== RENDER VIEW ==========
  print('--- RenderView Notes ---');

  // RenderView is the root of the render tree. It is created and managed
  // by the framework (RendererBinding). Cannot be constructed standalone
  // without a FlutterView.
  print('RenderView is the root render object of the render tree');
  print('It is created by the framework (RendererBinding)');
  print('Cannot be constructed standalone — requires a FlutterView');

  // ========== RENDER VIEWPORT ==========
  print('--- RenderViewport Notes ---');

  // RenderViewport requires axisDirection, crossAxisDirection, offset
  // and a ViewportOffset. It manages slivers.
  print('RenderViewport is the scrollable viewport render object');
  print('Requires: axisDirection, crossAxisDirection, offset (ViewportOffset)');

  // We can construct a basic RenderViewport with ViewportOffset
  final offset = ViewportOffset.fixed(0.0);
  final viewport = RenderViewport(
    axisDirection: AxisDirection.down,
    crossAxisDirection: AxisDirection.right,
    offset: offset,
  );
  print('RenderViewport created: ${viewport.runtimeType}');
  print('  axisDirection: ${viewport.axisDirection}');
  print('  crossAxisDirection: ${viewport.crossAxisDirection}');
  print('  anchor: ${viewport.anchor}');
  print('  cacheExtent: ${viewport.cacheExtent}');

  final viewportCustom = RenderViewport(
    axisDirection: AxisDirection.right,
    crossAxisDirection: AxisDirection.down,
    offset: ViewportOffset.fixed(50.0),
    anchor: 0.5,
    cacheExtent: 100.0,
  );
  print('RenderViewport(custom):');
  print('  axisDirection: ${viewportCustom.axisDirection}');
  print('  crossAxisDirection: ${viewportCustom.crossAxisDirection}');
  print('  anchor: ${viewportCustom.anchor}');
  print('  cacheExtent: ${viewportCustom.cacheExtent}');

  // Modify properties
  viewport.axisDirection = AxisDirection.up;
  print('After axisDirection change: ${viewport.axisDirection}');
  viewport.anchor = 0.25;
  print('After anchor change: ${viewport.anchor}');
  viewport.cacheExtent = 200.0;
  print('After cacheExtent change: ${viewport.cacheExtent}');

  // ========== RENDER SHRINK WRAPPING VIEWPORT ==========
  print('--- RenderShrinkWrappingViewport Tests ---');

  final shrinkViewport = RenderShrinkWrappingViewport(
    axisDirection: AxisDirection.down,
    crossAxisDirection: AxisDirection.right,
    offset: ViewportOffset.zero(),
  );
  print('RenderShrinkWrappingViewport created: ${shrinkViewport.runtimeType}');
  print('  axisDirection: ${shrinkViewport.axisDirection}');
  print('  crossAxisDirection: ${shrinkViewport.crossAxisDirection}');

  // ========== RENDER ABSTRACT VIEWPORT ==========
  print('--- RenderAbstractViewport Notes ---');
  print('RenderAbstractViewport is the abstract base class for viewports');
  print('Provides: getOffsetToReveal, defaultCacheExtent');

  // ========== VIEWPORT OFFSET ==========
  print('--- ViewportOffset Tests ---');

  final fixedOffset = ViewportOffset.fixed(100.0);
  print('ViewportOffset.fixed(100): pixels=${fixedOffset.pixels}');

  final zeroOffset = ViewportOffset.zero();
  print('ViewportOffset.zero(): pixels=${zeroOffset.pixels}');

  print('hasPixels: ${fixedOffset.hasPixels}');
  print('userScrollDirection: ${fixedOffset.userScrollDirection}');

  // ========== RENDER SLIVER FILL VIEWPORT ==========
  print('--- RenderSliverFillViewport Notes ---');
  print('RenderSliverFillViewport requires a RenderSliverBoxChildManager');
  print('Cannot construct standalone — needs child manager');

  // ========== CACHE EXTENT STYLE ==========
  print('--- CacheExtentStyle values ---');
  print('CacheExtentStyle.pixel: ${CacheExtentStyle.pixel}');
  print('CacheExtentStyle.viewport: ${CacheExtentStyle.viewport}');

  // Note: Cannot call layout() or paint() on orphan render objects
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects view test completed');
  return Container(child: Text('RenderObjects view test passed'));
}
