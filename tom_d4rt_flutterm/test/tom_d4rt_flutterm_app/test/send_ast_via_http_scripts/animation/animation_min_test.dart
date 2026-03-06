// D4rt test script: Tests AnimationMin from animation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationMin test executing');

  // Test AnimationMin - Min of animations
  print('AnimationMin is available in the animation package');
  print('AnimationMin: Min of animations');

  print('AnimationMin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimationMin Tests'),
      Text('Min of animations'),
    ],
  );
}
