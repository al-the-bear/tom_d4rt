// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderViewportBase from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderViewportBase test executing');
  print('=' * 50);

  // RenderViewportBase is abstract
  print('\nRenderViewportBase is abstract');
  print('Extends: RenderBox');
  print('Implements: RenderAbstractViewport');
  print('Purpose: Base for render objects hosting RenderSliver children inside a RenderBox');

  // Generic type parameter
  print('\nGeneric type:');
  print('  RenderViewportBase<ParentDataClass>');
  print('  where ParentDataClass extends ContainerParentDataMixin<RenderSliver>');

  // Constructor parameters
  print('\nConstructor parameters:');
  print('  axisDirection: AxisDirection (default down)');
  print('  crossAxisDirection: AxisDirection (required)');
  print('  offset: ViewportOffset (required)');
  print('  cacheExtent: double? (defaults to defaultCacheExtent)');
  print('  cacheExtentStyle: CacheExtentStyle (default pixel)');
  print('  paintOrder: SliverPaintOrder (default firstIsTop)');
  print('  clipBehavior: Clip (default hardEdge)');

  // Key properties
  print('\nKey properties:');
  print('  axisDirection - Direction of main scroll axis');
  for (final dir in AxisDirection.values) {
    print('    ${dir.name}: index=${dir.index}');
  }

  // SliverPaintOrder
  print('\nSliverPaintOrder (painting order):');
  for (final order in SliverPaintOrder.values) {
    print('  ${order.name}: index=${order.index}');
  }

  // CacheExtentStyle
  print('\nCacheExtentStyle:');
  for (final style in CacheExtentStyle.values) {
    print('  ${style.name}: index=${style.index}');
  }

  // Default cache extent
  print('\nRenderAbstractViewport.defaultCacheExtent:');
  print('  ${RenderAbstractViewport.defaultCacheExtent}');

  // Concrete subclass
  print('\nConcrete subclass:');
  print('  RenderViewport - Standard scrollable viewport');
  print('  RenderShrinkWrappingViewport - Shrink-wrapped viewport');

  // Widget equivalent
  print('\nWidget equivalents:');
  print('  Viewport -> RenderViewport');
  print('  ShrinkWrappingViewport -> RenderShrinkWrappingViewport');
  print('  Both used internally by ScrollView');

  // Clip behavior
  print('\nClip behaviors:');
  for (final clip in Clip.values) {
    print('  ${clip.name}: index=${clip.index}');
  }

  print('\n${'=' * 50}');
  print('RenderViewportBase test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderViewportBase Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Extends: RenderBox'),
      Text('defaultCacheExtent: ${RenderAbstractViewport.defaultCacheExtent}'),
      Text('Subclasses: Viewport, ShrinkWrapping'),
    ],
  );
}
