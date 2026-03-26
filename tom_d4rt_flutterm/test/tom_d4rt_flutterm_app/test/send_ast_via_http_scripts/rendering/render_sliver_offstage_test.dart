// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverOffstage from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverOffstage test executing');
  print('=' * 50);

  // RenderSliverOffstage is concrete
  print('\nRenderSliverOffstage:');
  print('Extends: RenderProxySliver');
  print('Purpose: Hides a sliver from painting, hit testing, and layout placement');

  // Create instance
  final offstage = RenderSliverOffstage();
  print('\nCreated instance:');
  print('  runtimeType: ${offstage.runtimeType}');
  print('  offstage: ${offstage.offstage}');

  // Test offstage property
  print('\nDefault offstage: ${offstage.offstage}');
  offstage.offstage = false;
  print('After set to false: ${offstage.offstage}');
  offstage.offstage = true;
  print('After set to true: ${offstage.offstage}');

  // Create with explicit false
  final visible = RenderSliverOffstage(offstage: false);
  print('\nCreated with offstage=false:');
  print('  offstage: ${visible.offstage}');

  // Type checks
  print('\nType hierarchy:');
  print('  runtimeType: ${offstage.runtimeType}');
  print('  RenderSliverOffstage extends RenderProxySliver');
  print('  RenderProxySliver extends RenderSliver');
  print('  RenderSliver extends RenderObject');

  // Behavior explanation
  print('\nBehavior when offstage=true:');
  print('  Layout: PERFORMED (child is laid out)');
  print('  Painting: SKIPPED (invisible)');
  print('  Hit testing: SKIPPED (not interactive)');
  print('  Space: NO ROOM taken in parent');
  print('  Semantics: EXCLUDED from tree');

  // Comparison with IgnorePointer
  print('\nOffstage vs IgnorePointer:');
  print('  Offstage: No paint, no hit test, no room');
  print('  IgnorePointer: Paints, no hit test, takes room');
  print('  Key difference: Offstage hides completely');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('SliverOffstage(');
  print('  offstage: true,');
  print('  sliver: SliverToBoxAdapter(');
  print('    child: Container(height: 100),');
  print('  ),');
  print(');');

  // Use cases
  print('\nUse cases:');
  print('  - Conditionally showing slivers without rebuilding');
  print('  - Pre-laying out slivers for measurement');
  print('  - Visibility toggling in CustomScrollView');
  print('  - Keeping sliver state alive while hidden');

  print('\n${'=' * 50}');
  print('RenderSliverOffstage test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverOffstage Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Default offstage: true'),
      Text('Extends: RenderProxySliver'),
      Text('No paint, no hit test, no room'),
      Text('Widget: SliverOffstage'),
    ],
  );
}
