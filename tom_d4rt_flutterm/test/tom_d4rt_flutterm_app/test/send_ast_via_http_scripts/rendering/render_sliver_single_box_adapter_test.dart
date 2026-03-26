// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverSingleBoxAdapter from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverSingleBoxAdapter test executing');
  print('=' * 50);

  // RenderSliverSingleBoxAdapter is abstract
  print('\nRenderSliverSingleBoxAdapter is abstract');
  print('Extends: RenderSliver');
  print('Mixins: RenderObjectWithChildMixin<RenderBox>, RenderSliverHelpers');
  print('Purpose: Base for slivers containing a single RenderBox');

  // Single-child pattern
  print('\nSingle-child sliver pattern:');
  print('- Hosts exactly one RenderBox child');
  print('- Converts between sliver and box layout protocols');
  print('- Uses RenderSliverHelpers for hit testing and transforms');

  // Key methods
  print('\nKey methods:');
  print('  setChildParentData(RenderObject, SliverConstraints, SliverGeometry)');
  print('  - Configures child paint offset from sliver layout results');
  print('');
  print('  hitTestChildren(SliverHitTestResult)');
  print('  - Delegates to hitTestBoxChild from RenderSliverHelpers');
  print('');
  print('  childMainAxisPosition(RenderBox)');
  print('  - Returns logical offset minus current scroll offset');
  print('');
  print('  applyPaintTransform(RenderObject, Matrix4)');
  print('  - Applies paint transform for the box child');

  // Concrete subclass
  print('\nConcrete subclass:');
  print('  RenderSliverToBoxAdapter');
  print('  - The most common implementation');
  print('  - Wraps any single RenderBox in sliver protocol');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('SliverToBoxAdapter(');
  print('  child: Container(');
  print('    height: 100,');
  print('    color: Colors.blue,');
  print('  ),');
  print(');');

  // How box-to-sliver conversion works
  print('\nBox-to-sliver conversion:');
  print('  1. Receives SliverConstraints from viewport');
  print('  2. Converts to BoxConstraints for child');
  print('  3. Lays out child with box constraints');
  print('  4. Reports SliverGeometry back to viewport');
  print('  5. Child is a normal RenderBox inside sliver');

  // When to extend
  print('\nWhen to extend this class:');
  print('  - Custom slivers with exactly one box child');
  print('  - Need custom layout for single child in scroll view');
  print('  - Want sliver behavior with box rendering');

  print('\n${'=' * 50}');
  print('RenderSliverSingleBoxAdapter test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverSingleBoxAdapter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Mixins: RenderSliverHelpers'),
      Text('Child: Single RenderBox'),
      Text('Subclass: RenderSliverToBoxAdapter'),
    ],
  );
}
