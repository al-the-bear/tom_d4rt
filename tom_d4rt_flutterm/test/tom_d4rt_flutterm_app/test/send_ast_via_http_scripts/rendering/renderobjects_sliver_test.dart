// D4rt test script: Tests RenderSliverList, RenderSliverGrid, RenderSliverPadding, RenderSliverOpacity, SliverGeometry
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects sliver test executing');

  // ========== SLIVER GEOMETRY ==========
  print('--- SliverGeometry Tests ---');

  final geomZero = SliverGeometry.zero;
  print('SliverGeometry.zero: ${geomZero.runtimeType}');
  print('  scrollExtent: ${geomZero.scrollExtent}');
  print('  paintExtent: ${geomZero.paintExtent}');
  print('  layoutExtent: ${geomZero.layoutExtent}');
  print('  maxPaintExtent: ${geomZero.maxPaintExtent}');
  print('  visible: ${geomZero.visible}');

  final geomCustom = SliverGeometry(
    scrollExtent: 200.0,
    paintExtent: 150.0,
    maxPaintExtent: 200.0,
    layoutExtent: 150.0,
    cacheExtent: 250.0,
    hasVisualOverflow: false,
  );
  print('SliverGeometry(custom):');
  print('  scrollExtent: ${geomCustom.scrollExtent}');
  print('  paintExtent: ${geomCustom.paintExtent}');
  print('  maxPaintExtent: ${geomCustom.maxPaintExtent}');
  print('  layoutExtent: ${geomCustom.layoutExtent}');
  print('  cacheExtent: ${geomCustom.cacheExtent}');
  print('  hasVisualOverflow: ${geomCustom.hasVisualOverflow}');
  print('  visible: ${geomCustom.visible}');

  final geomWithOverflow = SliverGeometry(
    scrollExtent: 100.0,
    paintExtent: 100.0,
    maxPaintExtent: 100.0,
    hasVisualOverflow: true,
  );
  print(
    'SliverGeometry(overflow=true) hasVisualOverflow: ${geomWithOverflow.hasVisualOverflow}',
  );

  final geomScrollOff = SliverGeometry(
    scrollExtent: 300.0,
    paintExtent: 0.0,
    maxPaintExtent: 300.0,
    scrollOffsetCorrection: 10.0,
  );
  print(
    'SliverGeometry(scrollOffsetCorrection) scrollOffsetCorrection: ${geomScrollOff.scrollOffsetCorrection}',
  );

  // ========== SLIVER CONSTRAINTS ==========
  print('--- SliverConstraints Tests ---');

  // SliverConstraints normally comes from the parent sliver/viewport.
  // Cannot easily construct directly without proper rendering pipeline.
  print(
    'SliverConstraints: typically provided by parent viewport during layout',
  );
  print('  Contains: axisDirection, growthDirection, scrollOffset, etc.');

  // ========== RENDER SLIVER PADDING ==========
  print('--- RenderSliverPadding Tests ---');

  final sliverPadding = RenderSliverPadding(padding: EdgeInsets.all(16.0));
  print('RenderSliverPadding created: ${sliverPadding.runtimeType}');
  print('  padding: ${sliverPadding.padding}');

  final sliverPaddingCustom = RenderSliverPadding(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
  );
  print('RenderSliverPadding(symmetric):');
  print('  padding: ${sliverPaddingCustom.padding}');

  final sliverPaddingOnly = RenderSliverPadding(
    padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 30.0, bottom: 40.0),
  );
  print('RenderSliverPadding(only): padding=${sliverPaddingOnly.padding}');

  // Modify padding
  sliverPadding.padding = EdgeInsets.all(24.0);
  print('After setting padding to 24: ${sliverPadding.padding}');

  // ========== RENDER SLIVER OPACITY ==========
  print('--- RenderSliverOpacity Tests ---');

  final sliverOpacity = RenderSliverOpacity(opacity: 0.5);
  print('RenderSliverOpacity(0.5) created: ${sliverOpacity.runtimeType}');
  print('  opacity: ${sliverOpacity.opacity}');
  print('  alwaysIncludeSemantics: ${sliverOpacity.alwaysIncludeSemantics}');

  final sliverOpacityZero = RenderSliverOpacity(opacity: 0.0);
  print('RenderSliverOpacity(0.0) opacity: ${sliverOpacityZero.opacity}');

  final sliverOpacityFull = RenderSliverOpacity(opacity: 1.0);
  print('RenderSliverOpacity(1.0) opacity: ${sliverOpacityFull.opacity}');

  final sliverOpacitySemantics = RenderSliverOpacity(
    opacity: 0.8,
    alwaysIncludeSemantics: true,
  );
  print(
    'RenderSliverOpacity(semantics=true) alwaysIncludeSemantics: ${sliverOpacitySemantics.alwaysIncludeSemantics}',
  );

  // Modify opacity
  sliverOpacity.opacity = 0.9;
  print('After setting opacity to 0.9: ${sliverOpacity.opacity}');

  // ========== RENDER SLIVER LIST / GRID ==========
  print('--- RenderSliverList / RenderSliverGrid Notes ---');

  // RenderSliverList and RenderSliverGrid require a RenderSliverBoxChildManager
  // which is an abstract class. They cannot be constructed standalone.
  print('RenderSliverList requires RenderSliverBoxChildManager (abstract)');
  print('RenderSliverGrid requires RenderSliverBoxChildManager + gridDelegate');
  print(
    'Limitation: Cannot construct without concrete child manager implementation',
  );
  print(
    'These are typically created internally by SliverList/SliverGrid widgets',
  );

  // ========== GROWTH DIRECTION AND SCROLL DIRECTION ==========
  print('--- GrowthDirection / ScrollDirection ---');
  print('GrowthDirection.forward: ${GrowthDirection.forward}');
  print('GrowthDirection.reverse: ${GrowthDirection.reverse}');
  print('ScrollDirection.idle: ${ScrollDirection.idle}');
  print('ScrollDirection.forward: ${ScrollDirection.forward}');
  print('ScrollDirection.reverse: ${ScrollDirection.reverse}');

  // Note: Cannot call layout() or paint() on orphan render objects
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects sliver test completed');
  return Container(child: Text('RenderObjects sliver test passed'));
}
