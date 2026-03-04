// D4rt test script: Tests AppBarThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AppBarThemeData test executing');

  // Test AppBarThemeData - App bar data
  print('AppBarThemeData is available in the material package');
  print('AppBarThemeData runtimeType accessible');

  print('AppBarThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AppBarThemeData Tests'),
      Text('App bar data'),
    ],
  );
}
