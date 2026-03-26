// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverGridLayout from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverGridLayout test executing');
  print('=' * 50);

  // SliverGridLayout is the abstract base for grid layouts
  print('\nSliverGridLayout:');
  print('Type: Abstract immutable class');
  print('Purpose: Defines how children are laid out in a SliverGrid');
  print('Concrete subclass: SliverGridRegularTileLayout');
  print('Cannot be instantiated directly');

  // Abstract methods
  print('\nAbstract methods:');
  print('  getMinChildIndexForScrollOffset(double scrollOffset) -> int');
  print('    First child visible at given scroll offset');
  print('  getMaxChildIndexForScrollOffset(double scrollOffset) -> int');
  print('    Last child visible at given scroll offset');
  print('  getGeometryForChildIndex(int index) -> SliverGridGeometry');
  print('    Position and size of the child at given index');
  print('  computeMaxScrollOffset(int childCount) -> double');
  print('    Maximum scroll extent for all children');

  // Demonstrate via concrete subclass
  const layout = SliverGridRegularTileLayout(
    crossAxisCount: 3,
    mainAxisStride: 110.0,
    crossAxisStride: 110.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: false,
  );
  print('\nConcrete example (SliverGridRegularTileLayout):');
  print('  crossAxisCount: ${layout.crossAxisCount}');

  // getMinChildIndexForScrollOffset
  final minIdx = layout.getMinChildIndexForScrollOffset(0.0);
  print('\n  getMinChildIndexForScrollOffset(0.0): $minIdx');
  final minIdx2 = layout.getMinChildIndexForScrollOffset(115.0);
  print('  getMinChildIndexForScrollOffset(115.0): $minIdx2');

  // getMaxChildIndexForScrollOffset
  final maxIdx = layout.getMaxChildIndexForScrollOffset(110.0);
  print('\n  getMaxChildIndexForScrollOffset(110.0): $maxIdx');

  // getGeometryForChildIndex
  final geo0 = layout.getGeometryForChildIndex(0);
  print('\n  getGeometryForChildIndex(0):');
  print('    scrollOffset: ${geo0.scrollOffset}');
  print('    crossAxisOffset: ${geo0.crossAxisOffset}');

  final geo4 = layout.getGeometryForChildIndex(4);
  print('  getGeometryForChildIndex(4):');
  print('    scrollOffset: ${geo4.scrollOffset}');
  print('    crossAxisOffset: ${geo4.crossAxisOffset}');

  // computeMaxScrollOffset
  final maxScroll = layout.computeMaxScrollOffset(9);
  print('\n  computeMaxScrollOffset(9): $maxScroll');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('  GridView.count(crossAxisCount: 3, ...)');
  print('  SliverGrid(delegate: ..., gridDelegate: ...)');

  print('\n==================================================');
  print('SliverGridLayout test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SliverGridLayout Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract immutable class'),
      Text('Subclass: SliverGridRegularTileLayout'),
      Text('Methods: getGeometryForChildIndex, etc.'),
      Text('Purpose: Grid layout strategy'),
    ],
  );
}
