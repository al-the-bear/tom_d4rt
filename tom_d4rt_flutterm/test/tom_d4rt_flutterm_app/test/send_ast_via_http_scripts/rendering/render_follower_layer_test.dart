// ignore_for_file: avoid_print
// D4rt test script: Tests RenderFollowerLayer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderFollowerLayer test executing');

  // RenderFollowerLayer - A render object that follows a LeaderLayer
  // Used by CompositedTransformFollower to position relative to leader
  
  // Create a LayerLink which connects leader and follower
  final link = LayerLink();
  print('LayerLink created: $link');
  print('LayerLink leaderSize: ${link.leaderSize}');
  
  // RenderFollowerLayer follows a RenderLeaderLayer via the LayerLink
  // The follower positions itself relative to the leader's transform
  print('\nRenderFollowerLayer properties:');
  print('- Uses LayerLink to connect to RenderLeaderLayer');
  print('- Can specify offset from leader position');
  print('- Can specify target anchor point on leader');
  print('- Can specify follower anchor point');
  print('- Supports unlinked behavior when leader not available');
  
  // Create a FollowerLayer (the layer managed by RenderFollowerLayer)
  final followerLayer = FollowerLayer(
    link: link,
    showWhenUnlinked: false,
    unlinkedOffset: Offset.zero,
    linkedOffset: const Offset(10, 20),
  );
  print('\nFollowerLayer created: $followerLayer');
  print('FollowerLayer link: ${followerLayer.link}');
  print('FollowerLayer showWhenUnlinked: ${followerLayer.showWhenUnlinked}');
  print('FollowerLayer unlinkedOffset: ${followerLayer.unlinkedOffset}');
  print('FollowerLayer linkedOffset: ${followerLayer.linkedOffset}');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('FollowerLayer extends ContainerLayer');
  print('ContainerLayer extends Layer');
  print('RenderFollowerLayer uses FollowerLayer for compositing');
  
  // Common use cases
  print('\nCommon use cases:');
  print('- Tooltips that follow their target');
  print('- Dropdown menus attached to buttons');
  print('- Overlay content that tracks a widget');
  print('- Popup menus positioned relative to anchor');

  print('\nRenderFollowerLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderFollowerLayer Tests'),
      Text('Follows LeaderLayer via LayerLink'),
      Text('linkedOffset: (10, 20)'),
      Text('showWhenUnlinked: false'),
    ],
  );
}
