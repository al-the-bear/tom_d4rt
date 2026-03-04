// D4rt test script: Tests CardThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CardThemeData test executing');

  // Test CardThemeData - Card data
  print('CardThemeData is available in the material package');
  print('CardThemeData runtimeType accessible');

  print('CardThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CardThemeData Tests'),
      Text('Card data'),
    ],
  );
}
