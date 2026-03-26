// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverIgnorePointer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverIgnorePointer test executing');
  print('=' * 50);

  // RenderSliverIgnorePointer is a concrete class
  print('\nRenderSliverIgnorePointer:');
  print('Extends: RenderProxySliver');
  print('Purpose: Makes sliver invisible to hit testing');
  print('Still paints and consumes layout space');

  // Create an instance
  final ignorePointer = RenderSliverIgnorePointer();
  print('\nCreated instance:');
  print('  runtimeType: ${ignorePointer.runtimeType}');
  print('  ignoring: ${ignorePointer.ignoring}');

  // Test ignoring property
  print('\nDefault ignoring: ${ignorePointer.ignoring}');
  ignorePointer.ignoring = false;
  print('After set to false: ${ignorePointer.ignoring}');
  ignorePointer.ignoring = true;
  print('After set to true: ${ignorePointer.ignoring}');

  // Create with explicit parameter
  final notIgnoring = RenderSliverIgnorePointer(ignoring: false);
  print('\nCreated with ignoring=false:');
  print('  ignoring: ${notIgnoring.ignoring}');

  // Type checks
  print('\nType hierarchy:');
  print('  runtimeType: ${ignorePointer.runtimeType}');
  print('  RenderSliverIgnorePointer extends RenderProxySliver');
  print('  RenderProxySliver extends RenderSliver');
  print('  RenderSliver extends RenderObject');

  // Behavior explanation
  print('\nBehavior when ignoring=true:');
  print('  Hit testing: SKIPPED (invisible to taps)');
  print('  Painting: NORMAL (still visible)');
  print('  Layout: NORMAL (still takes space)');
  print('  Semantics: Depends on ignoringSemantics');

  print('\nBehavior when ignoring=false:');
  print('  Hit testing: NORMAL');
  print('  Painting: NORMAL');
  print('  Layout: NORMAL');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('SliverIgnorePointer(');
  print('  ignoring: true,');
  print('  sliver: SliverToBoxAdapter(');
  print('    child: Container(height: 100),');
  print('  ),');
  print(');');

  // Use case
  print('\nCommon use cases:');
  print('  - Disable interaction during animations');
  print('  - Overlay slivers that should not capture taps');
  print('  - Temporarily disable sliver interaction');

  print('\n${'=' * 50}');
  print('RenderSliverIgnorePointer test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverIgnorePointer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Default ignoring: true'),
      Text('Extends: RenderProxySliver'),
      Text('Paints: Yes, Hit tests: No'),
      Text('Widget: SliverIgnorePointer'),
    ],
  );
}
