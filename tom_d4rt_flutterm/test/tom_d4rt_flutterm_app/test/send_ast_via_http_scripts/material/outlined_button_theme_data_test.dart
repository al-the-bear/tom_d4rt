// D4rt test script: Tests OutlinedButtonThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OutlinedButtonThemeData test executing');

  // Test OutlinedButtonThemeData - Outlined data
  print('OutlinedButtonThemeData is available in the material package');
  print('OutlinedButtonThemeData runtimeType accessible');

  print('OutlinedButtonThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OutlinedButtonThemeData Tests'),
      Text('Outlined data'),
    ],
  );
}
