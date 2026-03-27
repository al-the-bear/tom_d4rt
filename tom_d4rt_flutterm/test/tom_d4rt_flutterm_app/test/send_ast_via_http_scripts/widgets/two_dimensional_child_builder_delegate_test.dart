// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TwoDimensionalChildBuilderDelegate from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TwoDimensionalChildBuilderDelegate test executing');
  print('=' * 50);

  // TwoDimensionalChildBuilderDelegate for lazy building
  print('TwoDimensionalChildBuilderDelegate overview:');
  print('  - Extends TwoDimensionalChildDelegate');
  print('  - Lazy child building with callbacks');
  print('  - For large or infinite 2D lists');
  print('  - Similar to SliverChildBuilderDelegate');

  // Constructor parameters
  print('\nConstructor parameters:');
  print('  - builder: TwoDimensionalIndexedWidgetBuilder');
  print('  - maxXIndex: int? (optional column limit)');
  print('  - maxYIndex: int? (optional row limit)');
  print('  - repaintBoundaries: bool (default true)');
  print('  - addRepaintBoundaries: bool (deprecated)');
  print('  - addAutomaticKeepAlives: bool (default true)');

  // Builder callback
  print('\nBuilder callback signature:');
  print('  Widget? Function(BuildContext, ChildVicinity)');
  print('  - Returns null to signal no more children');
  print('  - ChildVicinity has xIndex and yIndex');
  print('  - Builds child on demand');

  // Create example
  print('\nCreating example delegate:');
  final delegate = TwoDimensionalChildBuilderDelegate(
    maxXIndex: 4,
    maxYIndex: 9,
    builder: (context, vicinity) {
      return Container(
        width: 100,
        height: 100,
        color: Colors.blue,
        child: Center(
          child: Text('(${vicinity.xIndex}, ${vicinity.yIndex})'),
        ),
      );
    },
  );
  print('  Created with 5x10 grid');
  print('  maxXIndex: ${delegate.maxXIndex}');
  print('  maxYIndex: ${delegate.maxYIndex}');

  // repaintBoundaries
  print('\nrepaintBoundaries:');
  print('  - Wraps children in RepaintBoundary');
  print('  - Optimizes repainting performance');
  print('  - Default true for efficiency');
  print('  - Set false for custom handling');

  // addAutomaticKeepAlives
  print('\naddAutomaticKeepAlives:');
  print('  - Wraps children in AutomaticKeepAlive');
  print('  - Preserves state when scrolling');
  print('  - Prevents dispose on scroll-out');
  print('  - Uses wantKeepAlive in children');

  // shouldRebuild
  print('\nshouldRebuild():');
  print('  - Returns true to rebuild all children');
  print('  - Called when delegate changes');
  print('  - Override for optimization');
  print('  - Default compares references');

  // Usage with TwoDimensionalScrollView
  print('\nUsage with TwoDimensionalScrollView:');
  print('  - Pass to delegate parameter');
  print('  - Viewport builds visible children');
  print('  - Recycles off-screen children');

  print('\n' + '=' * 50);
  print('TwoDimensionalChildBuilderDelegate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TwoDimensionalChildBuilderDelegate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: TwoDimensionalChildDelegate'),
      Text('Pattern: Lazy child building'),
      Text('Use: Large/infinite 2D grids'),
    ],
  );
}
