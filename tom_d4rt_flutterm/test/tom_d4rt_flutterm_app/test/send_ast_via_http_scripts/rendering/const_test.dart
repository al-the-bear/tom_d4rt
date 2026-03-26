// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests const values and constructors from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Rendering const values test executing');
  print('=' * 50);

  // SliverGeometry.zero is a key const in the rendering library
  print('\nSliverGeometry.zero:');
  final zero = SliverGeometry.zero;
  print('  scrollExtent: ${zero.scrollExtent}');
  print('  paintExtent: ${zero.paintExtent}');
  print('  paintOrigin: ${zero.paintOrigin}');
  print('  layoutExtent: ${zero.layoutExtent}');
  print('  maxPaintExtent: ${zero.maxPaintExtent}');
  print('  hitTestExtent: ${zero.hitTestExtent}');
  print('  visible: ${zero.visible}');
  print('  hasVisualOverflow: ${zero.hasVisualOverflow}');
  print('  cacheExtent: ${zero.cacheExtent}');

  // SliverGeometry with custom values
  print('\nSliverGeometry custom:');
  final custom = SliverGeometry(
    scrollExtent: 100.0,
    paintExtent: 80.0,
    maxPaintExtent: 100.0,
    hasVisualOverflow: true,
  );
  print('  scrollExtent: ${custom.scrollExtent}');
  print('  paintExtent: ${custom.paintExtent}');
  print('  layoutExtent: ${custom.layoutExtent}');
  print('  maxPaintExtent: ${custom.maxPaintExtent}');
  print('  hitTestExtent: ${custom.hitTestExtent}');
  print('  visible: ${custom.visible}');
  print('  hasVisualOverflow: ${custom.hasVisualOverflow}');

  // SliverPaintOrder enum
  print('\nSliverPaintOrder enum:');
  for (final value in SliverPaintOrder.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('Default: SliverPaintOrder.firstIsTop');

  // CacheExtentStyle enum
  print('\nCacheExtentStyle enum:');
  for (final value in CacheExtentStyle.values) {
    print('  ${value.name}: index=${value.index}');
  }

  // GrowthDirection enum
  print('\nGrowthDirection enum:');
  for (final value in GrowthDirection.values) {
    print('  ${value.name}: index=${value.index}');
  }

  // RenderAbstractViewport default cache extent
  print('\nRenderAbstractViewport.defaultCacheExtent:');
  print('  ${RenderAbstractViewport.defaultCacheExtent}');

  // SliverLogicalParentData
  print('\nSliverLogicalParentData:');
  final lpd = SliverLogicalParentData();
  print('  layoutOffset: ${lpd.layoutOffset}');
  print('  runtimeType: ${lpd.runtimeType}');

  // SliverPhysicalParentData
  print('\nSliverPhysicalParentData:');
  final ppd = SliverPhysicalParentData();
  print('  paintOffset: ${ppd.paintOffset}');
  print('  runtimeType: ${ppd.runtimeType}');

  print('\n${'=' * 50}');
  print('Rendering const values test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Rendering Const Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('SliverGeometry.zero: visible=${zero.visible}'),
      Text('SliverPaintOrder: ${SliverPaintOrder.values.length} values'),
      Text('CacheExtentStyle: ${CacheExtentStyle.values.length} values'),
      Text('GrowthDirection: ${GrowthDirection.values.length} values'),
    ],
  );
}
