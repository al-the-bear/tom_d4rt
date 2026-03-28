// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderProxySliver from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderProxySliver test executing');
  print('=' * 50);

  // RenderProxySliver class overview
  print('RenderProxySliver class overview:');
  print('  - Abstract class for sliver proxies');
  print('  - Extends RenderSliver');
  print('  - Delegates to single child');

  // Inheritance
  print('\nInheritance:');
  print('  RenderSliver');
  print('    -> RenderProxySliver');
  print('  Mixin: RenderObjectWithChildMixin');

  // Child property
  print('\nChild property:');
  print('  RenderSliver? child');
  print('    - Single sliver child');
  print('    - Layout delegated to it');

  // Default behavior
  print('\nDefault behavior:');
  print('  performLayout():');
  print('    - Calls child.layout()');
  print('    - Copies geometry');
  print('  paint():');
  print('    - Paints child');
  print('  hitTestChildren():');
  print('    - Delegates to child');

  // When to use
  print('\nWhen to use:');
  print('  Transform slivers');
  print('  Add effects to slivers');
  print('  Wrap sliver behavior');

  // Subclasses
  print('\nSubclasses:');
  print('  RenderSliverOpacity');
  print('  RenderSliverOffstage');
  print('  RenderSliverIgnorePointer');
  print('  Custom implementations');

  // Abstract nature
  print('\nAbstract nature:');
  print('  Cannot instantiate directly');
  print('  Extend and override behavior');
  print('  Provides base implementation');

  // Geometry
  print('\nGeometry:');
  print('  geometry: SliverGeometry');
  print('    - Size and paint info');
  print('  constraints: SliverConstraints');
  print('    - Input constraints');

  // Related
  print('\nRelated:');
  print('  RenderProxyBox: Box equivalent');
  print('  RenderSliverSingleBoxAdapter: Box child');

  print('\n' + '=' * 50);
  print('RenderProxySliver test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderProxySliver Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Key: child, performLayout()'),
      Text('Purpose: Sliver proxy base'),
    ],
  );
}
