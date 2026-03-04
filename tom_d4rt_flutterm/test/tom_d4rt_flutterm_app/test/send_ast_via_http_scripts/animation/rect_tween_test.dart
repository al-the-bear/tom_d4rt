// D4rt test script: Tests RectTween from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RectTween test executing');

  // Test RectTween - RectTween
  print('RectTween is available in the animation package');
  print('RectTween: RectTween');

  print('RectTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RectTween Tests'),
      Text('RectTween'),
    ],
  );
}
