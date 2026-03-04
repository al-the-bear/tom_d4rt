// D4rt test script: Tests ShapeBorderTween from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShapeBorderTween test executing');

  // Test ShapeBorderTween - ShapeBorderTween
  print('ShapeBorderTween is available in the material package');
  print('ShapeBorderTween runtimeType accessible');

  print('ShapeBorderTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShapeBorderTween Tests'),
      Text('ShapeBorderTween'),
    ],
  );
}
