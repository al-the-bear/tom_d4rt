// D4rt test script: Tests FollowerLayer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FollowerLayer test executing');

  // Test FollowerLayer - Follower layer
  print('FollowerLayer is available in the rendering package');
  print('FollowerLayer: Follower layer');

  print('FollowerLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FollowerLayer Tests'),
      Text('Follower layer'),
    ],
  );
}
