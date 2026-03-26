// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverHelpers from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverHelpers test executing');
  print('=' * 50);

  // RenderSliverHelpers is a mixin
  print('\nRenderSliverHelpers is a mixin');
  print('Declaration: mixin RenderSliverHelpers implements RenderSliver');
  print('Purpose: Utility functions for RenderSliver subclasses');

  // Key methods provided by the mixin
  print('\nMethods provided:');
  print('  hitTestBoxChild(BoxHitTestResult, RenderBox,');
  print('    mainAxisPosition, crossAxisPosition)');
  print('  - Converts sliver coords to Cartesian coords for RenderBox hit test');
  print('');
  print('  applyPaintTransformForBoxChild(RenderBox, Matrix4)');
  print('  - Applies paint transform for a box child within a sliver');

  // Internal utility
  print('\nInternal utility:');
  print('  _getRightWayUp(SliverConstraints)');
  print('  - Determines if sliver is right-way-up based on');
  print('    axisDirection and growthDirection');

  // Coordinate system conversion
  print('\nCoordinate conversion:');
  print('Slivers use mainAxis/crossAxis positioning');
  print('RenderBox children use Cartesian (x,y) positioning');
  print('This mixin bridges the two systems');

  // Usage pattern
  print('\nTypical usage:');
  print('class MySliver extends RenderSliver');
  print('    with RenderSliverHelpers {');
  print('  @override');
  print('  bool hitTestChildren(SliverHitTestResult result,');
  print('      {required double mainAxisPosition,');
  print('       required double crossAxisPosition}) {');
  print('    return hitTestBoxChild(BoxHitTestResult(),');
  print('      child!,');
  print('      mainAxisPosition: mainAxisPosition,');
  print('      crossAxisPosition: crossAxisPosition);');
  print('  }');
  print('}');

  // Used by
  print('\nUsed by:');
  print('  RenderSliverSingleBoxAdapter');
  print('  Other custom sliver implementations');
  print('  Any sliver that hosts RenderBox children');

  // GrowthDirection interaction
  print('\nGrowthDirection interaction:');
  for (final gd in GrowthDirection.values) {
    print('  ${gd.name}: index=${gd.index}');
  }
  print('  forward + down = right-way-up');
  print('  reverse + down = upside-down');

  print('\n${'=' * 50}');
  print('RenderSliverHelpers test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverHelpers Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Mixin'),
      Text('Implements: RenderSliver'),
      Text('hitTestBoxChild: Sliver-to-Box coords'),
      Text('applyPaintTransformForBoxChild: Paint transform'),
    ],
  );
}
