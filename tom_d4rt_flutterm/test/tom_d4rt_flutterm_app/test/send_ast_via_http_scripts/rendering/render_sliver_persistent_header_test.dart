// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverPersistentHeader from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverPersistentHeader test executing');
  print('=' * 50);

  // RenderSliverPersistentHeader is abstract
  print('\nRenderSliverPersistentHeader is abstract');
  print('Purpose: Base class for slivers with a single box child that');
  print('shrinks and grows as the user scrolls');

  // Key abstract properties
  print('\nAbstract properties (must be overridden):');
  print('  double get minExtent - Minimum size when fully collapsed');
  print('  double get maxExtent - Maximum size when fully expanded');

  // Key methods
  print('\nKey methods:');
  print('  layoutChild(scrollOffset, maxExtent, overlapsContent)');
  print('  - Lays out the child with constraints based on scroll position');
  print('');
  print('  updateChild(shrinkOffset, overlapsContent)');
  print('  - Called after layout to update the child widget');
  print('');
  print('  childMainAxisPosition(RenderBox)');
  print('  - Returns position of child along main axis');

  // Stretch configuration
  print('\nStretch support:');
  print('  stretchConfiguration - PersistentHeaderStretchConfiguration?');
  print('  When set, header stretches beyond maxExtent on overscroll');
  print('  Used by SliverAppBar with stretch: true');

  // Show on screen
  print('\nShow on screen:');
  print('  showOnScreenConfiguration - PersistentHeaderShowOnScreenConfiguration?');
  print('  Controls how header reveals itself when requested');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderSliver');
  print('  \u2514\u2500 RenderSliverPersistentHeader (this, abstract)');
  print('       \u251c\u2500 RenderSliverScrollingPersistentHeader');
  print('       \u251c\u2500 RenderSliverPinnedPersistentHeader');
  print('       \u2514\u2500 RenderSliverFloatingPersistentHeader');
  print('            \u2514\u2500 RenderSliverFloatingPinnedPersistentHeader');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('SliverPersistentHeader(');
  print('  delegate: SliverPersistentHeaderDelegate,');
  print('  pinned: false,');
  print('  floating: false,');
  print(');');

  // SliverAppBar relationship
  print('\nSliverAppBar relationship:');
  print('  SliverAppBar uses SliverPersistentHeader internally');
  print('  pinned: false, floating: false -> Scrolling');
  print('  pinned: true,  floating: false -> Pinned');
  print('  pinned: false, floating: true  -> Floating');
  print('  pinned: true,  floating: true  -> FloatingPinned');

  print('\n${'=' * 50}');
  print('RenderSliverPersistentHeader test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverPersistentHeader Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Key: minExtent, maxExtent'),
      Text('Subclasses: Scrolling, Pinned, Floating'),
      Text('Widget: SliverPersistentHeader'),
    ],
  );
}
