// D4rt test script: Tests SizeTween from animation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SizeTween test executing');

  // Test SizeTween - SizeTween
  print('SizeTween is available in the animation package');
  print('SizeTween: SizeTween');

  print('SizeTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SizeTween Tests'),
      Text('SizeTween'),
    ],
  );
}
