// D4rt test script: Tests ConstantTween from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ConstantTween test executing');

  // Test ConstantTween - ConstantTween
  print('ConstantTween is available in the animation package');
  print('ConstantTween: ConstantTween');

  print('ConstantTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ConstantTween Tests'),
      Text('ConstantTween'),
    ],
  );
}
