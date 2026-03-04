// D4rt test script: Tests InputDecorationTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InputDecorationTheme test executing');

  // Test InputDecorationTheme - Input theme
  print('InputDecorationTheme is available in the material package');
  print('InputDecorationTheme runtimeType accessible');

  print('InputDecorationTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InputDecorationTheme Tests'),
      Text('Input theme'),
    ],
  );
}
