// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverToBoxAdapter from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverToBoxAdapter test executing');
  print('=' * 50);

  // RenderSliverToBoxAdapter is concrete
  print('\nRenderSliverToBoxAdapter:');
  print('Extends: RenderSliverSingleBoxAdapter');
  print('Purpose: Wraps a single RenderBox child in sliver protocol');

  // Create instance
  final adapter = RenderSliverToBoxAdapter();
  print('\nCreated instance:');
  print('  runtimeType: ${adapter.runtimeType}');
  print('  child: ${adapter.child}');

  // Create with a child
  final childBox = RenderConstrainedBox(
    additionalConstraints: BoxConstraints.tightFor(height: 100.0),
  );
  final adapterWithChild = RenderSliverToBoxAdapter(child: childBox);
  print('\nCreated with child:');
  print('  child: ${adapterWithChild.child}');
  print('  child.runtimeType: ${adapterWithChild.child?.runtimeType}');

  // Type checks
  print('\nType hierarchy:');
  print('  runtimeType: ${adapter.runtimeType}');
  print('  RenderSliverToBoxAdapter extends RenderSliverSingleBoxAdapter');
  print('  RenderSliverSingleBoxAdapter extends RenderSliver');
  print('  RenderSliver extends RenderObject');

  // Layout behavior
  print('\nperformLayout behavior:');
  print('  1. If no child: geometry = SliverGeometry.zero');
  print('  2. Lays out child with max cross-axis extent');
  print('  3. Child gets its preferred main-axis size');
  print('  4. Reports SliverGeometry based on child size');
  print('  5. Handles scroll offset clipping');

  // SliverGeometry calculation
  print('\nGeometry calculation:');
  print('  childExtent = child.size along main axis');
  print('  paintedChildSize = clamp(childExtent - scrollOffset, 0, remaining)');
  print('  scrollExtent = childExtent');
  print('  paintExtent = paintedChildSize');
  print('  maxPaintExtent = childExtent');

  // Widget equivalent
  print('\nWidget: SliverToBoxAdapter');
  print('SliverToBoxAdapter(');
  print('  child: Card(');
  print('    child: ListTile(title: Text("Item")),');
  print('  ),');
  print(');');

  // Common patterns
  print('\nCommon usage patterns:');
  print('  - Headers in CustomScrollView');
  print('  - Single widgets between SliverLists');
  print('  - Padding/spacing between slivers');
  print('  - Any non-sliver widget inside scrollable');

  print('\n${'=' * 50}');
  print('RenderSliverToBoxAdapter test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverToBoxAdapter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('child: ${adapter.child}'),
      Text('Widget: SliverToBoxAdapter'),
      Text('Wraps single RenderBox in sliver'),
    ],
  );
}
