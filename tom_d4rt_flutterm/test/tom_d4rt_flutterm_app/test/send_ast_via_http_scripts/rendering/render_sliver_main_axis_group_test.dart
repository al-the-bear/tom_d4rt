// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverMainAxisGroup from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverMainAxisGroup test executing');
  print('=' * 50);

  // RenderSliverMainAxisGroup is a concrete class
  print('\nRenderSliverMainAxisGroup:');
  print('Extends: RenderSliver');
  print('Mixin: ContainerRenderObjectMixin<RenderSliver, SliverPhysicalContainerParentData>');
  print('Purpose: Lays out multiple sliver children in linear array along main axis');

  // Cannot easily instantiate without full rendering pipeline
  print('\nInstantiation:');
  print('Cannot instantiate outside rendering pipeline');
  print('Requires child slivers to be attached to render tree');

  // Layout behavior
  print('\nLayout behavior:');
  print('1. Children laid out sequentially along main axis');
  print('2. Each child receives remaining scroll extent');
  print('3. Combined geometry computed from all children');
  print('4. Handles scroll offset distribution to children');

  // Key methods
  print('\nKey methods:');
  print('  performLayout() - Lays out all sliver children sequentially');
  print('  childScrollOffset(RenderObject) - Offset of child in scroll coords');
  print('  childMainAxisPosition(RenderObject) - Position along main axis');
  print('  setupParentData(RenderObject) - Uses SliverPhysicalContainerParentData');

  // ParentData
  print('\nParent data:');
  print('Uses SliverPhysicalContainerParentData');
  final spd = SliverPhysicalContainerParentData();
  print('  runtimeType: ${spd.runtimeType}');
  print('  paintOffset: ${spd.paintOffset}');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('SliverMainAxisGroup(');
  print('  slivers: [');
  print('    SliverAppBar(...),');
  print('    SliverList(...),');
  print('    SliverGrid(...),');
  print('  ],');
  print(');');

  // Use cases
  print('\nUse cases:');
  print('  - Group related slivers together');
  print('  - Nested scrollable sections');
  print('  - Custom scroll effects on groups');
  print('  - Semantic grouping in CustomScrollView');

  // Comparison with alternatives
  print('\nComparison:');
  print('RenderSliverMainAxisGroup vs CustomScrollView:');
  print('  Group: Nested inside a parent CustomScrollView');
  print('  CustomScrollView: Top-level scrollable container');

  print('\n${'=' * 50}');
  print('RenderSliverMainAxisGroup test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverMainAxisGroup Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('Extends: RenderSliver'),
      Text('Purpose: Sequential sliver layout'),
      Text('Widget: SliverMainAxisGroup'),
    ],
  );
}
