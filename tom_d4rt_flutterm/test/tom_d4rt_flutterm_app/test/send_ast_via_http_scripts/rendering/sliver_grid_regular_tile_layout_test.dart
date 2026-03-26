// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverGridRegularTileLayout from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverGridRegularTileLayout test executing');
  print('=' * 50);

  // SliverGridRegularTileLayout is the standard grid layout
  print('\nSliverGridRegularTileLayout:');
  print('Extends: SliverGridLayout');
  print('Purpose: Regular grid with uniform tile sizes');
  print('Used by SliverGridDelegateWithFixedCrossAxisCount');

  // Create a 3-column grid layout
  const layout = SliverGridRegularTileLayout(
    crossAxisCount: 3,
    mainAxisStride: 110.0,
    crossAxisStride: 110.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: false,
  );
  print('\nCreated 3-column layout:');
  print('  runtimeType: ${layout.runtimeType}');
  print('  crossAxisCount: ${layout.crossAxisCount}');
  print('  mainAxisStride: ${layout.mainAxisStride}');
  print('  crossAxisStride: ${layout.crossAxisStride}');
  print('  childMainAxisExtent: ${layout.childMainAxisExtent}');
  print('  childCrossAxisExtent: ${layout.childCrossAxisExtent}');
  print('  reverseCrossAxis: ${layout.reverseCrossAxis}');

  // Geometry for first row tiles
  print('\nFirst row (indices 0, 1, 2):');
  for (int i = 0; i < 3; i++) {
    final geo = layout.getGeometryForChildIndex(i);
    print('  [$i] scroll: ${geo.scrollOffset}, cross: ${geo.crossAxisOffset}');
  }

  // Geometry for second row tiles
  print('\nSecond row (indices 3, 4, 5):');
  for (int i = 3; i < 6; i++) {
    final geo = layout.getGeometryForChildIndex(i);
    print('  [$i] scroll: ${geo.scrollOffset}, cross: ${geo.crossAxisOffset}');
  }

  // Stride vs extent (gap = stride - extent)
  print('\nStride vs extent:');
  print('  mainAxisStride - childMainAxisExtent = ${layout.mainAxisStride - layout.childMainAxisExtent} (main gap)');
  print('  crossAxisStride - childCrossAxisExtent = ${layout.crossAxisStride - layout.childCrossAxisExtent} (cross gap)');

  // Reverse cross axis (RTL)
  const layoutRtl = SliverGridRegularTileLayout(
    crossAxisCount: 3,
    mainAxisStride: 110.0,
    crossAxisStride: 110.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: true,
  );
  print('\nReversed cross axis (RTL):');
  print('  reverseCrossAxis: ${layoutRtl.reverseCrossAxis}');

  // Scroll visibility
  print('\nScroll visibility:');
  print('  getMinChildIndexForScrollOffset(0.0): ${layout.getMinChildIndexForScrollOffset(0.0)}');
  print('  getMinChildIndexForScrollOffset(110.0): ${layout.getMinChildIndexForScrollOffset(110.0)}');
  print('  getMaxChildIndexForScrollOffset(110.0): ${layout.getMaxChildIndexForScrollOffset(110.0)}');

  // Max scroll offset
  print('\nMax scroll offsets:');
  print('  6 children: ${layout.computeMaxScrollOffset(6)}');
  print('  9 children: ${layout.computeMaxScrollOffset(9)}');
  print('  10 children: ${layout.computeMaxScrollOffset(10)}');

  print('\n==================================================');
  print('SliverGridRegularTileLayout test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SliverGridRegularTileLayout Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete immutable class'),
      Text('crossAxisCount: ${layout.crossAxisCount}'),
      Text('mainAxisStride: ${layout.mainAxisStride}'),
      Text('Purpose: Uniform grid tile layout'),
    ],
  );
}
