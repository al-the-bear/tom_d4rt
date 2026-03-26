// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverWithKeepAliveMixin from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverWithKeepAliveMixin test executing');
  print('=' * 50);

  // RenderSliverWithKeepAliveMixin is a mixin
  print('\nRenderSliverWithKeepAliveMixin is a mixin');
  print('Declaration: mixin RenderSliverWithKeepAliveMixin implements RenderSliver');
  print('Purpose: Ensures parentData uses KeepAliveParentDataMixin');

  // What it does
  print('\nWhat it does:');
  print('  Overrides setupParentData to assert that');
  print('  child.parentData is KeepAliveParentDataMixin');
  print('  This ensures children can participate in keep-alive');

  // Keep alive mechanism
  print('\nKeep alive mechanism in Flutter:');
  print('  1. AutomaticKeepAlive widget wraps list items');
  print('  2. KeepAliveNotification signals to keep child alive');
  print('  3. Sliver stores child in _keepAliveBucket');
  print('  4. When scrolled out, child is NOT destroyed');
  print('  5. When scrolled back, child restores from bucket');
  print('  6. Prevents expensive rebuilds of list items');

  // KeepAliveParentDataMixin
  print('\nKeepAliveParentDataMixin:');
  print('  keepAlive: bool - Whether to keep child alive');
  print('  keptAlive: bool - Whether currently in keep-alive bucket');

  // SliverMultiBoxAdaptorParentData
  print('\nSliverMultiBoxAdaptorParentData:');
  final pd = SliverMultiBoxAdaptorParentData();
  print('  runtimeType: ${pd.runtimeType}');
  print('  keepAlive: ${pd.keepAlive}');
  print('  index: ${pd.index}');

  // Usage pattern
  print('\nUsage pattern:');
  print('class MySliverList extends RenderSliver');
  print('    with RenderSliverWithKeepAliveMixin {');
  print('  // parentData will be validated for keep-alive support');
  print('}');

  // Widget-level equivalent
  print('\nWidget-level equivalent:');
  print('ListView.builder(');
  print('  itemBuilder: (context, index) {');
  print('    return AutomaticKeepAlive(');
  print('      child: KeepAliveChild(...),');
  print('    );');
  print('  },');
  print(');');

  // When keep-alive is needed
  print('\nWhen keep-alive is useful:');
  print('  - Heavy widget initialization (video players)');
  print('  - Scroll position preservation in nested lists');
  print('  - Form state preservation in scrollable forms');
  print('  - Tab content that should not be rebuilt');

  print('\n${'=' * 50}');
  print('RenderSliverWithKeepAliveMixin test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverWithKeepAliveMixin Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Mixin'),
      Text('Implements: RenderSliver'),
      Text('keepAlive: ${pd.keepAlive}'),
      Text('Purpose: Keep-alive parentData support'),
    ],
  );
}
