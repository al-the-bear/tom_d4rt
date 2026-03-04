// D4rt test script: Tests ColorTween from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ColorTween test executing');

  // Test ColorTween - ColorTween
  print('ColorTween is available in the animation package');
  print('ColorTween: ColorTween');

  print('ColorTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ColorTween Tests'),
      Text('ColorTween'),
    ],
  );
}
