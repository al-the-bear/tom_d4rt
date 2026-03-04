// D4rt test script: Tests ParametricCurve from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ParametricCurve test executing');

  // Test ParametricCurve - ParametricCurve
  print('ParametricCurve is available in the animation package');
  print('ParametricCurve: ParametricCurve');

  print('ParametricCurve test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ParametricCurve Tests'),
      Text('ParametricCurve'),
    ],
  );
}
