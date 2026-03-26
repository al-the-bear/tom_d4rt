// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverPinnedPersistentHeader from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverPinnedPersistentHeader test executing');
  print('=' * 50);

  // RenderSliverPinnedPersistentHeader is abstract
  print('\nRenderSliverPinnedPersistentHeader is abstract');
  print('Extends: RenderSliverPersistentHeader');
  print('Purpose: Header that shrinks at the edge then stays pinned');

  // Pinned behavior explained
  print('\nPinned header behavior:');
  print('1. Starts at maxExtent (fully expanded)');
  print('2. As user scrolls, shrinks toward minExtent');
  print('3. Once at minExtent, stays pinned at viewport edge');
  print('4. Never scrolls off screen - always visible');
  print('5. Expands again when user scrolls back');

  // Key properties inherited
  print('\nInherited from RenderSliverPersistentHeader:');
  print('  minExtent - Size when fully collapsed (pinned)');
  print('  maxExtent - Size when fully expanded');
  print('  child - The RenderBox being displayed');
  print('  stretchConfiguration - For overscroll stretch');

  // Additional properties
  print('\nAdditional properties:');
  print('  showOnScreenConfiguration - Controls reveal behavior');

  // Layout math
  print('\nLayout calculation:');
  print('  shrinkOffset = scrollOffset.clamp(0, maxExtent - minExtent)');
  print('  currentExtent = maxExtent - shrinkOffset');
  print('  Always: currentExtent >= minExtent');
  print('  paintExtent = max(minExtent, maxExtent - scrollOffset)');
  print('  layoutExtent = max(0, maxExtent - scrollOffset)');

  // Visual diagram
  print('\nVisual scroll progression:');
  print('  [=====HEADER=====]  <- maxExtent (no scroll)');
  print('  [===HEADER===]      <- scrolling, shrinking');
  print('  [=HEADER=]          <- at minExtent, pinned');
  print('  [=HEADER=]          <- stays pinned (content scrolls behind)');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('SliverPersistentHeader(');
  print('  delegate: MyDelegate(),');
  print('  pinned: true,');
  print('  floating: false,');
  print(');');

  // SliverAppBar
  print('\nSliverAppBar usage:');
  print('SliverAppBar(');
  print('  pinned: true,');
  print('  floating: false,');
  print('  expandedHeight: 200.0,');
  print('  title: Text("Pinned Header"),');
  print(');');

  print('\n${'=' * 50}');
  print('RenderSliverPinnedPersistentHeader test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverPinnedPersistentHeader Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Extends: RenderSliverPersistentHeader'),
      Text('Behavior: Shrinks then stays pinned'),
      Text('Never scrolls off screen'),
    ],
  );
}
