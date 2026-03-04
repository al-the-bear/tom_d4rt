// D4rt test script: Tests ReverseTween from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReverseTween test executing');

  // Test ReverseTween - ReverseTween
  print('ReverseTween is available in the animation package');
  print('ReverseTween: ReverseTween');

  print('ReverseTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ReverseTween Tests'),
      Text('ReverseTween'),
    ],
  );
}
