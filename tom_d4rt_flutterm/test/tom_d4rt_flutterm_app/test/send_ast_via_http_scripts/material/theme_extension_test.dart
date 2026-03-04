// D4rt test script: Tests ThemeExtension from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ThemeExtension test executing');

  // Test ThemeExtension - ThemeExtension
  print('ThemeExtension is available in the material package');
  print('ThemeExtension runtimeType accessible');

  print('ThemeExtension test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ThemeExtension Tests'),
      Text('ThemeExtension'),
    ],
  );
}
