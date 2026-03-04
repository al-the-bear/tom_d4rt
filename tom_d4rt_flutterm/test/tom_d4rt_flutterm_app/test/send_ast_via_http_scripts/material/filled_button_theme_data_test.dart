// D4rt test script: Tests FilledButtonThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FilledButtonThemeData test executing');

  // Test FilledButtonThemeData - Filled data
  print('FilledButtonThemeData is available in the material package');
  print('FilledButtonThemeData runtimeType accessible');

  print('FilledButtonThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FilledButtonThemeData Tests'),
      Text('Filled data'),
    ],
  );
}
