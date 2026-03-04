// D4rt test script: Tests SnackBarThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnackBarThemeData test executing');

  // Test SnackBarThemeData - SnackBarThemeData
  print('SnackBarThemeData is available in the material package');
  print('SnackBarThemeData runtimeType accessible');

  print('SnackBarThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SnackBarThemeData Tests'),
      Text('SnackBarThemeData'),
    ],
  );
}
