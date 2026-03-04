// D4rt test script: Tests IntTween from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IntTween test executing');

  // Test IntTween - IntTween
  print('IntTween is available in the animation package');
  print('IntTween: IntTween');

  print('IntTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IntTween Tests'),
      Text('IntTween'),
    ],
  );
}
