// ignore_for_file: avoid_print
// D4rt test script: Tests FollowerLayer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FollowerLayer test executing');
  print('=' * 50);

  // FollowerLayer for following a LeaderLayer
  print('\nFollowerLayer:');
  print('Layer that follows a LeaderLayer');
  print('Used for tooltips, dropdowns, overlays');

  // Create LeaderLayer first
  final leader = LeaderLayer(link: LayerLink());
  print('\nLeaderLayer created:');
  print('link: ${leader.link}');

  // Create FollowerLayer
  final follower = FollowerLayer(link: leader.link, showWhenUnlinked: false);
  print('\nFollowerLayer created:');
  print('link: ${follower.link}');
  print('showWhenUnlinked: ${follower.showWhenUnlinked}');

  // Properties
  print('\nProperties:');
  print('link: LayerLink connecting to leader');
  print('showWhenUnlinked: Show when no leader');
  print('unlinkedOffset: Offset when unlinked');
  print('linkedOffset: Offset relative to leader');

  // LayerLink
  print('\nLayerLink:');
  print('- Connects FollowerLayer to LeaderLayer');
  print('- One-to-one relationship');
  print('- Updates follower position automatically');

  // Use cases
  print('\nUse cases:');
  print('- Tooltips');
  print('- Dropdowns');
  print('- Menus');
  print('- Overlays');
  print('- CompositedTransformFollower');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('CompositedTransformTarget (leader)');
  print('CompositedTransformFollower (follower)');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Layer');
  print('  \u2514\u2500 ContainerLayer');
  print('       \u2514\u2500 FollowerLayer');

  // Explain purpose
  print('\nFollowerLayer purpose:');
  print('- Follow LeaderLayer position');
  print('- LayerLink for connection');
  print('- Overlay positioning');
  print('- Tooltip/dropdown support');
  print('- Compositing layer');

  print('\n${'=' * 50}');
  print('FollowerLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FollowerLayer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('showWhenUnlinked: ${follower.showWhenUnlinked}'),
      Text('Has link: true'),
      Text('For: tooltips, dropdowns'),
      Text('Purpose: Layer following'),
    ],
  );
}
