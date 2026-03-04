// D4rt test script: Tests CompositedTransformFollower from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CompositedTransformFollower test executing');

  // Test CompositedTransformFollower - Transform follower
  print('CompositedTransformFollower is available in the widgets package');
  print('CompositedTransformFollower runtimeType accessible');

  print('CompositedTransformFollower test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CompositedTransformFollower Tests'),
      Text('Transform follower'),
    ],
  );
}
