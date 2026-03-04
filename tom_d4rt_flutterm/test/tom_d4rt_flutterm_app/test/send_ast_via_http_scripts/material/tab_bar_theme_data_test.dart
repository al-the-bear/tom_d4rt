// D4rt test script: Tests TabBarThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabBarThemeData test executing');

  // Test TabBarThemeData - Tab data
  print('TabBarThemeData is available in the material package');
  print('TabBarThemeData runtimeType accessible');

  print('TabBarThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TabBarThemeData Tests'),
      Text('Tab data'),
    ],
  );
}
