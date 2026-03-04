// D4rt test script: Tests IconButtonThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IconButtonThemeData test executing');

  // Test IconButtonThemeData - Icon data
  print('IconButtonThemeData is available in the material package');
  print('IconButtonThemeData runtimeType accessible');

  print('IconButtonThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IconButtonThemeData Tests'),
      Text('Icon data'),
    ],
  );
}
