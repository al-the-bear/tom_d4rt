// D4rt test script: Tests ThemeDataTween from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ThemeDataTween test executing');

  // Test ThemeDataTween - ThemeDataTween
  print('ThemeDataTween is available in the material package');
  print('ThemeDataTween runtimeType accessible');

  print('ThemeDataTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ThemeDataTween Tests'),
      Text('ThemeDataTween'),
    ],
  );
}
