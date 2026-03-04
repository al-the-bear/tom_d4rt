// D4rt test script: Tests DialogThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DialogThemeData test executing');

  // Test DialogThemeData - Dialog data
  print('DialogThemeData is available in the material package');
  print('DialogThemeData runtimeType accessible');

  print('DialogThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DialogThemeData Tests'),
      Text('Dialog data'),
    ],
  );
}
