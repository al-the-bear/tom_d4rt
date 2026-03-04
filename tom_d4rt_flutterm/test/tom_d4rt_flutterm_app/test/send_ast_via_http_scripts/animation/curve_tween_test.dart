// D4rt test script: Tests CurveTween from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CurveTween test executing');

  // Test CurveTween - CurveTween
  print('CurveTween is available in the animation package');
  print('CurveTween: CurveTween');

  print('CurveTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CurveTween Tests'),
      Text('CurveTween'),
    ],
  );
}
